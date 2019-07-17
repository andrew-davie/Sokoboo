    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

                NEWBANK ROM_SHADOW_OF_BANK_DRAW_BUFFERS

    ; NOTE: Access to these buffers must NOT overlap pages...


    ; The blank stack is a stack of recently blanked-out squares.  These squares
    ; are processed to determine if any of the surrounding squares should also
    ; be processed (for example, an action causing a blank square may cause some
    ; other action in surrounding squares, a sort of chain reaction).  The blank
    ; stack is usually added to when objects move.  Objects on the blank stack
    ; are not persistant (the blanks reference squares on the board, not physical
    ; objects doing things).


    ; THe BlankStack lists can NOT overlap page boundaries. Be careful.
BLANK_STACK_MAX = 128 ; may NOT be extended

BlankStackX     ds BLANK_STACK_MAX
BlankStackY     ds BLANK_STACK_MAX

   ; NOTE: We get auto-initialisation of these variables from the ROM values by
    ; copying the whole bank into the RAM bank.  Neato.

DRAW_STACK_SIZE      =   SCREEN_ARRAY_SIZE      ; <-- TJ TRY CHANGING THIS TO (SAY) 15  (!!)



DrawStack       ds DRAW_STACK_SIZE,0                    ; a stack of character #'s to draw
DrawFlag        ds SCREEN_ARRAY_SIZE,0                  ; holds new character to draw at position

                OPTIONAL_PAGEBREAK "ScreenBuffer", SCREEN_ARRAY_SIZE

    ; D7 of ScreenBuffer indicates if a DirectDraw is to be used to draw this character
    ; Note: this may actually cause two characters to be drawn -- for the price of one.  This is *exactly*
    ; what we want to happen!

ScreenBuffer    ds SCREEN_ARRAY_SIZE,0                    ; the char buffer for delta-drawing



    ;------------------------------------------------------------------------------
    ; RAM-BASED SUBROUTINES...
    ; NOTE: When calling these routines, remember you are actually calling the ROM routine
    ; as it is the ROM bank that is switched in.  The first thing to do to access the RAM
    ; is to switch the appropriate RAM bank in.  It would be nicer to be able to direct-call
    ; the RAM-based routine.



    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE InsertBlankStack ;=32(A) ; in RAM

        ; places a blank square (POS_X,POS_Y) into the blank object stack

                ldy BlankStackPtr               ; 3

#if BLANK_STACK_MAX = 128
                bmi BuffersFull                 ; 2/3
#else
                cpy #BLANK_STACK_MAX
                beq BuffersFull                     ; A REAL PROBLEM, BUT GRACEFULLY HANDLE IT
#endif

                lda POS_Y                       ; 3
                sta BlankStackY+RAM_WRITE,y     ; 5
                lda POS_X                       ; 3
                sta BlankStackX+RAM_WRITE,y     ; 5

                inc BlankStackPtr               ; 5

waitForDraw
BuffersFull     rts                             ; 6

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawStackUpdate ;=196 (+13 for fall-through bit)

    ; Parse the DrawFlags buffer and create a draw stack
    ; so that the actual draw doesn't need to scan for characters to draw.


 ;@TJ -- let's see if we see any bad lag/shear in screen drawing without this wait in.
 ; symptoms would be missing parts of screen when scrolling.
 ; Gameplay (not visual) lag noticed - re-enabled 11/8/11

                lda DrawStackPointer
                bpl waitForDraw                 ; Wait for previously not-drawn characters to be drawn

                lda INTIM                       ;4
                cmp #SEGTIME_BDS                ;2
                bcc waitForDraw                 ;2/3
                STRESS_TIME SEGTIME_BDS


    ; Now that all characters are drawn, recalculate/move sprite. Doing this here prevents the player
    ; moving into the middle of dirt, or BOXs when pushing, or diamonds when grabbing.

;                sec            already set
                lda ManY                        ;3
                sbc BoardScrollY                ;3
                sta ManDrawY                    ;3

                sec                             ;2
                lda ManX                        ;3
                sbc BoardScrollX                ;3
                cmp #SCREEN_WIDTH               ;2
                bcc onsc                        ;2/3

    ; if the man is offscreen, we have a timing issue between the horizontal positioning code and the player
    ; draw code.  The following gets around this by setting the Y offscreen (causing the player draw code to
    ; blank the graphic) and leaving the X alone (so we don't see a brief flash in left of screen).

                lda #SCREEN_LINES               ;2
                sta ManDrawY                    ;3
                bne skipsc                      ;3               unconditional

onsc            sta ManDrawX                    ;3
skipsc

                inc timer                       ;5
                jmp AnimateCharReplacements2    ;3+139
retAnim

                inc ScreenDrawPhase             ;5

                lda #SCREEN_ARRAY_SIZE-1        ;2
                sta DSL                         ;3

    ; fall through...
    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawIntoStack

                tsx                             ;2
                stx save_SP                     ;3
                ldx DrawStackPointer            ;3
                txs                             ;2 = 10

                ldy DSL                         ;3

    ; worst-case DrawStackOne loop = 61 cycles per character (+11 for first one)
    ; + exit cost which is +10 cycles
    ; TJ: I count 63
    ;   + 14 for the wtf2 exit
    ;   + 22 for the end of loop exit

    ; This loops 80 times/frame and is called 1-2 times/frame, so any saving inside the loop will make up for a lot of overhead outside
    ; For 80 iterations that is 640 cycles, just for checking INTIM
    ; Worst case we would have ~5000. Though that will most likely never happen, we have to optimize for it, since
    ; it also will require a lot of CPU time for updating the screen data.

    ; TODO: optimize!
    ;
    ; idea #4: the mixed draw idea (two different characters have to be redrawn),
    ; first do a QuickDraw and then a SlowDraw, faster than two SlowDraws
    ; costs some detection time here, but saves ~240 cylces for drawing the two

.loopDrawStack  lda INTIM                       ;4
                cmp #SEGTIME_DSL                ;2
                bcc .exitDrawStack              ;2/3= 8/9
                STRESS_TIME SEGTIME_DSL

                lda DrawFlag,y                  ;4
                cmp ScreenBuffer,y              ;4              Is the character already there the same as the new one?
                beq .next0                      ;2/3=10/11      yes, so we don't draw anything

    ; Character is NOT the same. Figure out how it should be drawn.
    ; If it is in column 0 or 5 then it can be DirectDrawn (indirectly found by a A:A compare)
    ; If it is the same as its paired character (sharing same PF byte) then it can be DirectDrawn
    ; The top bit of the ScreenBuffer character indicates the DirectDrawn hint

                ldx PairedCharacter,y           ;4              the "paired" character for this one
                cmp DrawFlag,x                  ;4              same as partner character in new drawn screen?
                bne .notPaired0                 ;2/3=10/11

    ; Consider two 'paired' characters. Either A:A or A:B
    ; When we're scanning, and we check the first, if they are NOT paired, then the second character
    ; can be considered in isolation -- its check comes later, will determine itself if the pair can be written
    ; If, however, the first character IS paired, then the write below will cause the second check to FAIL
    ; on the comparison, so the character will not be added to the draw stack. So our first character will
    ; do the job of drawing BOTH characters to the screen.

                sta ScreenBuffer+RAM_WRITE,x    ;5              mark paired character as drawn already (!!)
                ora #$80                        ;2 =  7         DirectDraw this character 'pair'

    ; In the case of columns 0 and 5, the X and Y registers will be the same -- no problemo, because
    ; the last write(below) marks the character as to be direct-drawn.

.notPaired0     sta ScreenBuffer+RAM_WRITE,y    ;5              NEW character to draw + DirectDraw flag (128)

    ; The following 'pla' really just increments the draw-stack pointer.  Value is unimportant. Unusual!

                pla                             ;4              ASSUMPTION IS WE DON'T OvERFLOW DRAW STACK
                tya                             ;2
                tsx                             ;2              << now X holds drawstackpointer
                sta DrawStack+RAM_WRITE,x       ;5 = 18         index of character to draw

.next0          dey                             ;2
                bmi .finishedDrawStack          ;2/3= 4/5

    ; unrolled 2nd loop:
                lda DrawFlag,y                  ;4
                cmp ScreenBuffer,y              ;4              Is the character already there the same as the new one?
                beq .next1                      ;2/3=10/11      yes, so we don't draw anything

                ldx PairedCharacter,y           ;4              the "paired" character for this one
                cmp DrawFlag,x                  ;4              same as partner character in new drawn screen?
                bne .notPaired1                 ;2/3=10/11

                sta ScreenBuffer+RAM_WRITE,x    ;5              mark paired character as drawn already (!!)
                ora #$80                        ;2 =  7         DirectDraw this character 'pair'

.notPaired1     sta ScreenBuffer+RAM_WRITE,y    ;5              NEW character to draw + DirectDraw flag (128)

                pla                             ;4              ASSUMPTION IS WE DON'T OvERFLOW DRAW STACK
                tya                             ;2
                tsx                             ;2
                sta DrawStack+RAM_WRITE,x       ;5 = 18         index of character to draw

.next1          dey                             ;2
                bpl .loopDrawStack              ;2/3= 4/5
;worst case: 111-4
;40 loops(-4), max. 2 calls(+20) -> -160+40=-120, +8 bytes

   ; THE FOLLOWING OPTIMISATION IS STUFFED IF PROCESSOBJSTACK is not first in the vector processor!

.finishedDrawStack
                inc ScreenDrawPhase             ;5 =  5
                tsx                             ;2
                stx DrawStackPointer            ;3
                ldx save_SP                     ;3
                txs                             ;2 = 10

                jmp SwitchObjects

                ;rts                             ;6 =  6

.exitDrawStack
                sty DSL                         ;3 =  3
                tsx                             ;2
                stx DrawStackPointer            ;3
                ldx save_SP                     ;3
                txs                             ;2 = 10
NoBlanks        rts                             ;6 =  6

        ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE BlankCreatureInsertion ;=853(A)

                ldy BlankStackPtr               ;3
                dey                             ;2

    ; Processes a blank stack object.

                lda BlankStackY,y               ;4
                sta POS_Y                       ;3
                lda BlankStackX,y               ;4
                sta POS_X                       ;3

    ; We have the position of a blank square on the board that has been placed onto
    ; the blank stack in the previous iteration.  IFF the square is still blank, then
    ; we check the squares immediately above and to the sides and place those object(s)
    ; into the object stack

                lda #0                          ;2
                sta POS_VAR                     ;3              for object stack insertion

    ;  +---+---+---+
    ;  | 1 | 2 | 3 |
    ;  +---+---+---+
    ;  | 0 | B | 4 |
    ;  +---+---+---+

    ; Given a position 'B', checks the surrounding squares 0-4 for objects that could
    ; possibly be caused to "fall" by the creation of a blank at 'B'.  These objects
    ; are pushed onto the object stack to let them do their stuff.

                dec POS_X                       ;5
                jsr GetBoardCharacter__CALL_FROM_RAM__          ;6+61
                jsr CheckIt                     ;6+108(A)       @ "0"

                inc POS_X                       ;5
                inc POS_X                       ;5
                jsr CheckIt2                    ;6+141          # "4"

                dec POS_Y                       ;5
                jsr GetBoardCharacter__CALL_FROM_RAM__          ;6+61
                jsr CheckIt                     ;6+110(A)       @ "3"

                dec POS_X                       ;5
                jsr CheckIt2                    ;6+141          @ "2"

                dec POS_X                       ;5

    ; fall through (@ "1")

CheckIt2 ;=141

                lda #BANK_BOARD                         ;2                      Warning -- will not work for multiple bank board!
                jsr PartialGetBoardCharacter            ;6+23

CheckIt ;=110(A)

                lda GenericCharFlag,x                   ; 4     check char as a fallable item
                bpl NoBlanks                            ; 2/3   NOT a fallable object!

    ; Only FALLABLE objects detected in the candidate position are added to the object list.
    ; These objects then make their own minds up if they're ACTUALLY going to fall.


                lda CharToType,x                        ;4      get type of object based on character
                sta POS_Type                            ;3

                jmp InsertObjectStackFromRAM            ;3+94(B)

    ;------------------------------------------------------------------------------
    ; Gives character replacements used during screen drawing.
    ; The character from the board is morphed via this array into an actual character
    ; to draw.  This allows global animation and replacment of characters without
    ; individual objects needing to do this.  Note, the draw-time replacement happens,
    ; not board-time.

CharReplacement ; in RAM -- BANK_DRAW_BUFFERS

    ; Converts a character # to an animated creature type
    ; The array is indexed by CHARACTER_...

                .byte CHARACTER_BLANK       ;  0
                .byte CHARACTER_SOIL        ;  1
                .byte CHARACTER_BOX     ;  2
ANIM_AMOEBA     .byte CHARACTER_AMOEBA      ;  3
ANIM_DIAMOND    .byte CHARACTER_DIAMOND     ;  4
                .byte 0;CHARACTER_DIAMOND   ;  5
                .byte CHARACTER_MANOCCUPIED ;  6
ANIM_BUTTERFLY0 .byte CHARACTER_FLUTTERBY   ;  7
ANIM_BUTTERFLY1 .byte CHARACTER_FLUTTERBY   ;  8
ANIM_FIREFLY0   .byte CHARACTER_FIREFLY     ;  9
ANIM_FIREFLY1   .byte CHARACTER_FIREFLY     ; 0a
ANIM_MAGICWALL  .byte CHARACTER_WALL0       ; 0b
                .byte 0;CHARACTER_WALL0     ; 0c
                .byte 0;CHARACTER_WALL0     ; 0d
                .byte 0;CHARACTER_WALL0     ; 0e
                .byte CHARACTER_STEEL       ; 0f
                .byte CHARACTER_WALL        ; 10
ANIM_EXITDOOR   .byte CHARACTER_EXITDOOR    ; 11
                .byte 0;CHARACTER_EXITDOOR  ; 12
                .byte CHARACTER_EXPLOSION   ; 13
                .byte CHARACTER_EXPLOSION1  ; 14
                .byte CHARACTER_EXPLOSION2  ; 15
                .byte CHARACTER_EXPLOSION3  ; 16
                .byte 0;CHARACTER_AMOEBA    ; 17
                .byte CHARACTER_BOX     ; 18    falling BOX
                .byte CHARACTER_DIAMOND     ; 19    falling diamond, no anim
                .byte CHARACTER_NOGO            ;20 the unkillable man for end of level

    IF * - CharReplacement < CHARACTER_MAXIMUM
        ECHO "ERROR: Missing entry in CharReplacement table!"
        EXIT
    ENDIF
    CHECKPAGEX CharReplacement, "CharReplacement in BANK_ROM_SHADOW_DRAWBUFFERS"

    ;------------------------------------------------------------------------------

PairedCharacter

SOFF   SET 0
    REPEAT SCREEN_LINES
        .byte SOFF,SOFF+2,SOFF+1,SOFF+4,SOFF+3,SOFF+5,SOFF+7,SOFF+6,SOFF+9,SOFF+8
SOFF    SET SOFF + SCREEN_WIDTH
    REPEND

    OPTIONAL_PAGEBREAK "ROW_BankChar", SCREEN_LINES * SCREEN_WIDTH
    DEFINE_SUBROUTINE ROW_BankChar

.BANK       SET BANK_SCREENMARKII1
        REPEAT SCREEN_LINES
            REPEAT SCREEN_WIDTH
                .byte .BANK
            REPEND
.BANK       SET .BANK + 1
        REPEND




    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_BANK_DRAW_BUFFERS"

    ; Here there is another 1K of usable ROM

    DEFINE_SUBROUTINE MoveExit

                bit scoringFlags
                bpl NoExitYet                                   ; D7 (extra diamond) triggers exit open

                lda caveDisplay
                bpl lifeMaxedOut                ; not a bonus level
                lda MenCurrent
                and #$0f
                cmp #9
                bcs lifeMaxedOut
                inc MenCurrent

                ; bonus life has priority over score:
                lda scoringFlags
                and #DISPLAY_FLAGS
                eor scoringFlags                    ; remove existing score mode
                ora #DISPLAY_LIVES                  ; switch to new score mode
                sta scoringFlags
                lda #SCORING_TIMER
                sta scoringTimer
                lda #EXTRA_LIFE_TIMER
                sta extraLifeTimer

lifeMaxedOut

                lda #MANMODE_BONUS_START
                sta ManMode

                lda #BANK_MoveExit
                sta ROM_Bank

                ;jsr MoveNoButton2                ; move man over exit door area

    ; Stop the sort, so it doesn't accidentally swap "in" any creatures

                lda #<(-1)
                sta sortRequired
                lda #0
                sta sortPtr
                sta BlankStackPtr               ; don't allow any new objects either!

    ; We want *everything* to stop, but the player to keep processing
    ; So, kill every creature in the two object stacks, re-add the man (automatic), and continue

                ldx ObjStackNum
                sta ObjStackPtr,x               ; =0, kill new object stack
                txa
                eor #1
                tax
                lda ObjStackPtr,x
                sta ObjIterator                 ; set the iterator to the END of the current object stack so it ends

    ; all creatures now dead and we'll only have the (reinserted) man left

                asl ThrottleSpeed               ; double game loop speed

NoExitYet       rts

            include "CaveBank1.asm"

    CHECK_BANK_SIZE "ROM_SHADOW_OF_BANK_DRAW_BUFFERS -- full 2K"

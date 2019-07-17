    ;------------------------------------------------------------------------------
    ;###############################  FIXED BANK  #################################
    ;------------------------------------------------------------------------------


ORIGIN          SET FIXED_BANK

                NEWBANK THE_FIXED_BANK
                RORG $f800


    ;------------------------------------------------------------------------------
; TJ: used by:
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm
    include "Brick_Wall.asm"    ; 2 * LINES_PER_CHAR bytes

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetSurroundingChars ;=156[-28](C)
; TJ: used by:
; - BANK_INITBANK.asm

    ; Retrieve the surrounding characters from the board around a given position.
    ; These are placed into the Surround array with the indexes as shown...

    ; +------+------+------+
    ; |*     | a(0) |      |   *= where Temp_board_address1 points
    ; +------+------+------+
    ; | d(3) | X(4) | b(1) |
    ; +------+------+------+
    ; |      | c(2) |      |
    ; +------+------+------+

    ; X = ( POS_X,POS_Y )

                lda #BANK_GetBoardAddress4          ;
                sta SET_BANK                        ;
                jsr GetBoardAddress4                ;11+72[-16](C)

                sta SET_BANK_RAM                    ;3
                lax (Temp_Board_Address1),y         ;5
                sta Surround                        ;3

    IF MULTI_BANK_BOARD = YES
                lda Temp_Bank3                      ;3
                sta SET_BANK_RAM                    ;3
    ENDIF
                lda (Temp_Board_Address3),y         ;5
                sta Surround+2                      ;3

    IF MULTI_BANK_BOARD = YES
                lda Temp_Bank2                      ;3
                sta SET_BANK_RAM                    ;3
    ENDIF
                lda (Temp_Board_Address2),y         ;5
                sta Surround+4                      ;3

                dey                                 ;2
                lda (Temp_Board_Address2),y         ;5
                sta Surround+3                      ;3

                iny                                 ;2
                iny                                 ;2
                lda (Temp_Board_Address2),y         ;5
                sta Surround+1                      ;3

                lda ROM_Bank                        ;3
                sta SET_BANK                        ;3

; returns: X = Surround
                rts                                 ;6 = 156[-12]

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawTimeFromROM
; TJ: used by:
; - BANK_INITBANK.asm

                sta SET_BANK_RAM
                jsr DrawTime
                sta SET_BANK
                rts

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE InsertBlankStack2         ;=51(A)
; TJ: used by:
; - BANK_INITBANK.asm

                sta SET_BANK_RAM                ; 3
                jsr InsertBlankStack            ; 6+30(A)
                lda ROM_Bank                    ; 3
                sta SET_BANK                    ; 3
                rts                             ; 6

    ;------------------------------------------------------------------------------


    DEFINE_SUBROUTINE GetROMByte ;=23(A)
; TJ: used by:
; - BANK_INITBANK.asm
; - DecodeCave.asm

    ; a = ROM bank to retrieve (NOTE: status negative flag important!!!!!!!)
    ; y = page index
    ; ROM_Bank = bank to return to
    ; (Board_AddressR) = page
    ; out a = byte from (Board_AddressR)

                sta SET_BANK                    ;3
                jmp GetBoardCharacter2          ;3+17(A)        unconditional

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardCharacter ;=20(A)
; TJ: used by:
; - BANK_INITBANK.asm

    ; call from ROM bank
    ; switches back to ROM_Bank on exit

    ; pass A = bank containing character
    ; Y = x character position
    ; (Board_AddressR) points to character position
    ; returns character from board


                sta SET_BANK_RAM                ;3   switch to bank to read

GetBoardCharacter2 ;=17(A)

                lax (Board_AddressR),y          ;5
                ldy ROM_Bank                    ;3
                sty SET_BANK                    ;3   switch back caller's bank
                rts                             ;6   and go back

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE PutBoardCharacter    ;=21(A)
; TJ: used by:
; - BANK_INITBANK.asm
                stx SET_BANK_RAM            ; 3

PutBoardCharacterSB ; =18
                sta (Board_AddressW),y      ; 6
                lda ROM_Bank                ; 3
                sta SET_BANK                ; 3
                rts                         ; 6 = 21

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE PutBoardCharacterButterfly ;=110(B)
; TJ: used by:
; - BANK_INITBANK.asm


                stx SET_BANK_RAM            ;3
                sta (Board_AddressW),y      ;6
                jmp ReInsertObject          ;3+98(B)

   ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardCharacter__CALL_FROM_RAM__ ;=61[-2](A)
; TJ: used by:
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm
; - DecodeCave.asm

                ldy POS_Y                       ;3

                lda #BANK_GetBoardAddressR      ;
                sta SET_BANK                    ;
                jsr GetBoardAddressR            ;11+24[-2](A)


    DEFINE_SUBROUTINE PartialGetBoardCharacter ;=23
; TJ: used by:
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm

                sta SET_BANK_RAM                ;3
                ldy POS_X                       ;3
                lax (Board_AddressR),y          ;5
                ldy RAM_Bank                    ;3
                sty SET_BANK_RAM                ;3              return to RAM caller
                rts                             ;6              and go back

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE PutBoardCharacterFromRAM ;=71[-2]
; TJ: used by:
; - BANK_INITBANK.asm
; - DecodeCave.asm

    ; POS_Y  = row
    ; POS_Type = character to write
    ; POS_X     = column
    ; RAM_Bank = caller's bank

                ldy POS_Y                           ;3

                lda #BANK_GetBoardAddressW          ;
                sta SET_BANK                        ;
                jsr GetBoardAddressW                ;11+24[-2](A)

                stx SET_BANK_RAM                    ;3

                ldy POS_X                           ;3
                lda POS_Type                        ;3
                sta (Board_AddressW),y              ;6
                ldy RAM_Bank                        ;3
                sty SET_BANK_RAM                    ;3 return to RAM caller
                rts                                 ;6


    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE ProcessObjStack ; 15 minimum segtime abort
; TJ: used by:
; - BANK_FIXED.asm

                lda INTIM                       ;4
                cmp #MINIMUM_SEGTIME            ;2
                bcc EarlyAbort                  ;2/3= 8
                STRESS_TIME MINIMUM_SEGTIME

                lda ObjStackNum                 ;3
                eor #1                          ;2
                tax                             ;2

                lda ObjIterator                 ;3
                cmp ObjStackPtr,x               ;5
                bcs doBlanks                    ;2/3           check for blanks

    ; Process an object...
    ; Actual object code (the handlers) starts 82 cycles after previous segtime check!

                ldy BankObjStack,x              ;4
                sty SET_BANK_RAM                ;3

                tax                             ;2
                ldy SortedObjPtr,x              ;4              indirect object pointer list (sorted)

                lda ObjStackX,y                 ;4
                sta POS_X                       ;3
                lda ObjStackY,y                 ;4
                sta POS_Y                       ;3
                lda ObjStackVar,y               ;4
                sta POS_VAR                     ;3
                ldx ObjStackType,y              ;4
                stx POS_Type                    ;3

                lda #BANK_VectorProcess         ;2
                sta SET_BANK                    ;3

                lda OSPointerHI,x               ;4
                sta POS_Vector+1                ;3
                lda OSPointerLO,x               ;4
                sta POS_Vector                  ;3

                jmp (POS_Vector)                ;5 = 82         vector to processor for particular object type


    ;---------------------------------------------------------------------------
    ; Now process the blank stack.  This stack holds all the recently blanked squares
    ; and determines (and moves) BOXs or diamonds into these squares.  The space vacated
    ; by these objects are added again to the blank stack.

doBlanks        inc ScreenDrawPhase
                ldy BlankStackPtr               ; 3
                beq nextPhase                   ; 2/3           blanks finished!!

    DEFINE_SUBROUTINE ProcessBlankStack ;=892

                lda INTIM                       ;4
                cmp #MINIMUM_SEGTIMEBLANK       ;2
                bcc EarlyAbort                  ;2/3
                STRESS_TIME MINIMUM_SEGTIMEBLANK

                lda #BANK_DRAW_BUFFERS          ;2
                sta SET_BANK_RAM                ;3
                sta RAM_Bank                    ;3
                jsr BlankCreatureInsertion      ;6+853

NextBlank       dec BlankStackPtr               ;5              one less object on the blank stack
                bne ProcessBlankStack           ;2/3

nextPhase       inc ScreenDrawPhase             ;5              obj/blank finished -- let the draw stuff proceed
EarlyAbort      rts                             ;6



    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE SwitchObjects ;=72
; TJ: used by:
; - BANK_FIXED.asm

    ; The game loop has come to an end. The only possible "still happening" thing is the sort, which runs
    ; in parallel with other processes (objects, draw stack, etc). We may or may not want to wait for the
    ; sort to complete.  This code does all the checks needed to switch to the next game frame.

                lda INTIM                       ; 4
                cmp #SEGTIME_SWITCHOBJECTS      ; 2
                bcc EarlyAbort                  ; 2/3= 8
                STRESS_TIME SEGTIME_SWITCHOBJECTS

    ; If we're undertime, then abort. The sort will continue to run, and that's great. Only when
    ; we're at the throttle cutoff do we switch game-frames.

                ;sec
                lda Throttle                    ;3
                sbc #MAX_THROTTLE               ;2
                bcc EarlyAbort                  ;2/3            plenty of time left!

    ; Time is up. But we may be in a cave which requires perfect sorting (e.g., intermission 4)
    ; So we check for these caves, and wait for the sort to complete for those.

                bit caveDisplay                 ;3
                bvc keepFractional              ;2/3            screen does not require complete sort

    ; We have an intermission or screen which requires the sort to go to completion
    ; Check to see if the sort is finished...

                ldy sortPtr                     ;3
                bne EarlyAbort                  ;2/3            sort still in progress, so wait
                ldy sortRequired                ;3
                bpl EarlyAbort                  ;2/3            sort still in progress, so wait

keepFractional  sta Throttle                    ;3              save fractional 'left over' bit


    ; Pause the game with B/W switch:

                lda gameMode
;                ora LookingAround               ; New behavour of looking around pauses creatures when activated.
                bmi .paused                     ; pause flag set

    ; Now that we have completed processing both the object and blanks stacks, we switch
    ; the stack bank pointers for the next time around.

                lda ObjStackNum                 ;3
                eor #1                          ;2
                tax                             ;2
                stx ObjStackNum                 ;3              swap stacks @here

    ; STOP the sort so it doesn't corrupt the "other" object stack. Sort may get a look-in immediately after
    ; this code is finished, so we don't want it to do something unexpected!

                ldy #<(-1)                      ;2
                sty sortRequired                ;3
                iny                             ;2              Y==0
                sty sortPtr                     ;3

    ; Initialise the iterator and stack pointer for next time around.
    ; Previously the stack pointer auto-initialised by popping the stack. Now we have an iterator it's
    ; necessary to initialise both.

                sty ObjIterator                 ;3              Y==0
                sty ObjStackPtr,x               ;4

                sty ScreenDrawPhase             ;3
.paused
quickExit       rts                             ;6

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE PROCESS_MAN
; TJ: used by:
; - BANK_INITBANK.asm

                lda INTIM
                cmp #SEGTIME_MAN
                bcc EarlyAbort
                STRESS_TIME SEGTIME_MAN

                lda #BANK_GetJoystickForDemoMode
                sta SET_BANK
                jsr GetJoystickForDemoMode      ; 2 player/2 joysticks

                lda #BANK_ManProcess
                sta ROM_Bank
                sta SET_BANK
                jsr ManProcess

                jsr MovePlayer                  ; 6+{}

                lda specialTimeFlag
                bpl quickExit                  ; time problem (e.g., bigbang)

                lda #BANK_AdvanceJoystick       ;
                sta SET_BANK                    ;
                jsr AdvanceJoystick             ;11+49      2 player/2 joysticks

                lda #BANK_TrackPlayer           ;
                sta SET_BANK                    ;
                jsr TrackPlayer                 ;11+145

                lda #TYPE_MAN                   ; 2
                sta POS_Type                    ; 3

                jsr InsertObjectStack           ; 6+76(B)          re-insert man (POS X/Y DOESN'T MATTER)
gnobj           jmp NextObject

    ;---------------------------------------------------------------------------


    DEFINE_SUBROUTINE RestoreOriginalCharacter     ;=93[-2](A)
; TJ: used by:
; - BANK_FIXED.asm
; - BANK_INITBANK.asm

                ldx POS_Y                       ;3
                ldy POS_X                       ;3

                lda #BANK_BoardLineStartLO      ;2
                sta SET_BANK                    ;3

                lda BoardLineStartLO,x          ;4
                sta Board_AddressW              ;3
                lda BoardLineStartHiW,x         ;4
                sta Board_AddressW+1            ;3 WRITE address
        IF MULTI_BANK_BOARD = YES
                lda BoardBank,x                 ;4 switch this on return
        ELSE
                lda #BANK_BOARD                 ;2
        ENDIF
                sta SET_BANK_RAM                ;3

                lda POS_VAR           ;3
                sta (Board_AddressW),y          ;6 clear vacated board position

                ;lda #BANK_DRAW_BUFFERS          ;2
                ;sta SET_BANK_RAM                ;3
                ;jsr InsertBlankStack            ;6+30(A)

                lda ROM_Bank                    ;3
                sta SET_BANK                    ;3
                rts                             ;6


    DEFINE_SUBROUTINE BlankOriginalLocation     ;=93[-2](A)
; TJ: used by:
; - BANK_FIXED.asm
; - BANK_INITBANK.asm

                ldx POS_Y                       ;3
                ldy POS_X                       ;3

    DEFINE_SUBROUTINE BlankOriginalLocationXY   ;=87[-2](A)

                lda #BANK_BoardLineStartLO      ;2
                sta SET_BANK                    ;3

                lda BoardLineStartLO,x          ;4
                sta Board_AddressW              ;3
                lda BoardLineStartHiW,x         ;4
                sta Board_AddressW+1            ;3 WRITE address
        IF MULTI_BANK_BOARD = YES
                lda BoardBank,x                 ;4 switch this on return
        ELSE
                lda #BANK_BOARD                 ;2
        ENDIF
                sta SET_BANK_RAM                ;3

                lda #CHARACTER_BLANK            ;2
                sta (Board_AddressW),y          ;6 clear vacated board position

                ;lda #BANK_DRAW_BUFFERS          ;2
                ;sta SET_BANK_RAM                ;3
                ;jsr InsertBlankStack            ;6+30(A)

                lda ROM_Bank                    ;3
                sta SET_BANK                    ;3

EarlyAbortBOX

                rts                             ;6

    ;---------------------------------------------------------------------------

; IF the creature runs out of time to do stuff, then rts HOWEVER the creature must eventually do something
;  as it will be continually called in available time-slices until it does. This can lockup the system.

; if the creature is done, and is alive next cycle, then jump ReInsertObject

; if the creature dies then jump NextObject


    DEFINE_SUBROUTINE PROCESS_BOX
    DEFINE_SUBROUTINE PROCESS_DIAMOND
; TJ: used by:
; - BANK_INITBANK.asm

                lda INTIM                       ;4
                cmp #SEGTIME_BOX1           ;2
                bcc EarlyAbortBOX           ;2/3
                STRESS_TIME SEGTIME_BOX1

                lda POS_X                       ;3
                sta POS_X_NEW                   ;3
                ldy POS_Y                       ;3
                sty POS_Y_NEW                   ;3

    ; Make sure the character we're working with is still the same type of object
    ; (for example, a 'BOX' placed on the object stack by the blank stack
    ; handler, may no longer be there, so it's really a dummy).

                ;ldy POS_Y                       ;3

                lda #BANK_GetBoardAddressR      ;
                sta SET_BANK                    ;
                jsr GetBoardAddressR            ;11+24[-2](A)
                sta SET_BANK_RAM                ;3

                ldy POS_X                       ;3
                lax (Board_AddressR),y          ;5
                lda CharToType,x                ;4
                cmp POS_Type                    ;3
                ;bne gnobj                       ;2/3

                jmp NotStraightDown     ; Sokoban ovveride


NotEnoughTime2
                rts

NotStraightDown
                lda INTIM
                cmp #SEGTIME_BOX3
                bcc NotEnoughTime2
                STRESS_TIME SEGTIME_BOX3

ProcessBD

        ; Depending on the character UNDER this object (since this object can't fall straight
        ; down), we either fall sideways or not.  Currently we fall if the object we are
        ; on top of is a 'rounded' object AND the two sideways squares are blank.

        ; Note that the object under us may be a NON-ROUNDED (=FALLING) BOX/diamond

                ;;lda GenericCharFlag,x               ; is the object we're sitting on 'rounded'?
                ;;and #GENERIC_MASK_ROUNDED
                ;;bne mayRoundOff

        ; Could have been FALLING character/object type, so replace with a default character on the board

ReplaceFallingChar

                ldy POS_Y

                lda #BANK_GetBoardAddressW          ;
                sta SET_BANK                        ;
                jsr GetBoardAddressW                ;11+24[-2](A)
                stx SET_BANK_RAM                    ;3

                ldy POS_X
                ldx POS_Type
                lda BaseTypeCharacter,x             ; original character base character
                sta (Board_AddressW),y              ; draw object in new location (Y = new X posn)

                ; We have just...
                ; a) Rolled off a rounded object, or...  (TJ, TODO: Original makes no sound here)
                ; b) Hit an object which we can't squash
                ; So, play a terminating sound but only if the object was already falling

                jsr StartSoundCheckAlreadyFalling
silentAlways
wasNotFalling   jmp NextObject                      ; no, so we can't roll off it. Object becomes quiescent.

        ; The object underneath is rounded, so we may roll off it.  We preferentially roll
        ; to the left.  Rolling involves moving sideways if the square to the side is blank AND
        ; the one below that one is squashable.  Here we get the 4 squares which will be
        ; involved in the calcs...
;;mayRoundOff                                         ; y == POS_X
;;                dey
;;                lda (Board_AddressR),y              ; leftward of row UNDERNEATH
;;                sta BOXLeft
;;                iny
;;                iny
;;                lda (Board_AddressR),y
;;                sta BOXRight                    ; rightward of row UNDERNEATH

;;                ldy POS_Y

;;                lda #BANK_GetBoardAddressR          ;
;;                sta SET_BANK                        ;
;;                jsr GetBoardAddressR                ;11+24[-2](A)
;;                sta SET_BANK_RAM                    ;3

;;                ldy POS_X
;;                dey
;;                lda (Board_AddressR),y              ; leftward of current row

;;                ora BOXLeft                     ; check for the movement left/down
;;                bne MayRollRight                    ; there must be NOTHING in the left squares

;;                dec POS_X_NEW                       ; new position (LEFT)
;;                bpl BlankDownSound                  ; unconditional

;;MayRollRight

    ; check for the movement right/down
;;                iny
;;                iny
;;                lda (Board_AddressR),y              ; rightward of current row
;;                ora BOXRight
;;                bne ReplaceFallingChar              ; there must be NOTHING in the right squares

;;                inc POS_X_NEW                       ; new position (RIGHT)

;;BlankDownSound:

;;                jsr StartSoundCheckAlreadyFalling   ; prevent a sound if the object wasn't already falling
;;                lda #VAR_FALLING                    ; this prevents a sound in the following
;;                sta POS_VAR                         ; ...call to StartSoundCheckFalling

;;BlankDown

;;                lda INTIM
;;                cmp #SEGTIME_BOX4
;;                bcc NotEnoughTime
;;                STRESS_TIME SEGTIME_BOX4

    ; The object is 'falling' into position (POS_X_NEW,POS_Y_NEW)
    ; object starts falling, so we play a sound here too:

;;                lda #<(~VAR_FALLING)                ; do not start if already falling
;;                jsr StartSoundCheckFalling

;;                lda #VAR_FALLING
;;                sta POS_VAR

                ;lda POS_VAR
                ;ora #VAR_FALLING
                ;sta POS_VAR                         ; indicate object *is* falling

;;                jsr BlankOriginalLocation       ;6+97(A)        blank/stack previous position

;;                ldy POS_Y_NEW
;;                sty POS_Y

;;                lda #BANK_GetBoardAddressW          ;
;;                sta SET_BANK                        ;
;;                jsr GetBoardAddressW                ;11+24[-2](A)
;;                stx SET_BANK_RAM                    ;3

;;                ldy POS_X_NEW
;;                sty POS_X

;;                ldx POS_Type
;;                lda BaseTypeCharacterFalling,x               ; original character base character
;;                sta (Board_AddressW),y                       ; draw object in new location (Y = new X posn)

ReInsertObject  jsr InsertObjectStack           ; 6+76(B)  = 98 (if jumping here)        place on stack so it keeps moving

NextObject
                inc ObjIterator                 ; 5
;                dec ObjStackPtr,x               ; 6
                jmp ProcessObjStack             ; 3 = 16

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE StartSoundCheckAlreadyFalling
; TJ: used by:
; - BANK_FIXED.asm
                lda #VAR_FALLING                ; play ONLY if we were already falling
    DEFINE_SUBROUTINE StartSoundCheckFalling
                eor POS_VAR                     ; check if already falling or not
                bmi .noSound                    ; <--- DANGEROUS assumption of flag value
    DEFINE_SUBROUTINE StartSoundAlways
                ldy POS_Type
                lda newSounds
                and #SND_MASK_LO                ; already a new sound triggerd?
                cmp #SOUND_MOVE_SOIL+1          ; except for low priority move sounds!
                bcs .noSound                    ; yes, no new sound
                eor newSounds
                ora FallSoundTbl-TYPE_BOX,y
                sta newSounds
.noSound
                rts

    ;---------------------------------------------------------------------------

; Warning: Hardwired dependence on existing TYPE_
; sounds are played when BOXs/diamonds start *and* end falling:
FallSoundTbl:
; TJ: used by:
; - BANK_FIXED.asm
                .byte   SOUND_BOX           ; TYPE_BOX
                .byte   0
                .byte   0
                .byte   0
                .byte   SOUND_DIAMOND_FALLING   ; TYPE_DIAMOND

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE InsertObjectStackFromRAM ;=94(B)
; TJ: used by:
; - BANK_FIXED.asm
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm

                jsr InsertObjectStack           ;6+76(B)
                lda RAM_Bank                    ;3
                sta SET_BANK_RAM                ;3

NotEnoughTime   rts                             ;6

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE InsertObjectStack ;=81(B)
; TJ: used by:
; - BANK_FIXED.asm
; - BANK_INITBANK.asm

        ; POS_X     x position
        ; POS_Y     y position
        ; POS_VAR   direction or other variable
        ; POS_Type  type of object

                ldx ObjStackNum                 ; 3
                ldy BankObjStack,x              ; 4
                sty SET_BANK_RAM                ; 3
                ldy ObjStackPtr,x               ; 4 = 14


                lda POS_Y                       ; 3
                sta ObjStackY+RAM_WRITE,y       ; 5
                lda POS_X                       ; 3
                sta ObjStackX+RAM_WRITE,y       ; 5
                lda POS_VAR                     ; 3
                sta ObjStackVar+RAM_WRITE,y     ; 5
                lda POS_Type                    ; 3
                sta ObjStackType+RAM_WRITE,y    ; 5 = 32

    ; Nice addition limits overflow of the stack, BUT always reserves a spot for the man.
    ; Objects are unceremoniously dumped when there's not enough space.  This is just trying to cater
    ; for a no-win situation. Try and preserve the player at the cost of correct gameplay. Avoid crashing.


        IF TYPE_MAN != 0
                cmp #TYPE_MAN                   ; 2
        ENDIF
                beq alwaysAllowMan              ; 2/3

                cpy #OBJ_STACK_SIZE-2           ; 2         reserve 1 last-gasp slot for man only
                bcs insertDone                  ; 2/3= 6    no room -- drop object
alwaysAllowMan

                tya                             ; 2
                sta SortedObjPtr+RAM_WRITE,y    ; 5         indirection pointer for later sorting

                inc ObjStackPtr,x               ; 7         overflow is assumed not to happen!
    IF SORT_OBJECTS = YES
                sty sortRequired                ; 3         flag that a sort is required
    ENDIF

insertDone      ldy ROM_Bank                    ; 3
                sty SET_BANK                    ; 3

ManIsDead2      rts                             ; 6 = 29

    ;---------------------------------------------------------------------------

BankObjStack    .byte BANK_OBJSTACK, BANK_OBJSTACK2
; TJ: used by:
; - BANK_FIXED.asm

     ;---------------------------------------------------------------------------


MovePlayer
; TJ: used by:
; - BANK_FIXED.asm
; - BANK_INITBANK.asm
                lda ManMode
                cmp #MANMODE_DEAD
                bcs ManIsDead2

                ldy POS_Y_NEW

                lda #BANK_GetBoardAddressRW         ;2
                sta SET_BANK                        ;3
                sta ROM_Bank                        ;3
                jsr GetBoardAddressRW               ;6+32[-2]
    IF MULTI_BANK_BOARD = YES
                stx RAM_Bank
    ENDIF
                stx SET_BANK_RAM                    ; 3

                ldy POS_X_NEW
                lax (Board_AddressR),y
; TODO: would it makes sense to add a move conversion table?
; that way, the move tables would become much smaller
                lda #BANK_MoveVecLO
                sta SET_BANK

                lda MoveVecLO,x
                sta MAN_Move
                lda MoveVecHI,x
                sta MAN_Move+1

    IF MULTI_BANK_BOARD = YES
                lda RAM_Bank
    ELSE
                lda #BANK_BOARD
    ENDIF
                sta SET_BANK_RAM
                jmp (MAN_Move)

    ;---------------------------------------------------------------------------


MOVE_DIAMOND
; TJ: used by:
; - BANK_FIXED.asm


                lda INTIM
                cmp #SEGTIME_GET_DIAMOND
                ror specialTimeFlag             ; mark any overtime!
                bpl timeExit
                STRESS_TIME SEGTIME_GET_DIAMOND

    IF MULTI_BANK_BOARD = YES
                lda RAM_Bank
    ELSE
                lda #BANK_BOARD
    ENDIF
                sta SET_BANK_RAM
                bpl checkForSnatch              ;3              unconditional

    ;---------------------------------------------------------------------------

MOVE_BLANK
; TJ: used by:
; - BANK_FIXED.asm

    ; The movement sounds are lowest priority. They only trigger if there is a free channel.
    ; The code below checks the two channels and if either is free, uses it for the move sound.

                ldy #SOUND_MOVE_BLANK           ; 2
                NOP_W                           ; 2
MOVE_SOIL       ldy #SOUND_MOVE_SOIL            ; 2
; TJ: used by:
; - BANK_FIXED.asm

    ; lowest priority, look for a free channel, 0 first

                lax newSounds
                and #SND_MASK_LO
                bne .skipUseLow                 ;               LO channel is not available

                tya
                bne .setSound                   ;               unconditional: USE lo channel!

.skipUseLow
                txa
                and #SND_MASK_HI
                bne checkForSnatch              ;2/3            no channel available so skip sound

                tya
                asl
                asl
                asl
                asl                             ;               use requested sound in Hi channel

.setSound       ora newSounds
                sta newSounds

    ;---------------------------------------------------------------------------
    ; Handle snatching...

checkForSnatch


                lda #BANK_BOARD
                sta SET_BANK_RAM

                ldy POS_X_NEW
                lda (Board_AddressR),y
                pha

                lda #CHARACTER_MANOCCUPIED      ; 2
                sta (Board_AddressW),y          ; 6 =  8        the man's new square


                ldx ManY                        ; 3
                stx POS_Y                       ; 3
                ldy ManX                        ; 3
                sty POS_X                       ; 3 = 12

                jsr RestoreOriginalCharacter

                pla
                sta POS_VAR


pastblank                lda POS_X_NEW                   ; 3
                sta ManX                        ; 3
                lda POS_Y_NEW                   ; 3
                sta ManY                        ; 3 = 12        actually MOVE!

MOVE_GENERIC
; TJ: used by:
; - BANK_FIXED.asm
                lda #0                          ; 2
                sta ManPushCounter              ; 3
timeExit        rts                             ; 6 = 11

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE MOVE_BOX
; TJ: used by:
; - BANK_FIXED.asm

                lda #BANK_PushBox
                sta SET_BANK
                jmp PushBox

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE StealCharDraw; in FIXED_BANK
; TJ: used by:
; - BANK_FIXED.asm

                lda #BANK_DRAW_BUFFERS          ; 2
                sta SET_BANK_RAM                ; 3
                ldy DrawStackPointer            ; 3         MUST have been set by BuildDrawStack!
                bpl EnterStealCharDraw          ; 3 = 10(11)

ExitStealCharDraw

    ; fall through...

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE TimeSlice
; TJ: used by:
; - BANK_FIXED.asm

    ; FIRST check the time is sufficient for the smallest of the timeslices. Not much point
    ; going ahead if there's insufficient time. This allows the previous character drawing to
    ; be much smaller in time, as they don't have to include the timeslice code overhead.

                lda INTIM                       ; 4
                cmp #SEGTIME_MINIMUM_TIMESLICE  ; 2
                bcc timeExit                    ; 2(3)

    ; Uses the phase variable to vector to the correct processing code for the given timeslice
    ; Code may be in any bank. Avoid the fixed bank at all costs!  Once a section is complete
    ; it should increment ScreenDrawPhase.

    ; Switched-in bank(s) are undefined after this function is called!

                lda #BANK_TS_PhaseVectorLO      ; 2
                sta SET_BANK                    ; 3

                ldx ScreenDrawPhase             ; 3             current phase of drawing
                lda TS_PhaseVectorLO,x          ; 4
                sta TS_Vector                   ; 3
                lda TS_PhaseVectorHI,x          ; 4
                sta TS_Vector+1                 ; 3

                lda TS_PhaseBank,x              ; 4
                sta SET_BANK                    ; 3             switch bank

                jmp (TS_Vector)                 ; 3 = 40        vector to timeslice handler

                                                ; = 55 minimum return time (if segtime abort)

    ;---------------------------------------------------------------------------


DrawAnother
; TJ: used by:
; - BANK_ROM_SHADOW_RAMBANK.asm

                lda #BANK_DRAW_BUFFERS          ; 2         A = SCREEN_LINES
                sta SET_BANK_RAM                ; 3 =  5

                ldy DrawStackPointer            ; 3 =  3    MUST have been set by BuildDrawStack!

                ldx DrawStack,y                 ; 4         in actuality a character index
                lda ScreenBuffer,x              ; 4         new character to draw
                and #~128                       ; 2
                sta ScreenBuffer+RAM_WRITE,x    ; 4 = 14    clear hint bit

                dey                             ; 2
                sty DrawStackPointer            ; 3         one less to draw
                bmi ExitStealCharDraw           ; 2(3)=7

EnterStealCharDraw:                             ;           RAM bank MUST be at BANK_DRAW_BUFFERS
; TJ: used by:
; - BANK_FIXED.asm

                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_MIN            ; 2
                bcc ExitStealCharDraw           ; 2/3= 8

                ldx DrawStack,y                 ; 4         in actuality a character index
                ldy ScreenBuffer,x              ; 4 =  8    new character to draw

                lda ROW_BankChar,x              ; 4         A = 0..SCREEN_LINES-1
                sta SET_BANK_RAM                ; 3
                jmp StealPart3                  ; 3 = 10    --> 18 cycles after check for SEGTIME_SCD_MIN


    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE BuildDrawStack ; in FIXED BANK
; TJ: used by:
; - BANK_FIXED.asm

                lda #BANK_DRAW_BUFFERS
                sta SET_BANK_RAM
                jmp DrawStackUpdate

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawAIntoStack ; in FIXED BANK
; TJ: used by:
; - BANK_FIXED.asm

                lda #BANK_DRAW_BUFFERS
                sta SET_BANK_RAM
                jmp DrawIntoStack


    ;---------------------------------------------------------------------------


    DEFINE_SUBROUTINE DrawFullScreenMain ;=2484[-89]

    ; Check the screen for all those characters that need to be redrawn
    ; Just copies the mxn grid from the board to a DrawFlags array.  If the entry in
    ; the drawflags array is different to the ScreenBuffer array entry, then the
    ; screenbuffer will need redrawing.

CopyRow2
; TJ: used by:
; - BANK_INITBANK.asm

    IF MULTI_BANK_BOARD = YES
                lda BDF_BoardBank               ; 3
    ELSE
                lda #BANK_BOARD                 ; 2     saves 5*8 = 40 cyles
    ENDIF
                sta SET_BANK_RAM                ; 3
                lax (BDF_BoardAddress),y        ; 5
                txs                             ; 2
                lax (BDF_BoardAddress2),y       ; 5(= 18[-1])

                lda #BANK_DRAW_BUFFERS          ; 2
                sta SET_BANK_RAM                ; 3
                lda CharReplacement,x           ; 4
                sta (BDF_DrawFlagAddress2),y    ; 6
                tsx                             ; 2
                lda CharReplacement,x           ; 4
                sta (BDF_DrawFlagAddress),y     ; 6(= 27)

                dey                             ; 2
                bpl CopyRow2                    ; 2/3=49/50[-1]
; total: 5*49[-1]-1 = 244[-5]

; TJ: examples for multi RAM bank access.
;CopyRow2
;                lax (BDF_BoardAddress),y        ; 5
;                txs                             ; 2
;                lax (BDF_BoardAddress2),y       ; 5(= 12)
;                lda CharReplacement,x           ; 4
;                sta (BDF_DrawFlagAddress2),y    ; 6
;                tsx                             ; 2
;                lda CharReplacement,x           ; 4
;                sta (BDF_DrawFlagAddress),y     ; 6(= 22)
;                dey                             ; 2
;                bpl CopyRow2                    ; 2/3=38/39
;; total: 5*39 - 1 = 194
;
;CopyRow2
;                lax (BDF_BoardAddress),y        ; 5
;                lda CharReplacement,x           ; 4
;                sta (BDF_DrawFlagAddress),y     ; 6(= 15)
;                dey                             ; 2
;                bpl CopyRow2                    ; 2/3=19/20
;; total: 10*20 - 1 = 199 (and much less setup code)

                lax DHS_Line                    ; 3
                beq .exitCopy                   ; 2/3= 5/6

                ldy #BANK_DrawScreenRowPreparation;2
                sty SET_BANK                    ; 3
                jmp DrawScreenRowPreparation    ;55[-7] = 60[-7]

; total: (244[-5]+5)*8 + 60[-7]*7 + 1 + 11 = 2424[-89]


                CHECKPAGEX CopyRow2, "CopyRow2 in BANK_FIXED.asm"

.exitCopy       ldx DHS_Stack                   ; 3
                txs                             ; 2

                jmp BuildDrawStack

SwitchPhaseR    rts                             ; 6 = 11

    ;---------------------------------------------------------------------------

Reset
; TJ: used by:
; - BANK_FIXED.asm

                CLEAN_START

    ; Scoring bank is copied once (not per game, not per level...)
    ; otherwise non-SaveKey high score gets zapped

                ldx #ROM_SHADOW_OF_BANK_SCORING
                ldy #BANK_SCORING
                jsr CopyROM2RAM_F000

Restart     ; go here on RESET + SELECT
; TJ: used by:
; - BANK_INITBANK.asm


Title
                ldx #$ff                    ; adjust stack pointer after RESET + SELECT
                txs

                lda #BANK_TitleScreen           ; 2
                sta SET_BANK                    ; 3
                jmp TitleScreen                 ; 3+x
ExitTitleScreen:
    ; temporary vars from title screen are used to init level/cave
                lda #BANK_Cart_Init             ; 2
                sta SET_BANK                    ; 3
                jsr Cart_Init                   ; 6+x


    ;---------------------------------------------------------------------------


SEGMENT_DECODE_CAVE_SHADOW = $F000      ; if not = $F000, this will cause an assertion failure

                ldx #BANK_DECODE_CAVE_SHADOW
                ldy #BANK_DECODE_CAVE
                jsr CopyROM2RAM_F000


    ;---------------------------------------------------------------------------
    ; Once-only game initialisation goes here...
    ; now we have two players so things get a bit tricky

                lda #BANK_SCORING
                sta SET_BANK_RAM
                jsr GameInitialise


    ;---------------------------------------------------------------------------

RestartCaveNextPlayer
; TJ: used by:
; - BANK_FIXED.asm

    ; a player has lost a life.
    ; store his vars, swap to other player, continue

                ;lda #BANK_SCORING
                ;sta SET_BANK_RAM
                ;jsr SwapPlayers

                lda #BANK_SwapPlayersGeneric
                sta SET_BANK
                jsr SwapPlayersGeneric


                lda MenCurrent
                beq Title                           ; all lives lost! (works for both P1P2)
                bne skipDemoCheck

NextCaveLevel
                bit demoMode
                bmi Title
skipDemoCheck

    ; Initialise all in-game variables; those that must be re-initialised at the start of each level,
    ; including those for general systems function. But NOT those which do not need re-initialising between
    ; levels.
                lda #BANK_LevelInit             ; 2
                sta SET_BANK                    ; 3
                jsr LevelInit                   ; 6+x

                lda #BANK_DECODE_CAVE
                sta SET_BANK_RAM
                jsr DecodeCave

    ; Setup player animation and scroll limits.
    ; Mangle the board colours based on level

                lda #BANK_CreateCreatures       ; 2
                sta SET_BANK                    ; 3
                jsr CreateCreatures             ; 6+x


    ; Setup the various digit and display pointers
    ; Grab current player's score/cave/level from backup

                jsr goGeneralScoringSetups

    ; copy the screen draw ROM shadow to RAM

                ldy #SCREEN_LINES-1
CopyScreenBanks ldx #ROM_SHADOW_OF_RAMBANK_CODE
                jsr CopyROM2RAM_F000               ; copy draw ROMShadow to RAM
                jsr SetPlatformColours             ; set NTSC or PAL RGB values for draw + index
                dey
                bpl CopyScreenBanks

                ldx #ROM_SHADOW_OF_BANK_DRAW_BUFFERS
                ldy #BANK_DRAW_BUFFERS
                jsr CopyROMShadowToRAM_F000

    ;---------------------------------------------------------------------------

                lda #BANK_Resync                ; 2
                sta SET_BANK                    ; 3
                jsr Resync                      ; 6+x

NewFrameBD
    ; the (at least) 220 cycles wasted in the above... bugs me!
    ; the below is an unrolled version.  I've moved some other code between the sync writes, effectively saving um... 22 cycles/frame.
    ; This required TIM64T values to be increased by 1 for each platform (we have actually gained back some usable time :)

                bit NextLevelTrigger
                bpl NextCaveLevel               ; game-triggered next level
                bvs RestartCaveNextPlayer       ; loss of life

    ; Note: VSYNC must NOT be on when starting a new cave! Else you get annoying TV signals.

                lda #%1110                       ; VSYNC ON
.loopVSync      sta WSYNC
                sta VSYNC
                lsr
                bne .loopVSync                  ; branch until VYSNC has been reset

 ; moved *after* the loop since this allows to *increase* timer values by 1!

                ldx Platform
                ldy VBlankTime,x
                sty TIM64T

                ldx #BANK_PlaySounds
                stx SET_BANK

    ;---------------------------------------------------------------------------
    ; Do not separate code, as bank assumption is made

                jsr PlaySounds                  ; 6+x   Jentzsch sound system

                jsr StealCharDraw               ; NOTE THIS IS THE *ONLY* AREA BIG ENOUGH FOR > 30 INTIM NEEDS
    IF SORT_OBJECTS = YES
                jsr SortObjects2                ; 6+15 mininum. Opportunistic sorting
    ENDIF

    ;---------------------------------------------------------------------------
    ; START OF DISPLAY

                lda #BANK_SCORING               ; 2
                sta SET_BANK_RAM                ; 3
                jsr DrawDigits                  ; 6 = 11

    ;---------------------------------------------------------------------------
    ; A 42-cycle timing window in the screen draw code.  Perform any general
    ; per-frame code here, provided it takes exactly 42 cycles to execute.
    ; TJ: Well, not exactly 42 cycles, but it works! :)
                                            ;       @09
                sta COLUBK                  ; 3     value comes from subroutine
                                            ; + the 'black' left-side of top screen colour change when look-around is actually a HMOVE bar, so we can't fix it :)


;                inc Throttle                ; 5     speed limiter
                SLEEP 5                     ;       TODO: optimize for space

                lda #%00010101              ; 2     double width missile, double width player
                dex                         ; 2     = $6f, stars effect!
                stx HMM0                    ; 3     @24, exactly 21 cycles after the HMOVE

                sta NUSIZ0                  ; 3
                sty VDELP0                  ; 3     y = 0!

                iny                         ; 2     this relies on Y == 0 before...
                cpy extraLifeTimer          ; 3     ..,and bit 0 is set in A
                adc #2                      ; 2
                sta ENAM0                   ; 3     dis/enable Cosmic Ark star effect

                lda ManLastDirection        ; 3
                sta REFP0                   ; 3

                lda #BANK_SCREENMARKII1     ; 2
                sta SET_BANK_RAM            ; 3
                jsr DrawTheScreen           ; 6     @57 from RAM, no less!!
                                            ;       @66
                lda #BANK_PostScreenCleanup ; 2
                sta SET_BANK                ; 3
                jsr PostScreenCleanup       ; 6+x

                lda #BANK_SelfModDrawPlayers; 2
                sta SET_BANK                ; 3
                jsr SelfModDrawPlayers      ; 6+x

                jsr StealCharDraw
    IF SORT_OBJECTS = YES
                jsr SortObjects2            ;6+15 minimum  Opportunistic sorting
    ENDIF

OverscanBD      lda INTIM                   ;4
                bne OverscanBD              ;2/3
                beq NewFrameBD              ;3      unconditional

VBlankTime
; TJ: used by:
; - BANK_FIXED.asm
                .byte VBLANK_TIM_NTSC, VBLANK_TIM_NTSC
                .byte VBLANK_TIM_PAL, VBLANK_TIM_NTSC

    ;---------------------------------------------------------------------------

CharacterDataVecLO
; TJ: used by:
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm

    ; Two entries per character.  2nd is ptr to mirrored character
    ; Characters don't have to be mirrored, obviously -- use the same pointer for both!

                .byte <CHARACTERSHAPE_BLANK
                .byte <CHARACTERSHAPE_BLANK
                .byte <CHARACTERSHAPE_SOIL
                .byte <CHARACTERSHAPE_SOIL_MIRRORED
                .byte <CHARACTERSHAPE_BOX
                .byte <CHARACTERSHAPE_BOX_MIRRORED
                .byte <0
                .byte <0
                .byte <CHARACTERSHAPE_DIAMOND
                .byte <CHARACTERSHAPE_DIAMOND_MIRRORED
                .byte <CHARACTERSHAPE_DIAMOND2
                .byte <CHARACTERSHAPE_DIAMOND2_MIRRORED
                .byte <CHARACTERSHAPE_BLANK
                .byte <CHARACTERSHAPE_BLANK
                .byte <0
                .byte <0
                .byte <0
                .byte <0
                .byte <0
                .byte <0
                .byte <0
                .byte <0
                .byte <CHARACTERSHAPE_WALL0
                .byte <CHARACTERSHAPE_WALL0_MIRRORED
                .byte <CHARACTERSHAPE_WALL1
                .byte <CHARACTERSHAPE_WALL1
                .byte <CHARACTERSHAPE_WALL0
                .byte <CHARACTERSHAPE_WALL0
                .byte <CHARACTERSHAPE_WALL2
                .byte <CHARACTERSHAPE_WALL2
                .byte <CHARACTERSHAPE_STEEL
                .byte <CHARACTERSHAPE_STEEL_MIRRORED
                .byte <CHARACTERSHAPE_WALL
                .byte <CHARACTERSHAPE_WALL_MIRRORED
                .byte <CHARACTERSHAPE_EXITDOOR
                .byte <CHARACTERSHAPE_EXITDOOR_MIRRORED
                .byte <CHARACTERSHAPE_EXITDOOR2
                .byte <CHARACTERSHAPE_EXITDOOR2

                .byte <CHARACTERSHAPE_EXPLOSION
                .byte <CHARACTERSHAPE_EXPLOSION_MIRRORED
                .byte <CHARACTERSHAPE_EXPLOSION1
                .byte <CHARACTERSHAPE_EXPLOSION1_MIRRORED
                .byte <CHARACTERSHAPE_EXPLOSION2
                .byte <CHARACTERSHAPE_EXPLOSION2_MIRRORED
                .byte <CHARACTERSHAPE_EXPLOSION3
                .byte <CHARACTERSHAPE_EXPLOSION3_MIRRORED

                .byte <0
                .byte <0

                .byte <CHARACTERSHAPE_BOX                   ; falling BOX
                .byte <CHARACTERSHAPE_BOX_MIRRORED          ; falling BOX
                .byte <CHARACTERSHAPE_DIAMOND                   ; falling diamond
                .byte <CHARACTERSHAPE_DIAMOND_MIRRORED          ; falling diamond

                .byte <CHARACTERSHAPE_BLANK                     ; unkillable man
                .byte <CHARACTERSHAPE_BLANK                     ; unkillable man

    IF * - CharacterDataVecLO < CHARACTER_MAXIMUM*2
        ECHO "ERROR: Missing entry in CharacterDataVecLO table!"
        EXIT
    ENDIF

    ;---------------------------------------------------------------------------

CharacterDataVecHI
; TJ: used by:
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm

                .byte ( >CHARACTERSHAPE_BLANK ) & $7F
                .byte ( >CHARACTERSHAPE_BLANK ) & $7F
                .byte >CHARACTERSHAPE_SOIL
                .byte >CHARACTERSHAPE_SOIL_MIRRORED
                .byte >CHARACTERSHAPE_BOX
                .byte >CHARACTERSHAPE_BOX_MIRRORED
                .byte >0
                .byte >0
                .byte >CHARACTERSHAPE_DIAMOND
                .byte >CHARACTERSHAPE_DIAMOND_MIRRORED
                .byte >CHARACTERSHAPE_DIAMOND2
                .byte >CHARACTERSHAPE_DIAMOND2_MIRRORED
                .byte ( >CHARACTERSHAPE_BLANK ) & $7F ;manoccupied
                .byte ( >CHARACTERSHAPE_BLANK ) & $7F ;manoccupied
                .byte >0
                .byte >0
                .byte >0
                .byte >0
                .byte >0
                .byte >0
                .byte >0
                .byte >0
                .byte >CHARACTERSHAPE_WALL0
                .byte >CHARACTERSHAPE_WALL0_MIRRORED
                .byte >CHARACTERSHAPE_WALL1
                .byte >CHARACTERSHAPE_WALL1
                .byte >CHARACTERSHAPE_WALL0
                .byte >CHARACTERSHAPE_WALL0
                .byte >CHARACTERSHAPE_WALL2
                .byte >CHARACTERSHAPE_WALL2
                .byte >CHARACTERSHAPE_STEEL
                .byte >CHARACTERSHAPE_STEEL_MIRRORED
                .byte >CHARACTERSHAPE_WALL
                .byte >CHARACTERSHAPE_WALL_MIRRORED
                .byte >CHARACTERSHAPE_EXITDOOR
                .byte >CHARACTERSHAPE_EXITDOOR_MIRRORED
                .byte ( >CHARACTERSHAPE_EXITDOOR2 ) & $7F
                .byte ( >CHARACTERSHAPE_EXITDOOR2 ) & $7F

                .byte >CHARACTERSHAPE_EXPLOSION
                .byte >CHARACTERSHAPE_EXPLOSION_MIRRORED
                .byte >CHARACTERSHAPE_EXPLOSION1
                .byte >CHARACTERSHAPE_EXPLOSION1_MIRRORED
                .byte >CHARACTERSHAPE_EXPLOSION2
                .byte >CHARACTERSHAPE_EXPLOSION2_MIRRORED
                .byte >CHARACTERSHAPE_EXPLOSION3
                .byte >CHARACTERSHAPE_EXPLOSION3_MIRRORED

                .byte >0
                .byte >0

                .byte >CHARACTERSHAPE_BOX                   ; falling BOX
                .byte >CHARACTERSHAPE_BOX_MIRRORED          ; falling BOX
                .byte >CHARACTERSHAPE_DIAMOND                   ; falling diamond
                .byte >CHARACTERSHAPE_DIAMOND_MIRRORED          ; falling diamond

                .byte >CHARACTERSHAPE_BLANK                     ; unkillable man
                .byte >CHARACTERSHAPE_BLANK                     ; unkillable man

    IF * - CharacterDataVecHI < CHARACTER_MAXIMUM*2
        ECHO "ERROR: Missing entry in CharacterDataVecHI table!"
        EXIT
    ENDIF

    ;---------------------------------------------------------------------------

GenericCharFlag
; TJ: used by:
; - BANK_FIXED.asm
; - BANK_INITBANK.asm
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm

    ; Tells us information about a particular character.  Multiple bits define characteristics
    ; of how the character behaves during gameplay.

                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_SQUASHABLE                              ; blank
                .byte GENERIC_MASK_EXPLODABLE                                                      ; soil
                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_ROUNDED|GENERIC_MASK_FALLABLE           ; BOX
                .byte 0                                                                            ; <unused>
                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_ROUNDED|GENERIC_MASK_FALLABLE           ; diamond
                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_ROUNDED|GENERIC_MASK_FALLABLE           ; diamond2
                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_SQUASHABLE|GENERIC_MASK_KILLSBUTTERFLY  ; man

    ; Note: Butterflies and fireflies are not explodable, to prevent chain-reactions

                .byte 0                                                      ; unused
                .byte 0                                                      ; unused
                .byte 0                                                      ; unused
                .byte 0                                                      ; unused
                .byte GENERIC_MASK_SQUASHABLE|GENERIC_MASK_MAGICWALL                               ; magic wall
                .byte GENERIC_MASK_SQUASHABLE|GENERIC_MASK_MAGICWALL                               ; magic wall
                .byte GENERIC_MASK_SQUASHABLE|GENERIC_MASK_MAGICWALL                               ; magic wall
                .byte GENERIC_MASK_SQUASHABLE|GENERIC_MASK_MAGICWALL                               ; magic wall
                .byte 0                                                                            ; steel wall
                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_ROUNDED                                 ; plain brick wall
                .byte 0                                                                            ; exit
                .byte 0                                                                            ; exit
                .byte 0                                                                            ; explosion
                .byte 0                                                                            ; explosion 1
                .byte 0                                                                            ; explosion 2
                .byte 0                                                                            ; explosion 3
                .byte 0

                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_ROUNDED                                 ; falling BOX
                .byte GENERIC_MASK_EXPLODABLE|GENERIC_MASK_ROUNDED                                 ; falling diamond

                .byte 0                                                                            ; unkillable man

    IF * - GenericCharFlag < CHARACTER_MAXIMUM
        ECHO "ERROR: Missing entry in GenericCharFlag table!"
        EXIT
    ENDIF

    ;---------------------------------------------------------------------------

BaseTypeCharacter
; TJ: used by:
; - BANK_FIXED.asm

    ; Given an object type, gives a base character to use for that type
    ; essentially the conversion BaseTypeCharacer[ TYPE ] --> character

                .byte CHARACTER_MANOCCUPIED
                .byte CHARACTER_BOX
                .byte 0
                .byte 0
                .byte 0
                .byte CHARACTER_DIAMOND
                .byte CHARACTER_WALL0
                .byte CHARACTER_EXITDOOR        ; exit door
                .byte CHARACTER_BLANK           ; select
                .byte CHARACTER_EXPLOSION
                .byte CHARACTER_EXPLOSION1
                .byte CHARACTER_EXPLOSION2
                .byte CHARACTER_EXPLOSION3
                .byte CHARACTER_BLANK
                .byte CHARACTER_SOIL
                .byte CHARACTER_STEEL
                .byte CHARACTER_WALL

                ;--> if adding types, also see InitialFace in DecodeCave.asm

    IF * - BaseTypeCharacter < TYPE_MAXIMUM
        ECHO "ERROR: Missing entry in BaseTypeCharacter table!"
        EXIT
    ENDIF

    ;---------------------------------------------------------------------------

BaseTypeCharacterFalling
; TJ: used by:
; - BANK_FIXED.asm

    ; Given an object type, gives a base character to use for that type
    ; essentially the conversion BaseTypeCharacer[ TYPE ] --> character

                .byte CHARACTER_MANOCCUPIED
                .byte CHARACTER_BOX_FALLING
                .byte 0
                .byte 0
                .byte 0
                .byte CHARACTER_DIAMOND_FALLING
                .byte CHARACTER_WALL0
                .byte CHARACTER_EXITDOOR        ; exit door
                .byte CHARACTER_BLANK           ; select
                .byte CHARACTER_EXPLOSION
                .byte CHARACTER_EXPLOSION1
                .byte CHARACTER_EXPLOSION2
                .byte CHARACTER_EXPLOSION3
                .byte CHARACTER_BLANK
                .byte CHARACTER_SOIL
                .byte CHARACTER_STEEL
                .byte CHARACTER_WALL

                ;--> if adding types, also see InitialFace in DecodeCave.asm

    IF * - BaseTypeCharacterFalling < TYPE_MAXIMUM
        ECHO "ERROR: Missing entry in BaseTypeCharacterFalling table!"
        EXIT
    ENDIF

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE CharToType ; in FIXED_BANK
; TJ: used by:
; - BANK_FIXED.asm
; - BANK_INITBANK.asm

    ; Converts a character # to a creature type
    ; add 128 if character is NOT to be added as a creature on board draw

                .byte TYPE_BLANK            ;  0    blank
                .byte TYPE_SOIL             ;  1    soil
                .byte TYPE_BOX          ;  2
                .byte 0                    ;  3
                .byte TYPE_DIAMOND          ;  4
                .byte TYPE_DIAMOND          ;  5
                .byte TYPE_MAN              ;  6
                .byte 0        ;  7
                .byte 0        ;  8
                .byte 0          ;  9
                .byte 0          ; 0a
                .byte TYPE_MAGICWALL        ; 0b
                .byte TYPE_MAGICWALL        ; 0c
                .byte TYPE_MAGICWALL        ; 0d
                .byte TYPE_MAGICWALL        ; 0e
                .byte TYPE_STEELWALL        ; 0f     ; steel wall
                .byte TYPE_BRICKWALL        ; 10     ; plain brick wall
                .byte TYPE_EXITDOOR         ; 11
                .byte TYPE_EXITDOOR         ; 12
                .byte TYPE_EXPLOSION        ; 13
                .byte TYPE_EXPLOSION1       ; 14
                .byte TYPE_EXPLOSION2       ; 15
                .byte TYPE_EXPLOSION3       ; 16
                .byte 0           ; 17

                .byte TYPE_BOX          ; falling BOX
                .byte TYPE_DIAMOND          ; falling diamond

                .byte TYPE_BLANK            ; 20 unkillable man
                 ; --> see also MoveVec
                 ; --> see also DecodeCave's table

    IF * - CharToType < CHARACTER_MAXIMUM
        ECHO "ERROR: Missing entry in CharToType table!"
        EXIT
    ENDIF

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE AnimateCharReplacements2 ;139
; TJ: used by:
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm

    ; This manages character animation on a per-object basis.  Morph/animate these
    ; characters individually or as required.  Change will affect all characters
    ; of the same type in the visible display.

    ; -------------------------------------------
    ; The door will animate when it is 'open'. It's open when the required number of diamonds have been
    ; collected. This in turn triggers the "extra diamonds" flag for scoring, so that is used to determine
    ; when the door should flash.

                bit scoringFlags                                ;3
                bpl NoDoor                                      ;2/3            extra diamonds (D7) set when door animates

                lda ANIM_EXITDOOR                               ;4
                eor #CHARACTER_EXITDOOR2^CHARACTER_EXITDOOR     ;2
                sta ANIM_EXITDOOR + RAM_WRITE                   ;4 = 22         exit door
NoDoor

    ; -------------------------------------------

    ; handle the non-mandatory animating things

                lda timer                                       ;3
                and #%11                                        ;2
                bne nothingAnimates                             ;2/3

                lda scrollBits                                  ;3
                bne nothingAnimates                             ;2/3            DON'T animate if we scrolled

                lda ANIM_DIAMOND                                ;4
                eor #CHARACTER_DIAMOND^CHARACTER_DIAMOND2       ;2
                sta ANIM_DIAMOND + RAM_WRITE                    ;4 = 15         diamond

nothingAnimates jmp retAnim                                     ;3

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE ScoreAdd
; TJ: used by:
; - BANK_INITBANK.asm
                ldx #BANK_SCORING
                stx SET_BANK_RAM
                jsr UpdateScore
rbret           lda ROM_Bank
                sta SET_BANK
                rts

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE nextLevelMan
; TJ: used by:
; - BANK_INITBANK.asm
                lda #BANK_NextCave
                sta SET_BANK
                jmp NextCave

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE SortObjects2 ;=128(A), minimum 15 @ segtime exit
; TJ: used by:
; - BANK_FIXED.asm

                lda INTIM                       ;4
                cmp #MINIMUM_SORT_TIME          ;2
                bcc .sortExit                   ;2(3)=8        insufficient time
                STRESS_TIME MINIMUM_SORT_TIME

                ldx ObjStackNum                 ;3
                lda BankObjStack,x              ;4
                sta SET_BANK_RAM                ;3
                jmp .enterSort                  ;3 = 13

restartSort                                     ;  = 11

    ; So there's another sort 'starting' and we reset the ptr to the end of the obj list

    ; retrieve size of list to sort
                lda #<(-1)                      ;2
                sta sortRequired                ;3              flag that we're DOING it

                ldx ObjStackNum                 ;3
                ldy ObjStackPtr,x               ;4              index of 1st free slot = # slots in use
                dey                             ;2
                sty sortPtr                     ;3              earlier potential swappable object
                beq .sortExit                   ;2/3

midSort                                         ;  =  6

                lda SortedObjPtr,y              ;4              y = sortPtr!
                ldx SortedObjPtr-1,y            ;4              the 'current' object looking to be sorted correctly
                tay                             ;2

                lda ObjStackY,x                 ;4
                cmp ObjStackY,y                 ;4
                bcc earlierObject               ;2(3)
                bne swapAround                  ;2(3)

                lda ObjStackX,y                 ;4
                cmp ObjStackX,x                 ;4
                bcs earlierObject               ;2(3)           WE DO NOT WANT TO SWAP IF == OTHERWISE LOCKUP

swapAround                                      ;   = 32 max.
                tya                             ;2              y = SortedObjPtr[sortPtr]
                ldy sortPtr                     ;3
                sta SortedObjPtr+RAM_WRITE-1,y  ;5
                txa                             ;2              x = SortedObjPtr[sortPtr-1]
                sta SortedObjPtr+RAM_WRITE,y    ;5
                sty sortRequired                ;3 = 20         as we've done a swap, ensure another pass (ANY non-neg value)

earlierObject   dec sortPtr                     ;5 =  5         look at earlier object

                lda INTIM                       ;4
                cmp #MINIMUM_SORT_TIME          ;2
                bcc .sortExit                   ;2(3)=8        insufficient time
                STRESS_TIME MINIMUM_SORT_TIME
; loop max: 71 cycles, + 15 for exit + overhead outside
; -> MINIMUM_SORT_TIME = ceiling(86/64)+1 = 3
; TJ: I do not count the 1st INTIM, that's why I have 4 cylces less.
.enterSort
                ldy sortPtr                     ;3              sort 'stops' when potential swappable objects run out
                bne midSort                     ;2(3)=5
                lda sortRequired                ;3              AND there were no more sort requests
                bpl restartSort                 ;2(3)=5

.sortExit       rts                             ;6              completed sort! (or time exit)


    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE goGeneralScoringSetups
; TJ: used by:
; - BANK_INITBANK.asm
                lda #BANK_SCORING
                sta SET_BANK_RAM
                jsr GeneralScoringSetups
                lda ROM_Bank
                sta SET_BANK
                rts


    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE CopyROM2RAM_F000
; TJ: used by:
; - BANK_FIXED.asm

                lda #BANK_CopyROMShadowToRAM
                sta SET_BANK
                sta ROM_Bank
                jmp CopyROMShadowToRAM_F000


    ;---------------------------------------------------------------------------
; TJ: used by:
; - BANK_ROM_SHADOW_DRAWBUFFERS.asm
    include "BOX.asm"         ; 2 * LINES_PER_CHAR bytes
    include "Butterfly.asm"       ; 2 * LINES_PER_CHAR bytes
    include "Steel_Wall.asm"      ; 2 * LINES_PER_CHAR bytes
    ;---------------------------------------------------------------------------


    ECHO "FREE BYTES IN FIXED BANK = ", $FFFB - *

    ;---------------------------------------------------------------------------
    ; The reset vectors
    ; these must live in the fixed bank (last 2K of any ROM image in TigerVision)

                SEG InterruptVectors
                ORG FIXED_BANK + $7FC
                RORG $7ffC

;               .word Reset           ; NMI        (not used)
                .word Reset           ; RESET
                .word Reset           ; IRQ        (not used)

    ;---------------------------------------------------------------------------

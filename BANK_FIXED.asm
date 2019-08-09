;    Sokoboo - a Sokoban implementation
;    using a generic tile-based display engine for the Atari 2600
;    Sokoban (倉庫番)™ is © Falcon Co., Ltd.
;
;    Code related to this Sokoban™ implementation was developed by Andrew Davie.
;
;    Code related to the generic tile-based display engine was developed by
;    Andrew Davie and Thomas Jentzsch during 2003-2011 and is
;    Copyright(C)2003-2019 Thomas Jentzsch and Andrew Davie - contacts details:
;    Andrew Davie (andrew@taswegian.com), Thomas Jentzsch (tjentzsch@yahoo.de).
;
;    Code related to music and sound effects uses the TIATracker music player
;    Copyright 2016 Andre "Kylearan" Wichmann - see source code in the "sound"
;    directory for Apache licensing details.
;
;    Some level data incorporated in this program were created by Lee J Haywood.
;    See the copyright notices in the License directory for a list of level
;    contributors.
;
;    Except where otherwise indicated, this software is released under the
;    following licensing arrangement...
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;    see https://www.gnu.org/licenses/gpl-3.0.en.html

;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.

    ;------------------------------------------------------------------------------
    ;###############################  FIXED BANK  #################################
    ;------------------------------------------------------------------------------


ORIGIN          SET FIXED_BANK

                NEWBANK THE_FIXED_BANK
                RORG $f800



    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawTimeFromROM

                lda #BANK_SCORING
                sta SET_BANK_RAM
                jsr DrawTime
                jsr DrawTargetsRequired
                lda ROM_Bank
                sta SET_BANK
                rts

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetROMByte ;=23(A)

    ; a = ROM bank to retrieve
    ; y = page index
    ; ROM_Bank = bank to return to
    ; (Board_AddressR) = page
    ; out a = byte from (Board_AddressR)

                sta SET_BANK                    ;3
                jmp GetBoardCharacter2          ;3+17(A)        unconditional

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardCharacter ;=20(A)

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

                stx SET_BANK_RAM            ; 3

PutBoardCharacterSB ; =18
                sta (Board_AddressW),y      ; 6
                lda ROM_Bank                ; 3
                sta SET_BANK                ; 3
                rts                         ; 6 = 21

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardCharacter__CALL_FROM_RAM__ ;=61[-2](A)

                ldy POS_Y                       ;3

                lda #BANK_GetBoardAddressR      ;
                sta SET_BANK                    ;
                jsr GetBoardAddressR            ;11+24[-2](A)


    ;DEFINE_SUBROUTINE PartialGetBoardCharacter ;=23

                sta SET_BANK_RAM                ;3
                ldy POS_X                       ;3
                lax (Board_AddressR),y          ;5
                ldy RAM_Bank                    ;3
                sty SET_BANK_RAM                ;3              return to RAM caller
                rts                             ;6              and go back

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE PutBoardCharacterFromRAM ;=71[-2]

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


    DEFINE_SUBROUTINE PutBoardCharacterFromROM
        pha
        jsr PutBoardCharacterFromRAM
        pla
        sta SET_BANK
        rts

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE ProcessObjStack ; 15 minimum segtime abort

                lda INTIM                       ;4
                cmp #MINIMUM_SEGTIME            ;2
                bcc EarlyAbort                  ;2/3= 8
                STRESS_TIME MINIMUM_SEGTIME

                lda ObjStackNum                 ;3
                eor #1                          ;2
                tax                             ;2

                lda ObjIterator                 ;3
                cmp ObjStackPtr,x               ;5
                bcs nextPhase                   ;2/3


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
    ; and determines (and moves) BOXs or TARGETs into these squares.  The space vacated
    ; by these objects are added again to the blank stack.

nextPhase

            ;clc
            ;lda circle_d
            ;adc #255
            ;sta circle_d
            ;bcc nocirc
;nocirc

                inc ScreenDrawPhase             ;5              obj/blank finished -- let the draw stuff proceed
EarlyAbort      rts                             ;6

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE SwitchObjects ;=72

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

    ; Time is up. But we may be in a level which requires perfect sorting
    ; So we check for these levels, and wait for the sort to complete for those.

                bit levelDisplay                 ;3
                bvc keepFractional              ;2/3            screen does not require complete sort

    ; We have a level which requires the sort to go to completion
    ; Check to see if the sort is finished...

                ldy sortPtr                     ;3
                bne EarlyAbort                  ;2/3            sort still in progress, so wait
                ldy sortRequired                ;3
                bpl EarlyAbort                  ;2/3            sort still in progress, so wait

keepFractional  sta Throttle                    ;3              save fractional 'left over' bit

    ; Pause the game with B/W switch:

                lda gameMode
                bmi .paused                     ; pause flag set

    ; Now that we have completed processing the object stack, we switch
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

#if 0
    DEFINE_SUBROUTINE PROCESS_CIRCLE_DRAWER

                ldy #CHARACTER_BLANK
                lda circle_d+1
                ;jsr DrawCircle
                ;bcc finCircle
                ;lda #TYPE_CIRCLE_DRAWER
                ;sta POS_Type
                ;jsr InsertObjectStack
finCircle       jmp NextObject

    DEFINE_SUBROUTINE PROCESS_CIRCLE_HELPER

                lda INTIM
                cmp #SEGTIME_CIRCLE_HELPER
                bcc EarlyAbort


                jmp NextObject                  ; and die


    DEFINE_SUBROUTINE PROCESS_CIRCLE

                lda INTIM
                cmp #SEGTIME_CIRCLE
                bcc EarlyAbort

                clc
                lda circle_d
                adc #255
                sta circle_d
                bcc inactiveCircle

                inc circle_d+1
                lda circle_d+1
                cmp #20
                beq circleComplete
                ; time to fire off another "ring" of the clearing circle

                ;sta POS_VAR               ; diameter for helper to use
                ;lda #TYPE_CIRCLE_HELPER
                ;sta POS_Type
                ;jsr InsertObjectStack


                ; a = radius

                ldy #CHARACTER_BLANK
                sty circ_char

                lda circle_d+1
                sec
                sbc #1
                sta circ_x
                eor #255
                clc
                adc #1
                sta circ_scratch     ; "d" --> "1-r" in unit terms

                lda #0
                sta circ_y

                ;lda circle_d+1                     ; radius
                ;lda #TYPE_CIRCLE_DRAWER
                ;sta POS_Type
                ;jsr InsertObjectStack

                            ldy #CHARACTER_BLANK
                            lda circle_d+1
                ;            sec
                ;            sbc #1
                            jsr DrawCircle

                ;            ldy #CHARACTER_STEEL
              ;              sty circ_char
                            lda circle_d+1
                            sta circ_x
                            eor #255
                            clc
                            adc #1
                            sta circ_scratch     ; "d" --> "1-r" in unit terms

                            lda #0
                            sta circ_y

                            ;lda circle_d+1                     ; radius
                            ;lda #TYPE_CIRCLE_DRAWER
                            ;sta POS_Type
                            ;jsr InsertObjectStack

                            ;            ldy #CHARACTER_BLANK
                            ;            lda circle_d+1
                            ;            ;jsr DrawCircle



;                            inc circle_d+1
;                            ldy #CHARACTER_STEEL
;                            lda circle_d+1
;                            jsr DrawCircle

inactiveCircle  lda #TYPE_CIRCLE
                sta POS_Type
                jsr InsertObjectStack

circleComplete  jmp NextObject
#endif

    ;---------------------------------------------------------------------------

EarlyAbort4     rts

    DEFINE_SUBROUTINE PROCESS_MAN

                lda INTIM
                cmp #SEGTIME_MAN
                bcc EarlyAbort4
                STRESS_TIME SEGTIME_MAN

                lda #BANK_ManProcess
                sta ROM_Bank
                sta SET_BANK
                jsr ManProcess

                jsr MovePlayer                  ; 6+{}

                lda ManMode
                cmp #MANMODE_NEXTLEVEL      ; kludge
                bcs notComplete
                lda targetsRequired
                bne notComplete
                lda #MANMODE_NEXTLEVEL
                sta ManMode
notComplete


                lda #BANK_TrackPlayer           ;
                sta SET_BANK                    ;
                jsr TrackPlayer                 ;11+145

                lda #TYPE_MAN                   ; 2
                sta POS_Type                    ; 3

                jsr InsertObjectStack           ; 6+76(B)          re-insert man (POS X/Y DOESN'T MATTER)
gnobj           jmp NextObject

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE RestoreOriginalCharacter     ;=93[-2](A)

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

                lda POS_VAR
                sta (Board_AddressW),y          ;6 clear vacated board position

                lda ROM_Bank                    ;3
                sta SET_BANK                    ;3
EarlyAbortBOX   rts                             ;6


    ;---------------------------------------------------------------------------

; IF the creature runs out of time to do stuff, then rts HOWEVER the creature must eventually do something
;  as it will be continually called in available time-slices until it does. This can lockup the system.

; if the creature is done, and is alive next cycle, then jump ReInsertObject

; if the creature dies then jump NextObject


ReInsertObject  jsr InsertObjectStack           ; 6+76(B)  = 98 (if jumping here)        place on stack so it keeps moving

NextObject      inc ObjIterator                 ; 5
;                dec ObjStackPtr,x               ; 6
                jmp ProcessObjStack             ; 3 = 16

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE InsertObjectStackFromRAM ;=94(B)

                jsr InsertObjectStack           ;6+76(B)
                lda RAM_Bank                    ;3
                sta SET_BANK_RAM                ;3

NotEnoughTime   rts                             ;6

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE InsertObjectStack ;=81(B)
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

insertDone      ldy ROM_Bank                    ; 3
                sty SET_BANK                    ; 3

ManIsDead2



                rts                             ; 6 = 29

    ;---------------------------------------------------------------------------

BankObjStack    .byte BANK_OBJSTACK, BANK_OBJSTACK2

     ;---------------------------------------------------------------------------

MovePlayer
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

    DEFINE_SUBROUTINE MOVE_BLANK
    DEFINE_SUBROUTINE MOVE_SOIL
    DEFINE_SUBROUTINE MOVE_TARGET

                ldy POS_X_NEW
                lda (Board_AddressR),y              ; what's on the board under man?
                pha

                lda #CHARACTER_MANOCCUPIED
                sta (Board_AddressW),y

                ldx ManY
                stx POS_Y
                ldy ManX
                sty POS_X

                jsr RestoreOriginalCharacter

                pla
                sta POS_VAR                     ; save 'restore' characte

                lda #BANK_TAKEBACK
                sta SET_BANK_RAM

                ldx moveCounterBinary

                lda POS_X_NEW
                sta ManX
                sta RAM_WRITE+TakeBackX,x

                lda POS_Y_NEW
                sta ManY                        ; actually MOVE!
                sta RAM_WRITE+TakeBackY,x

                lda POS_VAR                     ; replace char
                sta RAM_WRITE+TakeBackA,x

                lda RAM_Bank
                sta SET_BANK_RAM

    ; Move counter..

                inc moveCounterBinary

                sed
                clc
                lda moveCounter
                adc #1
                sta moveCounter
                lda moveCounter+1
                adc #0
                sta moveCounter+1
                cld

MOVE_GENERIC    lda #0                          ; 2
                sta ManPushCounter              ; 3

timeExit        rts                             ; 6 = 11

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE MOVE_BOX

                ldx #CHARACTER_BLANK        ; restoration character
                lda #BANK_PushBox
                sta ROM_Bank
                sta SET_BANK
                jmp PushBox

    DEFINE_SUBROUTINE MOVE_BOX_ON_TARGET

                ldx #CHARACTER_TARGET      ; restoration character
                lda #BANK_PushBox
                sta ROM_Bank
                sta SET_BANK
                jmp PushBox

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE restorePreviousManPosition

                ldx moveCounterBinary
                beq noMovesToTake
                dex
                dec moveCounterBinary

                lda #BANK_TAKEBACK
                sta SET_BANK_RAM

                lda TakeBackX,x
                sta POS_X
                sta POS_X_NEW
                lda TakeBackY,x
                sta POS_Y
                sta POS_Y_NEW
                lda TakeBackA,x
                sta POS_VAR

                ; Put character @ X,Y
                jsr RestoreOriginalCharacter

                lda ROM_Bank
                sta SET_BANK

noMovesToTake   rts

  ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE StealCharDraw; in FIXED_BANK

                lda #BANK_DRAW_BUFFERS          ; 2
                sta SET_BANK_RAM                ; 3
                ldy DrawStackPointer            ; 3         MUST have been set by BuildDrawStack!
                bpl EnterStealCharDraw          ; 3 = 10(11)

ExitStealCharDraw

    ; fall through...

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE TimeSlice

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

                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_MIN            ; 2
                bcc ExitStealCharDraw           ; 2/3= 8

                ldx DrawStack,y                 ; 4         in actuality a character index
                ldy ScreenBuffer,x              ; 4 =  8    new character to draw

                lda ROW_BankChar,x              ; 4         A = 0..SCREEN_LINES-1
                sta SET_BANK_RAM                ; 3
                jmp StealPart3                  ; 3 = 10    --> 18 cycles after check for SEGTIME_SCD_MIN




    DEFINE_SUBROUTINE DrawFullScreenMain ;=2484[-89]

    ; Check the screen for all those characters that need to be redrawn
    ; Just copies the mxn grid from the board to a DrawFlags array.  If the entry in
    ; the drawflags array is different to the ScreenBuffer array entry, then the
    ; screenbuffer will need redrawing.

CopyRow2

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
; total: 5*(50[-1])-1 = 244 *OR*  249 (MB)

                lax DHS_Line                    ; 3
                beq .exitCopy                   ; 2/3= 5/6

                ldy #BANK_DrawScreenRowPreparation;2
                sty SET_BANK                    ; 3
                jmp DrawScreenRowPreparation    ;55[-7] = 60[-7]

; total: (244[-5]+5)*8 + 60[-7]*7 + 1 + 11 = 2424[-89]


                CHECKPAGEX CopyRow2, "CopyRow2 in BANK_FIXED.asm"

.exitCopy       ldx DHS_Stack                   ; 3
                txs                             ; 2

    ; fall through

    DEFINE_SUBROUTINE BuildDrawStack

                lda #BANK_DRAW_BUFFERS
                sta SET_BANK_RAM
                jmp DrawStackUpdate

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawAIntoStack

                lda #BANK_DRAW_BUFFERS
                sta SET_BANK_RAM
                jmp DrawIntoStack


    ;---------------------------------------------------------------------------


Reset
                CLEAN_START

                ;lda #2
                ;sta VSYNC
                ;lda #%01000010                  ; bit6 is not required
                ;sta VBLANK                      ; end of screen - enter blanking

    ; Scoring bank is copied once (not per game, not per level...)
    ; otherwise non-SaveKey high score gets zapped

                ldx #ROM_SHADOW_OF_BANK_SCORING
                ldy #BANK_SCORING
                jsr CopyROM2RAM_F000

Restart     ; go here on RESET + SELECT


Title
                ldx #$ff                    ; adjust stack pointer after RESET + SELECT
                txs

    ; temporary vars from title screen are used to init level
                lda #BANK_Cart_Init             ; 2
                sta SET_BANK                    ; 3
                jsr Cart_Init                   ; 6+x


    ;---------------------------------------------------------------------------


SEGMENT_DECODE_LEVEL_SHADOW = $F000      ; if not = $F000, this will cause an assertion failure

                ldx #BANK_DECODE_LEVEL_SHADOW
                ldy #BANK_DECODE_LEVEL
                jsr CopyROM2RAM_F000


    ;---------------------------------------------------------------------------
    ; Once-only game initialisation goes here...
    ; now we have two players so things get a bit tricky

                lda #BANK_SCORING
                sta SET_BANK_RAM
                jsr GameInitialise


    ;---------------------------------------------------------------------------

                #include "sound/intro1_init.asm"

                SET_PLATFORM

                lda #BANK_TitleScreen
                sta SET_BANK
                jsr TitleSequence

RestartLevelNextPlayer


    ; a player has lost a life.
    ; store his vars, swap to other player, continue

                ;lda #BANK_SCORING
                ;sta SET_BANK_RAM
                ;jsr SwapPlayers

                lda #BANK_SwapPlayersGeneric
                sta SET_BANK
                jsr SwapPlayersGeneric

NextLevelLevel
skipDemoCheck

    ; Initialise all in-game variables; those that must be re-initialised at the start of each level,
    ; including those for general systems function. But NOT those which do not need re-initialising between
    ; levels.
                lda #BANK_LevelInit             ; 2
                sta SET_BANK                    ; 3
                jsr LevelInit                   ; 6+x

                lda #0
                sta base_x
                sta base_y

                lda #BANK_DECODE_LEVEL
                sta SET_BANK_RAM
                jsr UnpackLevel

    ; TODO now we KNOW the width, we can set the top left accordingly and re-unpack

                lda #SIZE_BOARD_X
                sta BoardLimit_Width
                lda #SIZE_BOARD_Y
                sta BoardLimit_Height

    ; Setup player animation and scroll limits.
    ; Mangle the board colours based on level

                lda #BANK_CreateCreatures       ; 2
                sta SET_BANK                    ; 3
                jsr CreateCreatures             ; 6+x

    ; Setup the various digit and display pointers
    ; Grab current player's score/level from backup

                lda #BANK_SCORING
                sta SET_BANK_RAM
                jsr GeneralScoringSetups
                ;lda ROM_Bank
                ;sta SET_BANK

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

NewFrameStart

                bit NextLevelTrigger
                bpl NextLevelLevel               ; game-triggered next level
                bvs RestartLevelNextPlayer       ; loss of life

    ; Note: VSYNC must NOT be on when starting a new level! Else you get annoying TV signals.

                lda #%1110                       ; VSYNC ON
.loopVSync      sta WSYNC
                sta VSYNC
                lsr
                bne .loopVSync                  ; branch until VYSNC has been reset

 ; moved *after* the loop since this allows to *increase* timer values by 1!

                ldx Platform
                ldy VBlankTime,x
                sty TIM64T


    #include "sound/intro1_player.asm"

                jsr StealCharDraw               ; NOTE THIS IS THE *ONLY* AREA BIG ENOUGH FOR > 30 INTIM NEEDS

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
                ;sta COLUBK                  ; 3     value comes from subroutine
                                            ; + the 'black' left-side of top screen colour change when look-around is actually a HMOVE bar, so we can't fix it :)

;                inc Throttle                ; 5     speed limiter
                SLEEP 2                    ;       TODO: optimize for space

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
                sta SET_BANK                ; testing
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

OverscanBD      lda INTIM                   ;4
                bne OverscanBD              ;2/3
                jmp NewFrameStart
VBlankTime
                .byte VBLANK_TIM_NTSC, VBLANK_TIM_NTSC
                .byte VBLANK_TIM_PAL, VBLANK_TIM_PAL


#if 0
    DEFINE_SUBROUTINE SokoScreen



    ;---------------------------------------------------------------------------
    ; A 42-cycle timing window in the screen draw code.  Perform any general
    ; per-frame code here, provided it takes exactly 42 cycles to execute.
    ; TJ: Well, not exactly 42 cycles, but it works! :)
                                            ;       @09
                ;sta COLUBK                  ; 3     value comes from subroutine
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
                sta REFP0                   ; 3                lda #BANK_SCREENMARKII1     ; 2
                sta SET_BANK_RAM            ; 3
                jsr DrawTheScreen           ; 6     @57 from RAM, no less!!
                                            ;       @66
                lda #BANK_PostScreenCleanup ; 2
                sta SET_BANK                ; 3
                jsr PostScreenCleanup       ; 6+x

                lda #BANK_SelfModDrawPlayers; 2
                sta SET_BANK                ; 3
                jsr SelfModDrawPlayers      ; 6+x

frame
                jsr StealCharDraw
           lda INTIM
                bne frame


                lda #BANK_TitleScreen
                sta SET_BANK
                rts
#endif

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE nextLevelMan

                lda #20
                sta DelayEndOfLevel
                lda #20
                sta ColourTimer


                lda #0
                sta circle_d
                sta circle_d+1

            #if 0

            ; Fire up a circle-drawing special-effect object...


                lda #TYPE_CIRCLE
                sta POS_Type
                jsr InsertObjectStack

            #endif


#if 0
                lda #$08
                sta color
                lda #$04
                sta color+1
                lda #$0A
                sta color+2
#endif
                inc ManMode
                rts

    DEFINE_SUBROUTINE nextLevelMan2

#if 0
                ldy #SCREEN_LINES-1
CopyScreenBank2 ldx #ROM_SHADOW_OF_RAMBANK_CODE
                sty RAM_Bank
                jsr SetPlatformColours             ; set NTSC or PAL RGB values for draw + index
                dey
                bpl CopyScreenBank2

                ldx #2
fade            lda color,x
                and #$F
                bne nz
                lda #1
                sta color,x
nz              dec color,x
zalready        dex
                bpl fade
#endif

                ;dec DelayEndOfLevel
                ;beq goNL3

                inc circle_d+1
                lda circle_d+1
                cmp #20
                bcs goNL3


                rts

goNL3
                inc ManMode

    DEFINE_SUBROUTINE switchLevels

                ;lda #BANK_NextLevelX
                ;sta SET_BANK
                ;jmp NextLevelX

   ; Now do the actual switching

               lda NextLevelTrigger
               and #<(~BIT_NEXTLEVEL)
               sta NextLevelTrigger

   ; Next level is due. Point to the next level, but if we're at the end of playable levels,
   ; then increment the level number. This is completely circular, so we eventually wrap
   ; the level back to 0 and start afresh.

               inc levelX
               lda levelX
               cmp #NUMBEROFLEVELS
               bcc .level_ok
               lda #0
.level_ok      sta levelX
               rts

    ;---------------------------------------------------------------------------


    DEFINE_SUBROUTINE CopyROM2RAM_F000

                lda #BANK_CopyROMShadowToRAM
                sta SET_BANK
                sta ROM_Bank
                jmp CopyROMShadowToRAM_F000


    ;---------------------------------------------------------------------------

    ;---------------------------------------------------------------------------

    ;include "circle.asm"
    include "sound/intro1_trackdata.asm"

    include "characterset/character_BOX.asm"
    include "characterset/character_WALL.asm"

    #if DIGITS
    include "characterset/character_9.asm"
    include "characterset/character_8.asm"
    include "characterset/character_7.asm"
    include "characterset/character_6.asm"
    include "characterset/character_5.asm"
    include "characterset/character_4.asm"
    include "characterset/character_3.asm"
    include "characterset/character_2.asm"
    include "characterset/character_1.asm"
    include "characterset/character_0.asm"
    #endif

    #if TROPHY
    include "trophyData.asm"
    #endif




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

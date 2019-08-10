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

            NEWBANK INITBANK

    .byte   0   ; to avoid extra cycle when accessing via BoardLineStartLO-1,y

    DEFINE_SUBROUTINE BoardLineStartLO

    ; Gives the start address (LO) of each board line
#if 1
.BOARD_LOCATION SET Board
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
                .byte <.BOARD_LOCATION
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X
            REPEND
    CHECKPAGEX BoardLineStartLO, "BoardLineStartLO in BANK_INITBANK.asm"

SIZE_BOARD = .BOARD_LOCATION-Board  ; verify calculated value
#endif

;------------------------------------------------------------------------------

BoardLineStartHiR

    ; Gives the start address (HI) of each board line
    ; Note this caters for the memory wrapping when we go from bank to bank, as
    ; the board overlays multiple banks!

.BOARD_LOCATION SET Board
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
                .byte >( .BOARD_LOCATION & $13FF )      ; cater for mirroring of memory images
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X
            REPEND
    CHECKPAGEX BoardLineStartHiR, "BoardLineStartHiR in BANK_INITBANK"
;------------------------------------------------------------------------------

BoardLineStartHiW

    ; Gives the start address (HI) of each board line
    ; Note this caters for the memory wrapping when we go from bank to bank, as
    ; the board overlays multiple banks!

.BOARD_LOCATION SET Board
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
                .byte >( ( .BOARD_LOCATION & $13FF ) + RAM_WRITE )      ; cater for mirroring of memory images
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X
            REPEND
    CHECKPAGEX BoardLineStartHiW, "BoardLineStartHiW in BANK_INITBANK"

;------------------------------------------------------------------------------
    IF MULTI_BANK_BOARD = YES
BoardBank
    ENDIF
    ; Gives the RAM bank of the start of the board row for a given row.

.BOARD_LOCATION SET Board - RAM_3E
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
    IF MULTI_BANK_BOARD = YES
                .byte BANK_BOARD + (.BOARD_LOCATION / RAM_SIZE)            ; actual bank #
    ENDIF
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X      ; note, we CANNOT cross a page boundary within a row
            REPEND
    IF MULTI_BANK_BOARD = YES
    CHECKPAGEX BoardBank, "BoardBank in BANK_INITBANK.asm"
    ENDIF


    ;------------------------------------------------------------------------------

CopyROMShadowToRAM_F000
                lda #>$F000

    DEFINE_SUBROUTINE CopyROMShadowToRAM ; in INITBANK

    ; Function copies a RAM prototype ROM bank into the destination RAM bank.  Typically
    ; the variable definitions are in the ROM shadow because this allows auto-initialisation
    ; of the variable contents from ROM declarations, but still allows access to them as
    ; variables when the correct RAM bank is switched in.  Code is also, of course, copied
    ; into the RAM destination so that code is callable whenever the ROM *or* RAM bank is
    ; switched in.  Further, if multiple copies are made to multiple RAM banks, then the
    ; code co-lives in all banks and may run even as bankswitching occurs between those
    ; banks -- by the very code itself.

    ; Note: Relies on ROM_Bank having being set via CALL mechanism to call this function
                sta Board_AddressR+1
                stx O_ROM_Source_Bank           ; source bank
                sty RAM_Bank                    ; destination bank

                ldy #0
                sty Board_AddressR
                sty Board_AddressW
                lda #>($1000+RAM_WRITE)
                sta Board_AddressW+1

    ; Iterate 4 pages (1K) for complete bank copy

                lda #4
                sta O_CopyCount

CopyPage        sty O_Index
                lda O_ROM_Source_Bank
                jsr GetROMByte                  ; get byte from ROM shadow bank
                ;tax
                ldy O_Index
                ldx RAM_Bank
                jsr PutBoardCharacter           ;6+21(A)        write byte to RAM bank

                ldy O_Index
                iny
                bne CopyPage

                inc Board_AddressR+1
                inc Board_AddressW+1

                dec O_CopyCount
                bne CopyPage

                ldy RAM_Bank                    ; TODO: remove!?
                rts


    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE SetPlatformColours ; in INITBANK

    ; Now modify the hardwired colours so that we're correctly switched for NTSC/PAL
    ; The platform (0=NTSC, 1=PAL) is set from the right difficulty switch
    ; Note: This relies on DrawTheScreen starting on page boundary so that the (),y
    ; addressing will not violate the page-crossing restriction of 3E.

;                sty RAM_Bank                    ; we assume we called CopyROMShadowToRAM before

                lda #<DrawTheScreen             ; = 0
                sta Board_AddressW
                lda #>( DrawTheScreen + RAM_WRITE )
                sta Board_AddressW+1

    ; first, set the x index (with last one being a RTS ($60))

                ldx RAM_Bank
                cpx #SCREEN_LINES-1             ; might become variable when vertical scrolling
                bne .skipPatch
                lda #$60                        ; rts
                ldy #<SELFMOD_X
                jsr PutBoardCharacter           ;6+21(A)        set index/rts
.skipPatch

                ldx #3-1
.loopColor
                stx colorIdx
; set PF colors
                lda color,x
                ldy SelfModColOfsTbl,x
                ;tax
                ldx RAM_Bank
                jsr PutBoardCharacter           ;6+21(A)        copy PF colour RED/GREEN/BLUE to self-modifying RAM
; set player colors
                ldx colorIdx
                lda SelfModePlayerTbl,x
                ldy Platform
                cpy #PAL
                bcc .platform0
                adc #LINES_PER_CHAR-1           ; C==1!
.platform0:
                ldy SelfModPlayerColOfsTbl,x
                ;tax
                ldx RAM_Bank
                jsr PutBoardCharacter           ;6+21(A)        copy player colour RED/GREEN/BLUE to self-modifying RAM
; loop
                ldx colorIdx
                dex
                bpl .loopColor

                ldy RAM_Bank
                rts

SelfModColOfsTbl:
    .byte   <(SELFMOD_BLUE+1), <(SELFMOD_GREEN+1), <(SELFMOD_RED+1)
SelfModePlayerTbl:
    .byte   <SpriteColourBLUE, <SpriteColourGREEN, <SpriteColourRED
SelfModPlayerColOfsTbl:
    .byte   <(SELFMOD_PLAYERCOL_BLUE+1), <(SELFMOD_PLAYERCOL_GREEN+1), <(SELFMOD_PLAYERCOL_RED+1)


DrawLineStartLO

    ; Gives the start address of each line in the draw flags buffer

.DRAW_LOCATION  SET DrawFlag
            REPEAT SCREEN_LINES
                .byte <.DRAW_LOCATION
.DRAW_LOCATION  SET .DRAW_LOCATION + SCREEN_WIDTH
            REPEND


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardAddressRW ; in INITBANK
    ; Must share same bank as BoardLineStart tables

                lda BoardLineStartLO,y          ; 4
                sta Board_AddressR              ; 3
                sta Board_AddressW              ; 3
                lda BoardLineStartHiR,y         ; 4
                sta Board_AddressR+1            ; 3         READ address
                ora #>RAM_WRITE                 ; 2
                sta Board_AddressW+1            ; 3         WRITE address
    IF MULTI_BANK_BOARD = YES
                ldx BoardBank,y                 ; 4 = 26    switch this on return
    ELSE
                ldx #BANK_BOARD                 ; 2
    ENDIF
                rts                             ; 6 = 32[-2]

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardAddressR ;=24[-2](A)

                lda BoardLineStartLO,y          ; 4
                sta Board_AddressR              ; 3
                lda BoardLineStartHiR,y         ; 4
                sta Board_AddressR+1            ; 3     READ address
    IF MULTI_BANK_BOARD = YES
                lda BoardBank,y                 ; 4     switch this on return
    ELSE
                lda #BANK_BOARD                 ; 2
    ENDIF
                rts                             ; 6[-2]

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardAddressW ;=24[-2](A)

    ; Must share same bank as BoardLineStart tables

                lda BoardLineStartLO,y          ;4
                sta Board_AddressW              ;3
                lda BoardLineStartHiW,y         ;4
                sta Board_AddressW+1            ;3 WRITE address
    IF MULTI_BANK_BOARD = YES
                ldx BoardBank,y                 ;4 switch this on return
    ELSE
                ldx #BANK_BOARD                 ;2
    ENDIF
QRet            rts                             ;6

;-------------------------------------------------------------------------------


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE PushBox ; in INITBANK

      ; X = restoration character for square we are moving TO
      ; so, if X = CHARACTER_TARGET AND we move, THEN we are pushing a box off a target

                sta ROM_Bank

                lda ManPushCounter
                cmp #PUSH_LIMIT
                bcc cannotPush

                stx restorationCharacter          ; BOX'S NEW CHAR

    ; Determine if the box is pushable
    ; we use the joystick to calculate the subsequent square

                lda BufferedJoystick
                lsr
                lsr
                lsr
                lsr
                pha
                tay

                clc
                lda POS_Y_NEW
                adc JoyMoveY,y
                tay
                jsr GetBoardAddressRW

                pla
                tay

                clc
                lda POS_X_NEW
                adc JoyMoveX,y
                pha
                tay

    IF MULTI_BANK_BOARD = YES
                lda RAM_Bank
    ELSE
                lda #BANK_BOARD                 ; 2
    ENDIF
                jsr GetBoardCharacter           ;6+20(A)
                pla
                tay

                lda #CHARACTER_BOX
                cpx #CHARACTER_BLANK
                beq canPushTarget

                cpx #CHARACTER_TARGET
                beq decreaseTargets
                cpx #CHARACTER_TARGET2
                bne cannotPush

    ; Box is now on a target - so decrease the remaining targets

decreaseTargets sed
                sec
                lda targetsRequired
                sbc #1
                sta targetsRequired
                cld

                lda #CHARACTER_BOX_ON_TARGET
canPushTarget   pha

    ; If the box *WAS* on a target (restoration character = CHARACTER_TARGET)
    ; then we increase targets (as there is one more to get)

                lda restorationCharacter
                cmp #CHARACTER_TARGET
                bne notOnTargetAlready

    ; increase the required targets as box is leaving one

                sed
                clc
                lda targetsRequired
                adc #1
                sta targetsRequired
                cld

notOnTargetAlready


                pla


  IF MULTI_BANK_BOARD = YES
              ldx RAM_Bank
  ELSE
              ldx #BANK_BOARD                 ; 2
  ENDIF
                jsr PutBoardCharacter           ;6+21(A)

                lda POS_VAR                     ; player's restoration character
                pha

                ldx POS_Y_NEW
                stx POS_Y
                ldy POS_X_NEW
                sty POS_X
                lda restorationCharacter
                sta POS_VAR

                jsr RestoreOriginalCharacter    ; put back BOX's restoration character

                pla
                sta POS_VAR

                ;START_SOUND SOUND_BOX

                jmp MovePlayer              ; now there's a gap, player should move in

cannotPush      inc ManPushCounter
                rts

   ;------------------------------------------------------------------------------

; IF the creature runs out of time to do stuff, then rts HOWEVER the creature must eventually do something
;  as it will be continually called in available time-slices until it does. This can lockup the system.

; if the creature is done, and is alive next cycle, then jump ReInsertObject

; if the creature dies then jump NextObject



RDirY           .byte -1    ;,0,1,0
RDirX           .byte 0,1   ;,0,-1
DirPushModX      .byte 0,-1,1,0
DirPushModY      .byte -1,0,0,1
Directional     .byte 1,2,3,0,1,2, 0,0, 11,8,9,10,11,8


    ;------------------------------------------------------------------------------

; the auto-calculation of these was causing DASM to get confused and abort assembling.
; I don't particularly know why; probably because of the level variable-size array and the values
; changing from pass to pass. I've put in the hardwired values and it seems to be OK now.

MANMODE_STARTUP     = 0
MANMODE_NORMAL      = 1
MANMODE_DEAD        = 2
MANMODE_WAITING     = 3
MANMODE_WAITING2    = 4
MANMODE_WAITING_NT  = 5
MANMODE_WAITING_NT2 = 6
MANMODE_NEXTLEVEL   = 7
MANMODE_NEXTLEVEL2 = 8
MANMODE_SWITCH = 9

    DEFINE_SUBROUTINE ManProcess

    ; ManMode tells the player what it is currently doing.  State machine.

    ; Check the switches....
    ; RESET to restart this level
    ; SELECT to start next level

                lda SWCHB
                and #3
                tax
                lda newMode,x
                bmi skipModeChange
                sta ManMode
skipModeChange

                jsr DrawTimeFromROM             ; Z-flag == 0!

                ldy ManMode
                lda ManActionLO,y
                sta actionVector
                lda ManActionHI,y
                sta actionVector+1
                jmp (actionVector)

newMode         .byte -1, MANMODE_SWITCH, MANMODE_WAITING2, -1

ManActionLO
                .byte <manStartup               ; 0             no timer
                .byte <normalMan                ; 1             timer
                .byte <deadMan                  ; 2             timer
                .byte <waitingMan               ; 3             timer
                .byte <waitingManPress          ; 4             timer
                .byte <waitingMan               ; 5             no timer
                .byte <waitingManPress          ; 6             no timer
                .byte <nextLevelMan             ; 7             no timer
                .byte <nextLevelMan2             ; 8             no timer
                .byte <switchLevels             ; 9             no timer

ManActionHI
                .byte >manStartup               ; no timer
                .byte >normalMan                ; timer
                .byte >deadMan                  ; timer
                .byte >waitingMan               ; timer
                .byte >waitingManPress          ; timer
                .byte >waitingMan               ; no timer
                .byte >waitingManPress          ; no timer
                .byte >nextLevelMan             ; no timer
                .byte >nextLevelMan2             ; no timer
                .byte >switchLevels             ;9  no timer

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE manStartup

    IF WAIT_FOR_INITIAL_DRAW
                lda DrawStackPointer
                bpl midDraw
                lda #0
                sta blankState
midDraw
    ENDIF

                lda ManX
                sta POS_X
                lda ManY
                sta POS_Y

#if 0
anotherC                inc POS_X
                lda #CHARACTER_2
                sta POS_Type
                lda #BANK_manStartup
                jsr PutBoardCharacterFromROM
                inc POS_Type
                lda POS_Type
                cmp #CHARACTER_2
                ;bcc anotherC
#endif


                lda ManX
                sta POS_X_NEW ;NewX
                sta POS_X
                lda ManY
                sta POS_Y_NEW ;NewY
                sta POS_Y

                inc manAnimationIndex
                ldx manAnimationIndex                 ; animation index
                lda .ManStartup-1,x
                bmi CreateThePlayer
                sta POS_Type

                lda #$FF
                sta ManDelayCount           ; anything, just non-0

                jmp PutBoardCharacterFromRAM    ;70 --> switches this bank out but who cares!

CreateThePlayer

                inc ManMode                 ; --> MANMODE_NORMAL
RTS_CF
                rts

.ManStartup
    .byte CHARACTER_NOGO
    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
;    .byte CHARACTER_STEEL
    .byte CHARACTER_NOGO
;    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
;    .byte CHARACTER_NOGO
;    .byte CHARACTER_STEEL
;    .byte CHARACTER_NOGO
;    .byte CHARACTER_STEEL
;    .byte CHARACTER_NOGO
;    .byte CHARACTER_STEEL
;    .byte CHARACTER_NOGO
;    .byte CHARACTER_STEEL
;    .byte CHARACTER_NOGO
;    .byte CHARACTER_STEEL
    ;.byte CHARACTER_NOGO
    .byte CHARACTER_MANOCCUPIED
    .byte -1

    ;------------------------------------------------------------------------------

waitingMan
waitingManPress

;                lda #50
;                sta ColourTimer


                lda NextLevelTrigger
                ora #BIT_NEXTLIFE
                sta NextLevelTrigger
                rts


    ;------------------------------------------------------------------------------
    ; Normal man state


normalMan

    ; Timer is still running, so we see if the player is to die for any reason

;                bit demoMode
;                bmi stayAlive
    ; SELECT pressed?
;                lda SWCHB
;                eor #$FF
;                and #3
;                bne Time0                       ; EITHER select or reset are pressed
;                lsr
;                lsr
;                bcc Time0                       ; suicide!
stayAlive

    ;------------------------------------------------------------------------------

                ;ldx ManY
                ;ldy ManX

                ;lda BoardLineStartLO,x
                ;sta Board_AddressR
                ;lda BoardLineStartHiR,x
                ;sta Board_AddressR+1

    IF MULTI_BANK_BOARD = YES
                ;lda BoardBank,x                 ;4
                ;sta RAM_Bank                    ;3
    ELSE
                ;lda #BANK_BOARD                 ;2
    ENDIF
                ;jsr GetBoardCharacter           ;6+20(A)

                ;lda CharToType,x
                ;cmp #TYPE_MAN
                ;beq PlayerAlive
                jmp PlayerAlive ;sok

    ; character he's on isn't a MAN character, so he dies...

Time0

                inc ManMode                   ; #1 -- player dead!


deadMan         lda ManX
                sta POS_X
                lda ManY
                sta POS_Y

                ;jsr BlankPlayerFrame

    ; and becomes a man waiting for resurrection...

                inc ManMode

timeTooShortToDie
                rts

    ;------------------------------------------------------------------------------

PlayerAlive

    ; Calling code uses 'POS_X_NEW' and 'POS_Y_NEW' as new player position, so these must be set
    ; before exiting via (for example) look-around option :)

                lda ManX
                sta POS_X_NEW
                lda ManY
                sta POS_Y_NEW



    ;------------------------------------------------------------------------------
    ; Look around is triggered by holding down the fire button for a while, without any other
    ; joystick directions chosen. The variable LookingAround has a negative value ($FF) when looking
    ; is active. Otherwise, it is counting down to the time where it will trigger.

LOOK_DELAY = 0


                ;------------------------------------------------------------------------------
                ; Take-back is a press/release of the button, with the press being limited in duratino
                ; to allow the action to be "cancelled". Meanwhile, a button press + direction triggers
                ; "look-around mode"

                lda BufferedButton
                bmi noLook                      ; button?

    ; button pressed, so in looking-around mode

                ldx #$FF
                stx BufferedButton              ; "release" button

                lda LookingAround
                bmi LookAround
                stx LookingAround
LookAround

    ; Use the joystick as a window-scroller to change the viewport

                lda BufferedJoystick
                lsr
                lsr
                lsr
                lsr
                tay

                lda JoyMoveX,y
                ora JoyMoveY,y
                beq AbandonY

                lda #$FE
                sta LookingAround

                lda JoyMoveX,y
                ;asl
                clc
                adc BoardScrollX
                cmp BoardEdge_Right
                bcs AbandonX
                sta BoardScrollX

AbandonX        lda JoyMoveY,y
                ;asl
                clc
                adc BoardScrollY
                cmp BoardEdge_Bottom
                bcs AbandonY
                sta BoardScrollY

AbandonY        rts

noLook          lda LookingAround
                cmp #$FF
                bne bProcComp

    ; button was presssed and now released and we didn't actually look around
    ; TODO -- takeback here
                ;jsr restorePreviousManPosition
                ;lda #2
                ;sta ColourTimer

bProcComp       ldx #0
                stx LookingAround

    ;------------------------------------------------------------------------------

                ; control the scrolling via the joystick

                lda ManLastDirection
                and #DIRECTION_BITS
                tay

                lda BufferedJoystick                 ; joystick
                and BufferedJoystick+1

                ldx #0
.loopDirs       asl
                bcc .dirFound
                dey
                inx
                cpx #4
                bne .loopDirs
                clc
.dirFound
                lda POS_X_NEW ;NewX
                adc JoyDirX,x
                sta POS_X_NEW ;NewX
                lda POS_Y_NEW ;NewY
                clc
                adc JoyDirY,x
                sta POS_Y_NEW ;NewY

                tya
                beq noMovement                  ; animation OK

                txa
                eor ManLastDirection
                and #DIRECTION_BITS
                eor ManLastDirection
                sta ManLastDirection
                lda ManAnimTblLo,x
                sta ManAnimation
                ;lda ManAnimTblHi,x
                ;sta ManAnimation+1
                lda #0
                sta ManDelayCount
phase0          ;jsr MovePlayer
noMovement      ;ldx MAN_Player

DFS_rts         rts


ManAnimTblLo
    .byte   AnimateRIGHT-Manimate, AnimateLEFT-Manimate, AnimateUP-Manimate, AnimateUP-Manimate, AnimateSTOPPED-Manimate
;ManAnimTblHi
;    .byte   >AnimateRIGHT, >AnimateLEFT, >AnimateUP, >AnimateUP, >AnimateSTOPPED



JoyMoveX        .byte 0,0,0,0,0,1, 1,1,0,-1,-1,-1;,0, 0,0,0
JoyMoveY        .byte 0,0,0,0,0,1,-1,0,0, 1,-1;, 0,0,1,-1,0

JoyDirY
    .byte   0,0;,1,-1,0
JoyDirX
    .byte   1,-1,0,0,0


    ;------------------------------------------------------------------------------


    DEFINE_SUBROUTINE DrawFullScreen ; = 2568[-96]

    ; 83[-7] + 2484[-89] = 2567[-96]


                lda INTIM                       ; 4
                cmp #SEGTIME_BDF                ; 2
                bcc DFS_rts                     ; 2/3
                STRESS_TIME SEGTIME_BDF

                lda #>( DrawFlag + RAM_WRITE )  ; 2
                sta BDF_DrawFlagAddress+1       ; 3
                sta BDF_DrawFlagAddress2+1      ; 3

                tsx                             ; 2
                stx DHS_Stack                   ; 3

                inc ScreenDrawPhase             ; 5

                clc                             ; 2         required clear for DrawScreenRowPreparation
                ldx #SCREEN_LINES               ; 2
                txa                             ; 2 = *32

        ; fall through

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawScreenRowPreparation ; = *59[-7 if not multi-bank-board]

                ;clc
                dex                             ; 2
                stx DHS_Line                    ; 3
                adc BoardScrollY                ; 3         the Y offset of screen into board
                tay                             ; 2 = 10

                ;clc
                lda BoardLineStartLO-1,y        ; 4         Y is one too big!
                adc BoardScrollX                ; 3         the X offset of screen into board
                sta BDF_BoardAddress            ; 3
                adc #SCREEN_WIDTH/2             ; 2
                sta BDF_BoardAddress2           ; 3

                lda BoardLineStartHiR-1,y       ; 4         a board line *WILL NOT CROSS* page boundary
                sta BDF_BoardAddress+1          ; 3
                sta BDF_BoardAddress2+1         ; 3 = 25

                lda DrawLineStartLO,x           ; 4
                sta BDF_DrawFlagAddress         ; 3
                adc #SCREEN_WIDTH/2             ; 2
                sta BDF_DrawFlagAddress2        ; 3 = 12

    IF MULTI_BANK_BOARD = YES
                lda BoardBank-1,y               ; 4
                sta BDF_BoardBank               ; 3
    ENDIF
                ldy #SCREEN_WIDTH/2-1           ; 2
                jmp CopyRow2                    ; 3 = 12[-7]

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE VectorProcess ;=19(A)

                ;sta ROM_Bank                    ;3              processors can assume bank is stored

                lda OSPointerHI,x               ;4
                sta POS_Vector+1                ;3
                lda OSPointerLO,x               ;4
                sta POS_Vector                  ;3

                jmp (POS_Vector)                ;5 = 19         vector to processor for particular object type
                                                ;               NOTE: Bank is either INITBANK or FIXED.


OBJTYPE    SET 0
    MAC DEFINE
TYPE_{1}    = OBJTYPE
OBJTYPE    .SET OBJTYPE + 1
    ENDM

        ; If adding/removing types, the following must also be updated...
        ;   InitialFace[...]                in UnpackLevel.asm
        ;   BaseTypeCharacter[...]          in BANK_FIXED.asm
        ;   BaseTypeCharacterFalling[...]   in BANK_FIXED.asm
        ;   OSPointerLO[...]                in BANK_INITBANK.asm
        ;   OSPointerHI[...]                in BANK_INITBANK.asm
        ;   CharReplacement[...]            in BANK_ROM_SHADOW_DRAWBUFFERS.asm
        ;   Sortable[...]                   in BANK_FIXED.asm


                DEFINE MAN
                ;DEFINE CIRCLE
                ;DEFINE CIRCLE_HELPER
                ;DEFINE CIRCLE_DRAWER

                DEFINE MAXIMUM


    DEFINE_SUBROUTINE OSPointerLO
                .byte <PROCESS_MAN
                ;.byte <PROCESS_CIRCLE
                ;.byte <PROCESS_CIRCLE_HELPER

    IF * - OSPointerLO < TYPE_MAXIMUM-4
        ECHO "ERROR: Missing entry in OSPointerLO table!"
        ERR
    ENDIF


    DEFINE_SUBROUTINE OSPointerHI
                .byte >PROCESS_MAN
                ;.byte >PROCESS_CIRCLE
                ;.byte >PROCESS_CIRCLE_HELPER

    IF * - OSPointerHI < TYPE_MAXIMUM-4
        ECHO "ERROR: Missing entry in OSPointerHI table!"
        ERR
    ENDIF

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE MoveVecLO ; [character type]

        .byte <MOVE_BLANK
        .byte <MOVE_SOIL
        .byte <MOVE_BOX
        .byte <MOVE_TARGET
        .byte <MOVE_TARGET
        .byte <MOVE_GENERIC ;man occupied
        .byte <MOVE_GENERIC ;steel
        .byte <MOVE_GENERIC ;wall
        .byte <MOVE_BOX_ON_TARGET ;box on target
        .byte <MOVE_GENERIC ;nogo

#if DIGITS
    REPEAT 10   ; DIGITS 0-9
        .byte <MOVE_BLANK
    REPEND
#endif

#if TROPHY
    REPEAT 20       ; 4x5
        .byte <MOVE_BLANK
    REPEND
#endif

    IF * - MoveVecLO != CHARACTER_MAXIMUM
        ECHO "ERROR: Incorrect number of entries in MoveVecLO table!"
        ERR
    ENDIF


    DEFINE_SUBROUTINE MoveVecHI ;[character type]

        .byte >MOVE_BLANK
        .byte >MOVE_SOIL
        .byte >MOVE_BOX
        .byte >MOVE_TARGET
        .byte >MOVE_TARGET
        .byte >MOVE_GENERIC ;man occupied
        .byte >MOVE_GENERIC ;steel
        .byte >MOVE_GENERIC ;wall
        .byte >MOVE_BOX_ON_TARGET ;box on target
        .byte >MOVE_GENERIC ;nogo

#if DIGITS
    REPEAT 10   ; DIGITS 0-9
        .byte >MOVE_BLANK
    REPEND
#endif

#if TROPHY
    REPEAT 20       ; 4x5
        .byte >MOVE_BLANK
    REPEND
#endif

    IF * - MoveVecHI != CHARACTER_MAXIMUM
        ECHO "ERROR: Incorrect number of entries in MoveVecHI table!"
        ERR
    ENDIF


    CHECK_BANK_SIZE "INITBANK"

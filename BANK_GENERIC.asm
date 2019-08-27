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
    ;##############################################################################
    ;------------------------------------------------------------------------------

            NEWBANK GENERIC_BANK_1



    DEFINE_1K_SEGMENT DECODE_LEVEL_SHADOW
            include "DecodeLevel.asm"

            CHECK_HALF_BANK_SIZE "GENERIC_BANK_1 (DECODE_LEVEL)"

    ;------------------------------------------------------------------------------
    ; ... the above is a RAM-copied section -- the following is ROM-only.  Note that
    ; we do not configure a 1K boundary, as we con't really care when the above 'RAM'
    ; bank finishes.  Just continue on from where it left off...
    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE Cart_Init ; in GENERIC_BANK_1

    ; Note the variables from the title selection are incredibly transient an can be stomped
    ; at any time.  So they need to be used immediately.


    ; odd usage below is to prevent any possibility of variable stomping/assumptions

                lda #1
                ldx #0 ;sLevel                                      ; level # from title select
                ldy #0 ;sJoysticks
                sty jtoggle
                stx level
                lda #0
                ;sta levelX                                        ; make an immediate copy to safe variables!
                sta startingLevel

    ; multiply with LEVEL_DEFINITION_SIZE (5):
                asl
                asl
                sta levelX

                LOAD_ANIMATION Animation_IDLE
                lda #ANIMATION_IDLE_ID
                sta ManAnimationID

                lda #0
                sta SWBCNT                      ; console I/O always set to INPUT
                sta SWACNT                      ; set controller I/O to INPUT
                sta HMCLR

    ; cleanup remains of title screen
                sta GRP0
                sta GRP1
;?                sta GRP0

                lda #%00010000              ; 2     double width missile, double width player
                sta NUSIZ0                  ; 3
                sta NUSIZ1

                sta ScreenDrawPhase             ; sequences the sections of gameplay/screen drawing
                sta ethnic

                lda #%100                       ; players/missiles BEHIND BG
                sta CTRLPF

                lda #$FF
                sta DrawStackPointer
                sta BufferedButton
                sta BufferedButton+1

                ;lda #DIRECTION_BITS             ;???
                ;sta ManLastDirection

                ;lda #0
;                sta ObjStackPtr                 ; object stack index of last entry
;                sta ObjStackPtr+1
;                sta ObjStackNum
;                sta ObjIterator

                ;sta sortPtr
                ;lda #<(-1)
                ;sta sortRequired

; read high score from SaveKey and store in highScoreSK,
; which is transferred to high score variable in RAM by GeneralScoringSetups
                jmp ReadSaveKey

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE SwapPlayersGeneric

    ; at the start of a level (or player, doesn't matter) we grab the current state of the colour/B&W switch
    ; into the gameMode variable.

;                lda gameMode
;                and #~(BW_SWITCH|GAMEMODE_PAUSED)
;                sta gameMode
;                lda SWCHB
;                and #BW_SWITCH
;                ora gameMode                    ; COLOR/B&W @start of level stored in gameMode -- so now we just detect a CHANGE is pause
;                sta gameMode                    ; also, BIT7=0 -- system is NOT paused


    ; restart level
                lda NextLevelTrigger
                and #<(~BIT_NEXTLIFE)
                sta NextLevelTrigger

    ; if new high score was set by SwapPlayers, update it:

                jmp WriteSaveKey


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE CreateCreatures

    ; Calculate rightmost value for scrolling edge.  .

                sta ROM_Bank

                sec
                lda BoardLimit_Width
                sbc #SCREEN_WIDTH-1
                sta BoardEdge_Right              ; absolute rightmost scroll value

;                sec                        already set
                lda BoardLimit_Height
                sbc #SCREEN_LINES-1
                sta BoardEdge_Bottom            ; absolute bottommost scroll value

    ; kludge position scroll roughly at player

;                sec                    already set
                lda ManX
                sbc #5
                bcs notL0
                lda #0
notL0           sta BoardScrollX

                sec
                lda ManY
                sbc #4
                bcs notU0
                lda #0
notU0           sta BoardScrollY

                lda #0
                sta ManMode
                ;sta ManDelayCount
                sta TakebackInhibit
                sta base_x
                sta base_y
                sta ManPushCounter

                lda #$FF
                sta LastSpriteY
                sta ManAnimationID

                ;lda #DIRECTION_BITS             ;????
                ;sta ManLastDirection            ; duplicate?

                rts

    ;-------------------------------------------------------------------------------------

    DEFINE_SUBROUTINE LevelInit ; in GENERIC_BANK_1

                lda #0
                sta ObjStackPtr
                sta ObjStackPtr+1               ; kill all creatures
                sta ObjStackNum
                sta ObjIterator

                sta scrollBits
                sta ScreenDrawPhase

                sta BGColour
                sta ColourTimer

                sta AUDV0
                sta AUDV1                           ; turn off music while levels init
;                sta AUDC0

                ;sta ManLastDirection
                ;sta ManPushCounter

                ;sta sortPtr                     ; sort stopped
                ;lda #<(-1)
                ;sta sortRequired                ; nothing needed
                sta DrawStackPointer

                ;lda #DISPLAY_TIME ;DISPLAY_SCORE
                ;sta scoringFlags
                ;lda #0 ;SCORING_TIMER_FIRST                 ; We want the first timer display to be long, to show level and lives
                ;sta scoringTimer

                clc
                lda ethnic
                adc #16
                cmp #4*16
                bcc ethOK
                lda #0
ethOK           sta ethnic

                rts

    ;-------------------------------------------------------------------------------------

    DEFINE_SUBROUTINE Resync
                RESYNC
Ret             rts

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE TrackPlayer ; =145; in GENERIC_BANK_1

                lda LookingAround               ; 3
                bne Ret                         ; 2/3=5/6   don't track when looking around

    ; Contribution by Thomas Jentzsch

; scrolling constants:
.SCRL_START_LEFT    = 2                                 ; 3
.SCRL_STOP_LEFT     = 2 ;SCREEN_WIDTH-5                    ; 5 scrolls 5-3+1 = 3 pixel
.SCRL_START_RIGHT   = SCREEN_WIDTH-.SCRL_START_LEFT     ; 7
.SCRL_STOP_RIGHT    = SCREEN_WIDTH-.SCRL_STOP_LEFT      ; 5
.SCRL_LEFT_BIT      = %00010001
.SCRL_RIGHT_BIT     = %00100010
.SCRL_X_BITS        = .SCRL_LEFT_BIT|.SCRL_RIGHT_BIT

.SCRL_START_UP      = 2                                 ; 2
.SCRL_STOP_UP       = 2 ;SCREEN_LINES-5                    ; 3 scrolls 3-2+1 = 2 pixel
.SCRL_START_DOWN    = SCREEN_LINES-.SCRL_START_UP       ; 6
.SCRL_STOP_DOWN     = SCREEN_LINES-.SCRL_STOP_UP        ; 5
.SCRL_UP_BIT        = %01000100
.SCRL_DOWN_BIT      = %10001000
.SCRL_Y_BITS        = .SCRL_UP_BIT|.SCRL_DOWN_BIT

; *** horizontal scrolling (unoptimized version): ***

    ; check for enabling horizontal scrolling:
                lda ManX                        ; 3
                sec                             ; 2
                sbc BoardScrollX                ; 3
                tay                             ; 2         for later use
                lda #.SCRL_LEFT_BIT             ; 2
                cpy #.SCRL_START_LEFT           ; 2         <3?
                bmi .startXScroll               ; 2/3       yes, scroll left
                cpy #.SCRL_START_RIGHT          ; 2         <8?
                bmi .skipStartXScroll           ; 2/3       no
                lda #.SCRL_RIGHT_BIT            ; 2 = 22    yes, scroll right
.startXScroll:
                and #.SCRL_X_BITS >> 4          ; 2
                ora scrollBits                  ; 3
                sta scrollBits                  ; 3 =  8
.skipStartXScroll:

    ; do horizontal scrolling:
                lda scrollBits                  ; 3
                and #.SCRL_X_BITS >> 4          ; 2
                beq .skipXScroll                ; 2/3
                and #.SCRL_RIGHT_BIT            ; 2
                bne .xScrollRight               ; 2/3=11/12

    ; scroll left:
                lda BoardScrollX                ; 3         already at left edge?
                beq .stopXScroll                ; 2
                dec BoardScrollX                ; 5
                cpy #.SCRL_STOP_LEFT-1          ; 2
                bpl .stopXScroll                ; 2/3=15
                bmi .skipXScroll                ; 3
;---------------------------------------
.xScrollRight:
                ldx BoardScrollX                ; 3
                inx                             ; 2
                cpx BoardEdge_Right             ; 3         already at right edge?
                bpl .stopXScroll                ; 2/3
                stx BoardScrollX                ; 3
                cpy #.SCRL_STOP_RIGHT+1         ; 2
                bpl .skipXScroll                ; 2/3=17/18
.stopXScroll:
                lda scrollBits                  ; 3
                and #(~(.SCRL_X_BITS >> 4))     ; 2
                sta scrollBits                  ; 3 =  8
.skipXScroll:
; worst case: 22 + 8 + 12 + 17 + 8 = 67

; *** vertical scrolling (unoptimized version): ***

    ; check for enabling vertical scrolling:
                lda ManY                        ; 3
                sec                             ; 2
                sbc BoardScrollY                ; 3
                tay                             ; 2         for later use
                lda #.SCRL_UP_BIT               ; 2
                cpy #.SCRL_START_UP             ; 2         <2?
                bmi .startYScroll               ; 2/3       yes, scroll up
                cpy #.SCRL_START_DOWN           ; 2         <6?
                bmi .skipStartYScroll           ; 2/3
                lda #.SCRL_DOWN_BIT             ; 2 = 22    yes, scroll down
.startYScroll:
                and #.SCRL_Y_BITS >> 4          ; 2
                ora scrollBits                  ; 3
                sta scrollBits                  ; 3 =  8
.skipStartYScroll:

    ; do vertical scrolling:
                lda scrollBits                  ; 3
                and #.SCRL_Y_BITS               ; 2
                beq .skipYScroll                ; 2/3
                and #.SCRL_DOWN_BIT             ; 2
                bne .yScrollDown                ; 2/3=11/12

    ; scroll up
                lda BoardScrollY                ; 3
                beq .stopYScroll                ; 2
                dec BoardScrollY                ; 5
                cpy #.SCRL_STOP_UP-1            ; 2
                bpl .stopYScroll                ; 2/3=15
                bmi .skipYScroll                ; 3
;---------------------------------------
.yScrollDown:
                ldx BoardScrollY                ; 3
                inx                             ; 2
                cpx BoardEdge_Bottom      ;     ; 3
                bpl .stopYScroll                ; 2/3
                stx BoardScrollY                ; 3
                cpy #.SCRL_STOP_DOWN+1          ; 2
                bpl .skipYScroll                ; 2/3=17/18
.stopYScroll:
                lda scrollBits                  ; 3
                and #(~(.SCRL_Y_BITS >> 4))     ; 2
                sta scrollBits                  ; 3 =  8
.skipYScroll:
; worst case: 22 + 8 + 12 + 17 + 8 = 67

EarlyAbortx     rts                             ; 6 =  6
; total: 5+67*2+6 = 145


;------------------------------------------------------------------------------

; This is a GOOD home for these tables.

    DEFINE_SUBROUTINE TS_PhaseVectorLO

    ; Gives LO byte of addresses of subroutines for timeslice processing
    ; note +31✅ cycles at start of the function called

                .byte <ProcessObjStack          ; abort = 46✅
                .byte <DrawFullScreen           ; abort = 46✅
                .byte <BuildDrawStack           ; abort = 54✅
                .byte <DrawAIntoStack           ; abort = 54✅
                .byte <SwitchObjects            ; abort = 46✅

TS_PhaseVectorHI

    ; Gives HI byte of addresses of subroutines for timeslice processing

                .byte >ProcessObjStack
                .byte >DrawFullScreen
                .byte >BuildDrawStack
                .byte >DrawAIntoStack
                .byte >SwitchObjects

TS_PhaseBank

    ; Gives bank of subroutines for timeslice processing

                .byte BANK_ProcessObjStack
                .byte BANK_DrawFullScreen
                .byte BANK_DRAW_BUFFERS ;BANK_BuildDrawStack
                .byte BANK_DRAW_BUFFERS ;BANK_BuildDrawStack2
                .byte BANK_SwitchObjects

;------------------------------------------------------------------------------
lookColour2     .byte $02, $02
                .byte $04, $04

OverscanTime
    .byte OVERSCAN_TIM_NTSC, OVERSCAN_TIM_NTSC
    .byte OVERSCAN_TIM_PAL, OVERSCAN_TIM_NTSC

theThrottler
        .byte 30, 30, 30*60/50, 30

    DEFINE_SUBROUTINE PostScreenCleanup

                iny                             ; --> 0

                sty COLUBK                      ; starts colour change bottom score area, wraps to top score area
                                                ; + moved here so we don't see a minor colour artefact bottom of screen when look-arounding

                sty PF0                         ; why wasn't this here?  I saw colour glitching in score area!
                                                ; TJ: no idea why, but you had removed it in revision 758 ;)
                                                ; completely accidental -- one of our cats may have deleted it.
                sty PF1
                sty PF2
                sty ENAM0
                sty GRP0                        ; when look-scrolling, we can see feet at the top if these aren't here
                sty GRP1                        ; 30/12/2011 -- fix dots @ top!

    ; D1 VBLANK turns off beam

                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

    ;------------------------------------------------------------------------------
    ; This is where the PAL system has a bit of extra time on a per-frame basis.

                ldx Platform
                lda OverscanTime,x
                sta TIM64T

    ; Background colour priorities. Increasing order of priority...
    ;      black -- nothing happening
    ;      looking around                       lookingAround<0                 BLUE
    ;      when paused                          gameMode... BIT7                RED
    ;      when the door opens (flash)          ColourTimer>0                   WHITE


;                lda LookingAround
;                bpl nolooker                    ; if not looking around, that will do nicely
;                ldy #0 ;sok
;;                ldy lookColour2,x               ; otherwise, use the lookaround colour as the base
;nolooker        sty BGColour                    ; 'BASE' colour pause reverts TO when unpaused

                ldx Platform
                lda theThrottler,x
                clc
                adc Throttle
                bcs noVerflo
                sta Throttle
noVerflo

    ;----------------------------------------------------------------------------------------------

    ; has to be done AFTER screen display, because it disables the effect!
                ;SLEEP 6
                ;lda rnd                     ; 3     randomly reposition the Cosmic Ark missile
                ;sta HMM0                    ; 3     this assumes that HMOVE is called at least once/frame

    ; "Flash" has highest BG colour priority

                lda ColourTimer
                beq noFlashBG
                dec ColourTimer
                bne noFlashBG
                lda #0
                sta BGColour
                ;lda ColourFlash
                ;lda FlashColour,x
noFlashBG
;       sta BGColour

    ; Handle the player joystick reading. We do it *every frame* so that we can incorporate a two-frame
    ; buffer.  This is designed to give a little better responsiveness to the 'quick tap' movement.

                lda BufferedJoystick            ; previous frame
                sta BufferedJoystick+1          ; -> buffered


    ; Create a 'standardised' joystick with D4-D7 having bits CLEAR if the appropriate direction is chosen.

                lda INPT4
                and BufferedButton
                sta BufferedButton

                lda SWCHA
                sta BufferedJoystick


#if 0
    ; "Scoring timer" reset stomp comment

                lda scoringTimer
                beq timer0now
                dec scoringTimer
                bne timer0now
                ;lda scoringFlags
                ;and #<(~DISPLAY_FLAGS)      ;       switches to time display
                ;sta scoringFlags
timer0now
#endif

    ; TODO - fast frame-based animation handling can go here

                rts



pscol       .byte $40, $40
            .byte $60, $60

;------------------------------------------------------------------------------

    include "i2c_v2.2.inc"

    i2c_subs

HandleSaveKey SUBROUTINE

SAVEKEY_ADR     = $2F00         ;           tentative address for Sokoban (64 bytes)

;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE ReadSaveKey ; = 2371

; assume no SaveKey found:
    lda     #$ff                ; 2         return $ff if no SaveKey found
    sta     highScoreSK+2       ; 3

; setup SaveKey:
    lda     startingLevel           ; 3         load start levelX*5 and level
    ldx     level               ; 3
    jsr     SetupSaveKey        ;6+853
    bcc     NoSKfound           ; 2/3

    ;    lda     #$34
    ;    sta     COLUBK

; start read
    jsr     i2c_stopwrite       ;6+42       end of "fake" write
    jsr     i2c_startread       ;6+284      Start signal and $a1 command byte

; read high score:
    ldx     #3-1                ; 2 = 1187
.loopRead
    jsr     i2c_rxbyte          ;6+333      read byte from EEPROM
    cmp     #$ff                ; 2         EEPROM slot empty?
    bne     .skipEmpty          ; 2/3        no, skip clear
    lda     #0                  ; 2         clear EEPROM slot
.skipEmpty
    sta     highScoreSK,x       ; 4
    dex                         ; 2
    bpl     .loopRead           ; 2/3= 354

; stop read:
    jmp     i2c_stopread        ;3+92=95    terminate read

;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE WriteSaveKey ; = 1751

; check if new high score:
    ldx     highScoreSK         ; 3
    inx                         ; 2
    beq     NoSKfound           ; 2/3       no new high score, abort

; setup SaveKey:
    lda     startingLevel           ; 3         load start levelX*5 and level
    ldx     startLevel          ; 3
    jsr     SetupSaveKey        ; 6+853
    bcc     NoSKfound           ; 2/3

    ;    lda     #$64
    ;    sta     COLUBK

; write high score:
    ldx     #3-1                ; 2 = 841
.loopWrite
    lda     highScoreSK,x       ; 4
    jsr     i2c_txbyte          ;6+264      transmit to EEPROM
    dex                         ; 2
    bpl     .loopWrite          ; 2/3= 837

; stop write:
    jmp     i2c_stopwrite       ; 3+42= 45  terminate write and commit to memory


;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE SetupSaveKey ; = 853

; calculate slot;
; a = levelX
; x = level (0..4)
    sta     offsetSK            ; 3
    txa                         ; 2
    clc                         ; 2
    adc     offsetSK            ; 3
    sta     offsetSK            ; 3
    asl                         ; 2         multiply by 3
    adc     offsetSK            ; 3
    adc     #<SAVEKEY_ADR       ; 2
    tax                         ; 2 = 22
; detect SaveKey:
    jsr     i2c_startwrite      ;6+280
    bne     .exitSK             ; 2/3

; setup address:
    clv                         ; 2
    lda     #>SAVEKEY_ADR       ; 2         upper byte of address
    jsr     i2c_txbyte          ;6+264
    txa                         ; 2         x = lower byte offset
    jmp     i2c_txbyte          ;3+264      returns C==1

.exitSK
    clc
NoSKfound
    rts
  ENDIF


            CHECK_BANK_SIZE "GENERIC_BANK_1 -- full 2K"

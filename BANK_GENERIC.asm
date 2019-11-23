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

    IF PLUSCART = YES
            .byte "SokobooAPI.php", #0
	        .byte "pluscart.firmaplus.de", #0
    ENDIF

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
                sta startingLevel

                sta levelX
;                sta levelX+1

                LOAD_ANIMATION IDLE

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
                sta BufferedJoystick

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
                sta FadeComplete                    ; start fading
                sta FadeOutComplete                 ; flags "not fading out"

                lda #20
                sta fadeslow

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
                sta LookingAround

                lda #255
                sta Throttle
                sta BufferedJoystick

                lda #0
                sta AUDV0

                sta AUDV1                           ; turn off music while levels init

                sta seconds
                sta seconds+1


;                sta AUDC0

;                sta VBLANK


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

    DEFINE_SUBROUTINE TrackPlayer ; =76

                lda LookingAround               ; 3
                bne EarlyAbortx                 ; 2/3       don't track when looking around

.SCRL_START_LEFT    = 2
.SCRL_START_RIGHT   = SCREEN_WIDTH-.SCRL_START_LEFT
.SCRL_START_UP      = 2
.SCRL_START_DOWN    = SCREEN_LINES-.SCRL_START_UP

                lda ManX                        ; 3
                sec                             ; 2
                sbc BoardScrollX                ; 3
                tay                             ; 2 = 10         for later use

                lda #-1                         ; 2
                cpy #.SCRL_START_LEFT           ; 2
                bmi .startXScroll               ; 2/3
                cpy #.SCRL_START_RIGHT          ; 2
                bmi .skipXScroll                ; 2/3
                lda #1                          ; 2 = 12

.startXScroll:  clc                             ; 2
                adc BoardScrollX                ; 3
                cmp BoardEdge_Right             ; 3
                bcs .skipXScroll                ; 2/3
                sta BoardScrollX                ; 3 = 13

.skipXScroll:

    ; = 35 worst

                lda ManY                        ; 3
                sec                             ; 2
                sbc BoardScrollY                ; 3
                tay                             ; 2 = 10         for later use

                lda #-1                         ; 2
                cpy #.SCRL_START_UP             ; 2
                bmi .startYScroll               ; 2/3
                cpy #.SCRL_START_DOWN           ; 2
                bmi .skipYScroll                ; 2/3
                lda #1                          ; 2 = 12

.startYScroll:  clc                             ; 2
                adc BoardScrollY                ; 3
                cmp BoardEdge_Bottom            ; 3
                bcs .skipYScroll                ; 2/3
                sta BoardScrollY                ; 3 = 13

.skipYScroll:

    ; = 35 worst

EarlyAbortx     rts                             ; 6 =  6


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

OverscanTime
    .byte OVERSCAN_TIM_NTSC, OVERSCAN_TIM_NTSC
    .byte OVERSCAN_TIM_PAL, OVERSCAN_TIM_NTSC


THROT_BASE = 18
theThrottler
        .byte THROT_BASE, THROT_BASE, THROT_BASE*60/50, THROT_BASE

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

    ; Create a 'standardised' joystick with D4-D7 having bits CLEAR if the appropriate direction is chosen.

                lda SWCHA
                and BufferedJoystick
                sta BufferedJoystick

                rts

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

    ;----------------------------------------------------------------------


    DEFINE_SUBROUTINE GenerateHighScoreCode

;rdm = random.randint(1,3)
;__encoding = [
;    (rdm << 5) | (seconds >> 8),
;    seconds & 0xFF,
;    level,
;    moves >> 8,
;    moves & 0xFF
;]

MAX_SECOND_COUNT    = %1111111111111

                lda seconds+1
                cmp #>MAX_SECOND_COUNT
                bcc secRangeOK
                bne secAdjust
                lda seconds
                cmp #<MAX_SECOND_COUNT
                bcc secRangeOK

secAdjust       lda #<MAX_SECOND_COUNT
                sta seconds
                lda #>MAX_SECOND_COUNT
                sta seconds+1

secRangeOK



rerandom        jsr Random
                and #%11
                beq rerandom

;__randomiser = (rdm << 6) | (rdm << 4) | (rdm << 2) | rdm

                tax
                lda RandomMaskByte,x
                sta __randomiser

                lda seconds+1
                sta __encoding+0                ;    (rdm << 5) | (seconds >> 8),
                lda seconds
                sta __encoding+1                ;    seconds & 0xFF,

                lda levelX
                sta __encoding+2                ;    level, should be < 128

    ; f'n ugly convert 2 byte (4-digit) BCD into 2 byte binary...

rangedOK        lda BCD_moveCounter+1
                lsr
                lsr
                lsr
                lsr                         ; THOUSANDS 0-9
                asl
                tax
                lda Times1000,x
                sta __binMoves
                lda Times1000+1,x
                sta __binMoves+1

                lda BCD_moveCounter+1
                and #$F                     ; HUNDREDS 0-9
                asl
                tax

                lda __binMoves
                adc Times100,x
                sta __binMoves
                lda __binMoves+1
                adc Times100+1,x
                sta __binMoves+1

                lda BCD_moveCounter
                and #$F                     ;   UNITS 0-9
                clc
                adc __binMoves
                sta __binMoves
                lda __binMoves+1
                adc #0
                sta __binMoves+1

                lda BCD_moveCounter
                lsr
                lsr
                lsr
                lsr                         ; tens
                tax
                clc
                lda __binMoves
                adc Times10,x
                sta __binMoves
                lda __binMoves+1
                adc #0
                sta __binMoves+1

MAX_MOVE_COUNT = $FFF

                lda __binMoves+1
                cmp #>MAX_MOVE_COUNT
                bcc movRangeOK
                bne movAdjust
                lda __binMoves
                cmp #<MAX_MOVE_COUNT
                bcc movRangeOK

movAdjust       lda #<MAX_MOVE_COUNT
                sta __binMoves
                lda #>MAX_MOVE_COUNT
                sta __binMoves+1

movRangeOK

                lda __binMoves
                sta __encoding+4
                lda __binMoves+1
                sta __encoding+3

    ; generate a checksum

                clc
                lda __encoding
                adc __encoding+1
                clc
                adc __encoding+2
                clc
                adc __encoding+3
                clc
                adc __encoding+4              ;checksum = sum(__encoding) & 0xF
                asl
                asl
                asl
                asl
                ora __encoding+3
                sta __encoding+3                ;__encoding[3] |= (checksum << 4)

CompletedPlainEncode

;for i in range(len(__encoding)):
;    __encoding[i] ^= __randomiser

                ldx #4
xorencode       lda __encoding,x
                eor __randomiser
                sta __encoding,x
                dex
                bpl xorencode

    ; put __randomiser in D6,D5 of __encoding[0]

                lda __randomiser
                lsr
                and #%01100000
                sta __randomiser

                lda __encoding
                and #%00011111
                ora __randomiser
                sta __encoding


    ; because they were 0, and have now been xor'd with __randomiser...
    ; for top 3 bits, D7D6 now hold the relevant __randomiser value. D5 is same as D7 for what it's worth
    ; write the encoded bytes for 6502.ts emulator to intercept for web triggering

                ldx #0
emulNotify      lda __encoding,x
                sta INPT0               ; for web interface triggering
                inx
                cpx #5
                bcc emulNotify
                stx INPT1               ; for web interface triggering

    IF PLUSCART = YES
    ; write the digits for the PlusCart

                lda PLUSCART_IO
                cmp #PLUS0
                bne isplus
                lda PLUSCART_IO+1
                cmp #PLUS1
                bne isplus
                lda PLUSCART_IO+2
                cmp #PLUS2
                bne isplus
                lda PLUSCART_IO+3
                cmp #PLUS3
                beq noPlusCart
isplus


                ldx #0
sendCodeToPlus  lda __encoding,x
            	;sta $1ff0				; write to request buffer
                inx
                cpx #4
                bcc sendCodeToPlus
                lda __encoding,x
            	;sta $1ff1				; send request buffer to Backend..

noPlusCart

    ENDIF


    ; we now have a binary version of the __encoding.
    ; Convert this into 12 decimal digits

                ldy #55                     ; --> high byte of 10^11
                ldx #0
decimalise
                lda #0
                sta __decimal,x

                sec
subonedecdigit
.OFFSET         SET 4
                REPEAT 5
                lda __encoding + .OFFSET
                sbc DecimalDigit + .OFFSET,y
                sta __encoding + .OFFSET
.OFFSET         SET .OFFSET - 1
                REPEND
                inc __decimal,x
                bcs subonedecdigit

    ; add back on the 'overshoot'
.OFFSET         SET 4
                REPEAT 5
                lda __encoding + .OFFSET
                adc DecimalDigit + .OFFSET,y
                sta __encoding + .OFFSET
.OFFSET         SET .OFFSET - 1
                REPEND

                dec __decimal,x

                inx

                dey
                dey
                dey
                dey
                dey                         ; point to previous 10^x

                bpl decimalise

    ; on exit, the 12 decimal digits are in '__decimal'

                rts

DecimalDigit    .byte %00000000,%00000000,%00000000,%00000000,%00000001     ; 10^0
                .byte %00000000,%00000000,%00000000,%00000000,%00001010     ; 10^1
                .byte %00000000,%00000000,%00000000,%00000000,%01100100     ; 10^2
                .byte %00000000,%00000000,%00000000,%00000011,%11101000     ; 10^3
                .byte %00000000,%00000000,%00000000,%00100111,%00010000     ; 10^4
                .byte %00000000,%00000000,%00000001,%10000110,%10100000     ; 10^5
                .byte %00000000,%00000000,%00001111,%01000010,%01000000     ; 10^6
                .byte %00000000,%00000000,%10011000,%10010110,%10000000     ; 10^7
                .byte %00000000,%00000101,%11110101,%11100001,%00000000     ; 10^8
                .byte %00000000,%00111011,%10011010,%11001010,%00000000     ; 10^9
                .byte %00000010,%01010100,%00001011,%11100100,%00000000     ; 10^10
                .byte %00010111,%01001000,%01110110,%11101000,%00000000     ; 10^11
                ;.byte %11101000,%11010100,%10100101,%00010000,%00000000     ; 10^12



RandomMaskByte  .byte 0, %01010101, %10101010, %11111111
Times10         .byte 0, 10, 20, 30, 40, 50, 60, 70, 80, 90
Times100        .word 0, 100, 200, 300, 400, 500, 600, 700, 800, 900
Times1000       .word 0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000









            CHECK_BANK_SIZE "GENERIC_BANK_1 -- full 2K"

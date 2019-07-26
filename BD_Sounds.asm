    processor 6502
    include vcs.h

; TODOs:
; - bonus point sound
; - uncover sound

;===============================================================================
; A S S E M B L E R - S W I T C H E S
;===============================================================================

VERSION     = $0000
BASE_ADR    = $f800

NTSC        = 1
ILLEGAL     = 1
DEBUG       = 1


;===============================================================================
; C O N S T A N T S
;===============================================================================

RAND_EOR_8      = $b2                   ;$b2; $b4; $e7; $c3

NUM_SOUNDS      = 19



;===============================================================================
; Z P - V A R I A B L E S
;===============================================================================

    SEG.U   variables
    ORG     $80

frameCnt    .byte
tmpVar      .byte

rnd         .byte
seconds     .byte

; sound driver needs 6 bytes:
soundIdxLst     ds 2            ; index of current sound
decayIdxLst     ds 2            ; index of current note
decayTimeLst    ds 2            ; remaining lenght of current note
soundBonusPts   = decayIdxLst   ; used for bonus points count down (channel 0!)


;===============================================================================
; M A C R O S
;===============================================================================

DEBUG_BYTES SET 0

  MAC DEBUG_BRK
    IF DEBUG
DEBUG_BYTES SET DEBUG_BYTES + 1
      brk                         ;
    ENDIF
  ENDM

  MAC SLEEP
    IF {1} = 1
      ECHO "ERROR: SLEEP 1 not allowed !"
      END
    ENDIF
    IF {1} & 1
      nop $00
      REPEAT ({1}-3)/2
        nop
      REPEND
    ELSE
      REPEAT ({1})/2
        nop
      REPEND
    ENDIF
  ENDM

  MAC CHECKPAGE
    IF >. != >{1}
      ECHO ""
      ECHO "ERROR: different pages! (", {1}, ",", ., ")"
      ECHO ""
      ERR
    ENDIF
  ENDM

    MAC DEFINE_SUBROUTINE               ; name of subroutine
                SUBROUTINE              ; keep everything local
{1}                                     ; entry point
    ENDM

  MAC NEXT_RANDOM
; used for randomizing frequencies, any other rnd function will do too
    lda     rnd                 ; 3
    lsr                         ; 2
    bcc     .skipEor            ; 2�
    eor     #RAND_EOR_8         ; 2
.skipEor:                       ;
    sta     rnd                 ; 3
  ENDM


;===============================================================================
; R O M - C O D E
;===============================================================================
    SEG     Bank0
    ORG     BASE_ADR

Start SUBROUTINE
    cld                         ;           Clear BCD math bit.
    lda     #0
    tax
    dex
    txs
.clearLoop:
    tsx
    pha
    bne     .clearLoop

    jsr     GameInit

.mainLoop:
    jsr     VerticalBlank
    jsr     GameCalc
    jsr     DrawScreen
    jsr     OverScan
    jmp     .mainLoop


GameInit SUBROUTINE
    inc     rnd
    lda     #$0e
    sta     COLUP0
    lda     #$94
    sta     COLUP1
    lda     #$06
    sta     COLUPF
    lda     #1
    sta     CTRLPF

;    lda     #$10
;    sta     soundBonusPts
;    lda     #SOUND_BONUS_POINTS
;    lda     #SOUND_AMOEBA
;    jsr     StartSound

    rts
; GameInit


VerticalBlank SUBROUTINE
    lda     #%00001110
.loopVSync:
    sta     WSYNC
    sta     VSYNC
    lsr
    bne     .loopVSync

    lda     SWCHB
    lsr
    bcs     .skipReset
    brk

.skipReset:

    inc     frameCnt
  IF NTSC
    lda     #44
  ELSE
    lda     #77
  ENDIF
    sta     TIM64T
    rts
; VerticalBlank


GameCalc SUBROUTINE


;    lda     frameCnt
;    and     #$1f
;    bne     .skipNextSound
    bit     INPT4
    bmi     .skipNextSound
    lda     soundIdxLst
    ora     soundIdxLst+1           ; wait until channel 1 (time sound) finished
    bne     .skipNextSound
    jsr     StartBonusSeconds
;    lda     soundIdxLst
;    bne     .skipNextSound
;.nextTry:
;    jsr     NextRandom
;    and     #$1f
;    cmp     #NUM_SOUNDS
;    bcs     .nextTry
;    asl
;    asl
;  lda     #SOUND_TARGET_PICKUP
;  jsr     StartSound
;  lda     #SOUND_AMOEBA
;  lda     #SOUND_MAGIC_WALL
.skipNextSound:
    jsr     DoBonusSeconds          ; some sounds should be started close before paying them
    jsr     PlaySounds
;    jsr     PlayBonusSound

    rts
; GameCalc

StartBonusSeconds SUBROUTINE
    NEXT_RANDOM
    and     #$7f
;  lda     #50                ; just an example
    sta     seconds
    lda     #SOUND_BONUS_POINTS
    jsr     StartSound
    rts

DoBonusSeconds SUBROUTINE
    ldx     seconds
    stx     PF2
    stx     PF1
    bne     .contBonus
    stx     soundIdxLst         ; only stop bonus sound, time sound decays
    stx     AUDV0
    rts

.contBonus:
    lda     frameCnt
    lsr
    bcs     .exit
    dex
    stx     seconds
    cpx     #10
    bcs     .skipTime
    lda     TimeTbl,x
    jsr     StartSound
.skipTime:
.exit:
    rts

TimeTbl:
    .byte   SOUND_TIME_0
    .byte   SOUND_TIME_1
    .byte   SOUND_TIME_2
    .byte   SOUND_TIME_3
    .byte   SOUND_TIME_4
    .byte   SOUND_TIME_5
    .byte   SOUND_TIME_6
    .byte   SOUND_TIME_7
    .byte   SOUND_TIME_8
    .byte   SOUND_TIME_9

;PlayBonusSound SUBROUTINE
;    lda     #$0a
;    sta     AUDV1
;    lda     #DIST_DIV2
;    sta     AUDC1
;
;    lda     soundBonusPts
;    and     #$03
;    eor     #$03
;    sta     tmpVar
;    lda     soundBonusPts
;    lsr
;    lsr
;    lsr
;    sec                     ; a bit smoother
;    sbc     tmpVar
;;    clc                     ; ...than this
;;    adc     tmpVar
;    sta     AUDF1
;
;    inc     soundBonusPts
;    rts

DrawScreen SUBROUTINE
    tsx
    stx     tmpVar

    ldx     #227
.waitTim:
    lda     INTIM
    bne     .waitTim
    sta     WSYNC
    sta     VBLANK
    stx     TIM64T
;---------------------------------------------------------------
    ldy     #180
.loopKernel:
    sta     WSYNC

    dey
    bne     .loopKernel
    sta     WSYNC
;---------------------------------------------------------------
    ldy     #0
    sty     PF0
    sty     PF1
    sty     PF2
    sty     GRP0
    sty     GRP1
    sty     ENAM0
    sty     ENAM1
    sty     ENABL

    ldx     #2
.waitScreen:
    lda     INTIM
    bne     .waitScreen
    sta     WSYNC
    stx     VBLANK

    ldx     tmpVar
    txs
    rts
; DrawScreen


OverScan SUBROUTINE
  IF NTSC
    lda     #36
  ELSE
    lda     #63
  ENDIF
    sta     TIM64T

.waitTim:
    lda     INTIM
    bne     .waitTim
    rts
; OverScan

    #include "sounds.asm"

    org     BASE_ADR + $7fc
    .word   Start
    .word   Start

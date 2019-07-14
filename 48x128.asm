
;  IF FINAL_VERSION = NO
;COPYTIMESTART       = 29                ; = 0.5s
;  ELSE
COPYTIMESTART       = 228               ; = 4.0s (4*60/276*262)
;  ENDIF
COPYCOLOUR          = WHITE

   ;------------------------------------------------------------------------

    NEWBANK COPYRIGHT_BANK

    include "copyright.asm"

;--------------------------------------------------------------------------
; The beautiful, beautiful, draw loop which draws the entire matrix onscreen
; This caters for an adjustable (at compile-time) number of rows and also
; facilitates double-size pixels.

            SUBROUTINE

    ; Each sprite has 6 columns, each with a pointer to the column data
    ; setup in the vertical blank.  The columns are already mirrored (that
    ; is, they point to the correct column for the mirrored-state of the
    ; frame).

    DEFINE_SUBROUTINE DrawSprite

            ldy #128
.LABB
            dey                         ; 2
            sta WSYNC
            sty LoopCount               ; 3

            lda CopyrightNotice+128*0,y ; 4
            sta GRP0                    ; 3
            lda CopyrightNotice+128*1,y ; 4
            sta GRP1                    ; 3
            lda CopyrightNotice+128*2,y ; 4
            sta GRP0                    ; 3

            lda CopyrightNotice+128*5,y ; 4
            sta Temp                    ; 3
            ldx CopyrightNotice+128*4,y ; 4
            lda CopyrightNotice+128*3,y ; 4
            ldy Temp                    ; 3
            sta GRP1                    ; 3
            stx GRP0                    ; 3
            sty GRP1                    ; 3
            sta GRP0                    ; 3

            ldy LoopCount               ; 3
            bne .LABB                   ; 3

            sty GRP0
            sty GRP1
            sty GRP0                    ; buffered!
            rts


    ;--------------------------------------------------------------------------
    ; Object X,Y positioning
    ; Timing is absolutely critical here!

PositionObject

    ; Waste scanlines to start of object position, giving our vertical movement

.delayVert
            sta WSYNC
;---------------------------------------
            dex                 ; 2
            bne .delayVert      ; 2/3

    ; Now the horizontal magic
            lda #COPYCOLOUR     ; 2
            sta COLUP0          ; 3
            sta COLUP1          ; 3

            lda #%110011        ; 2
            sta NUSIZ0          ; 3
            sta NUSIZ1          ; 3

            sta VDELP0          ; 3

            ldx #$4f            ; 2
            sta RESM0           ; 3     @28     mask left of AA text
            sta VDELP1          ; 3
            stx HMP0            ; 3
            stx HMM0            ; 3

            sta.w RESP0         ; 4     @41
            sta RESP1           ; 3     @44
            sta RESBL           ; 3     @47

            stx HMBL            ; 3             ball is used for blue AA text
            inx                 ; 2
            sta RESM1           ; 3     @55     mask right of AA text

            stx HMP1            ; 3
            lda #$d0            ; 2
            sta HMM1            ; 3

            sta WSYNC
;---------------------------------------
            sta HMOVE
            rts


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE CopyrightVerticalSync

    ; Start of vertical blank processing

            lda #$02
            sta WSYNC
            sta VBLANK
            sta VSYNC
            sta WSYNC
            sta WSYNC
            lsr
            sta WSYNC
            sta VSYNC

            ldy Platform
            lda VBlankTblC,y
            sta TIM64T

VblankLoop  lda INTIM
            bne VblankLoop

            sta WSYNC
            sta VBLANK

    ;------------------------------------------------------------------------------
    ; START OF DISPLAY

            lda #238
            sta TIM64T
            rts


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE EndOfScreen

.waitKernel
            lda INTIM
            bne .waitKernel

            sta WSYNC

            lda #%01000010
            sta VBLANK                      ; end of screen - enter blanking

OverscanStart
            SET_PLATFORM

            tay
            lda OverscanTblC,y
            sta TIM64T

    ; shorten wait time for PAL (identical to NTSC)
            cpy #PAL_50
            bne .timeOK                     ; NTSC
            lda #COPYTIMESTART*SCANLINES_NTSC/SCANLINES_PAL ; = 201
            cmp CopyTime
            bcs .timeOK
            sta CopyTime
.timeOK
            bit INPT4
            bpl CopyExit

Overscan    lda INTIM
            bne Overscan

            dec CopyTime
            rts


VBlankTblC
  IF L276
    .byte   40
    .byte   40
    .byte   57
    .byte   40
  ELSE
    .byte   34
    .byte   34
    .byte   57
    .byte   34
  ENDIF

OverscanTblC
  IF L276
    .byte   46
    .byte   46
    .byte   72
    .byte   46
  ELSE
    .byte   35
    .byte   35
    .byte   72
    .byte   35
  ENDIF


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawCopyright

            lda #0
            ldy #GAMEMODE_2600
            ldx $d0
            cpx #$2c
            bne .is2600
            ldx $d1
            cpx #$a9
            bne .is2600
            tay                 ; 7800: bit 6 = 0
.is2600                         ; 2600: bit 6 = 1
            tax                 ; A=0!

            cld
.clearLoop
            dex
            txs
            pha
            bne .clearLoop      ; SP=$FF, X = A = 0

            sty gameMode        ; store console type

            lda #<COPYTIMESTART
            sta CopyTime


    DEFINE_SUBROUTINE NewCopyRightFrame

            jsr CopyrightVerticalSync

            ldx #36
            jsr PositionObject
            jsr DrawSprite

            jsr EndOfScreen
            bne NewCopyRightFrame

    ; fall through

;*******************************************************************************
;*******************************************************************************
;*******************************************************************************

            SUBROUTINE

    DEFINE_SUBROUTINE AtariAge

            lda #<COPYTIMESTART
            sta CopyTime

    DEFINE_SUBROUTINE NewAtariAgeFrame

            jsr CopyrightVerticalSync
            ldx #44
            jsr PositionObject           ; center AA logo

            jsr DrawAtariAge

            jsr EndOfScreen
            bne NewAtariAgeFrame

CopyExit
            jmp ExitCopyRight

    ;--------------------------------------------------------------------------

AABlueTbl
    .byte   $a2, $a2
    .byte   $b2, $b2 ;96
AAOrangeTbl
    .byte   $3c, $3c
    .byte   $4c, $4c

LOGO_AA3
    .byte   %11000000
    .byte   %11111000
    .byte   %11111110
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %00011111
    .byte   %00000111
    .byte   %00000011
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000011
    .byte   %00000011
    .byte   %00000011
    .byte   %00000111

    .byte   %00000111
    .byte   %00000111
    .byte   %00001111
    .byte   %00001111
    .byte   %00001111
    .byte   %00001111
    .byte   %00011110
    .byte   %00011110

    .byte   %00011110
    .byte   %00111100
    .byte   %00111100
    .byte   %00111100
    .byte   %01111000
    .byte   %01111000
    .byte   %01111000
    .byte   %01110110

    .byte   %11110111
    .byte   %11111111
    .byte   %11111111
    .byte   %11101111
    .byte   %11101111
    .byte   %11111110
    .byte   %11011110
    .byte   %11011110

    .byte   %11111100
    .byte   %10111100
    .byte   %00111100
    .byte   %01111000
    .byte   %01111000
    .byte   %01111000
    .byte   %01111000
    .byte   %11110000

    .byte   %11110000
    .byte   %11110000
    .byte   %11100000
    .byte   %11100000
    .byte   %11100000
    .byte   %11000000
    .byte   %11000000
    .byte   %11000000

    .byte   %10000000
    .byte   %10000000
    .byte   %10000000
    .byte   %10000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000011
    .byte   %00000111
    .byte   %00011111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111110
    .byte   %11111000
    .byte   %11000000


Text_AA4b
    .byte   %11111001
    .byte   %11110100
    .byte   %11111110

    .byte   %10010000
    .byte   %10000110
    .byte   %00100110
    .byte   %00100110
    .byte   %01110000
    .byte   %01111010
;    .byte   %11111111
;    .byte   %11111111

Text_AA1b
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %01001000
    .byte   %00010011
    .byte   %10010000
    .byte   %10011111
    .byte   %10011011
    .byte   %00001100
    .byte   %10011111
;    .byte   %11111111

Text_AA2b
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %00100110
    .byte   %00100110
    .byte   %00100110
    .byte   %00100110
    .byte   %00100010
    .byte   %01101010
    .byte   %11111111
    .byte   %11111110

Text_AA0b
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %00111110
    .byte   %00111110
    .byte   %10000000
    .byte   %10011100
    .byte   %11001001
    .byte   %11001001
    .byte   %11100011
    .byte   %11100011

Text_AA5b
    .byte   %11111111
    .byte   %11111111
    .byte   %01111111

    .byte   %01100000
    .byte   %01001111
    .byte   %01000000
    .byte   %01001100
    .byte   %01100001
    .byte   %01110011
;    .byte   %11111111
;    .byte   %11111111

Text_AA3b
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %01001111
    .byte   %01001111
    .byte   %01100000
    .byte   %01100111
    .byte   %01110010
    .byte   %01110010
    .byte   %11111000
    .byte   %01111000
    .byte   %11111111



Text_AA4a
    .byte   %11110000
    .byte   %11111110

    .byte   %10011010
    .byte   %10010000
    .byte   %00100110
    .byte   %00100110
    .byte   %01100110
    .byte   %01110000
    .byte   %11111111
;    .byte   %11111111
;    .byte   %11111111

Text_AA1a
    .byte   %11111111
    .byte   %11111111

    .byte   %01101101
    .byte   %00010010
    .byte   %10010011
    .byte   %10011000
    .byte   %10011111
    .byte   %00001000
    .byte   %10011111
    .byte   %11011111
;    .byte   %11111111

Text_AA2a
    .byte   %11111111
    .byte   %11111111

    .byte   %00100110
    .byte   %00100110
    .byte   %00100110
    .byte   %00100110
    .byte   %00100110
    .byte   %00100010
    .byte   %11111111
    .byte   %11111110
    .byte   %11111110

Text_AA0a
    .byte   %11111111
    .byte   %11111111

    .byte   %00111110
    .byte   %00111110
    .byte   %10000000
    .byte   %10011100
    .byte   %11001001
    .byte   %11001001
    .byte   %11100011
    .byte   %11100011
;    .byte   %11111111

Text_AA5a
    .byte   %11111111
    .byte   %01111111

    .byte   %01110001
    .byte   %01100110
    .byte   %01001111
    .byte   %01000000
    .byte   %01001100
    .byte   %01100001
    .byte   %11111111
;    .byte   %11111111
;    .byte   %11111111

Text_AA3a
    .byte   %11111111
    .byte   %11111111

    .byte   %01001111
    .byte   %01001111
    .byte   %01100000
    .byte   %01100111
    .byte   %01110010
    .byte   %01110010
    .byte   %11111000
    .byte   %01111000
    .byte   %01111111


    ;--------------------------------------------------------------------------

;    align 256

    DEFINE_SUBROUTINE DrawAtariAge
    tsx                             ; 2
    stx     saveSP                  ; 3

    lda     #$0e                    ; 2
    sta     COLUP0                  ; 3
    sta     COLUP1                  ; 3
    ldy     Platform                ; 3
    lda     AABlueTbl,y             ; 4
    sta     COLUPF                  ; 3
    lda     AAOrangeTbl,y           ; 4
    sta     colorBK                 ; 3

    lda     #%000001                ; 2
    sta     CTRLPF                  ; 3

    ldx     #88-1                   ; 2
.loopLogo
    txs                             ; 2
    lda     LOGO_AA_PF,x            ; 4/5
    sta     WSYNC                   ; 3 =  9/10
;---------------------------------------
    sta     PF2                     ; 3 =  3

    lda     LOGO_AA0,x              ; 4
    sta     GRP0                    ; 3
    lda     LOGO_AA1,x              ; 4
    sta     GRP1                    ; 3
    lda     LOGO_AA2,x              ; 4
    sta     GRP0                    ; 3 = 21

    lda     LOGO_AA5,x              ; 4
    sta     Temp                    ; 3
    ldy     LOGO_AA4,x              ; 4
    lda     LOGO_AA3,x              ; 4 = 15

    ldx     Temp                    ; 3
    sta     GRP1                    ; 3         @45!
    sty     GRP0                    ; 3
    stx     GRP1                    ; 3
    sta     GRP0                    ; 3 = 15

    tsx                             ; 2
    dex                             ; 2
    bpl     .loopLogo               ; 2/3= 6/7

    ; add some vertical gap between logo and text
    ldy     #22/2                   ; 2         = 50% of text height
.delayVert
    sta     WSYNC                   ; 3
;---------------------------------------
    dey                             ; 2
    bne     .delayVert              ; 2/3
    sty     COLUP0                  ; 3
    sty     COLUP1                  ; 3 = 10

    ldy     #7                      ; 2
.delayText
    dey                             ; 2
    bne     .delayText              ; 2/3
    pla                             ; 4 = 40    waste some time

    lda     #%110000                ; 2
    sta     CTRLPF                  ; 3 =  5

    stx     ENABL                   ; 3
    stx     ENAM0                   ; 3
    stx     ENAM1                   ; 3 =  9

    ldx     #22/2                   ; 2
    txs                             ; 2 =  4
.loopText                           ;           @68
    lda     Text_AA0a-1,x           ; 4
    sta     GRP0                    ; 3
;---------------------------------------
    lda     Text_AA1a-1,x           ; 4
    sta     GRP1                    ; 3
    lda     Text_AA2a-1,x           ; 4
    sta     GRP0                    ; 3 = 21

    lda     Text_AA5a-1,x           ; 4
    sta     Temp                    ; 3
    ldy     Text_AA4a-1,x           ; 4
    lda     Text_AA3a-1,x           ; 4 = 15

    ldx     #$ff                    ; 2
    stx     PF2                     ; 3
    ldx     colorBK                 ; 3
    stx     COLUBK                  ; 3 = 11

    ldx     Temp                    ; 3
    sta     GRP1                    ; 3         @45!
    sty     GRP0                    ; 3
    stx     GRP1                    ; 3
    sta     GRP0                    ; 3 = 15

    lda     #0                      ; 2
    sta     COLUBK                  ; 3
    sta     PF2                     ; 3 =  8

    tsx                             ; 2
    dex                             ; 2
    txs                             ; 2 =  6    @68

    lda     Text_AA0b,x             ; 4
    sta     GRP0                    ; 3
;---------------------------------------
    lda     Text_AA1b,x             ; 4
    sta     GRP1                    ; 3
    lda     Text_AA2b,x             ; 4
    sta     GRP0                    ; 3 = 21

    lda     Text_AA5b,x             ; 4
    sta     Temp                    ; 3
    ldy     Text_AA4b,x             ; 4
    lda     Text_AA3b,x             ; 4 = 15

    ldx     #$ff                    ; 2
    stx     PF2                     ; 3
    ldx     colorBK                 ; 3
    stx     COLUBK                  ; 3 = 11

    ldx     Temp                    ; 3
    sta     GRP1                    ; 3         @45!
    sty     GRP0                    ; 3
    stx     GRP1                    ; 3
    sta     GRP0                    ; 3 = 15

    lda     #0                      ; 2
    sta     COLUBK                  ; 3
    sta.w   PF2                     ; 4 =  9

    tsx                             ; 2
    bne    .loopText                ; 2/3= 4/5  @68

    stx     GRP0
    stx     GRP1
    stx     GRP0
    stx     ENAM0
    stx     ENAM1
    stx     ENABL

    ldx     saveSP
    txs
    rts

;    align 256

LOGO_AA_PF      ; crosses page, no problem here!
    ds 11, %00000000
    ds  4, %11000000
    ds 58, %11110000
    ds  4, %11000000
    ds 11-4, %00000000

LOGO_AA4
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %11000000
    .byte   %11100000
    .byte   %11100000
    .byte   %11110000

    .byte   %11111000
    .byte   %11111100
    .byte   %11111100
    .byte   %11111110
    .byte   %11111110
    .byte   %11111111
    .byte   %11111111
    .byte   %01111111

    .byte   %01111111
    .byte   %00111111
    .byte   %00011111
    .byte   %00011111
    .byte   %00001111
    .byte   %11001111
    .byte   %11000111
    .byte   %10000111

    .byte   %10000111
    .byte   %10000011
    .byte   %00000011
    .byte   %00000011
    .byte   %00000001
    .byte   %00000001
    .byte   %00000001
    .byte   %00000001

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %10000000
    .byte   %10000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000001
    .byte   %00000001
    .byte   %00000001
    .byte   %00000001
    .byte   %00000011
    .byte   %00000011
    .byte   %00000011
    .byte   %00000111

    .byte   %00000111
    .byte   %00000111
    .byte   %00001111
    .byte   %00001111
    .byte   %00011111
    .byte   %00011111
    .byte   %00111111
    .byte   %01111111

    .byte   %01111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111110
    .byte   %11111110
    .byte   %11111100
    .byte   %11111100
    .byte   %11111000

    .byte   %11110000
    .byte   %11100000
    .byte   %11100000
    .byte   %11000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000


LOGO_AA1
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000011
    .byte   %00000111
    .byte   %00000111
    .byte   %00001111

    .byte   %00011111
    .byte   %00111111
    .byte   %00111111
    .byte   %01111111
    .byte   %01111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111110

    .byte   %11111110
    .byte   %11111100
    .byte   %11111000
    .byte   %11111000
    .byte   %11110000
    .byte   %11110000
    .byte   %11100000
    .byte   %11100000

    .byte   %11100000
    .byte   %11000000
    .byte   %11000000
    .byte   %11000000
    .byte   %10000000
    .byte   %10000000
    .byte   %10000000
    .byte   %10000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %10000000
    .byte   %10000000
    .byte   %10000000
    .byte   %10000000
    .byte   %11000000
    .byte   %11000000
    .byte   %11000000
    .byte   %11100000

    .byte   %11100000
    .byte   %11100000
    .byte   %11110000
    .byte   %11110000
    .byte   %11111000
    .byte   %11111000
    .byte   %11111100
    .byte   %11111110

    .byte   %11111110
    .byte   %11111111
    .byte   %11111111
    .byte   %01111111
    .byte   %01111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00011111

    .byte   %00001111
    .byte   %00000111
    .byte   %00000111
    .byte   %00000011
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    align 256

LOGO_AA0
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000001

    .byte   %00000001
    .byte   %00000011
    .byte   %00000011
    .byte   %00000011
    .byte   %00000111
    .byte   %00000111
    .byte   %00000111
    .byte   %00000111

    .byte   %00001111
    .byte   %00001111
    .byte   %00001111
    .byte   %00001111
    .byte   %00011111
    .byte   %00011111
    .byte   %00011111
    .byte   %00011111

    .byte   %00011111
    .byte   %00011111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111

    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111

    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00111111
    .byte   %00011111
    .byte   %00011111

    .byte   %00011111
    .byte   %00011111
    .byte   %00011111
    .byte   %00011111
    .byte   %00001111
    .byte   %00001111
    .byte   %00001111
    .byte   %00001111

    .byte   %00000111
    .byte   %00000111
    .byte   %00000111
    .byte   %00000111
    .byte   %00000011
    .byte   %00000011
    .byte   %00000011
    .byte   %00000001

    .byte   %00000001
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000

;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000
;    .byte   %00000000

LOGO_AA5
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %10000000

    .byte   %10000000
    .byte   %11000000
    .byte   %11000000
    .byte   %11000000
    .byte   %11100000
    .byte   %11100000
    .byte   %11100000
    .byte   %11100000

    .byte   %11110000
    .byte   %11110000
    .byte   %11110000
    .byte   %11110000
    .byte   %11111000
    .byte   %11111000
    .byte   %11111000
    .byte   %11111000

    .byte   %11111000
    .byte   %11111000
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100

    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100

    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111100
    .byte   %11111000
    .byte   %11111000

    .byte   %11111000
    .byte   %11111000
    .byte   %11111000
    .byte   %11111000
    .byte   %11110000
    .byte   %11110000
    .byte   %11110000
    .byte   %11110000

    .byte   %11100000
    .byte   %11100000
    .byte   %11100000
    .byte   %11100000
    .byte   %11000000
    .byte   %11000000
    .byte   %11000000
    .byte   %10000000

    .byte   %10000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000


LOGO_AA2
    .byte   %00000011
    .byte   %00011111
    .byte   %01111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111000
    .byte   %11100000
    .byte   %11000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %01100000
    .byte   %01111000
    .byte   %01111000
    .byte   %01111000
    .byte   %01111000
    .byte   %00111000
    .byte   %00111100

    .byte   %00111100
    .byte   %00111100
    .byte   %00111100
    .byte   %00111100
    .byte   %00011100
    .byte   %00011100
    .byte   %00011110
    .byte   %00011110

    .byte   %00011110
    .byte   %00011110
    .byte   %00001110
    .byte   %00001110
    .byte   %11001110
    .byte   %11101111
    .byte   %11111111
    .byte   %11111111

    .byte   %11110111
    .byte   %11110111
    .byte   %11110111
    .byte   %01110111
    .byte   %01110111
    .byte   %01111111
    .byte   %01111111
    .byte   %01111011

    .byte   %01111011
    .byte   %01111011
    .byte   %00111000
    .byte   %00111000
    .byte   %00111100
    .byte   %00111100
    .byte   %00111100
    .byte   %00111100

    .byte   %00011100
    .byte   %00011100
    .byte   %00011101
    .byte   %00011111
    .byte   %00011111
    .byte   %00011111
    .byte   %00001111
    .byte   %00001111

    .byte   %00001111
    .byte   %00001111
    .byte   %00001111
    .byte   %00001111
    .byte   %00000111
    .byte   %00000000
    .byte   %00000000
    .byte   %00000000

    .byte   %00000000
    .byte   %00000000
    .byte   %11000000
    .byte   %11100000
    .byte   %11111000
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111

    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %11111111
    .byte   %01111111
    .byte   %00011111
    .byte   %00000011

;-------------------------------------------------------------------------------

    CHECK_BANK_SIZE "COPYRIGHT"

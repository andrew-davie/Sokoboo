; TODOs
; + update channel 1 each scanline
; + update channel 0 each scanline
; + convert both kernels to 2LK counters
; + split graphic data into odd and even lines
; + precalculate values
; + calculate inital values some scanlines ahead
; + update AUD0 during kernels
; + check carry flags! AGAIN!!!
; + DEBUG!!!
; + revert code to use ROM bank

; music ideas:
; + precalculate 1 channel (96 bytes RAM = 48 scanlines)
; + calculate other channel during kernel over two scanlines
; x use self-modifying code

; + sync music
; + share logo bank with other bank (copyright!)
; + set pointers
; + joystick input
;   + switch from logo to selection
;   + block 2 joystick row for 1 player
; x calculate cave*=4/5 (done somewhere else)

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

            NEWBANK TITLE_BANK

PLAY_CH_0       = YES           ; play the very tricky, precalculated channel 0
PLAY_CH_1       = YES           ; play the on-the-fly calculated channel 1

TWHITE          = WHITE

NOTE_LEN_NTSC   = 9             ; was: 9 ; number of frames each note is played in total
NOTE_LEN_PAL    = NOTE_LEN_NTSC-1 ; was: NOTE_LEN_NTSC-1 = 8
NOTE_OFF_LEN    = 2             ; number of silent frames between each note (>=1!)
VOL_MASK        = %1100

; number of precalculated values
PC_TOP          = 48            ; calculated during vertical blank
PC_BTM          = 48            ; calculated during overscan

  MAC CHECK_CLC
;    bcs     .                   ; 2/3       set carry causes endless loop
  ENDM

  MAC UPDATE_MUSIC_DATA_LO
    CHECK_CLC
;    clc                         ; 2         we always assume that carry is clear!
    lda     audv{1}Lo           ; 3
    adc     note{1}             ; 3
    sta     audv{1}Lo           ; 3 =  9
  ENDM

  MAC UPDATE_MUSIC_DATA_HI
    lda     audv{1}Hi           ; 3
    adc     #0                  ; 2
    sta     audv{1}Hi           ; 3 =  8
  ENDM

  MAC UPDATE_MUSIC_DATA
    UPDATE_MUSIC_DATA_LO {1}    ; 9
    UPDATE_MUSIC_DATA_HI {1}    ; 8 = 17
  ENDM

  MAC UPDATE_MUSIC_PREP_VOL
    and     #VOL_MASK/2         ; 2         optional, but sounds a tiny bit better if left in
    asl                         ; 2 =  4    carry clear now!
  ENDM

  MAC UPDATE_MUSIC_SET_VOL
   IF PLAY_CH_{1} == YES
    sta     AUDV{1}             ; 3         @07!    NOTE: this store must always occur on the same cycle
   ELSE
    nop     AUDV{1}             ; 3 =  3
   ENDIF
  ENDM

  MAC UPDATE_MUSIC_SET_VOL_W
   IF PLAY_CH_{1} == YES
    sta.w   AUDV{1}             ; 4         @07!    NOTE: this store must always occur on the same cycle
   ELSE
    nop.w   AUDV{1}             ; 4 =  4
   ENDIF
  ENDM

  MAC UPDATE_MUSIC_VOL
    UPDATE_MUSIC_PREP_VOL {1}   ; 4
    UPDATE_MUSIC_SET_VOL {1}    ; 3 =  7
  ENDM

  MAC UPDATE_MUSIC
    UPDATE_MUSIC_DATA {1}       ;17
    UPDATE_MUSIC_VOL {1}        ; 7 = 24
  ENDM

  MAC UPDATE_MUSIC_WSYNC
    UPDATE_MUSIC_DATA {1}       ;17
    sta     WSYNC               ; 3
;---------------------------------------
    UPDATE_MUSIC_VOL {1}        ; 7 = 27
  ENDM


NOT_SEL_COL = $0a

  MAC SET_ROW_COL
    ldx     Platform                ; 3
    lda     selRow                  ; 3
   IF {1} != 0
    eor     #{1}                    ; 2         do NOT change carry!
   ENDIF
    beq     .isSel{1}               ; 2/3
    lda     #NOT_SEL_COL            ; 2
    bne     .notSel{1}              ; 3

.isSel{1}
    lda     SelectionColTbl,x       ; 4
.notSel{1}
    sta     COLUP0                  ; 3
    sta     COLUP1                  ; 3 = 21
  ENDM

  MAC END_ROW                      ;           @59
    sty     COLUP0                  ; 3
    sty     COLUP1                  ; 3
    SLEEP   3                       ; 3
;    nop     GRP0                    ; 3
;    nop     GRP1                    ; 3
;    nop     GRP0                    ; 3

    UPDATE_MUSIC_DATA_HI 1          ; 8 = 17
;---------------------------------------
    UPDATE_MUSIC_VOL 1              ; 7         @07!    <-- AUDV1

    UPDATE_MUSIC_DATA_LO 1          ; 9         @16
  ENDM

  MAC START_ROW                     ;           @33
    ldy     #LKERNEL_H/8-1          ; 2
    sty     loopCntSel              ; 3
    lda     (ptrGfxA),y             ; 5
    sta     tmpGfxA                 ; 3

    SET_ROW_COL {1}                 ;21                 has to be late!

    jmp     EnterSelLoop{1}         ; 3 = 16    @70
  ENDM

  MAC SET_DIGIT_PTR
    ldy     selLst+{1}              ; 3
    lda     SelDigitAPtr,y          ; 4
    sta     ptrGfxA                 ; 3
    lda     SelDigitBPtr,y          ; 4
    sta     ptrGfxB                 ; 3 = 14
  ENDM

  MAC SET_CHAR_PTR
    lda     SelCharAPtr,y           ; 4
    sta     ptrGfxA                 ; 3
    lda     SelCharBPtr,y           ; 4
    sta     ptrGfxB                 ; 3 = 14
  ENDM

  MAC DRAW_ROW

   IF {1} != 0
    ALIGN_FREE 256
   ENDIF

    ;--------------------------------------------------------------------------
    ; Code is exquisitely timed so that each line takes
    ; *EXACTLY* 76 cycles.  Code cannot cross page-boundaries, as the branch
    ; would then take an extra cycle, and bugger the display.
LoopSelGfx{1}                       ;           @60
    ldx     SelGfxB0_{1}-1,y        ; 4
    stx.w   GRP0                    ; 4

    UPDATE_MUSIC_DATA_HI 1          ; 8 = 16    @76
;---------------------------------------
    UPDATE_MUSIC_VOL 1              ; 7         @07!    <-- AUDV1

    UPDATE_MUSIC_DATA_LO 1          ; 9         @16

    lda     SelGfxB1_{1}-1,y        ; 4
    sta     GRP1                    ; 3
    lda     SelGfxB2_{1}-1,y        ; 4
    sta     GRP0                    ; 4 = 14    @30

    lax     (ptrGfxB),y             ; 5
    lda     SelGfxB3_{1}-1,y        ; 4
    ldy     tmpGfxB                 ; 3 = 12

    sta     GRP1                    ; 3         @45
    sty     GRP0                    ; 3         @48
    stx     GRP1                    ; 3         @51
    sta     GRP0                    ; 3 = 15    @54

    ldy     loopCntSel              ; 3
    dey                             ; 2 =  5
    sty     loopCntSel              ; 3
    lda     (ptrGfxA),y             ; 5
    sta     tmpGfxA                 ; 3 = 11
EnterSelLoop{1}                     ;           @70
    lax     SelGfxB4_{1}-1,y        ; 4
;---------------------------------------
V_OFS SET (3-{1})*4                 ;                   calculate separately, else this gives wrong results!
    lda     audV0LstBtm+V_OFS,y     ; 4
    and     #VOL_MASK               ; 2
    UPDATE_MUSIC_SET_VOL 0          ; 3 = 13    @07!    <-- AUDV0

    stx     tmpGfxB                 ; 3
    ldx     SelGfxA0_{1},y          ; 4
    stx     GRP0                    ; 3
    lda     SelGfxA1_{1},y          ; 4
    sta     GRP1                    ; 3
    lda     SelGfxA2_{1},y          ; 4
    sta     GRP0                    ; 3 = 24
                                    ;           @31
    lax     SelGfxA4_{1},y          ; 4
    lda     SelGfxA3_{1},y          ; 4
    ldy     tmpGfxA                 ; 3
    sta     GRP1                    ; 3 = 14    @45!
    stx     GRP0                    ; 3         @48
    sty     GRP1                    ; 3         @51
    sta     GRP0                    ; 3 =  9    @54!

    ldy     loopCntSel              ; 3
    bne     LoopSelGfx{1}           ; 2/3= 5/6  @59
    CHECKPAGE LoopSelGfx{1}
  ENDM


;===============================================================================
; code starts here
;===============================================================================

FREE SET 0

    ;--------------------------------------------------------------------------

SwitchToContTitleBank SUBROUTINE
; has to be at start of bank!
    lda     #BANK_ContTitle     ; 2
    sta     SET_BANK            ; 3
    jmp     NewFrameTitle       ; 3 =  8

SwitchToDrawLogoBank SUBROUTINE
; has to be at start of bank!
    lda     #BANK_DrawLogo      ; 2
    sta     SET_BANK            ; 3

; color tables for NTSC/PAL:
BkColTbl
    .byte   $82
    .byte   $d2
StarsColTbl
    .byte   $9a
    .byte   $da

TradeMarkA = . - 4
    ds 28, 0                ; bottom 7 bytes don't matter
    .byte   %00011100
;    .byte   %00100010
    .byte   %00100010
;    .byte   %01010101
    .byte   %01010101
;    .byte   %01011001
    .byte   %01010101
;    .byte   %01011001
    .byte   %00100010
;    .byte   %00100010
    .byte   %00011100
    ds (TKERNEL_H-66-9-BORDER_H+1)/2, 0           ;
TradeMarkB = . - 33
;    .byte   %00011100
    .byte   %00100010
;    .byte   %00100010
    .byte   %01010101
;    .byte   %01010101
    .byte   %01011001
;    .byte   %01010101
    .byte   %01011001
;    .byte   %00100010
    .byte   %00100010
;    .byte   %00011100
    ds (TKERNEL_H-66-9-BORDER_H+1)/2, 0           ;
    CHECKPAGE TradeMarkA

;-----------------------------------------------------------
; Table defining the height of each PF graphics block.
; Total number must be even!

NextXTbl
; stop byte
    .byte   -1
; bottom border:
  REPEAT BORDER_H/2
    .byte 0
  REPEND
  REPEAT GAP_H/2
    .byte 1
  REPEND
; title graphics:
X SET 2
  REPEAT NUM_BLOCKS
    REPEAT BLOCK_H/2
    .byte X
    REPEND
X SET X+1
  REPEND
; top border:
  REPEAT GAP_H/2
    .byte 1     ; use symmetry
  REPEND
X SET X+1
  REPEAT BORDER_H/2
    .byte 0     ; use symmetry
  REPEND
    CHECKPAGE NextXTbl

;-----------------------------------------------------------
; BOX DASH PF graphics data:

title_STRIP_0
    .byte   240
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   16
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    .byte   208
    CHECKPAGE title_STRIP_0

    ALIGN_FREE 256

title_STRIP_1
    .byte   255
    .byte   0
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   3
    .byte   0
    .byte   207
    .byte   239
    .byte   239
    .byte   239
    .byte   45
    .byte   45
    .byte   45
    .byte   45
    .byte   237
    .byte   237
    .byte   205
    .byte   237
    .byte   45
    .byte   47
    .byte   239
    .byte   192
    CHECKPAGE title_STRIP_1

title_STRIP_2
    .byte   255
    .byte   0
    .byte   179
    .byte   183
    .byte   183
    .byte   183
    .byte   183
    .byte   180
    .byte   180
    .byte   244
    .byte   244
    .byte   180
    .byte   180
    .byte   180
    .byte   180
    .byte   228
    .byte   %01100111
    .byte   3
    .byte   0
    .byte   222
    .byte   222
    .byte   222
    .byte   222
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   214
    .byte   0
    CHECKPAGE title_STRIP_2

title_STRIP_3
    .byte   240
    .byte   0
    .byte   224
    .byte   224
    .byte   224
    .byte   224
    .byte   0
    .byte   0
    .byte   0
    .byte   224
    .byte   224
    .byte   224
    .byte   96
    .byte   96
    .byte   96
    .byte   224
    .byte   224
    .byte   0
    .byte   0
    .byte   176
    .byte   176
    .byte   176
    .byte   176
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   0
    CHECKPAGE title_STRIP_3

title_STRIP_4
    .byte   255
    .byte   0
    .byte   180
    .byte   180
    .byte   180
    .byte   180
    .byte   180
    .byte   180
    .byte   180
    .byte   188
    .byte   188
    .byte   188
    .byte   52
    .byte   52
    .byte   52
    .byte   180
    .byte   180
    .byte   0
    .byte   0
    .byte   231
    .byte   247
    .byte   247
    .byte   247
    .byte   150
    .byte   150
    .byte   150
    .byte   151
    .byte   151
    .byte   151
    .byte   150
    .byte   150
    .byte   150
    .byte   247
    .byte   231
    .byte   0
    CHECKPAGE title_STRIP_4

title_STRIP_5
    .byte   255
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   128
    .byte   173
    .byte   173
    .byte   173
    .byte   173
    .byte   188
    .byte   188
    .byte   156
    .byte   188
    .byte   172
    .byte   172
    .byte   172
    .byte   172
    .byte   172
    .byte   189
    .byte   157
    .byte   128
    CHECKPAGE title_STRIP_5

;    ALIGN_FREE 256

;    ds  $1d, 0
; kernel alignment
;    ds  11, 0
;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE TitleScreen

; clear TIA:
    lda     #0
    ldx     #CXCLR-TIA_BASE_ADDRESS
.loopClearTIA
    sta     TIA_BASE_ADDRESS,x
    dex
    bpl     .loopClearTIA

; clear title RAM to avoid initial sound disturbances
    ldx     #endOfTitleRAM-startOfTitleRAM
.loopClearRAM
    dex
    sta     startOfTitleRAM,x
    bne     .loopClearRAM

    inc     noteLen                 ; 5         == 1
    inc     titleMode

    lda     #BANK_TitleScreen
    sta     ROM_Bank

    lda     #>CharGfx
    sta     ptrGfxA+1
    sta     ptrGfxB+1

    jsr     DetectConsole

; special resync required here, since PAL-60 is not supported:
;    RESYNC                          ;                   -> X, Y == 0

; resync screen, X and Y == 0 afterwards
;        lda #%10                        ; make sure VBLANK is ON
        sta VBLANK

        ldx #8                          ; 5 or more RESYNC_FRAMES
.loopResync
        VERTICAL_SYNC

        ldy #SCANLINES_NTSC/2 - 2
        lda Platform
        and #PAL                        ; only test for PAL (carry unharmed!)
        beq .ntsc
        ldy #SCANLINES_PAL/2 - 2
.ntsc
.loopWait
        sta WSYNC
        sta WSYNC
        dey
        bne .loopWait
        dex
        bne .loopResync


;    clc                             ;                  can be removed after debugging

NewFrameTitle SUBROUTINE

; start of vertical sync processing:
VerticalSync
; Y = 00!
;---------------------------------------
TEST1
;    jsr     UpdateMusicWSync1       ;39         @13
    UPDATE_MUSIC_WSYNC 1            ;27         @07
    lda     #$72                    ; 2                 this value is important for the stars effect
    sta     HMM1                    ; 3
    sta     VSYNC                   ; 3 =  8            enable VSYNC
; put into here, just because we have time:
    lda     #TWHITE                 ; 2
    sta     COLUPF                  ; 3
    sta     COLUP0                  ; 3 =  8

; prepare data for 1st screen row:
    lda     titleMode               ; 3
    beq     .selMode                ; 2/3
; for logo screen:
    ldx     #$90                    ; 2
    stx     HMP0                    ; 3
    bne     .setHMP0                ; 3

; for selection screen:
.selMode                            ; 6
    ldx     hmJunior                ; 3                 $f0/$50
    stx     HMP1                    ; 3
    dex                             ; 2
.setHMP0
    stx     HMP0                    ; 3 = 16

;    ldy     #0
    bit     SWCHB                   ; 4
  IF NTSC_MODE = YES
    bpl     .primaryPlatform        ; 2/3
  ELSE
    bmi     .primaryPlatform        ; 2/3
  ENDIF
    iny                             ; 2
.primaryPlatform
    sty     Platform                ; 3 = 11    @47     P1 difficulty --> TV system (0=NTSC, 1=PAL)

    dec     noteLen                 ; 5                 update frame counter
; free: 1
;---------------------------------------
;    jsr     UpdateMusicWSync0       ;39         @13
    UPDATE_MUSIC_WSYNC 0            ;27

; prepare data for 1st screen row:
    ldx     titleMode               ; 3
    beq     .selMode2               ; 2/3
  IF DEMO_VERSION = NO
    dex
  ELSE
    nop                             ;                   start with 2nd row in demo version because cave cannot be changed anyway
  ENDIF
    stx     selRow                  ; 3
    bpl     .skipJoyX

.selMode2

    lda     noteLen                 ; 3
    bne     .skipJoyX               ; 2/3= 5

    ldy     selRow                  ; 3
    ldx     selLst,y                ; 4 =  7

    lda     SWCHA                   ; 4
    asl                             ; 2
    bcs     .notRight               ; 2/3
    inx                             ; 2
    bpl     .setJoyX                ; 3

.notRight                           ; 9
    clc                             ; 2
    bmi     .notLeft                ; 2/3
    dex                             ; 2
    bmi     .skipJoyX               ; 2/3
.notLeft
.setJoyX
    stx     selLst,y                ; 4
.skipJoyX                           ;   = 21 max
    ldy     #0                      ; 2
;---------------------------------------
    jsr     UpdateMusicWSync1       ;39         @13

; limit selection values:

  IF FINAL_VERSION = YES
; limit cave:
    lda     sLevel                  ; 3
    cmp     #3                      ; 2                 above level 3 only cave A is allowed
    bcc     .lowLevel               ; 2/3
    sty     sCave                   ; 3 = 10
.lowLevel
  ENDIF

; limit joysticks:
    lda     sPlayers                ; 3
    bne     .twoPlayers             ; 2/3
    sty     sJoysticks              ; 3 =  8

; limit current selection:
.twoPlayers
    ldx     selRow                  ; 3
    lda     SelMaxTbl,x             ; 4
    cmp     selLst,x                ; 3
    bcs     .selOk                  ; 2/3
    sta     selLst,x                ; 4
.selOk
    clc                             ; 2 = 18
; free: 1
;---------------------------------------
    jsr     UpdateMusicWSync0       ;39         @13
    sty     VSYNC                   ; 3         @16     disable VSYNC

    UPDATE_MUSIC_DATA_LO 0          ; 9
    php                             ; 3 = 12    @28
;    clc                             ; 2 = 14    @30

    inc     counter                 ; 5
    lda     counter                 ; 3
    and     #%111000                ; 2
    lsr                             ; 2
    lsr                             ; 2
    lsr                             ; 2
    tax                             ; 2 = 18    @48
; free: 4
;---------------------------------------
    jsr     UpdateMusicWSync1       ;39         @13
.r2
    dex                             ; 2
    bpl     .r2                     ; 2/3
    sta     RESM1                   ; 3         @20..55

    plp                             ; 4
    UPDATE_MUSIC_DATA_HI 0          ; 8
    UPDATE_MUSIC_PREP_VOL 0         ; 4
; free: 2
    sta     WSYNC                   ; 3
;---------------------------------------
    sta     HMOVE                   ; 3
    UPDATE_MUSIC_SET_VOL_W 0        ; 7         @07!    <-- AUDV0
    jsr     Wait12                  ;12                 waste 18 cycles and load move value
    dey                             ; 2
    sty     HMM1                    ; 3         @27     this is the tricky part

;-----------------------------------------------------------

  IF L276
    ldy     #(38-PC_TOP/2)/2        ; 2
  ELSE
    ldy     #(32-PC_TOP/2)/2        ; 2
  ENDIF
    lda     Platform                ; 3
    beq     .vSyncNTSC              ; 2/3
    ldy     #(68-PC_TOP/2)/2        ; 2 = 11
.vSyncNTSC                          ;           @38
    sty     tmpY                    ; 3

    ldy     audV0Lst+PC_TOP         ; 3                 take the last precalculated hi value
; here we precalculate another 48 values
    ldx     #PC_TOP-1               ; 2 =  8
; free: 10
.loopVSync                          ;           @46
;---------------------------------------
    UPDATE_MUSIC_WSYNC 1            ;27         @07     maintain sound while precalcuating
; 1st calculation:
    CHECK_CLC
    lda     audvTmpLo               ; 3
    adc     note0                   ; 3 =  6
    bcc     .skipHi1                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi1
    sty     audV0Lst,x              ; 4
    dex                             ; 2 = 14
; 2nd calculation:
    CHECK_CLC
    adc     note0                   ; 3
    sta     audvTmpLo               ; 3 =  6
    bcc     .skipHi2                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi2
    sty     audV0Lst,x              ; 4
    dex                             ; 2 = 14
                                    ;           @47 max
;---------------------------------------
    UPDATE_MUSIC_WSYNC 0            ;27         @07     maintain sound while precalcuating
; 3rd calculation:
    CHECK_CLC
    lda     audvTmpLo               ; 3
    adc     note0                   ; 3 =  6
    bcc     .skipHi3                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi3
    sty     audV0Lst,x              ; 4
    dex                             ; 2 = 14
; 4th calculation:
    CHECK_CLC
    adc     note0                   ; 3
    sta     audvTmpLo               ; 3 =  6
    bcc     .skipHi4                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi4
    sty     audV0Lst,x              ; 4
    dex                             ; 2 = 14
    bpl     .loopVSync              ; 2/3
                                    ;           @49 max
    ldx     tmpY                    ; 3
; do the remaining scanlines (required for PAL)
.waitVSync
;---------------------------------------
    UPDATE_MUSIC_WSYNC 1            ;27         @07

    cpx     #1
    clc
    beq     .lastLoop

    ldy     sCave
    lda     SelCharAPtr,y           ; 4
    sta     ptrGfxA                 ; 3
    lda     SelCharBPtr,y           ; 4
    sta     ptrGfxB                 ; 3
    bcc     .endLoop                ; 3 = 17

.lastLoop
    ldy     #LKERNEL_H/8-1          ; 2
    sty     loopCntSel              ; 3
    lda     (ptrGfxA),y             ; 5
    sta     tmpGfxA                 ; 3 = 13

    ldy     Platform                ; 3
    lda     BkColTbl,y              ; 4
    sta     COLUBK                  ; 3 = 10

; prepare data for 1st selection screen row:
    lda     selRow                  ; 3
    beq     .isSel                  ; 2/3
    lda     #NOT_SEL_COL            ; 2
    bne     .notSel                 ; 3

.isSel
    lda     SelectionColTbl,y       ; 4
.notSel
    sta     tmpGfxB                 ; 3 = 13
.endLoop
;---------------------------------------
    jsr     UpdateMusicWSync0       ;39         @13
    dex                             ; 2
    bne     .waitVSync              ; 2/3

    ;------------------------------------------------------------------------------
    ; START OF DISPLAY
;                                   ;           @17
    lda     StarsColTbl,y           ; 4                 Y is still set from above!
    sta     COLUP1                  ; 3 =  7    @24

    ldx     #0                      ; 2         also used for kernel!
    stx     VDELP0                  ; 3
    stx     NUSIZ0                  ; 3 =  8    @32

    lda     #%10101                 ; 2         double width missile, double width player
    sta     NUSIZ1                  ; 3
    lsr                             ; 2         bit 1 is set, turn missile0 on
    sta     ENAM1                   ; 3
    asl                             ; 2
    sta     CTRLPF                  ; 3 = 15    @47     = %00010100

    ldy     #TKERNEL_H/2            ; 2         total number of scanlines to display (160, was 149)

    UPDATE_MUSIC_DATA_LO 1          ; 9

    sta     RESP0                   ; 3         @61

    UPDATE_MUSIC_DATA_HI 1          ; 8
    UPDATE_MUSIC_PREP_VOL 1         ; 4 = 12    @73
;    bne    .enterKernel
;
;    align 256
;
;.enterKernel
    sta     WSYNC
;---------------------------------------
    stx.w   VBLANK                  ; 4 =  4
LoopTitle                           ;           @04
    UPDATE_MUSIC_SET_VOL 1          ; 3         @07!    <-- AUDV1
    lda     title_STRIP_0,x         ; 4
    sta     PF0                     ; 3
    lda     title_STRIP_1,x         ; 4
    sta     PF1                     ; 3
    lda     title_STRIP_2,x         ; 4
    sta     PF2                     ; 3 = 21    @28

    lda     TradeMarkA,y            ; 4
    sta     GRP0                    ; 3 =  7    @35

    lda     title_STRIP_3,x         ; 4
    sta     PF0                     ; 3         @42     <= @47!
    lda     title_STRIP_4,x         ; 4
    sta     PF1                     ; 3
    lda     title_STRIP_5,x         ; 4
    sta     PF2                     ; 3 = 21    @56

    UPDATE_MUSIC_DATA_LO 1          ; 9
;    SLEEP   9                       ; 9 = 18    @74
    pha                             ; 3
    pla                             ; 4
    nop                             ; 2
;---------------------------------------
    lda     audV0LstTop-1,y         ; 4
    and     #VOL_MASK               ; 2
    UPDATE_MUSIC_SET_VOL 0          ; 3 =  9    @07!    <-- AUDV0

    lda     title_STRIP_0,x         ; 4
    sta     PF0                     ; 3
    lda     title_STRIP_1,x         ; 4
    sta     PF1                     ; 3
    lda     title_STRIP_2,x         ; 4
    sta     PF2                     ; 3 = 21    @28

    lda     TradeMarkB,y            ; 4
    sta     GRP0                    ; 3 =  7    @35

    lda     title_STRIP_3,x         ; 4
    sta     PF0                     ; 3
    lda     title_STRIP_4,x         ; 4
    sta     PF1                     ; 3
    lda     title_STRIP_5,x         ; 4
    sta     PF2                     ; 3 = 21    @56

    UPDATE_MUSIC_DATA_HI 1          ; 8
    UPDATE_MUSIC_PREP_VOL 1         ; 4
    SLEEP   3                       ; 3 = 15    @71

    dey                             ; 2
    ldx     NextXTbl,y              ; 4 =  6    @01
;---------------------------------------
    bpl     LoopTitle               ; 2/3= 6    @04
    CHECKPAGE LoopTitle

    UPDATE_MUSIC_SET_VOL_W 1        ; 4         @07!    <-- AUDV1

    sty     COLUBK                  ; 3                 Y==0
    sty     PF0                     ; 3
    sty     PF1                     ; 3
    sty     PF2                     ; 3
    sty     ENAM1                   ; 3 = 15    @22

    lda     titleMode               ; 3
    beq     DrawSelection           ; 2/4       @29
    jmp     SwitchToDrawLogoBank    ; 8         @35

;--------------------------------------------------------------------------

UpdateMusicWSync0
; maintain first channel
    UPDATE_MUSIC_WSYNC 0            ;27
    rts                             ; 6 = 33

UpdateMusicWSync1
; maintain second channel
    UPDATE_MUSIC_WSYNC 1            ;27
Wait12
    rts                             ; 6 = 33

;--------------------------------------------------------------------------
; 6-sprite routine; 32+2 lines of sprites for selection screen.
    DEFINE_SUBROUTINE DrawSelection

;    lda     #1                      ; 2
;    sta.w   VDELP1                  ; 4

    SLEEP   6
                                    ;           @35
    lda     #%00011                 ; 2

    sta     RESP0                   ; 3         @40     centered
    sta     RESP1                   ; 3         @43

    sta     NUSIZ0                  ; 3
    sta     NUSIZ1                  ; 3
    sta     VDELP0                  ; 3 =  9    @52

; Cave:
    ldy     #LKERNEL_H/8-1          ; 2
;    sty     loopCntSel              ; 3
;    lda     (ptrGfxA),y             ; 5
;    sta     tmpGfxA                 ; 3 = 10
    lda     tmpGfxB                 ; 3
    sta.w   COLUP0                  ; 4
    sta     COLUP1                  ; 3 = 10    @64
;---------------------------------------
;    sta     HMOVE                   ; 3         @67
;    jmp     EnterSelLoop0           ; 3 =  6    @70

    lax     SelGfxB4_0-1,y          ; 4
    sta     HMOVE                   ; 3         @71
    jmp     EnterSelLoop0+3         ; 3 =  6    @74

;    ALIGN_FREE 256

    DRAW_ROW 0                      ;           @59
    END_ROW                         ;           @16

; Level 1/2:
    SET_DIGIT_PTR 1                 ;17
    START_ROW 1

;-------------------------------------------------------------------------------
; fill align gaps:
SelGfx1
  IF FINAL_VERSION = NO
SelGfxA0_2
    .byte   %11100000
    .byte   %11111100
    .byte   %11100110
    .byte   %11111100
SelGfxA0_1
    .byte   %11111101
    .byte   %11100001
    .byte   %11100001
    .byte   %11100001
  ENDIF
    CHECKPAGE SelGfx1

;-------------------------------------------------------------------------------
; Level 2/2
    DRAW_ROW 1                      ;           @59
    END_ROW                         ;           @16

; Players 1/2:
    SET_DIGIT_PTR 2                 ;17
    START_ROW 2

;-------------------------------------------------------------------------------
; fill align gaps:
SelGfx2
SelGfxA0_0
    .byte   %01111100
    .byte   %11100110
    .byte   %11100000
    .byte   %01111100

SelGfxA3_3
    .byte   %11111000
    .byte   %00001100
    .byte   %11111000
    .byte   %11111011
SelGfxA3_2
    .byte   %10011011
    .byte   %11110000
    .byte   %10011001
    .byte   %11110001
SelGfxA3_1
    .byte   %11111101
    .byte   %11000001
    .byte   %11111001
    .byte   %11111101
SelGfxA3_0
    .byte   %11111110
    .byte   %11100000
    .byte   %11111100
    .byte   %11111110

SelGfxA4_3
    .byte   %11100000
    .byte   %11100011
    .byte   %11100011
    .byte   %11111000
SelGfxA4_2
    .byte   %11110000
    .byte   %00011011
    .byte   %11110011
    .byte   %11110000
SelGfxA4_1
    .byte   %11111000
    .byte   %11000011
    .byte   %11000011
    .byte   %11000000
SelGfxA4_0
    .byte   %00000000
    .byte   %00000011
    .byte   %00000011
    .byte   %00000000

SelGfxB0_3
    .byte   %11111101
    .byte   %00001101
    .byte   %00001101
SelGfxB0_2
    .byte   %11100000
    .byte   %11111110
    .byte   %11100110
SelGfxB0_1
    .byte   %11111101
    .byte   %11100001
    .byte   %11100001
SelGfxB0_0
    .byte   %11111110
    .byte   %11100000
    .byte   %11100110

SelGfxB1_3
    .byte   %11111100
    .byte   %10001100
    .byte   %10001101
SelGfxB1_2
    .byte   %11111100
    .byte   %11100000
    .byte   %11100011
SelGfxB1_1
    .byte   %11111100
    .byte   %11000001
    .byte   %11000001
SelGfxB1_0
    .byte   %11100110
    .byte   %11100110
    .byte   %01111100

SelGfxB2_3
    .byte   %01110001
    .byte   %01110000
    .byte   %10001101
SelGfxB2_2
    .byte   %11100011
    .byte   %11100011
    .byte   %00011011
SelGfxB2_1
    .byte   %11111001
    .byte   %11001101
    .byte   %11001101
SelGfxB2_0
    .byte   %01111100
    .byte   %11100110
    .byte   %11100110

SelGfxB3_3
    .byte   %11111100
    .byte   %00001100
    .byte   %11000000
SelGfxB3_2
    .byte   %10011011
    .byte   %11110000
    .byte   %10011011
SelGfxB3_1
    .byte   %11111101
    .byte   %11000001
    .byte   %11000001
SelGfxB3_0
    .byte   %11111110
    .byte   %11100000
    .byte   %11100000
    CHECKPAGE SelGfx2

;-------------------------------------------------------------------------------
; Players 2/2:
    DRAW_ROW 2                      ;           @59
    END_ROW                         ;           @16

; Joysticks 1/2:
    SET_DIGIT_PTR 3                 ;17
    START_ROW 3

;-------------------------------------------------------------------------------
; fill align gaps:
SelGfx3
SelGfxB4_3
    .byte   %11100011
    .byte   %11100000
    .byte   %11100011
SelGfxB4_2
    .byte   %11111011
    .byte   %00011000
    .byte   %10000011
SelGfxB4_1
    .byte   %11111011
    .byte   %11000000
    .byte   %11000011
SelGfxB4_0
    .byte   %00000011
    .byte   %00000000
    .byte   %00000011

CharGfx
Gfx5_A
    .byte   %00111110
    .byte   %01110011
    .byte   %01111110
    .byte   %01111111
Gfx5_B
    .byte   %01111111
    .byte   %00000011
    .byte   %01110000

GfxA_A
    .byte   %01110011
    .byte   %01111111
    .byte   %01110011
    .byte   %00011100
Gfx1_A
    .byte   %00111111
    .byte   %00001100
    .byte   %00011100
    .byte   %00001100
GfxE_A
    .byte   %01111111
    .byte   %01110000
    .byte   %01111110
    .byte   %01111111
Gfx2_A
    .byte   %01111111
    .byte   %00111000
    .byte   %00001110
    .byte   %00111110
GfxI_A
    .byte   %00111110
    .byte   %00011100
    .byte   %00011100
    .byte   %00111110
Gfx3_A
    .byte   %00111110
    .byte   %01110011
    .byte   %00001100
    .byte   %00111111
GfxM_A
    .byte   %01100011
    .byte   %01100011
    .byte   %01111111
    .byte   %01100011
Gfx4_A
    .byte   %00001110
    .byte   %00001110
    .byte   %01101110
    .byte   %01100000

GfxA_B
    .byte   %01110011
    .byte   %01110011
    .byte   %00111110
  IF FINAL_VERSION = NO
    .byte   0
  ENDIF
Gfx1_B
    .byte   %00111111
    .byte   %00001100
    .byte   %00011100
GfxE_B
    .byte   %01111111
    .byte   %01110000
    .byte   %01110000
  IF FINAL_VERSION = NO
    .byte   0
  ENDIF
Gfx2_B
    .byte   %01111111
    .byte   %00011100
    .byte   %01100011
GfxI_B
    .byte   %00111110
    .byte   %00011100
    .byte   %00011100
  IF FINAL_VERSION = NO
    .byte   0
  ENDIF
Gfx3_B
    .byte   %01111111
    .byte   %00000110
    .byte   %00000110
GfxM_B
    .byte   %01100011
    .byte   %01101011
    .byte   %01110111
  IF FINAL_VERSION = NO
    .byte   0
  ENDIF
Gfx4_B
    .byte   %00001110
    .byte   %01111111
    .byte   %01100000

SelGfxA0_3
    .byte   %01111000
    .byte   %11001101
    .byte   %00001101
    .byte   %00001100

SelectionColTbl:
    .byte   YELLOW_NTSC|$C
    .byte   YELLOW_PAL|$C
;    CHECKPAGE CharGfx
    CHECKPAGE (SelGfx3-1)

;-------------------------------------------------------------------------------
; Joysticks 2/2:
    DRAW_ROW 3                      ;           @59

    sty     GRP0                    ; 3
    dey                             ; 2                 -> y = $ff
    sty     VBLANK                  ; 3                 end of screen - enter blanking
    SLEEP   4                       ; 4
    UPDATE_MUSIC_DATA_HI 1          ; 8 = 17    @76
---------------------------------------
    UPDATE_MUSIC_VOL 1              ; 7         @07!    <-- AUDV1

; free: 2

    jmp     SwitchToContTitleBank   ;11         @18

;-------------------------------------------------------------------------------

  IF FINAL_VERSION = YES
SelGfxA0_2
    .byte   %11100000
    .byte   %11111100
    .byte   %11100110
    .byte   %11111100
SelGfxA0_1
    .byte   %11111101
    .byte   %11100001
    .byte   %11100001
    .byte   %11100001
  ENDIF

SelGfxA1_3
    .byte   %11111000
    .byte   %10001100
    .byte   %10001100
    .byte   %11111001
SelGfxA1_2
    .byte   %11111100
    .byte   %11100000
    .byte   %11100001
    .byte   %11100011
SelGfxA1_1
    .byte   %11111100
    .byte   %11000001
    .byte   %11111001
    .byte   %11111101
SelGfxA1_0
    .byte   %11100110
    .byte   %11111110
    .byte   %11100110
    .byte   %00111000

SelGfxA2_3
    .byte   %01110001
    .byte   %01110000
    .byte   %11111000
    .byte   %10001100
SelGfxA2_2
    .byte   %11100011
    .byte   %11100011
    .byte   %11110011
    .byte   %00011011
SelGfxA2_1
    .byte   %01110001
    .byte   %11001101
    .byte   %11001101
    .byte   %11001101
SelGfxA2_0
    .byte   %00111000
    .byte   %11100110
    .byte   %11100110
    .byte   %11100110

  IF FINAL_VERSION = YES
; only caves A, E, I and M allowed
SelCharAPtr:
    .byte   <GfxA_A, <GfxE_A, <GfxI_A, <GfxM_A
    CHECKPAGE SelCharAPtr
SelCharBPtr:
    .byte   <GfxA_B-1, <GfxE_B-1, <GfxI_B-1, <GfxM_B-1
    CHECKPAGE (SelCharBPtr-1)
   ELSE
    IF DEMO_VERSION = NO
; allow selecting all caves and intermissions
; (intermediate caves displayed by "scrolling" effect)
SelCharAPtr:
    .byte   <GfxA_A, <GfxA_A+1 , <GfxA_A+2, <GfxA_A+3, <Gfx1_A
    .byte   <GfxE_A, <GfxE_A+1 , <GfxE_A+2, <GfxE_A+3, <Gfx2_A
    .byte   <GfxI_A, <GfxI_A+1 , <GfxI_A+2, <GfxI_A+3, <Gfx3_A
    .byte   <GfxM_A, <GfxM_A+1 , <GfxM_A+2, <GfxM_A+3, <Gfx4_A
    CHECKPAGE SelCharAPtr
SelCharBPtr
    .byte   <GfxA_B-1, <GfxA_B-1+1 , <GfxA_B-1+2, <GfxA_B-1+3, <Gfx1_B-1
    .byte   <GfxE_B-1, <GfxE_B-1+1 , <GfxE_B-1+2, <GfxE_B-1+3, <Gfx2_B-1
    .byte   <GfxI_B-1, <GfxI_B-1+1 , <GfxI_B-1+2, <GfxI_B-1+3, <Gfx3_B-1
    .byte   <GfxM_B-1, <GfxM_B-1+1 , <GfxM_B-1+2, <GfxM_B-1+3, <Gfx4_B-1
    CHECKPAGE (SelCharBPtr-1)
   ELSE
; demo version starts with cave M
SelCharAPtr:
    .byte   <GfxM_A
SelCharBPtr:
    .byte   <GfxM_B-1
   ENDIF
  ENDIF

SelDigitAPtr:
    .byte   <Gfx1_A, <Gfx2_A, <Gfx3_A, <Gfx4_A, <Gfx5_A
    CHECKPAGE SelDigitAPtr
SelDigitBPtr:
    .byte   <Gfx1_B-1, <Gfx2_B-1, <Gfx3_B-1, <Gfx4_B-1, <Gfx5_B-1
    CHECKPAGE (SelDigitBPtr-1)

SelMaxTbl:
  IF FINAL_VERSION
    .byte   4-1     ; only A, E, I, M selectable
  ELSE
    IF DEMO_VERSION = NO
    .byte   20-1    ; all caves selectable
    ELSE
    .byte   1-1     ; no caves selectable
  ENDIF
  IF DEMO_VERSION = NO
    .byte   NUM_LEVELS-1, 1, 1
  ELSE
    .byte   NUM_LEVELS-2-1
  ENDIF
    .byte   1, 1

;--------------------------------------------------------------------------

    ;------------------------------------------------------------------------------

   DEFINE_SUBROUTINE DetectConsole

;        ldx     #$80        ;       disable VDELP1, else detection will fail!
;        stx     VDELP1
;        dex
        ldx     #$7f        ;
        stx     HMP1        ;       move P1
        stx     ENAM0       ;       enable M0
        stx     GRP1        ;       enable P1
        sta     WSYNC
        sta     RESM0
        sta     RESP1
        sta     HMOVE       ;       HMOVE during RESPx
        sta     WSYNC       ;       start new line
        sta     CXCLR       ;       clear any collisions
        sta     WSYNC       ;       wait one line
        lda     #$f0-$30
        bit     CXM0P       ;       if M0/P1 collision then
        bmi     .compatible
        lda     #$50-$40    ;       console Kool Aid Man incompatible (Jr.) -- FIXED WOBBLE FOR ALL AD'S MACHINES
.compatible:
        sta     hmJunior    ;       different HM values for Jr.
    ; reset graphics:
        lda     #0
        sta     ENAM0
        sta     GRP1

        lda #%10            ;       ugly: make sure VBLANK is ON
        rts


FREE SET FREE + BANK_START + ROM_BANK_SIZE - .

    ECHO "Free bytes in TITLE_BANK:", FREE

    CHECK_BANK_SIZE "TITLE_BANK"

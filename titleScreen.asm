  NEWBANK TITLESCREEN
  DEFINE_SUBROUTINE TitleScreen

  ; Start of new frame

  ; Start of vertical blank processing

TitleSequence

               lda #%00000000
               sta CTRLPF    ; copy playfield
               lda #$0
               sta COLUBK   ; set the background color (sky)

                lda Platform
                and #%10
                tax
                lda colvec,x
                sta colour_table
                lda colvec+1,x
                sta colour_table+1


RestartFrame


               lda #%1110                       ; VSYNC ON
.loopVSync2    sta WSYNC
               sta VSYNC
               lsr
               bne .loopVSync2                  ; branch until VYSNC has been reset

      ;------------------------------------------------------------------

               ldx Platform
               ldy VBlankTime,x
               sty TIM64T

VerticalBlank  sta WSYNC
               lda INTIM
               bne VerticalBlank
               sta VBLANK

      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)

               ldy #119   ; this counts our scanline number
SokoLogo       ldx #3
triplet        lda (colour_table),y
               sta WSYNC
               sta COLUPF         ; 3

               lda COL_0,y  ; 5
               sta PF0      ; 3   @11
               lda COL_1,y  ; 5
               sta PF1      ; 3   @19
               lda COL_2,y  ; 5
               sta PF2      ; 3   @27

               lda COL_3,y  ; 5
               sta PF0      ; 3   @35
               SLEEP 2      ; @37
               lda COL_4,y  ; 5
               sta PF1      ; 3   @45
               SLEEP 3      ; @45
               lda COL_5,y  ; 5
               sta PF2      ; 3

               dey          ; 2
               dex          ; 2
               bne triplet  ; 2(3)

               cpy #2      ; 2
               bne SokoLogo ; 2(3)

              lda #0
              sta PF0
              sta PF1
              sta PF2

                ldx Platform
                lda OverscanTime2,x
                sta TIM64T




frame           lda INTIM
                bne frame



;              ldy #63
;bot2           sta WSYNC
;              dey
;              bpl bot2

      ;--------------------------------------------------------------------------

;              lda #0
;              sta PF0
;              sta PF1
;              sta PF2



    ; D1 VBLANK turns off beam
    ; It needs to be turned on 37 scanlines later

oscan           lda INTIM
                bne oscan

                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

                lda INPT4
                bpl ret

                jmp RestartFrame

ret             rts

OverscanTime2
    .byte 134, 134
    .byte 142, 142

;


colvec
    .word colr, colr_pal

colr_pal
    REPEAT 40
    .byte $3C,$66,$DA
    REPEND

colr
    REPEAT 40
    .byte $1C, $34, $8A
    REPEND

#if 0
colr
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $96,$74,$26
 .byte $96,$74,$26
 .byte $96,$74,$26
 .byte $96,$74,$26
 .byte $96,$74,$26

 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A
 .byte $CA,$74,$2A

 .byte $1A,$24,$2A
 .byte $1A,$24,$2A
 .byte $1A,$24,$2A
 .byte $1A,$24,$2A
 .byte $1A,$24,$2A
 .byte $AA,$24,$68
 .byte $AA,$24,$68
 .byte $AA,$24,$68
 .byte $AA,$24,$68
 .byte $AA,$24,$68

 .byte $28,$74,$68
 .byte $28,$74,$68
 .byte $28,$74,$68
 .byte $28,$74,$68
 .byte $28,$74,$68
 .byte $28,$74,$4A
 .byte $28,$74,$4A
 .byte $28,$74,$4A
 .byte $28,$74,$4A
 .byte $28,$74,$4A
#endif

; created by /anaconda3/envs/Utils4/bin/python /Users/boo/Documents/2600/Utils4/grid.py
COL_0
 .byte  128  ;R
 .byte  240  ;G
 .byte  128  ;B
 .byte  128  ;R
 .byte  240  ;G
 .byte  128  ;B
 .byte  128  ;R
 .byte  240  ;G
 .byte  128  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  48  ;R
 .byte  64  ;G
 .byte  48  ;B
 .byte  48  ;R
 .byte  64  ;G
 .byte  48  ;B
 .byte  112  ;R
 .byte  128  ;G
 .byte  112  ;B
 .byte  112  ;R
 .byte  128  ;G
 .byte  112  ;B
 .byte  112  ;R
 .byte  128  ;G
 .byte  112  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  224  ;R
 .byte  0  ;G
 .byte  224  ;B
 .byte  224  ;R
 .byte  0  ;G
 .byte  224  ;B
 .byte  112  ;R
 .byte  128  ;G
 .byte  112  ;B
 .byte  16  ;R
 .byte  32  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  32  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  32  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  32  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  32  ;G
 .byte  16  ;B
 .byte  48  ;R
 .byte  64  ;G
 .byte  48  ;B
 .byte  48  ;R
 .byte  64  ;G
 .byte  48  ;B
 .byte  48  ;R
 .byte  64  ;G
 .byte  48  ;B
 .byte  48  ;R
 .byte  192  ;G
 .byte  48  ;B
 .byte  224  ;R
 .byte  0  ;G
 .byte  224  ;B
 .byte  224  ;R
 .byte  0  ;G
 .byte  224  ;B
 .byte  192  ;R
 .byte  0  ;G
 .byte  192  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  192  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  192  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  192  ;G
 .byte  0  ;B
COL_1
 .byte  248  ;R
 .byte  192  ;G
 .byte  199  ;B
 .byte  248  ;R
 .byte  192  ;G
 .byte  199  ;B
 .byte  248  ;R
 .byte  192  ;G
 .byte  199  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  48  ;R
 .byte  9  ;G
 .byte  1  ;B
 .byte  48  ;R
 .byte  9  ;G
 .byte  1  ;B
 .byte  112  ;R
 .byte  9  ;G
 .byte  1  ;B
 .byte  120  ;R
 .byte  5  ;G
 .byte  1  ;B
 .byte  120  ;R
 .byte  5  ;G
 .byte  1  ;B
 .byte  120  ;R
 .byte  133  ;G
 .byte  1  ;B
 .byte  76  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  76  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  76  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  163  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  35  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  35  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  35  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  35  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  35  ;G
 .byte  1  ;B
 .byte  68  ;R
 .byte  35  ;G
 .byte  1  ;B
 .byte  100  ;R
 .byte  19  ;G
 .byte  1  ;B
 .byte  36  ;R
 .byte  19  ;G
 .byte  1  ;B
 .byte  36  ;R
 .byte  19  ;G
 .byte  1  ;B
 .byte  60  ;R
 .byte  3  ;G
 .byte  1  ;B
 .byte  28  ;R
 .byte  195  ;G
 .byte  1  ;B
 .byte  220  ;R
 .byte  35  ;G
 .byte  193  ;B
 .byte  220  ;R
 .byte  35  ;G
 .byte  193  ;B
 .byte  204  ;R
 .byte  35  ;G
 .byte  193  ;B
 .byte  200  ;R
 .byte  37  ;G
 .byte  193  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  126  ;R
 .byte  240  ;G
 .byte  113  ;B
 .byte  126  ;R
 .byte  240  ;G
 .byte  113  ;B
 .byte  126  ;R
 .byte  240  ;G
 .byte  113  ;B
COL_2
 .byte  63  ;R
 .byte  199  ;G
 .byte  248  ;B
 .byte  63  ;R
 .byte  199  ;G
 .byte  248  ;B
 .byte  63  ;R
 .byte  199  ;G
 .byte  248  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  96  ;R
 .byte  253  ;G
 .byte  12  ;B
 .byte  96  ;R
 .byte  253  ;G
 .byte  12  ;B
 .byte  112  ;R
 .byte  253  ;G
 .byte  4  ;B
 .byte  240  ;R
 .byte  255  ;G
 .byte  6  ;B
 .byte  240  ;R
 .byte  255  ;G
 .byte  6  ;B
 .byte  240  ;R
 .byte  255  ;G
 .byte  6  ;B
 .byte  144  ;R
 .byte  191  ;G
 .byte  7  ;B
 .byte  144  ;R
 .byte  191  ;G
 .byte  7  ;B
 .byte  144  ;R
 .byte  191  ;G
 .byte  7  ;B
 .byte  16  ;R
 .byte  55  ;G
 .byte  3  ;B
 .byte  16  ;R
 .byte  55  ;G
 .byte  3  ;B
 .byte  16  ;R
 .byte  55  ;G
 .byte  3  ;B
 .byte  16  ;R
 .byte  51  ;G
 .byte  1  ;B
 .byte  16  ;R
 .byte  51  ;G
 .byte  1  ;B
 .byte  16  ;R
 .byte  55  ;G
 .byte  3  ;B
 .byte  16  ;R
 .byte  55  ;G
 .byte  3  ;B
 .byte  16  ;R
 .byte  55  ;G
 .byte  3  ;B
 .byte  16  ;R
 .byte  63  ;G
 .byte  3  ;B
 .byte  16  ;R
 .byte  63  ;G
 .byte  7  ;B
 .byte  16  ;R
 .byte  63  ;G
 .byte  7  ;B
 .byte  16  ;R
 .byte  63  ;G
 .byte  6  ;B
 .byte  16  ;R
 .byte  63  ;G
 .byte  6  ;B
 .byte  16  ;R
 .byte  63  ;G
 .byte  6  ;B
 .byte  48  ;R
 .byte  125  ;G
 .byte  4  ;B
 .byte  32  ;R
 .byte  109  ;G
 .byte  4  ;B
 .byte  32  ;R
 .byte  109  ;G
 .byte  4  ;B
 .byte  224  ;R
 .byte  237  ;G
 .byte  4  ;B
 .byte  192  ;R
 .byte  221  ;G
 .byte  12  ;B
 .byte  192  ;R
 .byte  221  ;G
 .byte  12  ;B
 .byte  192  ;R
 .byte  221  ;G
 .byte  12  ;B
 .byte  128  ;R
 .byte  157  ;G
 .byte  12  ;B
 .byte  128  ;R
 .byte  157  ;G
 .byte  12  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  252  ;R
 .byte  28  ;G
 .byte  227  ;B
 .byte  252  ;R
 .byte  28  ;G
 .byte  227  ;B
 .byte  252  ;R
 .byte  28  ;G
 .byte  227  ;B
COL_3
 .byte  0  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  0  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  0  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  208  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  208  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  208  ;G
 .byte  192  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  80  ;R
 .byte  240  ;G
 .byte  64  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  208  ;R
 .byte  240  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  208  ;G
 .byte  192  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  112  ;G
 .byte  112  ;B
 .byte  0  ;R
 .byte  112  ;G
 .byte  112  ;B
 .byte  0  ;R
 .byte  112  ;G
 .byte  112  ;B
COL_4
 .byte  31  ;R
 .byte  252  ;G
 .byte  28  ;B
 .byte  31  ;R
 .byte  252  ;G
 .byte  28  ;B
 .byte  31  ;R
 .byte  252  ;G
 .byte  28  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  128  ;R
 .byte  193  ;G
 .byte  134  ;B
 .byte  128  ;R
 .byte  193  ;G
 .byte  134  ;B
 .byte  192  ;R
 .byte  225  ;G
 .byte  206  ;B
 .byte  224  ;R
 .byte  240  ;G
 .byte  239  ;B
 .byte  224  ;R
 .byte  240  ;G
 .byte  239  ;B
 .byte  224  ;R
 .byte  240  ;G
 .byte  239  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  41  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  41  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  41  ;B
 .byte  96  ;R
 .byte  116  ;G
 .byte  104  ;B
 .byte  96  ;R
 .byte  116  ;G
 .byte  104  ;B
 .byte  96  ;R
 .byte  116  ;G
 .byte  104  ;B
 .byte  224  ;R
 .byte  244  ;G
 .byte  232  ;B
 .byte  224  ;R
 .byte  244  ;G
 .byte  232  ;B
 .byte  192  ;R
 .byte  228  ;G
 .byte  200  ;B
 .byte  192  ;R
 .byte  228  ;G
 .byte  200  ;B
 .byte  192  ;R
 .byte  228  ;G
 .byte  200  ;B
 .byte  192  ;R
 .byte  228  ;G
 .byte  200  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  40  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  40  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  40  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  40  ;B
 .byte  32  ;R
 .byte  52  ;G
 .byte  40  ;B
 .byte  96  ;R
 .byte  114  ;G
 .byte  108  ;B
 .byte  96  ;R
 .byte  114  ;G
 .byte  100  ;B
 .byte  96  ;R
 .byte  114  ;G
 .byte  100  ;B
 .byte  224  ;R
 .byte  240  ;G
 .byte  231  ;B
 .byte  192  ;R
 .byte  224  ;G
 .byte  195  ;B
 .byte  192  ;R
 .byte  224  ;G
 .byte  195  ;B
 .byte  192  ;R
 .byte  224  ;G
 .byte  195  ;B
 .byte  128  ;R
 .byte  192  ;G
 .byte  129  ;B
 .byte  128  ;R
 .byte  192  ;G
 .byte  129  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  7  ;R
 .byte  63  ;G
 .byte  7  ;B
 .byte  7  ;R
 .byte  63  ;G
 .byte  7  ;B
 .byte  7  ;R
 .byte  63  ;G
 .byte  7  ;B
COL_5
 .byte  241  ;R
 .byte  112  ;G
 .byte  142  ;B
 .byte  241  ;R
 .byte  112  ;G
 .byte  142  ;B
 .byte  241  ;R
 .byte  112  ;G
 .byte  142  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  24  ;R
 .byte  32  ;G
 .byte  24  ;B
 .byte  24  ;R
 .byte  32  ;G
 .byte  24  ;B
 .byte  28  ;R
 .byte  32  ;G
 .byte  28  ;B
 .byte  60  ;R
 .byte  65  ;G
 .byte  60  ;B
 .byte  60  ;R
 .byte  65  ;G
 .byte  60  ;B
 .byte  60  ;R
 .byte  65  ;G
 .byte  60  ;B
 .byte  100  ;R
 .byte  138  ;G
 .byte  101  ;B
 .byte  100  ;R
 .byte  138  ;G
 .byte  101  ;B
 .byte  100  ;R
 .byte  138  ;G
 .byte  101  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  68  ;R
 .byte  138  ;G
 .byte  69  ;B
 .byte  76  ;R
 .byte  146  ;G
 .byte  77  ;B
 .byte  72  ;R
 .byte  146  ;G
 .byte  73  ;B
 .byte  72  ;R
 .byte  146  ;G
 .byte  73  ;B
 .byte  120  ;R
 .byte  130  ;G
 .byte  121  ;B
 .byte  112  ;R
 .byte  130  ;G
 .byte  113  ;B
 .byte  112  ;R
 .byte  130  ;G
 .byte  113  ;B
 .byte  112  ;R
 .byte  130  ;G
 .byte  113  ;B
 .byte  96  ;R
 .byte  130  ;G
 .byte  97  ;B
 .byte  32  ;R
 .byte  65  ;G
 .byte  32  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  199  ;R
 .byte  192  ;G
 .byte  56  ;B
 .byte  199  ;R
 .byte  192  ;G
 .byte  56  ;B
 .byte  199  ;R
 .byte  192  ;G
 .byte  56  ;B


 CHECK_BANK_SIZE "INITBANK"

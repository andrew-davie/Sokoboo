  NEWBANK TITLESCREEN
  DEFINE_SUBROUTINE TitleScreen

  ; Start of new frame

  ; Start of vertical blank processing

TitleSequence

               lda #%00000000
               sta CTRLPF    ; copy playfield
               lda #$0
               sta COLUBK   ; set the background color (sky)
               lda #0
               sta VBLANK
               lda #2
               sta VSYNC
               sta WSYNC
               sta WSYNC
               sta WSYNC   ; 3 scanlines of VSYNC signal

               lda #0
               sta VSYNC

      ;------------------------------------------------------------------

      ; 37 scanlines of vertical blank...



               ldx #0
VerticalBlank  sta WSYNC
               inx
               cpx #37
               bne VerticalBlank


      ;------------------------------------------------------------------

      ; Do 192 scanlines of color-changing (our picture)


              ldy #20
bot           sta WSYNC
              dey
              bpl bot


               ldy #119   ; this counts our scanline number
SokoLogo
               sta WSYNC
               ;sty COLUBK
               lda colr,y ;#$ca     ; 2
               sta COLUPF   ; 3 @ 5

               lda COL_0,y  ; 5
               sta PF0      ; 3   @13
               lda COL_1,y  ; 5
               sta PF1      ; 3   @21
               lda COL_2,y  ; 5
               sta PF2      ; 3   @29

               ; @29

               lda COL_3,y  ; 5
               sta PF0      ; 3 @ 37
               SLEEP 2      ; @39
               lda COL_4,y  ; 5
               sta PF1      ; 3 @47
               SLEEP 3
               lda COL_5,y
               sta PF2

                dey
;2
                sta WSYNC
                lda colr,y ;#$74
                sta COLUPF    ; set playfield color (cloud)

                lda COL_0,y  ; 5
                sta PF0      ; 3   @13
                lda COL_1,y  ; 5
                sta PF1      ; 3   @21
                lda COL_2,y  ; 5
                sta PF2      ; 3   @29

                ; @29

                lda COL_3,y  ; 5
                sta PF0      ; 3 @ 37
                SLEEP 2      ; @39
                lda COL_4,y  ; 5
                sta PF1      ; 3 @47
                SLEEP 3
                lda COL_5,y
                sta PF2

                dey
;3
              sta WSYNC
              lda colr,y ;#$2a
              sta COLUPF    ; set playfield color (cloud)

              lda COL_0,y  ; 5
              sta PF0      ; 3   @13
              lda COL_1,y  ; 5
              sta PF1      ; 3   @21
              lda COL_2,y  ; 5
              sta PF2      ; 3   @29

              ; @29

              lda COL_3,y  ; 5
              sta PF0      ; 3 @ 37
              SLEEP 2      ; @39
              lda COL_4,y  ; 5
              sta PF1      ; 3 @47
              SLEEP 3
              lda COL_5,y
              sta PF2

               dey
               cpy #$FF
               beq noGo
               jmp SokoLogo
noGo

              SLEEP 20
              lda #0
              sta PF0
              sta PF1
              sta PF2

              ldy #63
bot2           sta WSYNC
              dey
              bpl bot2

      ;--------------------------------------------------------------------------

              lda #0
              sta PF0
              sta PF1
              sta PF2


               lda #%01000010

               sta VBLANK   ; end of screen - enter blanking



      ; 30 scanlines of overscan...



               ldx #0

Overscan

               sta WSYNC

               inx

               cpx #30

               bne Overscan

               lda INPT4
               bpl ret

               jmp TitleSequence

ret            rts


;

colr
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26
 .byte $C6,$74,$26

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
 .byte $1A,$24,$68
 .byte $1A,$24,$68
 .byte $1A,$24,$68
 .byte $1A,$24,$68
 .byte $1A,$24,$68

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
 .byte  112  ;G
 .byte  48  ;B
 .byte  16  ;R
 .byte  80  ;G
 .byte  48  ;B
 .byte  96  ;R
 .byte  224  ;G
 .byte  112  ;B
 .byte  48  ;R
 .byte  176  ;G
 .byte  112  ;B
 .byte  80  ;R
 .byte  208  ;G
 .byte  112  ;B
 .byte  128  ;R
 .byte  128  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
 .byte  64  ;R
 .byte  64  ;G
 .byte  192  ;B
 .byte  128  ;R
 .byte  128  ;G
 .byte  192  ;B
 .byte  128  ;R
 .byte  128  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
 .byte  64  ;R
 .byte  64  ;G
 .byte  192  ;B
 .byte  128  ;R
 .byte  128  ;G
 .byte  192  ;B
 .byte  128  ;R
 .byte  128  ;G
 .byte  192  ;B
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
 .byte  64  ;R
 .byte  64  ;G
 .byte  224  ;B
 .byte  160  ;R
 .byte  160  ;G
 .byte  224  ;B
 .byte  96  ;R
 .byte  224  ;G
 .byte  112  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  16  ;B
 .byte  0  ;R
 .byte  32  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  16  ;B
 .byte  32  ;R
 .byte  96  ;G
 .byte  48  ;B
 .byte  48  ;R
 .byte  112  ;G
 .byte  48  ;B
 .byte  16  ;R
 .byte  80  ;G
 .byte  48  ;B
 .byte  32  ;R
 .byte  224  ;G
 .byte  48  ;B
 .byte  160  ;R
 .byte  160  ;G
 .byte  224  ;B
 .byte  64  ;R
 .byte  64  ;G
 .byte  224  ;B
 .byte  64  ;R
 .byte  64  ;G
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
 .byte  227  ;G
 .byte  193  ;B
 .byte  156  ;R
 .byte  163  ;G
 .byte  193  ;B
 .byte  204  ;R
 .byte  227  ;G
 .byte  193  ;B
 .byte  136  ;R
 .byte  165  ;G
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
 .byte  237  ;G
 .byte  12  ;B
 .byte  96  ;R
 .byte  237  ;G
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
 .byte  116  ;G
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

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

                RESYNC

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
    .byte $D6,$64,$3A
    .byte $D6,$64,$3A
    .byte $D6,$64,$3A
    .byte $D6,$64,$3A

    .byte $D4,$64,$38
    .byte $D4,$64,$38
    .byte $D4,$64,$38
    .byte $D4,$64,$38

        REPEAT 4
    .byte $D4,$64,$38
        REPEND

        REPEAT 4
    .byte $D6,$66,$38
        REPEND

        REPEAT 4
    .byte $D6,$66,$38
        REPEND

        REPEAT 4
    .byte $D6,$66,$38
        REPEND

        REPEAT 4
    .byte $D8,$68,$3A
        REPEND

        REPEAT 4
    .byte $D8,$68,$3A
        REPEND

        REPEAT 4
    .byte $D8,$68,$3A
        REPEND

        REPEAT 4
    .byte $DA,$6A,$3C
        REPEND

#if 0
colr
    REPEAT 40
    .byte $1C, $34, $8A
    REPEND
#else
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

COL_0
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
 .byte  224  ;R
 .byte  224  ;G
 .byte  224  ;B
 .byte  32  ;R
 .byte  224  ;G
 .byte  32  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  208  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  208  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  208  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  144  ;B
 .byte  144  ;R
 .byte  16  ;G
 .byte  144  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  208  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  112  ;R
 .byte  16  ;G
 .byte  80  ;B
 .byte  80  ;R
 .byte  16  ;G
 .byte  80  ;B
 .byte  112  ;R
 .byte  16  ;G
 .byte  80  ;B
 .byte  80  ;R
 .byte  16  ;G
 .byte  80  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  208  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  208  ;R
 .byte  16  ;G
 .byte  208  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  144  ;B
 .byte  144  ;R
 .byte  16  ;G
 .byte  144  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  16  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  240  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  48  ;R
 .byte  16  ;G
 .byte  16  ;B
 .byte  224  ;R
 .byte  32  ;G
 .byte  32  ;B
 .byte  224  ;R
 .byte  224  ;G
 .byte  224  ;B
 .byte  192  ;R
 .byte  192  ;G
 .byte  192  ;B
COL_1
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  0  ;R
 .byte  255  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  12  ;R
 .byte  127  ;G
 .byte  12  ;B
 .byte  125  ;R
 .byte  14  ;G
 .byte  12  ;B
 .byte  156  ;R
 .byte  63  ;G
 .byte  156  ;B
 .byte  189  ;R
 .byte  30  ;G
 .byte  156  ;B
 .byte  158  ;R
 .byte  63  ;G
 .byte  158  ;B
 .byte  222  ;R
 .byte  31  ;G
 .byte  222  ;B
 .byte  210  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  214  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  210  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  214  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  210  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  214  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  210  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  214  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  210  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  214  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  210  ;R
 .byte  27  ;G
 .byte  210  ;B
 .byte  182  ;R
 .byte  27  ;G
 .byte  146  ;B
 .byte  18  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  246  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  18  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  246  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  18  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  118  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  18  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  118  ;R
 .byte  27  ;G
 .byte  18  ;B
 .byte  154  ;R
 .byte  31  ;G
 .byte  154  ;B
 .byte  218  ;R
 .byte  31  ;G
 .byte  218  ;B
 .byte  238  ;R
 .byte  15  ;G
 .byte  238  ;B
 .byte  238  ;R
 .byte  15  ;G
 .byte  238  ;B
 .byte  102  ;R
 .byte  7  ;G
 .byte  102  ;B
 .byte  239  ;R
 .byte  6  ;G
 .byte  38  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
COL_2
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  0  ;R
 .byte  255  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  192  ;R
 .byte  221  ;G
 .byte  25  ;B
 .byte  196  ;R
 .byte  217  ;G
 .byte  25  ;B
 .byte  224  ;R
 .byte  237  ;G
 .byte  9  ;B
 .byte  228  ;R
 .byte  233  ;G
 .byte  9  ;B
 .byte  224  ;R
 .byte  237  ;G
 .byte  9  ;B
 .byte  224  ;R
 .byte  237  ;G
 .byte  13  ;B
 .byte  32  ;R
 .byte  239  ;G
 .byte  15  ;B
 .byte  160  ;R
 .byte  111  ;G
 .byte  15  ;B
 .byte  32  ;R
 .byte  239  ;G
 .byte  15  ;B
 .byte  176  ;R
 .byte  103  ;G
 .byte  7  ;B
 .byte  32  ;R
 .byte  231  ;G
 .byte  7  ;B
 .byte  176  ;R
 .byte  103  ;G
 .byte  7  ;B
 .byte  32  ;R
 .byte  227  ;G
 .byte  3  ;B
 .byte  184  ;R
 .byte  99  ;G
 .byte  3  ;B
 .byte  32  ;R
 .byte  103  ;G
 .byte  7  ;B
 .byte  176  ;R
 .byte  103  ;G
 .byte  7  ;B
 .byte  32  ;R
 .byte  103  ;G
 .byte  7  ;B
 .byte  160  ;R
 .byte  103  ;G
 .byte  7  ;B
 .byte  32  ;R
 .byte  111  ;G
 .byte  15  ;B
 .byte  160  ;R
 .byte  111  ;G
 .byte  15  ;B
 .byte  32  ;R
 .byte  109  ;G
 .byte  13  ;B
 .byte  160  ;R
 .byte  109  ;G
 .byte  13  ;B
 .byte  32  ;R
 .byte  109  ;G
 .byte  13  ;B
 .byte  164  ;R
 .byte  105  ;G
 .byte  9  ;B
 .byte  32  ;R
 .byte  105  ;G
 .byte  9  ;B
 .byte  100  ;R
 .byte  233  ;G
 .byte  9  ;B
 .byte  96  ;R
 .byte  233  ;G
 .byte  9  ;B
 .byte  68  ;R
 .byte  217  ;G
 .byte  25  ;B
 .byte  192  ;R
 .byte  217  ;G
 .byte  25  ;B
 .byte  196  ;R
 .byte  217  ;G
 .byte  25  ;B
 .byte  128  ;R
 .byte  153  ;G
 .byte  25  ;B
 .byte  196  ;R
 .byte  153  ;G
 .byte  25  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
COL_3
 .byte  240  ;R
 .byte  240  ;G
 .byte  240  ;B
 .byte  240  ;R
 .byte  240  ;G
 .byte  240  ;B
 .byte  0  ;R
 .byte  240  ;G
 .byte  0  ;B
 .byte  240  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  32  ;R
 .byte  16  ;G
 .byte  192  ;B
 .byte  0  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  32  ;R
 .byte  16  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  64  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  16  ;R
 .byte  48  ;G
 .byte  192  ;B
 .byte  48  ;R
 .byte  16  ;G
 .byte  192  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  240  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  240  ;R
 .byte  240  ;G
 .byte  240  ;B
 .byte  240  ;R
 .byte  240  ;G
 .byte  240  ;B
COL_4
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  0  ;R
 .byte  255  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  0  ;R
 .byte  63  ;G
 .byte  134  ;B
 .byte  56  ;R
 .byte  7  ;G
 .byte  134  ;B
 .byte  0  ;R
 .byte  31  ;G
 .byte  206  ;B
 .byte  0  ;R
 .byte  15  ;G
 .byte  238  ;B
 .byte  0  ;R
 .byte  15  ;G
 .byte  239  ;B
 .byte  128  ;R
 .byte  15  ;G
 .byte  111  ;B
 .byte  0  ;R
 .byte  207  ;G
 .byte  41  ;B
 .byte  194  ;R
 .byte  13  ;G
 .byte  41  ;B
 .byte  0  ;R
 .byte  207  ;G
 .byte  41  ;B
 .byte  194  ;R
 .byte  13  ;G
 .byte  41  ;B
 .byte  0  ;R
 .byte  143  ;G
 .byte  105  ;B
 .byte  130  ;R
 .byte  13  ;G
 .byte  105  ;B
 .byte  0  ;R
 .byte  15  ;G
 .byte  105  ;B
 .byte  2  ;R
 .byte  13  ;G
 .byte  233  ;B
 .byte  16  ;R
 .byte  15  ;G
 .byte  201  ;B
 .byte  18  ;R
 .byte  13  ;G
 .byte  201  ;B
 .byte  16  ;R
 .byte  15  ;G
 .byte  201  ;B
 .byte  18  ;R
 .byte  13  ;G
 .byte  73  ;B
 .byte  0  ;R
 .byte  207  ;G
 .byte  41  ;B
 .byte  194  ;R
 .byte  13  ;G
 .byte  41  ;B
 .byte  0  ;R
 .byte  79  ;G
 .byte  41  ;B
 .byte  194  ;R
 .byte  13  ;G
 .byte  41  ;B
 .byte  0  ;R
 .byte  15  ;G
 .byte  41  ;B
 .byte  194  ;R
 .byte  13  ;G
 .byte  41  ;B
 .byte  0  ;R
 .byte  15  ;G
 .byte  105  ;B
 .byte  128  ;R
 .byte  15  ;G
 .byte  109  ;B
 .byte  0  ;R
 .byte  15  ;G
 .byte  109  ;B
 .byte  24  ;R
 .byte  7  ;G
 .byte  197  ;B
 .byte  0  ;R
 .byte  7  ;G
 .byte  199  ;B
 .byte  24  ;R
 .byte  7  ;G
 .byte  199  ;B
 .byte  0  ;R
 .byte  3  ;G
 .byte  131  ;B
 .byte  60  ;R
 .byte  3  ;G
 .byte  131  ;B
 .byte  0  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  0  ;G
 .byte  0  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
 .byte  255  ;R
 .byte  255  ;G
 .byte  255  ;B
COL_5
 .byte  63  ;R
 .byte  63  ;G
 .byte  63  ;B
 .byte  127  ;R
 .byte  127  ;G
 .byte  127  ;B
 .byte  64  ;R
 .byte  127  ;G
 .byte  64  ;B
 .byte  255  ;R
 .byte  128  ;G
 .byte  128  ;B
 .byte  140  ;R
 .byte  227  ;G
 .byte  140  ;B
 .byte  239  ;R
 .byte  128  ;G
 .byte  140  ;B
 .byte  142  ;R
 .byte  225  ;G
 .byte  142  ;B
 .byte  239  ;R
 .byte  128  ;G
 .byte  142  ;B
 .byte  158  ;R
 .byte  193  ;G
 .byte  158  ;B
 .byte  222  ;R
 .byte  129  ;G
 .byte  158  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  218  ;R
 .byte  129  ;G
 .byte  146  ;B
 .byte  146  ;R
 .byte  201  ;G
 .byte  146  ;B
 .byte  214  ;R
 .byte  129  ;G
 .byte  150  ;B
 .byte  150  ;R
 .byte  193  ;G
 .byte  150  ;B
 .byte  214  ;R
 .byte  129  ;G
 .byte  148  ;B
 .byte  156  ;R
 .byte  195  ;G
 .byte  156  ;B
 .byte  222  ;R
 .byte  129  ;G
 .byte  156  ;B
 .byte  152  ;R
 .byte  193  ;G
 .byte  152  ;B
 .byte  255  ;R
 .byte  128  ;G
 .byte  152  ;B
 .byte  192  ;R
 .byte  128  ;G
 .byte  128  ;B
 .byte  127  ;R
 .byte  64  ;G
 .byte  64  ;B
 .byte  127  ;R
 .byte  127  ;G
 .byte  127  ;B
 .byte  63  ;R
 .byte  63  ;G
 .byte  63  ;B


 CHECK_BANK_SIZE "INITBANK"

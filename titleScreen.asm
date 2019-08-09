  NEWBANK TITLESCREEN
  DEFINE_SUBROUTINE TitleScreen

  ; Start of new frame

  ; Start of vertical blank processing

TitleSequence

                lda #%00000000
                sta CTRLPF
                sta COLUBK

                ldx Platform
                lda colvec,x
                sta colour_table
                lda colvec+1,x
                sta colour_table+1

                RESYNC

RestartFrame
                lda #%1110                       ; VSYNC ON
.loopVSync2     sta WSYNC
                sta VSYNC
                lsr
                bne .loopVSync2                  ; branch until VYSNC has been reset

      ;------------------------------------------------------------------

                ldx Platform
                ldy VBlankTime,x
                sty TIM64T

VerticalBlank   sta WSYNC
                lda INTIM
                bne VerticalBlank
                sta VBLANK


      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)

                ldy #119   ; this counts our scanline number
SokoLogo        ldx #3
triplet         lda (colour_table),y
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

                cpy #-1      ; 2
                bne SokoLogo ; 2(3)

                lda #0
                sta PF0
                sta PF1
                sta PF2

                ldx Platform
                lda OverscanTime2,x
                sta TIM64T

#if 0
            sta WSYNC
            sta WSYNC
            sta WSYNC
            sta WSYNC
            sta WSYNC
            SLEEP 8
            jsr SokoScreen

    lda #0
    sta BoardScrollX
    sta BoardScrollY
#endif

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

oscan
                lda INTIM
                bne oscan

                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

                lda INPT4
                bpl ret

                jmp RestartFrame

ret             rts

OverscanTime2
    .byte 131, 131
    .byte 139, 139

;


colvec
    .word colr, colr_pal

colr_pal
        REPEAT 40
    .byte $b8,$66,$5a
        REPEND

#if 1
colr
    REPEAT 40
    .byte $88, $36, $BA
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

    include "titleData.asm"

 CHECK_BANK_SIZE "INITBANK"

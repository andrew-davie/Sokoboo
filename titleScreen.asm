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

                sta rndHi
                sta rnd


                RESYNC

    DEFINE_SUBROUTINE RestartFrame
                lda #%1110                       ; VSYNC ON
.loopVSync2     sta WSYNC
                sta VSYNC
                lsr
                bne .loopVSync2                  ; branch until VYSNC has been reset

      ;------------------------------------------------------------------



                ldx Platform
                ldy VBlankTime,x
                sty TIM64T


#if 0
                lda SWCHB
                rol
                rol
                rol
                and #%11
                eor #PAL
                cmp Platform
                beq platOK
                sta Platform
                jmp TitleSequence
platOK
#endif

k2              inc rnd
                beq k2


VerticalBlank   sta WSYNC
                lda INTIM
                bne VerticalBlank
                sta VBLANK

                ;sta COLUBK

      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)

                ldy #210-1  ; this counts our scanline number
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


                NEXT_RANDOM

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
    .byte 26, 26
    .byte 33, 33

colvec
    .word colr_ntsc, colr_pal


    MAC LUMTABLE ;{1}{2}{3} base colours
; {4} MIN LUM 1
; {5} MIN LUM 2
; {6} MIN LUM 3

.LUM1     SET {4}*256
.LUM2     SET {5}*256
.LUM3     SET {6}*256

.STEP1 = (256*({7}-{4}))/72
.STEP2 = (256*({8}-{5}))/72
.STEP3 = (256*({9}-{6}))/72

    REPEAT 72
            .byte {1}+(.LUM1/256)
            .byte {2}+(.LUM2/256)
            .byte {3}+(.LUM3/256)
.LUM1     SET .LUM1 + .STEP1
.LUM2     SET .LUM2 + .STEP2
.LUM3     SET .LUM3 + .STEP3
    REPEND
    ENDM

;colr_pal    LUMTABLE $B0,$30,$A0,0,8,4 ;2,4,6
;    OPTIONAL_PAGEBREAK "colr_ntsc", 72*3
colr_ntsc   LUMTABLE $A0,$50,$30,$A,$2,$E,$8,$E,$8
;colr_ntsc   LUMTABLE $70,$40,$a0,$A,$2,$E,$8,$E,$8


;    OPTIONAL_PAGEBREAK "colr_pal", 72*3
;colr_pal        LUMTABLE $b0, $60, $20, $A,$6,$C,$8,$C,$8
colr_pal        LUMTABLE $90, $b0, $60, $6,$8,$a,$6,$a,$a

    include "titleData.asm"
;    include "pizza.asm"

 CHECK_BANK_SIZE "TITLESCREEN"

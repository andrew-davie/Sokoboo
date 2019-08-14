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

colvec
    .word colr_ntsc, colr_pal


    MAC LUMTABLE ;{1}{2}{3} base colours
; {4} MIN LUM 1
; {5} MIN LUM 2
; {6} MIN LUM 3

.LUM1     SET {4}
.LUM2     SET {5}
.LUM3     SET {6}

.STEP1 = 256*($C-{4})/8
.STEP2 = 256*($C-{5})/8
.STEP3 = 256*($C-{6})/8

    REPEAT 8
        REPEAT 5
            .byte {1}+{4}+(.LUM1/256/5)
            .byte {2}+{5}+(.LUM2/256/5)
            .byte {3}+{6}+(.LUM3/256/5)
.LUM1     SET .LUM1 + .STEP1
.LUM2     SET .LUM2 + .STEP2
.LUM3     SET .LUM3 + .STEP3
        REPEND
    REPEND
    ENDM

;colr_pal    LUMTABLE $B0,$30,$A0,0,8,4 ;2,4,6
colr_pal        LUMTABLE $C0, $90, $60,0,8,4
colr_ntsc   LUMTABLE $80,$B0,$50,0,8,4

    include "titleData.asm"
;    include "pizza.asm"

 CHECK_BANK_SIZE "INITBANK"

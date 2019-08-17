  NEWBANK LEVELSCREEN
  DEFINE_SUBROUTINE LevelScreen

  ; Start of new frame

  ; Start of vertical blank processing

LevelSequence

                lda #%00000000
                sta COLUBK
                sta CTRLPF
                sta digit
                sta digit+1

                lda #$FF
                sta digitick
                lda #75
                sta endwait

                lda #10
                sta initialdelay

                clc
                lda levelX
                adc #1
                sta targetDigit

                RESYNC

RestartFrameX
                lda #%1110                       ; VSYNC ON
.loopVSync3     sta WSYNC
                sta VSYNC
                lsr
                bne .loopVSync3                  ; branch until VYSNC has been reset

                lda digit+1
                asl
                tax
                lda LDIGIT,x
                sta digit1
                lda LDIGIT+1,x
                sta digit1+1

                lda digit
                asl
                tax
                lda RDIGIT,x
                sta digit2
                lda RDIGIT+1,x
                sta digit2+1




      ;------------------------------------------------------------------
                ldx Platform
                lda colvecX,x
                sta colour_table
                lda colvecX+1,x
                sta colour_table+1

                ldx Platform
                ldy VBlankTime2x,x
                sty TIM64T

VerticalBlankX   sta WSYNC
                lda INTIM
                bne VerticalBlankX
                sta VBLANK

                lda #0
                sta PF0
                sta PF1
                sta PF2

      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)

                ldy #26   ; this counts our scanline number
SokoLogoX


;1
                sta WSYNC               ; 3


                lda (colour_table),y    ; 5
                sta COLUPF              ; 3
                inc colour_table        ; 5

    ; PF0 < 22
    ; PF1 < 28
    ; PF2 < 38

                lda #0                  ; 2
                sta PF1                 ; 3 @18 OK

                lda (digit1),y          ; 5
                sta PF2                 ; 3 @ 26 OK

        ; RHS

    ; PF0 < 49
    ; PF1 < 54
    ; PF2 < 65

                lda (digit2),y          ; 5
                sta PF0                 ; 3 @ 34 OK        D7D6D5D4 <--- mirrored

                lda (digit2),y          ; 5
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                sta PF1                 ; 3 @40 OK        NOT MIRRORED, D7D6D5D4 -->

                lda #0                  ; 2
                sta PF2                 ; 3 @45 OK
                sta PF0         ; next line




;2
;1
                sta WSYNC               ; 3
                sta PF1


#if 0
                lda (colour_table),y    ; 5
                sta COLUPF              ; 3
                inc colour_table        ; 5

    ; PF0 < 22
    ; PF1 < 28
    ; PF2 < 38

                lda #0                  ; 2
                sta PF1                 ; 3 @18 OK

                lda (digit1),y          ; 5
                sta PF2                 ; 3 @ 26 OK

        ; RHS

    ; PF0 < 49
    ; PF1 < 54
    ; PF2 < 65

                lda (digit2),y          ; 5
                sta PF0                 ; 3 @ 34 OK        D7D6D5D4 <--- mirrored

                lda (digit2),y          ; 5
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                sta PF1                 ; 3 @40 OK        NOT MIRRORED, D7D6D5D4 -->

                lda #0                  ; 2
                sta PF2                 ; 3 @45 OK
                sta PF0         ; next line
#endif


;3
;1
                sta PF1
                sta WSYNC               ; 3



                dey
                bpl SokoLogoX ; 2(3)

                lda #0
                sta PF1
                sta PF2

                ldx Platform
                lda OverscanTime2X,x
                sta TIM64T

      ;--------------------------------------------------------------------------

                lda initialdelay
                beq canchange
                dec initialdelay
                jmp nodigchange

canchange                lda targetDigit
                beq nodigchange
                inc digitick
                lda digitick
                cmp #5
                bcc nodigchange
                lda #0
                sta digitick

                sec
                lda targetDigit
                sbc #10
                bcc units
                sta targetDigit

                inc digit+1
                jmp digok

units           adc #9
                sta targetDigit
                inc digit

digok
nodigchange

                lda targetDigit
                ora initialdelay
                bne oscanX
                lda endwait
                beq oscanX
                dec endwait

    ; D1 VBLANK turns off beam
    ; It needs to be turned on 37 scanlines later

oscanX
                lda INTIM
                bne oscanX

                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

                lda endwait
                beq retX

                lda INPT4
                bpl retX

                jmp RestartFrameX

retX             rts


VBlankTime2x
    .byte 123,123
    .byte 150,150
OverscanTime2X
    .byte 104, 104
    .byte 119, 119

colvecX
    .word colr_ntscX, colr_palX


    MAC LUMTABLE ;{1}{2}{3} base colours
; {4} MIN LUM 1
; {5} MIN LUM 2
; {6} MIN LUM 3

.LUM1     SET {4}*256
.LUM2     SET {5}*256
.LUM3     SET {6}*256

.STEP1 = (256*({7}-{4}))/{10}
.STEP2 = (256*({8}-{5}))/{10}
.STEP3 = (256*({9}-{6}))/{10}

    REPEAT 27
            .byte {1}+(.LUM1/256)
.LUM1     SET .LUM1 + .STEP1
.LUM2     SET .LUM2 + .STEP2
.LUM3     SET .LUM3 + .STEP3
    REPEND
    ENDM


    ALIGN 256
colr_palX        LUMTABLE $b0, $70, $40, $1,$1,$1, $F,$E,$D, 68
colr_ntscX   LUMTABLE $90,$B0,$20,1,1,1,$F, $E,$D, 68

LDIGIT
    .word LEFT_0
    .word LEFT_1
    .word LEFT_2
    .word LEFT_3
    .word LEFT_4
    .word LEFT_5
    .word LEFT_6
    .word LEFT_7
    .word LEFT_8
    .word LEFT_9

RDIGIT
    .word RIGHT_0
    .word RIGHT_1
    .word RIGHT_2
    .word RIGHT_3
    .word RIGHT_4
    .word RIGHT_5
    .word RIGHT_6
    .word RIGHT_7
    .word RIGHT_8
    .word RIGHT_9


#if 0
HDIGIT
        .word H_1
        .word H_2
        .word H_3
        .word H_4
        .word H_5
        .word H_6
        .word H_7
        .word H_8
        .word H_9
#endif


    include "bigDigits.asm"

 CHECK_BANK_SIZE "LEVELSCREEN"

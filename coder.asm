  NEWBANK CODER


        DEFINE_SUBROUTINE xdigitBlock

                ldy #26            ; #lines in characters-1

                ldx #0                  ; used as a generic "0" during the kernel
                sta WSYNC

    SLEEP 72

.LOOPCC SET 0
blockLine

    REPEAT 2

                stx PF0                 ; 3

                lda (bigdigit0),y       ; 5
                sta PF1                 ; 3 = 8 @11

                lda (bigdigit1),y       ; 5
                sta PF2                 ; 3 = 8 @19


        ; RHS


                lda (bigdigit2),y       ; 5
                sta PF0                 ; 3 = 8 @27       D7D6D5D4 <--- mirrored

                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2 = 8 @35

                sta codeTemp            ; 3
                lda (bigdigit3),y       ; 5
                and #$f                 ; 2
                ora codeTemp            ; 3
                sta PF1                 ; 3 = 16 @ 51        NOT MIRRORED, D7D6D5D4 -->

                lda (bigdigit3),y       ; 5
                lsr                     ; 2
                lsr                     ; 2
                lsr                     ; 2
                lsr                     ; 2
                sta PF2                 ; 3 = 16 @67

                SLEEP 2
                SLEEP 2                 ; @71


    IF .LOOPCC = 0
                SLEEP 5
    ENDIF
.LOOPCC SET .LOOPCC + 1


    REPEND

                dey                     ; 2
                bpl blockLine           ; 3/2

    CHECKPAGEX blockLine, "blockLine crosses page"



                lda #0
                sta PF0
                sta PF1
                sta PF2

                sta WSYNC
                sta WSYNC
                sta WSYNC
                sta WSYNC
                sta WSYNC

                rts



    DEFINE_SUBROUTINE setCodeDigits

                lda codeDigit,y
                lsr
                bcc correct0

                lda codeDelay
                lsr
                lsr
                lsr
                jmp correct0a

correct0        lda codeDigit,y
correct0a       and #%11111110
                tax
                lda CODE_DIGIT0,x
                sta bigdigit0
                lda CODE_DIGIT0+1,x
                sta bigdigit0+1

                lda codeDigit+1,y
                lsr
                bcc correct1

                lda codeDelay
                lsr
                lsr
                lsr
                jmp correct1a

correct1        lda codeDigit+1,y
correct1a       and #%11111110
                tax
                lda CODE_DIGIT1,x
                sta bigdigit1
                lda CODE_DIGIT1+1,x
                sta bigdigit1+1

                lda codeDigit+2,y
                lsr
                bcc correct2

                lda codeDelay
                lsr
                lsr
                lsr
                jmp correct2a

correct2        lda codeDigit+2,y
correct2a       and #%11111110
                tax
                lda CODE_DIGIT2,x
                sta bigdigit2
                lda CODE_DIGIT2+1,x
                sta bigdigit2+1

                lda codeDigit+3,y
                lsr
                bcc correct3

                lda codeDelay
                lsr
                lsr
                lsr
                jmp correct3a

correct3        lda codeDigit+3,y
correct3a         and #%11111110
                tax
                lda CODE_DIGIT3,x
                sta bigdigit3
                lda CODE_DIGIT3+1,x
                sta bigdigit3+1

                rts


    DEFINE_SUBROUTINE xSelectionScreenInit

                lda #%0
;                sta NUSIZ1
                sta VDELP0
                sta VDELP1
                sta REFP0
                sta REFP1
;                sta COLUBK
                sta AUDV0
                sta AUDV1                           ; turn off music while levels init


                lda #%11110000
                sta HMP0

                lda #%11010000
                sta HMP1
                lda #%111
                sta NUSIZ0
                sta NUSIZ1

                lda #%0
                sta CTRLPF
                sta codeDelay
                lda #5 ;1
                sta codeDelay+1

                ldx #11
xferdigits      lda codeDigit,x         ; == __decimal,x
                asl
                ora #1                  ; NOT locked
                sta codeDigit,x
                dex
                bpl xferdigits

;                ldx #11
;randomdig       jsr Random
;                and #15
;                cmp #10
;                bcs randomdig
;                asl
;                ora #1                  ; NOT locked!
;                sta codeDigit,x
;                dex
;                bpl randomdig

                rts

;xPlatformxwallColour
;    .byte $F0, $F0, $22, $22
;xPlatformxadjustColour
;    .byte 0,0, $c0, $c0




  DEFINE_SUBROUTINE xLevelScreen

                lda NextLevelTrigger
                and #32
                beq allGood
                rts
allGood


                jsr xSelectionScreenInit

                jsr Random
                and #%11110000
                sta codeTemp
                ora #2
                sta COLUBK
                sta COLUP0
                sta COLUP1

sameFix         jsr Random
                and #%11110000
                cmp codeTemp
                beq sameFix
                ora #8
                sta COLUPF



                RESYNC  ; uses overlay

xRestartFrameX

                lda #%1110                       ; VSYNC ON
.xloopVSync3    sta WSYNC
                sta VSYNC
                lsr
                bne .xloopVSync3                  ; branch until VYSNC has been reset

                ldx Platform
                lda xVBlankTime2x,x
                sta TIM64T

                lda #2
                sta VBLANK
                ldx #37
xtoplines       sta WSYNC
                dex
                bne xtoplines
                stx VBLANK

                ldy #0
                jsr setCodeDigits

      ;------------------------------------------------------------------


VerticalBlankX;
                lda INTIM
                bne VerticalBlankX


                lda #0
                sta PF0
                sta PF1
                sta PF2

        ; position the sprites for the box walls

                sta WSYNC

                SLEEP 10;21
                sta RESP0
                SLEEP 54
                sta RESP1

                sta WSYNC

    SLEEP 66
                sta HMOVE

                lda #0
                sta PF0
                sta PF1
                sta PF2
                sta GRP1

                lda #%11110000
                sta GRP0

;                sta WSYNC

      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)

                ldx #0                  ; used as a generic "0" during the kernel
                sta WSYNC
                jsr xdigitBlock

                ldy #4
                jsr setCodeDigits
                jsr xdigitBlock

                ldy #8
                jsr setCodeDigits
                jsr xdigitBlock

                ldy Platform
                lda xOverscanTime2X,y
                sta TIM64T

                sta WSYNC




                lda codeDelay
                clc
                adc #16
                cmp #$A0
                bcc cDOK

                lda codeDelay+1
                beq cDOK
                dec codeDelay+1
                lda #0
cDOK            sta codeDelay

                lsr
                lsr
                lsr
                lsr
                sta codeTemp            ; digit currently shown

                lda codeDelay+1
                bne onepass

                ldx #0
lockDigits      lda codeDigit,x
                lsr
                bcc nochange2

                cmp codeTemp
                bne onepass

                asl
                sta codeDigit,x

                lda #3
                sta codeDelay+1
                jmp onepass

nochange2       inx
                cpx #12
                bcc lockDigits

        ; none found so it's staic

onepass


      ;--------------------------------------------------------------------------

xoscanX          lda INTIM
                bne xoscanX

                ;sta COLUBK
                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

                lda #0
                sta VSYNC

xwaitbutton      lda INPT4
                bpl xretX

                jmp xRestartFrameX

xretX            rts


xVBlankTime2x
    .byte 56,56
    .byte 78,78
xOverscanTime2X
    .byte 42, 42
    .byte 64, 64

xCOLOUR_LINES    = 32
xcolvecX
    .byte 0, 0, xCOLOUR_LINES, xCOLOUR_LINES


CODE_DIGIT0
                .word CODE_DIGIT0_0
                .word CODE_DIGIT0_1
                .word CODE_DIGIT0_2
                .word CODE_DIGIT0_3
                .word CODE_DIGIT0_4
                .word CODE_DIGIT0_5
                .word CODE_DIGIT0_6
                .word CODE_DIGIT0_7
                .word CODE_DIGIT0_8
                .word CODE_DIGIT0_9

CODE_DIGIT1
                .word CODE_DIGIT1_0
                .word CODE_DIGIT1_1
                .word CODE_DIGIT1_2
                .word CODE_DIGIT1_3
                .word CODE_DIGIT1_4
                .word CODE_DIGIT1_5
                .word CODE_DIGIT1_6
                .word CODE_DIGIT1_7
                .word CODE_DIGIT1_8
                .word CODE_DIGIT1_9

CODE_DIGIT2
                .word CODE_DIGIT2_0
                .word CODE_DIGIT2_1
                .word CODE_DIGIT2_2
                .word CODE_DIGIT2_3
                .word CODE_DIGIT2_4
                .word CODE_DIGIT2_5
                .word CODE_DIGIT2_6
                .word CODE_DIGIT2_7
                .word CODE_DIGIT2_8
                .word CODE_DIGIT2_9


CODE_DIGIT3
                .word CODE_DIGIT3_0
                .word CODE_DIGIT3_1
                .word CODE_DIGIT3_2
                .word CODE_DIGIT3_3
                .word CODE_DIGIT3_4
                .word CODE_DIGIT3_5
                .word CODE_DIGIT3_6
                .word CODE_DIGIT3_7
                .word CODE_DIGIT3_8
                .word CODE_DIGIT3_9

    include "bigDigits3.asm"


 CHECK_BANK_SIZE "CODER"

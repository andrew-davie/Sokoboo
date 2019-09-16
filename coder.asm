  NEWBANK CODER

    DEFINE_SUBROUTINE EncodeGameStatistics

    ; create 3-byte code with
    ; 1 bit     PAL/NTSC flag
    ; 10 bits   Level Number (0-1023)
    ; 10 bits    # of moves (0-1023) - display shows 999 for > 999
    ; seconds count # frames/50(60)




    DEFINE_SUBROUTINE xSelectionScreenInit

                lda #%0
                sta NUSIZ0
                sta NUSIZ1
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


                lda #%100
                sta CTRLPF

                ;ldx Platform
;                lda PlatformxadjustColour,x
    jsr Random
    and #$F0
                sta xadjustColour
;                lda PlatformxwallColour,x
    jsr Random
    and #$F0
    bne xn00
    lda #$22
xn00
                sta xwallColour

                sta COLUP0
                sta COLUP1


                ldx #8
randomdig       jsr Random
                and #15
                cmp #10
                bcs randomdig
                asl
                sta codeDigit,x
                dex
                bpl randomdig

                rts

;xPlatformxwallColour
;    .byte $F0, $F0, $22, $22
xPlatformxadjustColour
    .byte 0,0, $c0, $c0



        DEFINE_SUBROUTINE xdigitBlock

                ldy #BIGDIG_SIZE-1              ; #lines in characters-1

                ldx #0                  ; used as a generic "0" during the kernel
                sta WSYNC

blockLine       stx PF0                 ; 3

                lda #4 ;!!!             ;2
                nop                     ;2
                ;lda Level,y             ; 4
                adc xadjustColour        ; 3
                sta COLUPF              ; 3 = 10 @13

                lda (xdigitHundreds),y   ; 5
                sta PF1                 ; 3 = 8 @21

                lda (xdigit1),y          ; 5
                sta PF2                 ; 3 = 8 @29

        ; RHS

                lda (xdigit2),y          ; 5
                sta PF0                 ; 3 = 8 @ 37        D7D6D5D4 <--- mirrored

                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                sta PF1                 ; 3 = 11 @48        NOT MIRRORED, D7D6D5D4 -->

                ;lda (digitstar),y       ; 5
                SLEEP 3
                lda #0
                sta PF2                 ; 3 = 8 @56

                SLEEP 8
                SLEEP 7

                dey                     ; 2
                bpl blockLine           ; 3/2
                rts


  DEFINE_SUBROUTINE xLevelScreen

                jsr xSelectionScreenInit

;                lda #-1
;                sta endwait

                lda #0
                sta xdigit
                sta xdigit+1
                sta xdigit+2

    ; convert to 3 xdigits decimal
                ;jsr xdd3

                RESYNC  ; uses overlay

xRestartFrameX

                lda #%1110                       ; VSYNC ON
.xloopVSync3     sta WSYNC
                sta VSYNC
                lsr
                bne .xloopVSync3                  ; branch until VYSNC has been reset

                ldx Platform
                lda xVBlankTime2x,x
                sta TIM64T

                lda #2
                sta VBLANK
                ldx #37
xtoplines        sta WSYNC
                dex
                bne xtoplines
                stx VBLANK

                lda #0
                sta COLUBK

xtopsync         lda INTIM
                bne xtopsync

;                ldx Platform
;                ldy VBlankTime2x,x
;                sty TIM64T




                ldx codeDigit
                lda xDIGITHUND,x
                sta xdigitHundreds
                lda xDIGITHUND+1,x
                sta xdigitHundreds+1

                ldx codeDigit+1
                lda xLDIGIT,x
                sta xdigit1
                lda xLDIGIT+1,x
                sta xdigit1+1

                ldx codeDigit+2
                lda xRDIGIT,x
                sta xdigit2
                lda xRDIGIT+1,x
                sta xdigit2+1

      ;------------------------------------------------------------------


;VerticalBlankX;
;                lda INTIM
;                bne VerticalBlankX


                lda #0
                sta PF0
                sta PF1
                sta PF2
                sta COLUBK

        ; position the sprites for the box walls

                sta WSYNC

                SLEEP 17
                sta RESP0

                SLEEP 37
                sta RESP1

                sta WSYNC
                sta HMOVE


;===================================================================================================

    ; now a top for the 'box'

                lda #0
                sta PF0
                sta PF1
                sta PF2

                ldy #TOPHAT-9
xboxtop          sta WSYNC               ;@0

                ;tya
                ;asl
                ;and #%110
                SLEEP 6
                lda xwallColour
                sta COLUPF
                lda #%11100000
                sta PF0
                lda #255
                ;nop
                sta PF1
                lda #255
                ;nop
                sta PF2                 ; 3 = 8 @ 19

        ; RHS
                lda xlid3,y ;#255
                ;nop
                sta PF0                 ; 3 = 8 @ 27 OK        D7D6D5D4 <--- mirrored

                SLEEP 8
                lda xlid4,y ;#255
                sta PF1                 ; 3 @40                 NOT MIRRORED, D7D6D5D4 -->

                lda #%00000000
;                nop
                sta PF2                 ; 3 = 8 @48

                lda #0
                sta COLUBK


                dey                     ; 2
                bpl xboxtop


                lda #0
                sta PF0
                sta PF1
                sta PF2
;                sta GRP0
;                sta GRP1

                lda #%11111100
                sta GRP0
                lda #%00111111
                sta GRP1


                sta WSYNC
;                sta WSYNC
;                sta WSYNC
;                sta WSYNC
;                sta WSYNC

;===================================================================================================

                ldx Platform
                lda xcolvecX,x
                tax

      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)


                lda #$2A                  ; 2
                sta COLUPF              ; 3 = 5 @8

                ldx #0                  ; used as a generic "0" during the kernel
                sta WSYNC
                jsr xdigitBlock

                sta WSYNC

                ldx codeDigit+3
                lda xDIGITHUND,x
                sta xdigitHundreds
                lda xDIGITHUND+1,x
                sta xdigitHundreds+1

                ldx codeDigit+4
                lda xLDIGIT,x
                sta xdigit1
                lda xLDIGIT+1,x
                sta xdigit1+1

                ldx codeDigit+5
                lda xRDIGIT,x
                sta xdigit2
                lda xRDIGIT+1,x
                sta xdigit2+1

                sta WSYNC


                jsr xdigitBlock

                sta WSYNC

                ldx codeDigit+6
                lda xDIGITHUND,x
                sta xdigitHundreds
                lda xDIGITHUND+1,x
                sta xdigitHundreds+1

                ldx codeDigit+7
                lda xLDIGIT,x
                sta xdigit1
                lda xLDIGIT+1,x
                sta xdigit1+1

                ldx codeDigit+8
                lda xRDIGIT,x
                sta xdigit2
                lda xRDIGIT+1,x
                sta xdigit2+1

                sta WSYNC

                jsr xdigitBlock



    ; now a bottom for the 'box'

                lda #0
                sta PF0
                sta PF1
                sta PF2

                lda xwallColour
                sta COLUPF

                ldy #8
xboxbottom       sta WSYNC               ;@0
                lda xlidb0,y ;#%11100000
                and #%11000000
                sta PF0
                lda xlidb1,y ;#255
                sta PF1
                lda xlidb2,y ;#255
                sta PF2                 ; 3 = 8 @ 19

        ; RHS
                lda xlidb3,y
                sta PF0                 ; 3 = 8 @ 27 OK        D7D6D5D4 <--- mirrored

                SLEEP 10
                lda xlidb4,y
                sta PF1                 ; 3 @40                 NOT MIRRORED, D7D6D5D4 -->

                lda #%00000000
;                nop
                sta PF2                 ; 3 = 8 @48

;                lda #6
;                sta COLUBK


                dey                     ; 2
                bpl xboxbottom


                lda #0
                sta PF0
                sta PF1
                sta PF2
                sta GRP0
                sta GRP1

                ldy Platform
                lda xOverscanTime2X,y
                sta TIM64T

                sta WSYNC


                ldx #8
randomdig2       jsr Random
                cmp #240
                bcc nochange2

                and #15
                cmp #10
                bcs nochange2
                asl
                sta codeDigit,x
nochange2                dex
                bpl randomdig2


      ;--------------------------------------------------------------------------


xdonedig

xoscanX          lda INTIM
                bne xoscanX

                sta COLUBK
                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

                lda #0
                sta VSYNC

xwaitbutton      lda INPT4
                bpl xretX

                jmp xRestartFrameX

xretX            rts


xVBlankTime2x
    .byte 70,70
    .byte 98,98
xOverscanTime2X
    .byte 102, 102
    .byte 117, 117

xCOLOUR_LINES    = 32
xcolvecX
    .byte 0, 0, xCOLOUR_LINES, xCOLOUR_LINES



xLDIGIT
    ;.word blankDig
    .word xLEFT_0
    .word xLEFT_1
    .word xLEFT_2
    .word xLEFT_3
    .word xLEFT_4
    .word xLEFT_5
    .word xLEFT_6
    .word xLEFT_7
    .word xLEFT_8
    .word xLEFT_9

xRDIGIT
    ;.word blankDig
    .word xRIGHT_0
    .word xRIGHT_1
    .word xRIGHT_2
    .word xRIGHT_3
    .word xRIGHT_4
    .word xRIGHT_5
    .word xRIGHT_6
    .word xRIGHT_7
    .word xRIGHT_8
    .word xRIGHT_9

xDIGITHUND
        ;.word blankDig
        .word xHUNDPF1_0
        .word xHUNDPF1_1
        .word xHUNDPF1_2
        .word xHUNDPF1_3
        .word xHUNDPF1_4
        .word xHUNDPF1_5
        .word xHUNDPF1_6
        .word xHUNDPF1_7
        .word xHUNDPF1_8
        .word xHUNDPF1_9
;        .word blankDig


xlid0
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000

xlid1
xlid2
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111

xlid3
xlid4
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111


xlidb0
xlidb1
xlidb2
xlidb3
xlidb4

    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111

;    .byte |..XXX...|

    include "bigDigits2.asm"

 CHECK_BANK_SIZE "LEVELSCREEN"

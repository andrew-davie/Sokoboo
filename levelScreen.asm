  NEWBANK LEVELSCREEN
  DEFINE_SUBROUTINE LevelScreen

  ; Start of new frame

  ; Start of vertical blank processing

Qcolour         .byte $44,$44, $64,$64

LevelSequence

                cmp #0
                beq noQuestion
                ldx Platform
                lda Qcolour,x
noQuestion      sta selector


                RESYNC  ; uses overlay

                lda #%00000000
                sta COLUBK
                sta CTRLPF
                sta AUDV0
                sta AUDV1                           ; turn off music while levels init

                lda #$80
                sta digitick
                lda #-1
                sta endwait

                lda #10
                sta initialdelay


                lda #-1
                sta targetDigit
                sta targetDigit+1
                sta targetDigit+2

                lda #0
                sta digit
                sta digit+1
                sta digit+2

    ; convert to 3 digits decimal
                jsr dd3


                lda selector
                beq RestartFrameX

                lda targetDigit
                sta digit
                lda targetDigit+2
                sta digit+2
                lda targetDigit+1
                sta digit+1



RestartFrameX
                lda #%1110                       ; VSYNC ON
.loopVSync3     sta WSYNC
                sta VSYNC
                lsr
                bne .loopVSync3                  ; branch until VYSNC has been reset

                ldx Platform
                ldy VBlankTime2x,x
                sty TIM64T


                lda digit+2                     ; hundreds
                asl
                tax
                lda DIGITHUND,x
                sta digitHundreds
                lda DIGITHUND+1,x
                sta digitHundreds+1

                lda digit+1                     ; tens
                asl
                tax
                lda LDIGIT,x
                sta digit1
                lda LDIGIT+1,x
                sta digit1+1

                lda digit                       ; units
                asl
                tax
                lda RDIGIT,x
                sta digit2
                lda RDIGIT+1,x
                sta digit2+1



                lda #<LEFT_star                 ; question mark
                sta digitstar
                lda #>LEFT_star
                sta digitstar+1


      ;------------------------------------------------------------------


VerticalBlankX
                lda INTIM
                bne VerticalBlankX
                sta VBLANK

                lda #0
                sta PF0
                sta PF1
                sta PF2

                lda BGColour
                sta COLUBK

                ldx Platform
                lda colvecX,x
                tax
 ldx #0 ;tmp
      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)

                ldy #26                 ; #lines in characters-1
LevelNumberDigits

.LOOP SET 0
    REPEAT 3

                sta WSYNC               ; 3
                lda #0                  ; 2
                sta PF0                 ; 3


        IF .LOOP < 2
                lda COLOUR_TABLEX,x      ; 4
        ENDIF

        IF .LOOP = 2
                lda #0
        ENDIF

                sta COLUPF              ; 3

                lda (digitHundreds),y   ; 5
                sta PF1                 ; 3

                lda (digit1),y          ; 5
                sta PF2                 ; 3 @ 26 OK

        ; RHS

                lda (digit2),y          ; 5
                sta PF0                 ; 3 @ 34 OK        D7D6D5D4 <--- mirrored

                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                sta PF1                 ; 3 @40 OK        NOT MIRRORED, D7D6D5D4 -->

                lda (digitstar),y       ; 5
                sta PF2                 ; 3

    IF .LOOP = 0 || .LOOP=1
                lda selector
    ELSE
                lda #0
    ENDIF
                 sta COLUPF
.LOOP SET .LOOP + 1
    REPEND
                inx
                dey
                bpl LevelNumberDigits ; 2(3)
exss
                lda #0
                sta PF0
                sta PF1
                sta PF2

                ldy Platform
                lda OverscanTime2X,y
                sta TIM64T

      ;--------------------------------------------------------------------------


                lda initialdelay
                beq canchange
                dec initialdelay
                jmp nodigchange

canchange
                inc digitick
                lda digitick
                cmp #8
                bcc nodigchange
                lda #0
                sta digitick



                ldx #2
scanner         lda digit,x
                cmp targetDigit,x
                beq scanOK

                clc
                adc #1
                cmp #10
                bcc scanOK2
                lda #0
scanOK2         sta digit,x

                lda #75
                sta endwait

                jmp donedig

scanOK          dex
                bpl scanner

                lda selector
                beq nodigchange               ; don't allow joystick selection

    lda #-1
    sta targetDigit
    sta targetDigit+1
    sta targetDigit+2

    lda SWCHA
    lsr
    lsr
    lsr
    lsr
    tax
    clc
    lda levelX
    adc xJoyMoveX,x
    cmp #255
    bne nml1
    lda #MAX_LEVEL-1
nml1 cmp #MAX_LEVEL
    bne nml2
    lda #0
nml2

    sta levelX
    jsr dd3

        ldx #2
zapper lda targetDigit,x
    sta digit,x
    dex
    bpl zapper

nohitd2
nojoy
donedig


digok
nodigchange

                lda endwait
                bmi neverend

                dec endwait
                ;beq retX

neverend
                lda selector
                bne waitbutton
                lda endwait
                beq retX


waitbutton                lda INPT4
                bpl retX

oscanX
                lda INTIM
                bne oscanX

                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking


                jmp RestartFrameX

retX             rts



dd3
                clc
                lda levelX
                adc #1
                sec
m100            sbc #100
                inc targetDigit+2
                bcs m100
                adc #100
m10             sbc #10
                inc targetDigit+1
                bcs m10
                adc #10
                sta targetDigit


                lda targetDigit+2
                bne hunds
                lda #10
                sta targetDigit+2
                sta digit+2             ; hide hundreds if 0
hunds

                rts


xJoyMoveX        .byte 0,0,0,0,0,1, 1,1,0,-1,-1,-1,0,-1,1,0

VBlankTime2x
    .byte 110,110
    .byte 150,150
OverscanTime2X
    .byte 118, 118
    .byte 120, 120

COLOUR_LINES    = 27
colvecX
    .byte 0, 0, COLOUR_LINES*3, COLOUR_LINES*3


blankDig ds COLOUR_LINES,0

    MAC LUMTABLE2
;{1}{2}{3} base colours
; {4}{5}{6}     base luminance
; {7}{8}{9}     target luminance
; {10}          number of lines

.LUM1     SET {4}*256
.LUM2     SET {5}*256
.LUM3     SET {6}*256

.STEP1 = (256*({7}-{4}))/8
.STEP2 = (256*({8}-{5}))/8
.STEP3 = (256*({9}-{6}))/8

    REPEAT 9 ;
            .byte {1}+(.LUM1/256)
            .byte {2}+(.LUM2/256)
            .byte {3}+(.LUM3/256)
.LUM1     SET .LUM1 + .STEP1
.LUM2     SET .LUM2 + .STEP2
.LUM3     SET .LUM3 + .STEP3
    REPEND
    ENDM

    ;ALIGN 256 ???
COLOUR_TABLEX
    LUMTABLE2 $90,$B0,$20,12,12,12,4, 4,4, COLOUR_LINES                ; NTSC
    LUMTABLE2 $B0,$30,$40,$C,$B,$A,0, 0,0, COLOUR_LINES                ; NTSC

quest
    REPEAT 9
        .byte $60,$60,$0
    REPEND

LDIGIT
    ;.word blankDig
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
    ;.word blankDig
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

DIGITHUND
        ;.word blankDig
        .word HUNDPF1_0
        .word HUNDPF1_1
        .word HUNDPF1_2
        .word HUNDPF1_3
        .word HUNDPF1_4
        .word HUNDPF1_5
        .word HUNDPF1_6
        .word HUNDPF1_7
        .word HUNDPF1_8
        .word HUNDPF1_9
        .word blankDig


    include "bigDigits.asm"

 CHECK_BANK_SIZE "LEVELSCREEN"

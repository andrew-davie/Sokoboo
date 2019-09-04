  NEWBANK LEVELSCREEN

TOPHAT = 18
BIGDIG_SIZE = 32


    DEFINE_SUBROUTINE SelectionScreenInit

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
                sta digitick

                lda #%11110000
                sta HMP0

                lda #%11010000
                sta HMP1


                lda #%100
                sta CTRLPF

                ldx Platform
                lda PlatformAdjustColour,x
                sta adjustColour
                lda PlatformWallColour,x
                sta wallColour

                sta COLUP0
                sta COLUP1

                rts

PlatformWallColour
    .byte $F0, $F0, $22, $22
PlatformAdjustColour
    .byte 0,0, $c0, $c0

  DEFINE_SUBROUTINE LevelScreen

                sta selector

;    lda #%10
;    sta VBLANK


                jsr SelectionScreenInit

                lda #-1
                sta endwait

                lda #-1
                sta targetDigit
                sta targetDigit+1
                sta targetDigit+2

                lda #0
                sta digit
                sta digit+1
                sta digit+2
                sta walkSpeed

    ; convert to 3 digits decimal
                jsr dd3

                jsr fixWalkFrame

                RESYNC  ; uses overlay

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
                lda VBlankTime2x,x
                sta TIM64T

                lda #2
                sta VBLANK
                ldx #37
toplines        sta WSYNC
                dex
                bne toplines
                stx VBLANK

                lda #0
                sta COLUBK

topsync         lda INTIM
                bne topsync

;                ldx Platform
;                ldy VBlankTime2x,x
;                sty TIM64T

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

                ldy #TOPHAT-1
boxtop          sta WSYNC               ;@0

                tya
                asl
                and #%110
                ora wallColour
                sta COLUPF
                lda lid0,y ;#%11100000
                sta PF0
                lda lid1,y ;#255
                ;nop
                sta PF1
                lda lid2,y ;#255
                ;nop
                sta PF2                 ; 3 = 8 @ 19

        ; RHS
                lda lid3,y ;#255
                ;nop
                sta PF0                 ; 3 = 8 @ 27 OK        D7D6D5D4 <--- mirrored

                SLEEP 8
                lda lid4,y ;#255
                sta PF1                 ; 3 @40                 NOT MIRRORED, D7D6D5D4 -->

                lda #%00000000
;                nop
                sta PF2                 ; 3 = 8 @48

                lda #0
                sta COLUBK


                dey                     ; 2
                bpl boxtop


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
                lda colvecX,x
                tax

      ;------------------------------------------------------------------

      ; Do X scanlines of color-changing (our picture)


                lda #$2A                  ; 2
                sta COLUPF              ; 3 = 5 @8

                ldy #BIGDIG_SIZE-1              ; #lines in characters-1

                ldx #0                  ; used as a generic "0" during the kernel
                sta WSYNC


DUPES   = 4
LevelNumberDigits

.LOOP SET 0
    REPEAT DUPES

                stx PF0                 ; 3

    IF .LOOP < DUPES-1
                lda colbk,y             ; 4
                adc adjustColour        ; 3
                sta COLUPF              ; 3 = 10 @13
    ELSE
                lda #0 ;wallColour          ; 3
                sta COLUPF              ; 3 = 7
                SLEEP 5                 ; 4 = 10 @13

    ENDIF
                lda (digitHundreds),y   ; 5
                sta PF1                 ; 3 = 8 @21

                lda (digit1),y          ; 5
                sta PF2                 ; 3 = 8 @29

        ; RHS

                lda (digit2),y          ; 5
                sta PF0                 ; 3 = 8 @ 37        D7D6D5D4 <--- mirrored

                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                asl                     ; 2
                sta PF1                 ; 3 = 11 @48        NOT MIRRORED, D7D6D5D4 -->

                lda (digitstar),y       ; 5
                sta PF2                 ; 3 = 8 @56

                lda (manc),y            ; 5
                sta COLUPF              ; 3 = 8 @64

SPARE = 12

    IF .LOOP < DUPES-1
        SLEEP SPARE
    ENDIF

    IF .LOOP = DUPES-1
        SLEEP SPARE-7
    ENDIF


.LOOP SET .LOOP + 1
    REPEND
                dey                     ; 2
                bmi ess                 ; 2/3
                jmp LevelNumberDigits   ; 3 = 7 mostly @ 71


ess

;                sta WSYNC


    ; now a bottom for the 'box'

                lda #0
                sta PF0
                sta PF1
                sta PF2

                lda wallColour
                sta COLUPF

                ldy #8
boxbottom       sta WSYNC               ;@0
                lda lidb0,y ;#%11100000
                and #%11000000
                sta PF0
                lda lidb1,y ;#255
                sta PF1
                lda lidb2,y ;#255
                sta PF2                 ; 3 = 8 @ 19

        ; RHS
                lda lidb3,y
                sta PF0                 ; 3 = 8 @ 27 OK        D7D6D5D4 <--- mirrored

                SLEEP 8
                lda lidb4,y
                sta PF1                 ; 3 @40                 NOT MIRRORED, D7D6D5D4 -->

                lda #%00000000
;                nop
                sta PF2                 ; 3 = 8 @48

                lda #6
                sta COLUBK


                dey                     ; 2
                bpl boxbottom


                lda #0
                sta PF0
                sta PF1
                sta PF2
                sta GRP0
                sta GRP1

                ldy Platform
                lda OverscanTime2X,y
                sta TIM64T

                sta WSYNC

      ;--------------------------------------------------------------------------

                dec digitick
                bpl donedig
                lda #7
                sta digitick

                ldx #2
scanner         lda digit,x
                cmp targetDigit,x
                beq scanOK

                sed
                adc #1
                and #$F
                sta digit,x
                cld

                lda #100
                sta endwait
                bne donedig

scanOK          dex
                bpl scanner

                lda selector
                beq donedig               ; don't allow joystick selection

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

                lda xJoyMoveX,x
                beq adjustLevelNum

    ; level is changing, so animate the man too

                jsr fixWalkFrame


adjustLevelNum  clc
                lda levelX
                adc xJoyMoveX,x
                cmp #255
                bne nml1
                lda #MAX_LEVEL-1
nml1            cmp #MAX_LEVEL
                bne nml2
                lda #0
nml2            sta levelX

                jsr dd3

                ldx #2
zapper          lda targetDigit,x
                sta digit,x
                dex
                bpl zapper

donedig

oscanX          lda INTIM
                bne oscanX

                sta COLUBK
                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

                lda #0
                sta VSYNC


                lda selector
                bne waitbutton
                dec endwait
                beq retX

waitbutton      lda INPT4
                bpl retX

                jmp RestartFrameX

retX            rts



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


    ; leading zero removal
                ;lda targetDigit+2
                ;bne hunds
                ;lda #10
                ;sta targetDigit+2
                ;sta digit+2             ; hide hundreds if 0
hunds

                rts


    DEFINE_SUBROUTINE fixWalkFrame


    lda selector
    beq walk0

                    clc
                    lda walkSpeed
                    adc #4
                    cmp #4*3
                    bcc walkFrameOK
                    lda #0
walkFrameOK         sta walkSpeed

                    lsr
                    lsr
                    and #%11
                    tay
                    lda walkOrder,y
                    asl
walk0               tay
                    lda walkFrame,y
                    sta digitstar
                    lda walkFrame+1,y
                    sta digitstar+1


                    lda walkColour,y
                    sta manc
                    lda walkColour+1,y
                    sta manc+1
                    rts



    OPTIONAL_PAGEBREAK "colbk @levelScreen.asm", BIGDIG_SIZE

colbk   ; hardwired for 32 - will need manual changing

.CRK SET 256*$B2
.CGK SET 256*$B2
.CBK SET 256*$B2

    REPEAT 10
        .byte .CRK/256
        .byte .CBK/256
        .byte .CGK/256

.CRK SET .CRK + 180 ;135
.CGK SET .CGK + 190 ;135
.CBK SET .CBK + 190 ;135
    REPEND
    .byte .CRK/256
    .byte .CBK/256

    CHECKPAGEX colbk, "WARNING: colbk crosses page @levelScreen.asm"



walkOrder   .byte 1,2,3,2
walkFrame
    .word LEFT_star0
    .word LEFT_star1
    .word LEFT_star2
    .word LEFT_star3

walkColour
    .word mancolourPAL2
    .word mancolourPAL
    .word mancolourPAL2
    .word mancolourPAL


mancolourPAL
; NTSC_TO_PAL $10, 4
 NTSC_TO_PAL $10, 4
 NTSC_TO_PAL $10, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $30, 4
 NTSC_TO_PAL $0, 12
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $0, 12
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $10, $C
 NTSC_TO_PAL $10, $C

mancolourPAL2
 NTSC_TO_PAL $10, 4
 NTSC_TO_PAL $10, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $90, 4
 NTSC_TO_PAL $30, 4
 NTSC_TO_PAL $0,12
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $90, 6
 NTSC_TO_PAL $0, 12
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $30, 8
 NTSC_TO_PAL $10, $C
 NTSC_TO_PAL $10, $C


xJoyMoveX        .byte 0,0,0,0,0,1, 1,1,0,-1,-1,-1,0,-1,1,0

VBlankTime2x
    .byte 70,70
    .byte 98,98
OverscanTime2X
    .byte 63, 63
    .byte 77, 77

COLOUR_LINES    = 32
colvecX
    .byte 0, 0, COLOUR_LINES, COLOUR_LINES


;blankDig ds COLOUR_LINES,0

;topcolour

;    .byte 0

;    REPEAT TOPHAT/2
;    .byte $F2
;    .byte $F0
;    REPEND

;quest
;    REPEAT 9
;        .byte $60,$60,$0
;    REPEND

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
;        .word blankDig


lid0
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %01100000
        .byte %01100000
        .byte %01100000
        .byte %01100000
        .byte %01100000
        .byte %01100000
        .byte %01100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000
        .byte %11100000

lid1
lid2
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11110111
        .byte %11110111
        .byte %11110111
        .byte %11110111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11000011

lid3
lid4
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11110111
        .byte %11110111
        .byte %11110111
        .byte %11110111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11000011

#if 0
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111011
        .byte %11111011
        .byte %11111011
        .byte %11111011
        .byte %11111011
        .byte %11111011
        .byte %11111011
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11111111
        .byte %11000011
#endif

lidb0
lidb1
lidb2
lidb3
lidb4

    .byte %10101010
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111


    include "bigDigits.asm"

 CHECK_BANK_SIZE "LEVELSCREEN"

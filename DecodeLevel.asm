;    Sokoboo - a Sokoban implementation
;    using a generic tile-based display engine for the Atari 2600
;    Sokoban (倉庫番)™ is © Falcon Co., Ltd.
;
;    Code related to this Sokoban™ implementation was developed by Andrew Davie.
;
;    Code related to the generic tile-based display engine was developed by
;    Andrew Davie and Thomas Jentzsch during 2003-2011 and is
;    Copyright(C)2003-2019 Thomas Jentzsch and Andrew Davie - contacts details:
;    Andrew Davie (andrew@taswegian.com), Thomas Jentzsch (tjentzsch@yahoo.de).
;
;    Code related to music and sound effects uses the TIATracker music player
;    Copyright 2016 Andre "Kylearan" Wichmann - see source code in the "sound"
;    directory for Apache licensing details.
;
;    Some level data incorporated in this program were created by Lee J Haywood.
;    See the copyright notices in the License directory for a list of level
;    contributors.
;
;    Except where otherwise indicated, this software is released under the
;    following licensing arrangement...
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;    see https://www.gnu.org/licenses/gpl-3.0.en.html

;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.



finX
  ; now put the soil in - fill from the outsides

                lda #CHARACTER_SOIL
                sta POS_Type

                lda #SIZE_BOARD_Y-1
                sta POS_Y

xlin            lda #SIZE_BOARD_X-1
                sta POS_X
zap1            jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg2a
                cmp #0
                bne endzap1
                jsr PutBoardCharacterFromRAM
kg2a            dec POS_X
                bpl zap1

endzap1         lda #0
                sta POS_X
zap2            jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg2
                cmp #0
                bne endzap2
                jsr PutBoardCharacterFromRAM
kg2             inc POS_X
                lda POS_X
                cmp #SIZE_BOARD_X
                bne zap2

endzap2         dec POS_Y
                bpl xlin


                lda #SIZE_BOARD_X-1
                sta POS_X

ylin            lda #SIZE_BOARD_Y-1
                sta POS_Y
zapy1           jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg3
                cmp #0
                bne endzapy1
                jsr PutBoardCharacterFromRAM
kg3             dec POS_Y
                bpl zapy1

endzapy1        lda #0
                sta POS_Y
zapy2            jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg3b
                cmp #0
                bne endzapy2
                jsr PutBoardCharacterFromRAM
kg3b                inc POS_Y
                lda POS_Y
                cmp #SIZE_BOARD_Y
                bne zapy2

endzapy2        dec POS_X
                bpl ylin
                rts

;A      steel wall
;B      soil (surround)
;C      box

    MAC NTSCPAL ; {col} {intensity}
    .byte {1}+{2}
    NTSC_TO_PAL {1},{2}
    ENDM



t16
    .byte $00
    .byte $20           ; don't use "10"!
    .byte $20
    .byte $30
    .byte $40
    .byte $50
    .byte $60
    .byte $70
    .byte $80
    .byte $90
    .byte $A0
    .byte $B0
    .byte $C0
    .byte $D0
    .byte $E0
    .byte $F0

inten
    .byte $08+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST
    .byte $08+PALETTE_INTENSITY_ADJUST
    .byte $08+PALETTE_INTENSITY_ADJUST
    .byte $08+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST             ; deep blue
    .byte $0A+PALETTE_INTENSITY_ADJUST
    .byte $08+PALETTE_INTENSITY_ADJUST
    .byte $08+PALETTE_INTENSITY_ADJUST
    .byte $08+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST
    .byte $0A+PALETTE_INTENSITY_ADJUST



  DEFINE_SUBROUTINE UnpackLevel

              sta RAM_Bank

  ; has to be done before decoding the level to have the platform right:
    ;          SET_PLATFORM

                lda #BANK_UnpackLevel               ; the *ROM* bank of this routine (NOT RAM)
                sta ROM_Bank                        ; GetROMByte returns to this bank



                lda #CHARACTER_SOIL
                sta POS_Type

                lda #SIZE_BOARD_Y-1
                sta POS_Y
xyLine          lda #SIZE_BOARD_X-1
                sta POS_X
xyClear         jsr PutBoardCharacterFromRAM
                dec POS_X
                bpl xyClear
                dec POS_Y
                bpl xyLine

                lda #4
                sta base_x
                lda #4
                sta base_y

                lda NextLevelTrigger
                ora #BIT_NEXTLEVEL
                sta NextLevelTrigger


                jsr Random
                and #$F
                tax
                lda t16,x
                ora inten,x
                sta icc_colour

ranother        jsr Random
                and #$F
                tax
                lda t16,x
                ora inten,x
                sec
                sbc #2
                sta icc_colour+2            ; mortar, lid

                ;sec
                sbc icc_colour
                bcs posicc
                eor #$FF
                adc #1
posicc          cmp #$31
                bcc ranother                ; don't allow similar colours



    ; Update the level colours (self-modifying) in each of the character line banks

                jsr CopyColoursToScreenLines

                lda #$00
                sta BCD_moveCounter
                sta BCD_moveCounterHi
                sta takebackIndex
                sta takebackBaseIndex
                sta BCD_targetsRequired           ; # of targets that do NOT have boxes on them

;              ldx Platform
;              lda theThrottler,x
;              sta ThrottleSpeed

  ; first fill bg with character_soil
  ; then rle unpack level
  ; change level colours

                lda #0
                sta POS_X
                sta POS_Y
                sta BoardLimit_Width
                sta BoardLimit_Height

rechooose       jsr Random
                and #3
                cmp #3
                bcs rechooose           ; weird, as we use 'rnd' later

GetNextItem

                lda #1
                sta upk_length
                lda #0
                sta upk_column         ; reuse var - this flags a digit already

Get2            inc Board_AddressR
                bne addrOK
                inc Board_AddressR+1
addrOK

                lda LEVEL_bank
                ldy #0
                jsr GetROMByte
                sta upk_temp       ;scratch

                cmp #0
                bne parse
                jmp  finX
parse
                cmp #"9"+1
                bcs notDigit
                cmp #"0"
                bcc notDigit

                lda upk_column
                beq firstDig

                lda upk_length
                asl
                asl
                asl
                adc upk_length
                adc upk_length

firstDig        clc
                adc upk_temp
                sec
                sbc #"0"
                sta upk_length
                inc upk_column     ; flag we have seen a digit
                jmp Get2

notDigit        cmp #"|"          ; newline
                bne checkWall

    ; Handle new-line
                lda #0
                sta POS_X
                inc POS_Y


                lda POS_Y
                cmp BoardLimit_Height
                bcc wOK2
                sta BoardLimit_Height ;???^^^
wOK2

                jmp GetNextItem

checkWall       cmp #"#"          ; wall
                bne checkForGap

                lda rnd
                and #3
                clc
                adc #CHARACTER_STEEL
                bne WriteChars

checkForGap   cmp #32
              beq writeGap
              cmp #"-"
              beq writeGap
              cmp #"_"
              bne checkForMan

writeGap      lda #CHARACTER_BLANK
              jmp WriteChars

checkForMan
              cmp #"+"            ; player on goal square
              bne notPlayerGoal

              jsr RegisterTarget

              ; put goal square, init player with POS_VAR = CHARACTER_TARGET

              lda #CHARACTER_TARGET
              bne genPlayer

notPlayerGoal
               cmp #"@"            ; player on normal square
               bne checkBox

              lda #CHARACTER_BLANK

genPlayer

              sta POS_VAR                     ; character man is on

              clc
              lda POS_X
              pha
              adc base_x
              sta POS_X
              sta ManX

              lda POS_Y
              pha
              adc base_y
              sta POS_Y
              sta ManY

              ; POS_X     x position
              ; POS_Y     y position
              ; POS_VAR   CHARACTER UNDER MAN TO RESTORE
              ; POS_Type  type of object

              lda #TYPE_MAN
              sta POS_Type                    ;       creature TYPE
              jsr InsertObjectStackFromRAM    ;6+94(B)

              pla
              sta POS_Y
              pla
              sta POS_X

              lda #CHARACTER_MANOCCUPIED
              jmp WriteChars

checkBox      cmp #"$"
              bne checkBoxTarget

              lda #CHARACTER_BOX
              bne WriteChars

checkBoxTarget  cmp #"*"
              bne checkTarget

              lda #CHARACTER_BOX_ON_TARGET
              bne WriteChars

checkTarget   cmp #"."
              beq targ
              jmp GetNextItem
targ

              lda #CHARACTER_TARGET

WriteChars    sta POS_Type

Wc2x              clc
              lda POS_X
              pha
              adc base_x
              sta POS_X

              lda POS_Y
              pha
              adc base_y
              cmp #SIZE_BOARD_Y
              bcs whoops
              sta POS_Y


              jsr PutBoardCharacterFromRAM

whoops        lda POS_Type
              cmp #CHARACTER_TARGET
              bne notargdet
              jsr RegisterTarget
notargdet

              pla
              sta POS_Y
              pla
              sta POS_X

              clc
              adc #1
              sta POS_X

              cmp BoardLimit_Width
              bcc wOK
              sta BoardLimit_Width
wOK

              dec upk_length
              bne Wc2x
              jmp GetNextItem

finishedUnpack

              rts
#endif

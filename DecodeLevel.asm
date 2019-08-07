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

LEVELNUM         SET 0
NUMBEROFLEVELS   SET 0
LEVEL_DEFINITION_SIZE  = 3

                MAC ADD_LEVEL ; {name}
LEVEL_ACTIVE_{1} SET 1
LEVEL_NAMED_{1}  = LEVELNUM
    .byte <LEVEL_{1}
    .byte >LEVEL_{1}
    .byte BANK_LEVEL_{1}
    ;.byte LEVEL_SIZE_{1}
LEVELNUM         SET LEVELNUM + LEVEL_DEFINITION_SIZE
NUMBEROFLEVELS   SET NUMBEROFLEVELS + 1
                ENDM

LevelInformation

                ; The ordering here corresponds to the ordering when playing...

    ADD_LEVEL _001_L
    ADD_LEVEL _001_R
    ADD_LEVEL _002_L
    ADD_LEVEL _002_R
    ADD_LEVEL _003_L
    ADD_LEVEL _003_R
    ADD_LEVEL _004_L
    ADD_LEVEL _004_R
    ADD_LEVEL _005_L
    ADD_LEVEL _005_R
    ADD_LEVEL _006_L
    ADD_LEVEL _006_R
    ADD_LEVEL _007_L
    ADD_LEVEL _007_R
    ADD_LEVEL _008_L
    ADD_LEVEL _008_R
    ADD_LEVEL _009_L
    ADD_LEVEL _009_R
    ADD_LEVEL _010_L
    ADD_LEVEL _010_R
    ADD_LEVEL _011_L
    ADD_LEVEL _011_R
    ADD_LEVEL _012_L
    ADD_LEVEL _012_R
    ADD_LEVEL _013_L
    ADD_LEVEL _013_R
    ADD_LEVEL _014_L
    ADD_LEVEL _014_R
    ADD_LEVEL _015_L
    ADD_LEVEL _015_R
    ADD_LEVEL _016_L
    ADD_LEVEL _016_R
    ADD_LEVEL _017_L
    ADD_LEVEL _017_R
    ADD_LEVEL _018_L
    ADD_LEVEL _018_R
    ADD_LEVEL _019_L
    ADD_LEVEL _019_R
    ADD_LEVEL _020_L
    ADD_LEVEL _020_R
    ADD_LEVEL _021_L
    ADD_LEVEL _021_R
    ADD_LEVEL _022_L
    ADD_LEVEL _022_R
    ADD_LEVEL _023_L
    ADD_LEVEL _023_R
    ADD_LEVEL _024_L
    ADD_LEVEL _024_R
    ADD_LEVEL _025_L
    ADD_LEVEL _025_R
    ADD_LEVEL _026_L
    ADD_LEVEL _026_R
    ADD_LEVEL _027_L
    ADD_LEVEL _027_R
    ADD_LEVEL _028_L
    ADD_LEVEL _028_R
    ADD_LEVEL _029_L
    ADD_LEVEL _029_R
    ADD_LEVEL _030_L
    ADD_LEVEL _030_R
    ADD_LEVEL _031_L
    ADD_LEVEL _031_R
    ADD_LEVEL _032_L
    ADD_LEVEL _032_R
    ADD_LEVEL _033_L
    ADD_LEVEL _033_R
    ADD_LEVEL _034_L
    ADD_LEVEL _034_R
    ADD_LEVEL _035_L
    ADD_LEVEL _035_R
    ADD_LEVEL _036_L
    ADD_LEVEL _036_R
    ADD_LEVEL _037_L
    ADD_LEVEL _037_R
    ADD_LEVEL _038_L
    ADD_LEVEL _038_R
    ADD_LEVEL _039_L
    ADD_LEVEL _039_R
    ADD_LEVEL _040_L
    ADD_LEVEL _040_R


    ADD_LEVEL _050_L
    ADD_LEVEL _050_R
    ADD_LEVEL _051_L
    ADD_LEVEL _051_R
    ADD_LEVEL _052_L
    ADD_LEVEL _052_R
    ADD_LEVEL _053_L
    ADD_LEVEL _053_R
    ADD_LEVEL _054_L
    ADD_LEVEL _054_R
    ADD_LEVEL _055_L
    ADD_LEVEL _055_R
    ADD_LEVEL _056_L
    ADD_LEVEL _056_R
    ADD_LEVEL _057_L

    ADD_LEVEL _060_R
    ADD_LEVEL _061_R
    ADD_LEVEL _061_L
    ADD_LEVEL _062_L
    ADD_LEVEL _062_R
    ADD_LEVEL _063_L
    ADD_LEVEL _063_R
    ADD_LEVEL _064_R
    ADD_LEVEL _064_L
    ADD_LEVEL _065_R
    ADD_LEVEL _065_L
    ADD_LEVEL _066_R
    ADD_LEVEL _066_L
    ADD_LEVEL _067_R
    ADD_LEVEL _067_L
    ADD_LEVEL _068_R
    ADD_LEVEL _068_L
    ADD_LEVEL _069_R
    ADD_LEVEL _069_L

    ADD_LEVEL _103_Arielle
    ADD_LEVEL _103_Ajalae
    ADD_LEVEL _103_Adin
    ADD_LEVEL _102_Raven
    ADD_LEVEL _102_Oralia
    ADD_LEVEL _102_Natalie
    ADD_LEVEL _102_Mirabel
    ADD_LEVEL _1XJH_Tara_Gelson
    ADD_LEVEL _1R7X_Alison
    ADD_LEVEL _1KWD_Cecile_Clayworth
    ADD_LEVEL _1EKT_Samantha_Gelson
    ADD_LEVEL _0VM5_Andrea_Wadd
    ADD_LEVEL _0PAL_Jill_Leatherby
    ADD_LEVEL _0IZ1_Sophia
    ADD_LEVEL _0CNH_Alice
    ADD_LEVEL Thomas_Reinke16
    ADD_LEVEL bDarcy_Burnsell101
    ADD_LEVEL bAlfa_DrFogh
    ADD_LEVEL bAislin101
    ADD_LEVEL b51X_Sharpen
;    ADD_LEVEL b82X_Sharpen


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

    DEFINE_SUBROUTINE RegisterOneMoreTarget

              sed
              clc
              lda targetsRequired
              adc #1
              sta targetsRequired
              cld
              rts

;A      steel wall
;B      soil (surround)
;C      box


C1
  .byte $b6,$2A,$a8,$48
  .byte $C8,$78,$28,$98
C2
  .byte $62,$A4,$22,$84
  .byte $44,$82,$F4,$64
C3
  .byte $2a,$7A,$f8,$B8
  .byte $FC,$C6,$98,$Ea

              ; C6 44 2A      browns
              ; BA 96 E8      ice blues


  DEFINE_SUBROUTINE UnpackLevel

              sta RAM_Bank

  ; has to be done before decoding the level to have the platform right:
    ;          SET_PLATFORM

              lda #CHARACTER_SOIL
              sta POS_Type

              lda #SIZE_BOARD_Y-1
              sta POS_Y
xyLine        lda #SIZE_BOARD_X-1
              sta POS_X
xyClear       jsr PutBoardCharacterFromRAM
              dec POS_X
              bpl xyClear
              dec POS_Y
              bpl xyLine

              lda #6
              sta base_x
              sta base_y

              lda NextLevelTrigger
              ora #BIT_NEXTLEVEL
              sta NextLevelTrigger

              lda levelX
              asl
              adc levelX
              tay
              sec
              lda LevelInformation,y
              sbc #1
              sta Board_AddressR
              lda LevelInformation+1,y
              sbc #0
              sta Board_AddressR+1
              lda LevelInformation+2,y
              sta LEVEL_bank

              lda #BANK_UnpackLevel               ; the *ROM* bank of this routine (NOT RAM)
              sta ROM_Bank                        ; GetROMByte returns to this bank

              lda levelX
              and #7
              tax
              lda C1,x
              sta color
              lda C2,x
              sta color+1
              lda C3,x
              sta color+2

              ;NEXT_RANDOM
              ;and #$F0
              ;ora #$A
              ;lda #$ba
              ;sta color
              ;lda #$96
              ;lda #$A0
              ;sta color+1
              ;lda #$e8 ;lda #$9C
              ;sta color+2

              ; good colours


              lda #$00
              sta moveCounter
              sta moveCounterHi
              sta moveCounterBinary

              lda #$00                      ; BCD reminder!
              sta targetsRequired           ; # of targets that do NOT have boxes on them

              ;lda #SIZE_BOARD_X
              ;sta BoardLimit_Width
              ;lda #SIZE_BOARD_Y
              ;sta BoardLimit_Height
              ;lda #$5
              ;sta targetsRequired              ;       should never be 0

              lda #24 ; arbitrary
              sta ThrottleSpeed

  ; first fill bg with character_soil
  ; then rle unpack level
  ; change level colours

              lda #0
              sta POS_X
              sta POS_Y
              sta BoardLimit_Width
              sta BoardLimit_Height

GetNextItem

              lda #1
              sta upk_length
              lda #0
              sta upk_column         ; reuse var - this flags a digit already

Get2          inc Board_AddressR
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

firstDig      clc
              adc upk_temp
              sec
              sbc #"0"
              sta upk_length
              inc upk_column     ; flag we have seen a digit
              jmp Get2

notDigit      cmp #"|"          ; newline
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

checkWall     cmp #"#"          ; wall
              bne checkForGap
              lda levelX
              and #1
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

              jsr RegisterOneMoreTarget

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

              lda #0
              sta manAnimationIndex

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
              sta POS_Y

              jsr PutBoardCharacterFromRAM

              lda POS_Type
              cmp #CHARACTER_TARGET
              bne notargdet
              jsr RegisterOneMoreTarget
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

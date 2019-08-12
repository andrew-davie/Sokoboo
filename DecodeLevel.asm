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

; The ordering here corresponds to the ordering when playing...

LevelInfoLO
     .byte <(LEVEL__001_L-1)
     .byte <(LEVEL__001_R-1)
     .byte <(LEVEL__002_L-1)
     .byte <(LEVEL__002_R-1)
     .byte <(LEVEL__003_L-1)
     .byte <(LEVEL__003_R-1)
     .byte <(LEVEL__004_L-1)
     .byte <(LEVEL__004_R-1)
     .byte <(LEVEL__005_L-1)
     .byte <(LEVEL__005_R-1)
     .byte <(LEVEL__006_L-1)
     .byte <(LEVEL__006_R-1)
     .byte <(LEVEL__007_L-1)
     .byte <(LEVEL__007_R-1)
     .byte <(LEVEL__008_L-1)
     .byte <(LEVEL__008_R-1)
     .byte <(LEVEL__009_L-1)
     .byte <(LEVEL__009_R-1)
     .byte <(LEVEL__010_L-1)
     .byte <(LEVEL__010_R-1)
     .byte <(LEVEL__011_L-1)
     .byte <(LEVEL__011_R-1)
     .byte <(LEVEL__012_L-1)
     .byte <(LEVEL__012_R-1)
     .byte <(LEVEL__013_L-1)
     .byte <(LEVEL__013_R-1)
     .byte <(LEVEL__014_L-1)
     .byte <(LEVEL__014_R-1)
     .byte <(LEVEL__015_L-1)
     .byte <(LEVEL__015_R-1)
     .byte <(LEVEL__016_L-1)
     .byte <(LEVEL__016_R-1)
     .byte <(LEVEL__017_L-1)
     .byte <(LEVEL__017_R-1)
     .byte <(LEVEL__018_L-1)
     .byte <(LEVEL__018_R-1)
     .byte <(LEVEL__019_L-1)
     .byte <(LEVEL__019_R-1)
     .byte <(LEVEL__020_L-1)
     .byte <(LEVEL__020_R-1)
     .byte <(LEVEL__021_L-1)
     .byte <(LEVEL__021_R-1)
     .byte <(LEVEL__022_L-1)
     .byte <(LEVEL__022_R-1)
     .byte <(LEVEL__023_L-1)
     .byte <(LEVEL__023_R-1)
     .byte <(LEVEL__024_L-1)
     .byte <(LEVEL__024_R-1)
     .byte <(LEVEL__025_L-1)
     .byte <(LEVEL__025_R-1)
     .byte <(LEVEL__026_L-1)
     .byte <(LEVEL__026_R-1)
     .byte <(LEVEL__027_L-1)
     .byte <(LEVEL__027_R-1)
     .byte <(LEVEL__028_L-1)
     .byte <(LEVEL__028_R-1)
     .byte <(LEVEL__029_L-1)
     .byte <(LEVEL__029_R-1)
     .byte <(LEVEL__030_L-1)
     .byte <(LEVEL__030_R-1)
     .byte <(LEVEL__031_L-1)
     .byte <(LEVEL__031_R-1)
     .byte <(LEVEL__032_L-1)
     .byte <(LEVEL__032_R-1)
     .byte <(LEVEL__033_L-1)
     .byte <(LEVEL__033_R-1)
     .byte <(LEVEL__034_L-1)
     .byte <(LEVEL__034_R-1)
     .byte <(LEVEL__035_L-1)
     .byte <(LEVEL__035_R-1)
     .byte <(LEVEL__036_L-1)
     .byte <(LEVEL__036_R-1)
     .byte <(LEVEL__037_L-1)
     .byte <(LEVEL__037_R-1)
     .byte <(LEVEL__038_L-1)
     .byte <(LEVEL__038_R-1)
     .byte <(LEVEL__039_L-1)
     .byte <(LEVEL__039_R-1)
     .byte <(LEVEL__040_L-1)
     .byte <(LEVEL__040_R-1)

     .byte <(LEVEL__041_L-1)
     .byte <(LEVEL__041_R-1)
     .byte <(LEVEL__042_L-1)
     .byte <(LEVEL__042_R-1)
     .byte <(LEVEL__043_L-1)
     .byte <(LEVEL__043_R-1)
     .byte <(LEVEL__044_L-1)
     .byte <(LEVEL__044_R-1)
     .byte <(LEVEL__045_L-1)
     .byte <(LEVEL__045_R-1)
     .byte <(LEVEL__046_L-1)
     .byte <(LEVEL__046_R-1)
     .byte <(LEVEL__047_L-1)
     .byte <(LEVEL__047_R-1)
     .byte <(LEVEL__048_L-1)
     .byte <(LEVEL__048_R-1)
     .byte <(LEVEL__049_L-1)
     .byte <(LEVEL__049_R-1)

     .byte <(LEVEL__050_L-1)
     .byte <(LEVEL__050_R-1)
     .byte <(LEVEL__051_L-1)
     .byte <(LEVEL__051_R-1)
     .byte <(LEVEL__052_L-1)
     .byte <(LEVEL__052_R-1)
     .byte <(LEVEL__053_L-1)
     .byte <(LEVEL__053_R-1)
     .byte <(LEVEL__054_L-1)
     .byte <(LEVEL__054_R-1)
     .byte <(LEVEL__055_L-1)
     .byte <(LEVEL__055_R-1)
     .byte <(LEVEL__056_L-1)
     .byte <(LEVEL__056_R-1)
     .byte <(LEVEL__057_L-1)
     .byte <(LEVEL__057_R-1)
     .byte <(LEVEL__058_L-1)
     .byte <(LEVEL__058_R-1)
     .byte <(LEVEL__059_L-1)
     .byte <(LEVEL__059_R-1)

     .byte <(LEVEL__060_R-1)
     .byte <(LEVEL__061_R-1)
     .byte <(LEVEL__061_L-1)
     .byte <(LEVEL__062_L-1)
     .byte <(LEVEL__062_R-1)
     .byte <(LEVEL__063_L-1)
     .byte <(LEVEL__063_R-1)
     .byte <(LEVEL__064_R-1)
     .byte <(LEVEL__064_L-1)
     .byte <(LEVEL__065_R-1)
     .byte <(LEVEL__065_L-1)
     .byte <(LEVEL__066_R-1)
     .byte <(LEVEL__066_L-1)
     .byte <(LEVEL__067_R-1)
     .byte <(LEVEL__067_L-1)
     .byte <(LEVEL__068_R-1)
     .byte <(LEVEL__068_L-1)
     .byte <(LEVEL__069_R-1)
     .byte <(LEVEL__069_L-1)

     .byte <(LEVEL__103_Arielle-1)
     .byte <(LEVEL__103_Ajalae-1)
     .byte <(LEVEL__103_Adin-1)
     .byte <(LEVEL__102_Raven-1)
     .byte <(LEVEL__102_Oralia-1)
     .byte <(LEVEL__102_Natalie-1)
     .byte <(LEVEL__102_Mirabel-1)
     .byte <(LEVEL__1XJH_Tara_Gelson-1)
     .byte <(LEVEL__1R7X_Alison-1)
     .byte <(LEVEL__1KWD_Cecile_Clayworth-1)
     .byte <(LEVEL__1EKT_Samantha_Gelson-1)
     .byte <(LEVEL__0VM5_Andrea_Wadd-1)
     .byte <(LEVEL__0PAL_Jill_Leatherby-1)
     .byte <(LEVEL__0IZ1_Sophia-1)
     .byte <(LEVEL__0CNH_Alice-1)
        .byte <(LEVEL__122_Maya-1)

MAX_LEVEL = * - LevelInfoLO
    ECHO MAX_LEVEL, "LEVELS INSTALLED"
LevelInfoHI

     .byte >(LEVEL__001_L-1)
     .byte >(LEVEL__001_R-1)
     .byte >(LEVEL__002_L-1)
        .byte >(LEVEL__002_R-1)
        .byte >(LEVEL__003_L-1)
        .byte >(LEVEL__003_R-1)
     .byte >(LEVEL__004_L-1)
     .byte >(LEVEL__004_R-1)
     .byte >(LEVEL__005_L-1)
     .byte >(LEVEL__005_R-1)
     .byte >(LEVEL__006_L-1)
     .byte >(LEVEL__006_R-1)
     .byte >(LEVEL__007_L-1)
     .byte >(LEVEL__007_R-1)
     .byte >(LEVEL__008_L-1)
     .byte >(LEVEL__008_R-1)
     .byte >(LEVEL__009_L-1)
     .byte >(LEVEL__009_R-1)
     .byte >(LEVEL__010_L-1)
     .byte >(LEVEL__010_R-1)
     .byte >(LEVEL__011_L-1)
     .byte >(LEVEL__011_R-1)
     .byte >(LEVEL__012_L-1)
     .byte >(LEVEL__012_R-1)
     .byte >(LEVEL__013_L-1)
     .byte >(LEVEL__013_R-1)
     .byte >(LEVEL__014_L-1)
     .byte >(LEVEL__014_R-1)
     .byte >(LEVEL__015_L-1)
     .byte >(LEVEL__015_R-1)
     .byte >(LEVEL__016_L-1)
     .byte >(LEVEL__016_R-1)
     .byte >(LEVEL__017_L-1)
    .byte >(LEVEL__017_R-1)
    .byte >(LEVEL__018_L-1)
    .byte >(LEVEL__018_R-1)
    .byte >(LEVEL__019_L-1)
    .byte >(LEVEL__019_R-1)
    .byte >(LEVEL__020_L-1)
    .byte >(LEVEL__020_R-1)
    .byte >(LEVEL__021_L-1)
    .byte >(LEVEL__021_R-1)
    .byte >(LEVEL__022_L-1)
    .byte >(LEVEL__022_R-1)
    .byte >(LEVEL__023_L-1)
    .byte >(LEVEL__023_R-1)
    .byte >(LEVEL__024_L-1)
    .byte >(LEVEL__024_R-1)
    .byte >(LEVEL__025_L-1)
    .byte >(LEVEL__025_R-1)
    .byte >(LEVEL__026_L-1)
    .byte >(LEVEL__026_R-1)
    .byte >(LEVEL__027_L-1)
    .byte >(LEVEL__027_R-1)
    .byte >(LEVEL__028_L-1)
    .byte >(LEVEL__028_R-1)
    .byte >(LEVEL__029_L-1)
    .byte >(LEVEL__029_R-1)
    .byte >(LEVEL__030_L-1)
    .byte >(LEVEL__030_R-1)
    .byte >(LEVEL__031_L-1)
    .byte >(LEVEL__031_R-1)
    .byte >(LEVEL__032_L-1)
    .byte >(LEVEL__032_R-1)
    .byte >(LEVEL__033_L-1)
    .byte >(LEVEL__033_R-1)
    .byte >(LEVEL__034_L-1)
    .byte >(LEVEL__034_R-1)
    .byte >(LEVEL__035_L-1)
    .byte >(LEVEL__035_R-1)
    .byte >(LEVEL__036_L-1)
    .byte >(LEVEL__036_R-1)
    .byte >(LEVEL__037_L-1)
    .byte >(LEVEL__037_R-1)
    .byte >(LEVEL__038_L-1)
    .byte >(LEVEL__038_R-1)
    .byte >(LEVEL__039_L-1)
    .byte >(LEVEL__039_R-1)
    .byte >(LEVEL__040_L-1)
    .byte >(LEVEL__040_R-1)

    .byte >(LEVEL__041_L-1)
    .byte >(LEVEL__041_R-1)
    .byte >(LEVEL__042_L-1)
    .byte >(LEVEL__042_R-1)
    .byte >(LEVEL__043_L-1)
    .byte >(LEVEL__043_R-1)
    .byte >(LEVEL__044_L-1)
    .byte >(LEVEL__044_R-1)
    .byte >(LEVEL__045_L-1)
    .byte >(LEVEL__045_R-1)
    .byte >(LEVEL__046_L-1)
    .byte >(LEVEL__046_R-1)
    .byte >(LEVEL__047_L-1)
    .byte >(LEVEL__047_R-1)
    .byte >(LEVEL__048_L-1)
    .byte >(LEVEL__048_R-1)
    .byte >(LEVEL__049_L-1)
    .byte >(LEVEL__049_R-1)

    .byte >(LEVEL__050_L-1)
    .byte >(LEVEL__050_R-1)
    .byte >(LEVEL__051_L-1)
    .byte >(LEVEL__051_R-1)
    .byte >(LEVEL__052_L-1)
    .byte >(LEVEL__052_R-1)
    .byte >(LEVEL__053_L-1)
    .byte >(LEVEL__053_R-1)
    .byte >(LEVEL__054_L-1)
    .byte >(LEVEL__054_R-1)
    .byte >(LEVEL__055_L-1)
    .byte >(LEVEL__055_R-1)
    .byte >(LEVEL__056_L-1)
    .byte >(LEVEL__056_R-1)
    .byte >(LEVEL__057_L-1)
    .byte >(LEVEL__057_R-1)
    .byte >(LEVEL__058_L-1)
    .byte >(LEVEL__058_R-1)
    .byte >(LEVEL__059_L-1)
    .byte >(LEVEL__059_R-1)

    .byte >(LEVEL__060_R-1)
    .byte >(LEVEL__061_R-1)
    .byte >(LEVEL__061_L-1)
    .byte >(LEVEL__062_L-1)
    .byte >(LEVEL__062_R-1)
    .byte >(LEVEL__063_L-1)
    .byte >(LEVEL__063_R-1)
    .byte >(LEVEL__064_R-1)
    .byte >(LEVEL__064_L-1)
    .byte >(LEVEL__065_R-1)
    .byte >(LEVEL__065_L-1)
    .byte >(LEVEL__066_R-1)
    .byte >(LEVEL__066_L-1)
    .byte >(LEVEL__067_R-1)
    .byte >(LEVEL__067_L-1)
    .byte >(LEVEL__068_R-1)
    .byte >(LEVEL__068_L-1)
    .byte >(LEVEL__069_R-1)
    .byte >(LEVEL__069_L-1)

    .byte >(LEVEL__103_Arielle-1)
    .byte >(LEVEL__103_Ajalae-1)
    .byte >(LEVEL__103_Adin-1)
    .byte >(LEVEL__102_Raven-1)
    .byte >(LEVEL__102_Oralia-1)
    .byte >(LEVEL__102_Natalie-1)
    .byte >(LEVEL__102_Mirabel-1)
    .byte >(LEVEL__1XJH_Tara_Gelson-1)
    .byte >(LEVEL__1R7X_Alison-1)
    .byte >(LEVEL__1KWD_Cecile_Clayworth-1)
    .byte >(LEVEL__1EKT_Samantha_Gelson-1)
    .byte >(LEVEL__0VM5_Andrea_Wadd-1)
    .byte >(LEVEL__0PAL_Jill_Leatherby-1)
    .byte >(LEVEL__0IZ1_Sophia-1)
    .byte >(LEVEL__0CNH_Alice-1)
    .byte >(LEVEL__122_Maya-1)

    IF (* - LevelInfoHI != MAX_LEVEL)
        ECHO "ERROR: Incorrect LevelInfoHI table!"
        ERR
    ENDIF

LevelInfoBANK

    .byte BANK_LEVEL__001_L
    .byte BANK_LEVEL__001_R
    .byte BANK_LEVEL__002_L
    .byte BANK_LEVEL__002_R
    .byte BANK_LEVEL__003_L
    .byte BANK_LEVEL__003_R
    .byte BANK_LEVEL__004_L
    .byte BANK_LEVEL__004_R
    .byte BANK_LEVEL__005_L
    .byte BANK_LEVEL__005_R
    .byte BANK_LEVEL__006_L
    .byte BANK_LEVEL__006_R
    .byte BANK_LEVEL__007_L
    .byte BANK_LEVEL__007_R
    .byte BANK_LEVEL__008_L
    .byte BANK_LEVEL__008_R
    .byte BANK_LEVEL__009_L
    .byte BANK_LEVEL__009_R
    .byte BANK_LEVEL__010_L
    .byte BANK_LEVEL__010_R
    .byte BANK_LEVEL__011_L
    .byte BANK_LEVEL__011_R
    .byte BANK_LEVEL__012_L
    .byte BANK_LEVEL__012_R
    .byte BANK_LEVEL__013_L
    .byte BANK_LEVEL__013_R
    .byte BANK_LEVEL__014_L
    .byte BANK_LEVEL__014_R
    .byte BANK_LEVEL__015_L
    .byte BANK_LEVEL__015_R
    .byte BANK_LEVEL__016_L
    .byte BANK_LEVEL__016_R
    .byte BANK_LEVEL__017_L
    .byte BANK_LEVEL__017_R
    .byte BANK_LEVEL__018_L
    .byte BANK_LEVEL__018_R
    .byte BANK_LEVEL__019_L
    .byte BANK_LEVEL__019_R
    .byte BANK_LEVEL__020_L
    .byte BANK_LEVEL__020_R
    .byte BANK_LEVEL__021_L
    .byte BANK_LEVEL__021_R
    .byte BANK_LEVEL__022_L
    .byte BANK_LEVEL__022_R
    .byte BANK_LEVEL__023_L
    .byte BANK_LEVEL__023_R
    .byte BANK_LEVEL__024_L
    .byte BANK_LEVEL__024_R
    .byte BANK_LEVEL__025_L
    .byte BANK_LEVEL__025_R
    .byte BANK_LEVEL__026_L
    .byte BANK_LEVEL__026_R
    .byte BANK_LEVEL__027_L
    .byte BANK_LEVEL__027_R
    .byte BANK_LEVEL__028_L
    .byte BANK_LEVEL__028_R
    .byte BANK_LEVEL__029_L
    .byte BANK_LEVEL__029_R
    .byte BANK_LEVEL__030_L
    .byte BANK_LEVEL__030_R
    .byte BANK_LEVEL__031_L
    .byte BANK_LEVEL__031_R
    .byte BANK_LEVEL__032_L
    .byte BANK_LEVEL__032_R
    .byte BANK_LEVEL__033_L
    .byte BANK_LEVEL__033_R
    .byte BANK_LEVEL__034_L
    .byte BANK_LEVEL__034_R
    .byte BANK_LEVEL__035_L
    .byte BANK_LEVEL__035_R
    .byte BANK_LEVEL__036_L
    .byte BANK_LEVEL__036_R
    .byte BANK_LEVEL__037_L
    .byte BANK_LEVEL__037_R
    .byte BANK_LEVEL__038_L
    .byte BANK_LEVEL__038_R
    .byte BANK_LEVEL__039_L
    .byte BANK_LEVEL__039_R
    .byte BANK_LEVEL__040_L
    .byte BANK_LEVEL__040_R

    .byte BANK_LEVEL__041_L
    .byte BANK_LEVEL__041_R
    .byte BANK_LEVEL__042_L
    .byte BANK_LEVEL__042_R
    .byte BANK_LEVEL__043_L
    .byte BANK_LEVEL__043_R
    .byte BANK_LEVEL__044_L
    .byte BANK_LEVEL__044_R
    .byte BANK_LEVEL__045_L
    .byte BANK_LEVEL__045_R
    .byte BANK_LEVEL__046_L
    .byte BANK_LEVEL__046_R
    .byte BANK_LEVEL__047_L
    .byte BANK_LEVEL__047_R
    .byte BANK_LEVEL__048_L
    .byte BANK_LEVEL__048_R
    .byte BANK_LEVEL__049_L
    .byte BANK_LEVEL__049_R

    .byte BANK_LEVEL__050_L
    .byte BANK_LEVEL__050_R
    .byte BANK_LEVEL__051_L
    .byte BANK_LEVEL__051_R
    .byte BANK_LEVEL__052_L
    .byte BANK_LEVEL__052_R
    .byte BANK_LEVEL__053_L
    .byte BANK_LEVEL__053_R
    .byte BANK_LEVEL__054_L
    .byte BANK_LEVEL__054_R
    .byte BANK_LEVEL__055_L
    .byte BANK_LEVEL__055_R
    .byte BANK_LEVEL__056_L
    .byte BANK_LEVEL__056_R
    .byte BANK_LEVEL__057_L
    .byte BANK_LEVEL__057_R
    .byte BANK_LEVEL__058_L
    .byte BANK_LEVEL__058_R
    .byte BANK_LEVEL__059_L
    .byte BANK_LEVEL__059_R

    .byte BANK_LEVEL__060_R
    .byte BANK_LEVEL__061_R
    .byte BANK_LEVEL__061_L
    .byte BANK_LEVEL__062_L
    .byte BANK_LEVEL__062_R
    .byte BANK_LEVEL__063_L
    .byte BANK_LEVEL__063_R
    .byte BANK_LEVEL__064_R
    .byte BANK_LEVEL__064_L
    .byte BANK_LEVEL__065_R
    .byte BANK_LEVEL__065_L
    .byte BANK_LEVEL__066_R
    .byte BANK_LEVEL__066_L
    .byte BANK_LEVEL__067_R
    .byte BANK_LEVEL__067_L
    .byte BANK_LEVEL__068_R
    .byte BANK_LEVEL__068_L
    .byte BANK_LEVEL__069_R
    .byte BANK_LEVEL__069_L

    .byte BANK_LEVEL__103_Arielle
    .byte BANK_LEVEL__103_Ajalae
    .byte BANK_LEVEL__103_Adin
    .byte BANK_LEVEL__102_Raven
    .byte BANK_LEVEL__102_Oralia
    .byte BANK_LEVEL__102_Natalie
    .byte BANK_LEVEL__102_Mirabel
    .byte BANK_LEVEL__1XJH_Tara_Gelson
    .byte BANK_LEVEL__1R7X_Alison
    .byte BANK_LEVEL__1KWD_Cecile_Clayworth
    .byte BANK_LEVEL__1EKT_Samantha_Gelson
    .byte BANK_LEVEL__0VM5_Andrea_Wadd
    .byte BANK_LEVEL__0PAL_Jill_Leatherby
    .byte BANK_LEVEL__0IZ1_Sophia
    .byte BANK_LEVEL__0CNH_Alice

    .byte BANK_LEVEL__122_Maya

    IF (* - LevelInfoBANK != MAX_LEVEL)
        ECHO "ERROR: Incorrect LevelInfoBANK table!"
        ERR
    ENDIF



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


C1 ;mortar
    .byte $88,$b6
    .byte $38,$68
    .byte $5a,$AA
    .byte $5a,$8a
C2  ; soil stripes
    .byte $34,$62
    .byte $b4,$74
    .byte $F4,$24
    .byte $a4,$74
C3 ; brick
    .byte $1A,$2a
    .byte $8C,$BC
    .byte $0A,$fA
    .byte $ca,$3a

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

              lda #4
              sta base_x
              sta base_y

                lda NextLevelTrigger
                ora #BIT_NEXTLEVEL
                sta NextLevelTrigger

                ldx levelX
                lda LevelInfoLO,x
                sta Board_AddressR
                lda LevelInfoHI,x
                sta Board_AddressR+1
                lda LevelInfoBANK,x
                sta LEVEL_bank

                lda #BANK_UnpackLevel               ; the *ROM* bank of this routine (NOT RAM)
                sta ROM_Bank                        ; GetROMByte returns to this bank

              lda levelX
              and #3
              asl
              asl
              ora Platform              ; NTSC/PAL
              lsr
              tax
              lda C1,x
              sta color
              lda C2,x
              sta color+1
              lda C3,x
              sta color+2

              lda #$00
              sta moveCounter
              sta moveCounterHi
              sta moveCounterBinary
              sta moveCounterBase

              lda #$00                      ; BCD reminder!
              sta targetsRequired           ; # of targets that do NOT have boxes on them

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

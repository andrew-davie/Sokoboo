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

; level definitions
; Sample level definitions.
; Any level can be in any bank.  System auto-calculates required bank buffer size in RAM.
; have as many banks as you like.

  NEWBANK LEVELS_TABLES


; The ordering here corresponds to the ordering when playing...

    align 256
    DEFINE_SUBROUTINE LevelInfoLO
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

        #if 1
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
    #endif

    .byte <(LEVEL_Thomas_Reinke16-1)

    .byte <(LEVEL__Hof_0-1)
    .byte <(LEVEL__Hof_1-1)
    .byte <(LEVEL__Hof_2-1)
    .byte <(LEVEL__Hof_3-1)
    .byte <(LEVEL__Hof_4-1)
    .byte <(LEVEL__Hof_5-1)
    .byte <(LEVEL__Hof_6-1)
    .byte <(LEVEL__Hof_7-1)
    .byte <(LEVEL__Hof_8-1)
    .byte <(LEVEL__Hof_9-1)

    .byte <(LEVEL_Zone_26_0-1)
    .byte <(LEVEL_Zone_26_1-1)
    .byte <(LEVEL_Zone_26_2-1)
    .byte <(LEVEL_Zone_26_3-1)
    .byte <(LEVEL_Zone_26_4-1)
    .byte <(LEVEL_Zone_26_5-1)
    .byte <(LEVEL_Zone_26_6-1)
    .byte <(LEVEL_Zone_26_7-1)
    .byte <(LEVEL_Zone_26_8-1)
    .byte <(LEVEL_Zone_26_9-1)

    .byte <(LEVEL_Zone_26_10-1)
    .byte <(LEVEL_Zone_26_11-1)
    .byte <(LEVEL_Zone_26_12-1)
    .byte <(LEVEL_Zone_26_13-1)
    .byte <(LEVEL_Zone_26_14-1)
    .byte <(LEVEL_Zone_26_15-1)
    .byte <(LEVEL_Zone_26_16-1)
    .byte <(LEVEL_Zone_26_17-1)
    .byte <(LEVEL_Zone_26_18-1)
    .byte <(LEVEL_Zone_26_19-1)

    .byte <(LEVEL_Zone_26_20-1)
    .byte <(LEVEL_Zone_26_21-1)
    .byte <(LEVEL_Zone_26_22-1)
    .byte <(LEVEL_Zone_26_23-1)
    .byte <(LEVEL_Zone_26_24-1)
    .byte <(LEVEL_Zone_26_25-1)
    .byte <(LEVEL_Zone_26_26-1)
    .byte <(LEVEL_Zone_26_27-1)
    .byte <(LEVEL_Zone_26_28-1)
    .byte <(LEVEL_Zone_26_29-1)

    .byte <(LEVEL_Zone_26_30-1)
    .byte <(LEVEL_Zone_26_31-1)
    .byte <(LEVEL_Zone_26_32-1)
    .byte <(LEVEL_Zone_26_33-1)
    .byte <(LEVEL_Zone_26_34-1)
    .byte <(LEVEL_Zone_26_35-1)
    .byte <(LEVEL_Zone_26_36-1)
    .byte <(LEVEL_Zone_26_37-1)
    .byte <(LEVEL_Zone_26_38-1)
    .byte <(LEVEL_Zone_26_39-1)

    .byte <(LEVEL_Zone_26_40-1)
    .byte <(LEVEL_Zone_26_41-1)
    .byte <(LEVEL_Zone_26_42-1)
    .byte <(LEVEL_Zone_26_43-1)
    .byte <(LEVEL_Zone_26_44-1)
    .byte <(LEVEL_Zone_26_45-1)
    .byte <(LEVEL_Zone_26_46-1)
    .byte <(LEVEL_Zone_26_47-1)
    .byte <(LEVEL_Zone_26_48-1)
    .byte <(LEVEL_Zone_26_49-1)

    .byte <(LEVEL_Zone_26_50-1)
    .byte <(LEVEL_Zone_26_51-1)
    .byte <(LEVEL_Zone_26_52-1)
    .byte <(LEVEL_Zone_26_53-1)
    .byte <(LEVEL_Zone_26_54-1)
    .byte <(LEVEL_Zone_26_55-1)
    .byte <(LEVEL_Zone_26_56-1)
    .byte <(LEVEL_Zone_26_57-1)
    .byte <(LEVEL_Zone_26_58-1)
    .byte <(LEVEL_Zone_26_59-1)

    .byte <(LEVEL_Zone_26_60-1)
    .byte <(LEVEL_Zone_26_61-1)
    .byte <(LEVEL_Zone_26_62-1)
    .byte <(LEVEL_Zone_26_63-1)
    .byte <(LEVEL_Zone_26_64-1)
    .byte <(LEVEL_Zone_26_65-1)
    .byte <(LEVEL_Zone_26_66-1)
    .byte <(LEVEL_Zone_26_67-1)
    .byte <(LEVEL_Zone_26_68-1)
    .byte <(LEVEL_Zone_26_69-1)

    .byte <(LEVEL_Zone_26_70-1)
    .byte <(LEVEL_Zone_26_71-1)
    .byte <(LEVEL_Zone_26_72-1)
    .byte <(LEVEL_Zone_26_73-1)
    .byte <(LEVEL_Zone_26_74-1)
    .byte <(LEVEL_Zone_26_75-1)
    .byte <(LEVEL_Zone_26_76-1)
    .byte <(LEVEL_Zone_26_77-1)
    .byte <(LEVEL_Zone_26_78-1)
    .byte <(LEVEL_Zone_26_79-1)

    .byte <(LEVEL_Zone_26_80-1)
    .byte <(LEVEL_Zone_26_81-1)
    .byte <(LEVEL_Zone_26_82-1)
    .byte <(LEVEL_Zone_26_83-1)
    .byte <(LEVEL_Zone_26_84-1)
    .byte <(LEVEL_Zone_26_85-1)
    .byte <(LEVEL_Zone_26_86-1)
    .byte <(LEVEL_Zone_26_87-1)
    .byte <(LEVEL_Zone_26_88-1)
    .byte <(LEVEL_Zone_26_89-1)

    .byte <(LEVEL_Zone_26_90-1)
    .byte <(LEVEL_Zone_26_91-1)
    .byte <(LEVEL_Zone_26_92-1)
    .byte <(LEVEL_Zone_26_93-1)
    .byte <(LEVEL_Zone_26_94-1)
    .byte <(LEVEL_Zone_26_95-1)
    .byte <(LEVEL_Zone_26_96-1)
    .byte <(LEVEL_Zone_26_97-1)
    .byte <(LEVEL_Zone_26_98-1)
    .byte <(LEVEL_Zone_26_99-1)

    .byte <(LEVEL_Zone_26_100-1)
    .byte <(LEVEL_Zone_26_101-1)
    .byte <(LEVEL_Zone_26_102-1)
    .byte <(LEVEL_Zone_26_103-1)
    .byte <(LEVEL_Zone_26_104-1)
    .byte <(LEVEL_Zone_26_105-1)
    .byte <(LEVEL_Zone_26_106-1)
    .byte <(LEVEL_Zone_26_107-1)
    .byte <(LEVEL_Zone_26_108-1)
    .byte <(LEVEL_Zone_26_109-1)

    .byte <(LEVEL_Zone_26_110-1)
    .byte <(LEVEL_Zone_26_111-1)
    .byte <(LEVEL_Zone_26_112-1)
    .byte <(LEVEL_Zone_26_113-1)
    .byte <(LEVEL_Zone_26_114-1)
    .byte <(LEVEL_Zone_26_115-1)
    .byte <(LEVEL_Zone_26_116-1)

    .byte <(LEVEL_Rectangled_0-1)
    .byte <(LEVEL_Rectangled_1-1)
    .byte <(LEVEL_Rectangled_2-1)
    .byte <(LEVEL_Rectangled_3-1)
    .byte <(LEVEL_Rectangled_4-1)
    .byte <(LEVEL_Rectangled_5-1)
    .byte <(LEVEL_Rectangled_6-1)
    .byte <(LEVEL_Rectangled_7-1)
    .byte <(LEVEL_Rectangled_8-1)
    .byte <(LEVEL_Rectangled_9-1)
    .byte <(LEVEL_Rectangled_10-1)

    .byte <(LEVEL_Scoria_3_0-1)
    .byte <(LEVEL_Scoria_3_1-1)
    .byte <(LEVEL_Scoria_3_2-1)
    .byte <(LEVEL_Scoria_3_3-1)
    .byte <(LEVEL_Scoria_3_4-1)
    .byte <(LEVEL_Scoria_3_5-1)
    .byte <(LEVEL_Scoria_3_6-1)
    .byte <(LEVEL_Scoria_3_7-1)
    .byte <(LEVEL_Scoria_3_8-1)
    .byte <(LEVEL_Scoria_3_9-1)
    .byte <(LEVEL_Scoria_3_10-1)
    .byte <(LEVEL_Scoria_3_11-1)
    .byte <(LEVEL_Scoria_3_12-1)
    .byte <(LEVEL_Scoria_3_13-1)
    .byte <(LEVEL_Scoria_3_14-1)
    .byte <(LEVEL_Scoria_3_15-1)
    .byte <(LEVEL_Scoria_3_16-1)
    .byte <(LEVEL_Scoria_3_17-1)
    .byte <(LEVEL_Scoria_3_18-1)
    .byte <(LEVEL_Scoria_3_19-1)

 .byte <(LEVEL_Sokompact_0-1)
 .byte <(LEVEL_Sokompact_1-1)
 .byte <(LEVEL_Sokompact_2-1)
 .byte <(LEVEL_Sokompact_3-1)
 .byte <(LEVEL_Sokompact_4-1)
 .byte <(LEVEL_Sokompact_5-1)
 .byte <(LEVEL_Sokompact_6-1)
 .byte <(LEVEL_Sokompact_7-1)
 .byte <(LEVEL_Sokompact_8-1)
 .byte <(LEVEL_Sokompact_9-1)
 .byte <(LEVEL_Sokompact_10-1)
 .byte <(LEVEL_Sokompact_11-1)
 .byte <(LEVEL_Sokompact_12-1)
 .byte <(LEVEL_Sokompact_13-1)
 .byte <(LEVEL_Sokompact_14-1)
 .byte <(LEVEL_Sokompact_15-1)
 .byte <(LEVEL_Sokompact_16-1)
 .byte <(LEVEL_Sokompact_17-1)
 .byte <(LEVEL_Sokompact_18-1)
 .byte <(LEVEL_Sokompact_19-1)
 .byte <(LEVEL_Sokompact_20-1)
 .byte <(LEVEL_Sokompact_21-1)
 .byte <(LEVEL_Sokompact_22-1)
 .byte <(LEVEL_Sokompact_23-1)
 .byte <(LEVEL_Sokompact_24-1)
 .byte <(LEVEL_Sokompact_25-1)
 .byte <(LEVEL_Sokompact_26-1)
 .byte <(LEVEL_Sokompact_27-1)
 .byte <(LEVEL_Sokompact_28-1)
 .byte <(LEVEL_Sokompact_29-1)
 .byte <(LEVEL_Sokompact_30-1)
 .byte <(LEVEL_Sokompact_31-1)
 .byte <(LEVEL_Sokompact_32-1)
 .byte <(LEVEL_Sokompact_33-1)
 .byte <(LEVEL_Sokompact_34-1)
 .byte <(LEVEL_Sokompact_35-1)
 .byte <(LEVEL_Sokompact_36-1)
 .byte <(LEVEL_Sokompact_37-1)
 .byte <(LEVEL_Sokompact_38-1)
 .byte <(LEVEL_Sokompact_39-1)
 .byte <(LEVEL_Sokompact_40-1)
 .byte <(LEVEL_Sokompact_41-1)
 .byte <(LEVEL_Sokompact_42-1)
 .byte <(LEVEL_Sokompact_43-1)
 .byte <(LEVEL_Sokompact_44-1)
 .byte <(LEVEL_Sokompact_45-1)
 .byte <(LEVEL_Sokompact_46-1)
 .byte <(LEVEL_Sokompact_47-1)
 .byte <(LEVEL_Sokompact_48-1)
 .byte <(LEVEL_Sokompact_49-1)
 .byte <(LEVEL_Sokompact_50-1)


 .byte <(LEVEL_SokoStation_0-1)
 .byte <(LEVEL_SokoStation_1-1)
 .byte <(LEVEL_SokoStation_2-1)
 .byte <(LEVEL_SokoStation_3-1)
 .byte <(LEVEL_SokoStation_4-1)
 .byte <(LEVEL_SokoStation_5-1)
 .byte <(LEVEL_SokoStation_6-1)
 .byte <(LEVEL_SokoStation_7-1)
 .byte <(LEVEL_SokoStation_8-1)
 .byte <(LEVEL_SokoStation_9-1)
 .byte <(LEVEL_SokoStation_10-1)
 .byte <(LEVEL_SokoStation_11-1)
 .byte <(LEVEL_SokoStation_12-1)
 .byte <(LEVEL_SokoStation_13-1)
 .byte <(LEVEL_SokoStation_14-1)
 .byte <(LEVEL_SokoStation_15-1)
 .byte <(LEVEL_SokoStation_16-1)
 .byte <(LEVEL_SokoStation_17-1)
 .byte <(LEVEL_SokoStation_18-1)
 .byte <(LEVEL_SokoStation_19-1)
 .byte <(LEVEL_SokoStation_20-1)
 .byte <(LEVEL_SokoStation_21-1)
 ;.byte <(LEVEL_SokoStation_22-1)
 .byte <(LEVEL_SokoStation_23-1)
 .byte <(LEVEL_SokoStation_24-1)
 .byte <(LEVEL_SokoStation_25-1)
 .byte <(LEVEL_SokoStation_26-1)
 .byte <(LEVEL_SokoStation_27-1)
 .byte <(LEVEL_SokoStation_28-1)
 .byte <(LEVEL_SokoStation_29-1)
 .byte <(LEVEL_SokoStation_30-1)
 .byte <(LEVEL_SokoStation_31-1)
 .byte <(LEVEL_SokoStation_32-1)
 .byte <(LEVEL_SokoStation_33-1)
 .byte <(LEVEL_SokoStation_34-1)
 .byte <(LEVEL_SokoStation_35-1)
 .byte <(LEVEL_SokoStation_36-1)
 .byte <(LEVEL_SokoStation_37-1)
 .byte <(LEVEL_SokoStation_38-1)
 .byte <(LEVEL_SokoStation_39-1)
 .byte <(LEVEL_SokoStation_40-1)
 .byte <(LEVEL_SokoStation_41-1)
 .byte <(LEVEL_SokoStation_42-1)
 .byte <(LEVEL_SokoStation_43-1)
 .byte <(LEVEL_SokoStation_44-1)
 .byte <(LEVEL_SokoStation_45-1)
 .byte <(LEVEL_SokoStation_46-1)
 .byte <(LEVEL_SokoStation_47-1)
 .byte <(LEVEL_SokoStation_48-1)
 .byte <(LEVEL_SokoStation_49-1)
 .byte <(LEVEL_SokoStation_50-1)
 .byte <(LEVEL_SokoStation_51-1)
 .byte <(LEVEL_SokoStation_52-1)
 .byte <(LEVEL_SokoStation_53-1)
 .byte <(LEVEL_SokoStation_54-1)
 .byte <(LEVEL_SokoStation_55-1)
 .byte <(LEVEL_SokoStation_56-1)
 .byte <(LEVEL_SokoStation_57-1)
 .byte <(LEVEL_SokoStation_58-1)
 .byte <(LEVEL_SokoStation_59-1)
 .byte <(LEVEL_SokoStation_60-1)
 .byte <(LEVEL_SokoStation_61-1)
 .byte <(LEVEL_SokoStation_62-1)
 .byte <(LEVEL_SokoStation_63-1)
 .byte <(LEVEL_SokoStation_64-1)
 .byte <(LEVEL_SokoStation_65-1)
 .byte <(LEVEL_SokoStation_66-1)
 .byte <(LEVEL_SokoStation_67-1)
 .byte <(LEVEL_SokoStation_68-1)
 .byte <(LEVEL_SokoStation_69-1)
 .byte <(LEVEL_SokoStation_70-1)
 .byte <(LEVEL_SokoStation_71-1)
 .byte <(LEVEL_SokoStation_72-1)
 .byte <(LEVEL_SokoStation_73-1)
 .byte <(LEVEL_SokoStation_74-1)
 .byte <(LEVEL_SokoStation_75-1)
 .byte <(LEVEL_SokoStation_76-1)
 .byte <(LEVEL_SokoStation_77-1)
 .byte <(LEVEL_SokoStation_78-1)
 .byte <(LEVEL_SokoStation_79-1)
 .byte <(LEVEL_SokoStation_80-1)
 .byte <(LEVEL_SokoStation_81-1)
 .byte <(LEVEL_SokoStation_82-1)
 .byte <(LEVEL_SokoStation_83-1)
 .byte <(LEVEL_SokoStation_84-1)
 .byte <(LEVEL_SokoStation_85-1)
 .byte <(LEVEL_SokoStation_86-1)
 .byte <(LEVEL_SokoStation_87-1)
 .byte <(LEVEL_SokoStation_88-1)
 .byte <(LEVEL_SokoStation_89-1)
 .byte <(LEVEL_SokoStation_90-1)
 .byte <(LEVEL_SokoStation_91-1)

 .byte <(LEVEL_SokoStation_92-1)
 .byte <(LEVEL_SokoStation_93-1)
 .byte <(LEVEL_SokoStation_94-1)
 .byte <(LEVEL_SokoStation_95-1)
 .byte <(LEVEL_SokoStation_96-1)
 .byte <(LEVEL_SokoStation_97-1)
 .byte <(LEVEL_SokoStation_98-1)
 .byte <(LEVEL_SokoStation_99-1)
; .byte <(LEVEL_SokoStation_100-1)
; .byte <(LEVEL_SokoStation_101-1)
; .byte <(LEVEL_SokoStation_102-1)
 .byte <(LEVEL_SokoStation_103-1)
 .byte <(LEVEL_SokoStation_104-1)
#if 0
 .byte <(LEVEL_SokoStation_105-1)
 .byte <(LEVEL_SokoStation_106-1)
 .byte <(LEVEL_SokoStation_107-1)
 .byte <(LEVEL_SokoStation_108-1)
 .byte <(LEVEL_SokoStation_109-1)
#endif


MAX_LEVEL = * - LevelInfoLO
    ECHO MAX_LEVEL, "LEVELS INSTALLED"

    align 256
    DEFINE_SUBROUTINE LevelInfoHI

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

    .byte >(LEVEL_Thomas_Reinke16-1)

    .byte >(LEVEL__Hof_0-1)
    .byte >(LEVEL__Hof_1-1)
    .byte >(LEVEL__Hof_2-1)
    .byte >(LEVEL__Hof_3-1)
    .byte >(LEVEL__Hof_4-1)
    .byte >(LEVEL__Hof_5-1)
    .byte >(LEVEL__Hof_6-1)
    .byte >(LEVEL__Hof_7-1)
    .byte >(LEVEL__Hof_8-1)
    .byte >(LEVEL__Hof_9-1)

    .byte >(LEVEL_Zone_26_0-1)
    .byte >(LEVEL_Zone_26_1-1)
    .byte >(LEVEL_Zone_26_2-1)
    .byte >(LEVEL_Zone_26_3-1)
    .byte >(LEVEL_Zone_26_4-1)
    .byte >(LEVEL_Zone_26_5-1)
    .byte >(LEVEL_Zone_26_6-1)
    .byte >(LEVEL_Zone_26_7-1)
    .byte >(LEVEL_Zone_26_8-1)
    .byte >(LEVEL_Zone_26_9-1)

    .byte >(LEVEL_Zone_26_10-1)
    .byte >(LEVEL_Zone_26_11-1)
    .byte >(LEVEL_Zone_26_12-1)
    .byte >(LEVEL_Zone_26_13-1)
    .byte >(LEVEL_Zone_26_14-1)
    .byte >(LEVEL_Zone_26_15-1)
    .byte >(LEVEL_Zone_26_16-1)
    .byte >(LEVEL_Zone_26_17-1)
    .byte >(LEVEL_Zone_26_18-1)
    .byte >(LEVEL_Zone_26_19-1)

    .byte >(LEVEL_Zone_26_20-1)
    .byte >(LEVEL_Zone_26_21-1)
    .byte >(LEVEL_Zone_26_22-1)
    .byte >(LEVEL_Zone_26_23-1)
    .byte >(LEVEL_Zone_26_24-1)
    .byte >(LEVEL_Zone_26_25-1)
    .byte >(LEVEL_Zone_26_26-1)
    .byte >(LEVEL_Zone_26_27-1)
    .byte >(LEVEL_Zone_26_28-1)
    .byte >(LEVEL_Zone_26_29-1)

    .byte >(LEVEL_Zone_26_30-1)
    .byte >(LEVEL_Zone_26_31-1)
    .byte >(LEVEL_Zone_26_32-1)
    .byte >(LEVEL_Zone_26_33-1)
    .byte >(LEVEL_Zone_26_34-1)
    .byte >(LEVEL_Zone_26_35-1)
    .byte >(LEVEL_Zone_26_36-1)
    .byte >(LEVEL_Zone_26_37-1)
    .byte >(LEVEL_Zone_26_38-1)
    .byte >(LEVEL_Zone_26_39-1)

    .byte >(LEVEL_Zone_26_40-1)
    .byte >(LEVEL_Zone_26_41-1)
    .byte >(LEVEL_Zone_26_42-1)
    .byte >(LEVEL_Zone_26_43-1)
    .byte >(LEVEL_Zone_26_44-1)
    .byte >(LEVEL_Zone_26_45-1)
    .byte >(LEVEL_Zone_26_46-1)
    .byte >(LEVEL_Zone_26_47-1)
    .byte >(LEVEL_Zone_26_48-1)
    .byte >(LEVEL_Zone_26_49-1)

    .byte >(LEVEL_Zone_26_50-1)
    .byte >(LEVEL_Zone_26_51-1)
    .byte >(LEVEL_Zone_26_52-1)
    .byte >(LEVEL_Zone_26_53-1)
    .byte >(LEVEL_Zone_26_54-1)
    .byte >(LEVEL_Zone_26_55-1)
    .byte >(LEVEL_Zone_26_56-1)
    .byte >(LEVEL_Zone_26_57-1)
    .byte >(LEVEL_Zone_26_58-1)
    .byte >(LEVEL_Zone_26_59-1)

    .byte >(LEVEL_Zone_26_60-1)
    .byte >(LEVEL_Zone_26_61-1)
    .byte >(LEVEL_Zone_26_62-1)
    .byte >(LEVEL_Zone_26_63-1)
    .byte >(LEVEL_Zone_26_64-1)
    .byte >(LEVEL_Zone_26_65-1)
    .byte >(LEVEL_Zone_26_66-1)
    .byte >(LEVEL_Zone_26_67-1)
    .byte >(LEVEL_Zone_26_68-1)
    .byte >(LEVEL_Zone_26_69-1)

    .byte >(LEVEL_Zone_26_70-1)
    .byte >(LEVEL_Zone_26_71-1)
    .byte >(LEVEL_Zone_26_72-1)
    .byte >(LEVEL_Zone_26_73-1)
    .byte >(LEVEL_Zone_26_74-1)
    .byte >(LEVEL_Zone_26_75-1)
    .byte >(LEVEL_Zone_26_76-1)
    .byte >(LEVEL_Zone_26_77-1)
    .byte >(LEVEL_Zone_26_78-1)
    .byte >(LEVEL_Zone_26_79-1)

    .byte >(LEVEL_Zone_26_80-1)
    .byte >(LEVEL_Zone_26_81-1)
    .byte >(LEVEL_Zone_26_82-1)
    .byte >(LEVEL_Zone_26_83-1)
    .byte >(LEVEL_Zone_26_84-1)
    .byte >(LEVEL_Zone_26_85-1)
    .byte >(LEVEL_Zone_26_86-1)
    .byte >(LEVEL_Zone_26_87-1)
    .byte >(LEVEL_Zone_26_88-1)
    .byte >(LEVEL_Zone_26_89-1)

    .byte >(LEVEL_Zone_26_90-1)
    .byte >(LEVEL_Zone_26_91-1)
    .byte >(LEVEL_Zone_26_92-1)
    .byte >(LEVEL_Zone_26_93-1)
    .byte >(LEVEL_Zone_26_94-1)
    .byte >(LEVEL_Zone_26_95-1)
    .byte >(LEVEL_Zone_26_96-1)
    .byte >(LEVEL_Zone_26_97-1)
    .byte >(LEVEL_Zone_26_98-1)
    .byte >(LEVEL_Zone_26_99-1)


    .byte >(LEVEL_Zone_26_100-1)
    .byte >(LEVEL_Zone_26_101-1)
    .byte >(LEVEL_Zone_26_102-1)
    .byte >(LEVEL_Zone_26_103-1)
    .byte >(LEVEL_Zone_26_104-1)
    .byte >(LEVEL_Zone_26_105-1)
    .byte >(LEVEL_Zone_26_106-1)
    .byte >(LEVEL_Zone_26_107-1)
    .byte >(LEVEL_Zone_26_108-1)
    .byte >(LEVEL_Zone_26_109-1)

    .byte >(LEVEL_Zone_26_110-1)
    .byte >(LEVEL_Zone_26_111-1)
    .byte >(LEVEL_Zone_26_112-1)
    .byte >(LEVEL_Zone_26_113-1)
    .byte >(LEVEL_Zone_26_114-1)
    .byte >(LEVEL_Zone_26_115-1)
    .byte >(LEVEL_Zone_26_116-1)

    .byte >(LEVEL_Rectangled_0-1)
    .byte >(LEVEL_Rectangled_1-1)
    .byte >(LEVEL_Rectangled_2-1)
    .byte >(LEVEL_Rectangled_3-1)
    .byte >(LEVEL_Rectangled_4-1)
    .byte >(LEVEL_Rectangled_5-1)
    .byte >(LEVEL_Rectangled_6-1)
    .byte >(LEVEL_Rectangled_7-1)
    .byte >(LEVEL_Rectangled_8-1)
    .byte >(LEVEL_Rectangled_9-1)
    .byte >(LEVEL_Rectangled_10-1)

    .byte >(LEVEL_Scoria_3_0-1)
    .byte >(LEVEL_Scoria_3_1-1)
    .byte >(LEVEL_Scoria_3_2-1)
    .byte >(LEVEL_Scoria_3_3-1)
    .byte >(LEVEL_Scoria_3_4-1)
    .byte >(LEVEL_Scoria_3_5-1)
    .byte >(LEVEL_Scoria_3_6-1)
    .byte >(LEVEL_Scoria_3_7-1)
    .byte >(LEVEL_Scoria_3_8-1)
    .byte >(LEVEL_Scoria_3_9-1)
    .byte >(LEVEL_Scoria_3_10-1)
    .byte >(LEVEL_Scoria_3_11-1)
    .byte >(LEVEL_Scoria_3_12-1)
    .byte >(LEVEL_Scoria_3_13-1)
    .byte >(LEVEL_Scoria_3_14-1)
    .byte >(LEVEL_Scoria_3_15-1)
    .byte >(LEVEL_Scoria_3_16-1)
    .byte >(LEVEL_Scoria_3_17-1)
    .byte >(LEVEL_Scoria_3_18-1)
    .byte >(LEVEL_Scoria_3_19-1)


 .byte >(LEVEL_Sokompact_0-1)
 .byte >(LEVEL_Sokompact_1-1)
 .byte >(LEVEL_Sokompact_2-1)
 .byte >(LEVEL_Sokompact_3-1)
 .byte >(LEVEL_Sokompact_4-1)
 .byte >(LEVEL_Sokompact_5-1)
 .byte >(LEVEL_Sokompact_6-1)
 .byte >(LEVEL_Sokompact_7-1)
 .byte >(LEVEL_Sokompact_8-1)
 .byte >(LEVEL_Sokompact_9-1)
 .byte >(LEVEL_Sokompact_10-1)
 .byte >(LEVEL_Sokompact_11-1)
 .byte >(LEVEL_Sokompact_12-1)
 .byte >(LEVEL_Sokompact_13-1)
 .byte >(LEVEL_Sokompact_14-1)
 .byte >(LEVEL_Sokompact_15-1)
 .byte >(LEVEL_Sokompact_16-1)
 .byte >(LEVEL_Sokompact_17-1)
 .byte >(LEVEL_Sokompact_18-1)
 .byte >(LEVEL_Sokompact_19-1)
 .byte >(LEVEL_Sokompact_20-1)
 .byte >(LEVEL_Sokompact_21-1)
 .byte >(LEVEL_Sokompact_22-1)
 .byte >(LEVEL_Sokompact_23-1)
 .byte >(LEVEL_Sokompact_24-1)
 .byte >(LEVEL_Sokompact_25-1)
 .byte >(LEVEL_Sokompact_26-1)
 .byte >(LEVEL_Sokompact_27-1)
 .byte >(LEVEL_Sokompact_28-1)
 .byte >(LEVEL_Sokompact_29-1)
 .byte >(LEVEL_Sokompact_30-1)
 .byte >(LEVEL_Sokompact_31-1)
 .byte >(LEVEL_Sokompact_32-1)
 .byte >(LEVEL_Sokompact_33-1)
 .byte >(LEVEL_Sokompact_34-1)
 .byte >(LEVEL_Sokompact_35-1)
 .byte >(LEVEL_Sokompact_36-1)
 .byte >(LEVEL_Sokompact_37-1)
 .byte >(LEVEL_Sokompact_38-1)
 .byte >(LEVEL_Sokompact_39-1)
 .byte >(LEVEL_Sokompact_40-1)
 .byte >(LEVEL_Sokompact_41-1)
 .byte >(LEVEL_Sokompact_42-1)
 .byte >(LEVEL_Sokompact_43-1)
 .byte >(LEVEL_Sokompact_44-1)
 .byte >(LEVEL_Sokompact_45-1)
 .byte >(LEVEL_Sokompact_46-1)
 .byte >(LEVEL_Sokompact_47-1)
 .byte >(LEVEL_Sokompact_48-1)
 .byte >(LEVEL_Sokompact_49-1)
 .byte >(LEVEL_Sokompact_50-1)


 .byte >(LEVEL_SokoStation_0-1)
 .byte >(LEVEL_SokoStation_1-1)
 .byte >(LEVEL_SokoStation_2-1)
 .byte >(LEVEL_SokoStation_3-1)
 .byte >(LEVEL_SokoStation_4-1)
 .byte >(LEVEL_SokoStation_5-1)
 .byte >(LEVEL_SokoStation_6-1)
 .byte >(LEVEL_SokoStation_7-1)
 .byte >(LEVEL_SokoStation_8-1)
 .byte >(LEVEL_SokoStation_9-1)
 .byte >(LEVEL_SokoStation_10-1)
 .byte >(LEVEL_SokoStation_11-1)
 .byte >(LEVEL_SokoStation_12-1)
 .byte >(LEVEL_SokoStation_13-1)
 .byte >(LEVEL_SokoStation_14-1)
 .byte >(LEVEL_SokoStation_15-1)
 .byte >(LEVEL_SokoStation_16-1)
 .byte >(LEVEL_SokoStation_17-1)
 .byte >(LEVEL_SokoStation_18-1)
 .byte >(LEVEL_SokoStation_19-1)
 .byte >(LEVEL_SokoStation_20-1)
 .byte >(LEVEL_SokoStation_21-1)
 ;.byte >(LEVEL_SokoStation_22-1)
 .byte >(LEVEL_SokoStation_23-1)
 .byte >(LEVEL_SokoStation_24-1)
 .byte >(LEVEL_SokoStation_25-1)
 .byte >(LEVEL_SokoStation_26-1)
 .byte >(LEVEL_SokoStation_27-1)
 .byte >(LEVEL_SokoStation_28-1)
 .byte >(LEVEL_SokoStation_29-1)
 .byte >(LEVEL_SokoStation_30-1)
 .byte >(LEVEL_SokoStation_31-1)
 .byte >(LEVEL_SokoStation_32-1)
 .byte >(LEVEL_SokoStation_33-1)
 .byte >(LEVEL_SokoStation_34-1)
 .byte >(LEVEL_SokoStation_35-1)
 .byte >(LEVEL_SokoStation_36-1)
 .byte >(LEVEL_SokoStation_37-1)
 .byte >(LEVEL_SokoStation_38-1)
 .byte >(LEVEL_SokoStation_39-1)
 .byte >(LEVEL_SokoStation_40-1)
 .byte >(LEVEL_SokoStation_41-1)
 .byte >(LEVEL_SokoStation_42-1)
 .byte >(LEVEL_SokoStation_43-1)
 .byte >(LEVEL_SokoStation_44-1)
 .byte >(LEVEL_SokoStation_45-1)
 .byte >(LEVEL_SokoStation_46-1)
 .byte >(LEVEL_SokoStation_47-1)
 .byte >(LEVEL_SokoStation_48-1)
 .byte >(LEVEL_SokoStation_49-1)
 .byte >(LEVEL_SokoStation_50-1)
 .byte >(LEVEL_SokoStation_51-1)
 .byte >(LEVEL_SokoStation_52-1)
 .byte >(LEVEL_SokoStation_53-1)
 .byte >(LEVEL_SokoStation_54-1)
 .byte >(LEVEL_SokoStation_55-1)
 .byte >(LEVEL_SokoStation_56-1)
 .byte >(LEVEL_SokoStation_57-1)
 .byte >(LEVEL_SokoStation_58-1)
 .byte >(LEVEL_SokoStation_59-1)
 .byte >(LEVEL_SokoStation_60-1)
 .byte >(LEVEL_SokoStation_61-1)
 .byte >(LEVEL_SokoStation_62-1)
 .byte >(LEVEL_SokoStation_63-1)
 .byte >(LEVEL_SokoStation_64-1)
 .byte >(LEVEL_SokoStation_65-1)
 .byte >(LEVEL_SokoStation_66-1)
 .byte >(LEVEL_SokoStation_67-1)
 .byte >(LEVEL_SokoStation_68-1)
 .byte >(LEVEL_SokoStation_69-1)
 .byte >(LEVEL_SokoStation_70-1)
 .byte >(LEVEL_SokoStation_71-1)
 .byte >(LEVEL_SokoStation_72-1)
 .byte >(LEVEL_SokoStation_73-1)
 .byte >(LEVEL_SokoStation_74-1)
 .byte >(LEVEL_SokoStation_75-1)
 .byte >(LEVEL_SokoStation_76-1)
 .byte >(LEVEL_SokoStation_77-1)
 .byte >(LEVEL_SokoStation_78-1)
 .byte >(LEVEL_SokoStation_79-1)
 .byte >(LEVEL_SokoStation_80-1)
 .byte >(LEVEL_SokoStation_81-1)
 .byte >(LEVEL_SokoStation_82-1)
 .byte >(LEVEL_SokoStation_83-1)
 .byte >(LEVEL_SokoStation_84-1)
 .byte >(LEVEL_SokoStation_85-1)
 .byte >(LEVEL_SokoStation_86-1)
 .byte >(LEVEL_SokoStation_87-1)
 .byte >(LEVEL_SokoStation_88-1)
 .byte >(LEVEL_SokoStation_89-1)
 .byte >(LEVEL_SokoStation_90-1)
 .byte >(LEVEL_SokoStation_91-1)

 .byte >(LEVEL_SokoStation_92-1)
 .byte >(LEVEL_SokoStation_93-1)
 .byte >(LEVEL_SokoStation_94-1)
 .byte >(LEVEL_SokoStation_95-1)
 .byte >(LEVEL_SokoStation_96-1)
 .byte >(LEVEL_SokoStation_97-1)
 .byte >(LEVEL_SokoStation_98-1)
 .byte >(LEVEL_SokoStation_99-1)
; .byte >(LEVEL_SokoStation_100-1)
; .byte >(LEVEL_SokoStation_101-1)
; .byte >(LEVEL_SokoStation_102-1)
 .byte >(LEVEL_SokoStation_103-1)
 .byte >(LEVEL_SokoStation_104-1)
#if 0
 .byte >(LEVEL_SokoStation_105-1)
 .byte >(LEVEL_SokoStation_106-1)
 .byte >(LEVEL_SokoStation_107-1)
 .byte >(LEVEL_SokoStation_108-1)
 .byte >(LEVEL_SokoStation_109-1)
#endif

    IF (* - LevelInfoHI != MAX_LEVEL)
        ECHO "ERROR: Incorrect LevelInfoHI table!"
        ERR
    ENDIF

    align 256
    DEFINE_SUBROUTINE LevelInfoBANK

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

    .byte BANK_LEVEL_Thomas_Reinke16

    .byte BANK_LEVEL__Hof_0
    .byte BANK_LEVEL__Hof_1
    .byte BANK_LEVEL__Hof_2
    .byte BANK_LEVEL__Hof_3
    .byte BANK_LEVEL__Hof_4
    .byte BANK_LEVEL__Hof_5
    .byte BANK_LEVEL__Hof_6
    .byte BANK_LEVEL__Hof_7
    .byte BANK_LEVEL__Hof_8
    .byte BANK_LEVEL__Hof_9

    .byte BANK_LEVEL_Zone_26_0
    .byte BANK_LEVEL_Zone_26_1
    .byte BANK_LEVEL_Zone_26_2
    .byte BANK_LEVEL_Zone_26_3
    .byte BANK_LEVEL_Zone_26_4
    .byte BANK_LEVEL_Zone_26_5
    .byte BANK_LEVEL_Zone_26_6
    .byte BANK_LEVEL_Zone_26_7
    .byte BANK_LEVEL_Zone_26_8
    .byte BANK_LEVEL_Zone_26_9

    .byte BANK_LEVEL_Zone_26_10
    .byte BANK_LEVEL_Zone_26_11
    .byte BANK_LEVEL_Zone_26_12
    .byte BANK_LEVEL_Zone_26_13
    .byte BANK_LEVEL_Zone_26_14
    .byte BANK_LEVEL_Zone_26_15
    .byte BANK_LEVEL_Zone_26_16
    .byte BANK_LEVEL_Zone_26_17
    .byte BANK_LEVEL_Zone_26_18
    .byte BANK_LEVEL_Zone_26_19

    .byte BANK_LEVEL_Zone_26_20
    .byte BANK_LEVEL_Zone_26_21
    .byte BANK_LEVEL_Zone_26_22
    .byte BANK_LEVEL_Zone_26_23
    .byte BANK_LEVEL_Zone_26_24
    .byte BANK_LEVEL_Zone_26_25
    .byte BANK_LEVEL_Zone_26_26
    .byte BANK_LEVEL_Zone_26_27
    .byte BANK_LEVEL_Zone_26_28
    .byte BANK_LEVEL_Zone_26_29

    .byte BANK_LEVEL_Zone_26_30
    .byte BANK_LEVEL_Zone_26_31
    .byte BANK_LEVEL_Zone_26_32
    .byte BANK_LEVEL_Zone_26_33
    .byte BANK_LEVEL_Zone_26_34
    .byte BANK_LEVEL_Zone_26_35
    .byte BANK_LEVEL_Zone_26_36
    .byte BANK_LEVEL_Zone_26_37
    .byte BANK_LEVEL_Zone_26_38
    .byte BANK_LEVEL_Zone_26_39

    .byte BANK_LEVEL_Zone_26_40
    .byte BANK_LEVEL_Zone_26_41
    .byte BANK_LEVEL_Zone_26_42
    .byte BANK_LEVEL_Zone_26_43
    .byte BANK_LEVEL_Zone_26_44
    .byte BANK_LEVEL_Zone_26_45
    .byte BANK_LEVEL_Zone_26_46
    .byte BANK_LEVEL_Zone_26_47
    .byte BANK_LEVEL_Zone_26_48
    .byte BANK_LEVEL_Zone_26_49

    .byte BANK_LEVEL_Zone_26_50
    .byte BANK_LEVEL_Zone_26_51
    .byte BANK_LEVEL_Zone_26_52
    .byte BANK_LEVEL_Zone_26_53
    .byte BANK_LEVEL_Zone_26_54
    .byte BANK_LEVEL_Zone_26_55
    .byte BANK_LEVEL_Zone_26_56
    .byte BANK_LEVEL_Zone_26_57
    .byte BANK_LEVEL_Zone_26_58
    .byte BANK_LEVEL_Zone_26_59

    .byte BANK_LEVEL_Zone_26_60
    .byte BANK_LEVEL_Zone_26_61
    .byte BANK_LEVEL_Zone_26_62
    .byte BANK_LEVEL_Zone_26_63
    .byte BANK_LEVEL_Zone_26_64
    .byte BANK_LEVEL_Zone_26_65
    .byte BANK_LEVEL_Zone_26_66
    .byte BANK_LEVEL_Zone_26_67
    .byte BANK_LEVEL_Zone_26_68
    .byte BANK_LEVEL_Zone_26_69

    .byte BANK_LEVEL_Zone_26_70
    .byte BANK_LEVEL_Zone_26_71
    .byte BANK_LEVEL_Zone_26_72
    .byte BANK_LEVEL_Zone_26_73
    .byte BANK_LEVEL_Zone_26_74
    .byte BANK_LEVEL_Zone_26_75
    .byte BANK_LEVEL_Zone_26_76
    .byte BANK_LEVEL_Zone_26_77
    .byte BANK_LEVEL_Zone_26_78
    .byte BANK_LEVEL_Zone_26_79

    .byte BANK_LEVEL_Zone_26_80
    .byte BANK_LEVEL_Zone_26_81
    .byte BANK_LEVEL_Zone_26_82
    .byte BANK_LEVEL_Zone_26_83
    .byte BANK_LEVEL_Zone_26_84
    .byte BANK_LEVEL_Zone_26_85
    .byte BANK_LEVEL_Zone_26_86
    .byte BANK_LEVEL_Zone_26_87
    .byte BANK_LEVEL_Zone_26_88
    .byte BANK_LEVEL_Zone_26_89

    .byte BANK_LEVEL_Zone_26_90
    .byte BANK_LEVEL_Zone_26_91
    .byte BANK_LEVEL_Zone_26_92
    .byte BANK_LEVEL_Zone_26_93
    .byte BANK_LEVEL_Zone_26_94
    .byte BANK_LEVEL_Zone_26_95
    .byte BANK_LEVEL_Zone_26_96
    .byte BANK_LEVEL_Zone_26_97
    .byte BANK_LEVEL_Zone_26_98
    .byte BANK_LEVEL_Zone_26_99

    .byte BANK_LEVEL_Zone_26_100
    .byte BANK_LEVEL_Zone_26_101
    .byte BANK_LEVEL_Zone_26_102
    .byte BANK_LEVEL_Zone_26_103
    .byte BANK_LEVEL_Zone_26_104
    .byte BANK_LEVEL_Zone_26_105
    .byte BANK_LEVEL_Zone_26_106
    .byte BANK_LEVEL_Zone_26_107
    .byte BANK_LEVEL_Zone_26_108
    .byte BANK_LEVEL_Zone_26_109

    .byte BANK_LEVEL_Zone_26_110
    .byte BANK_LEVEL_Zone_26_111
    .byte BANK_LEVEL_Zone_26_112
    .byte BANK_LEVEL_Zone_26_113
    .byte BANK_LEVEL_Zone_26_114
    .byte BANK_LEVEL_Zone_26_115
    .byte BANK_LEVEL_Zone_26_116

    .byte BANK_LEVEL_Rectangled_0
    .byte BANK_LEVEL_Rectangled_1
    .byte BANK_LEVEL_Rectangled_2
    .byte BANK_LEVEL_Rectangled_3
    .byte BANK_LEVEL_Rectangled_4
    .byte BANK_LEVEL_Rectangled_5
    .byte BANK_LEVEL_Rectangled_6
    .byte BANK_LEVEL_Rectangled_7
    .byte BANK_LEVEL_Rectangled_8
    .byte BANK_LEVEL_Rectangled_9
    .byte BANK_LEVEL_Rectangled_10

    .byte BANK_LEVEL_Scoria_3_0
    .byte BANK_LEVEL_Scoria_3_1
    .byte BANK_LEVEL_Scoria_3_2
    .byte BANK_LEVEL_Scoria_3_3
    .byte BANK_LEVEL_Scoria_3_4
    .byte BANK_LEVEL_Scoria_3_5
    .byte BANK_LEVEL_Scoria_3_6
    .byte BANK_LEVEL_Scoria_3_7
    .byte BANK_LEVEL_Scoria_3_8
    .byte BANK_LEVEL_Scoria_3_9
    .byte BANK_LEVEL_Scoria_3_10
    .byte BANK_LEVEL_Scoria_3_11
    .byte BANK_LEVEL_Scoria_3_12
    .byte BANK_LEVEL_Scoria_3_13
    .byte BANK_LEVEL_Scoria_3_14
    .byte BANK_LEVEL_Scoria_3_15
    .byte BANK_LEVEL_Scoria_3_16
    .byte BANK_LEVEL_Scoria_3_17
    .byte BANK_LEVEL_Scoria_3_18
    .byte BANK_LEVEL_Scoria_3_19

 .byte BANK_LEVEL_Sokompact_0
 .byte BANK_LEVEL_Sokompact_1
 .byte BANK_LEVEL_Sokompact_2
 .byte BANK_LEVEL_Sokompact_3
 .byte BANK_LEVEL_Sokompact_4
 .byte BANK_LEVEL_Sokompact_5
 .byte BANK_LEVEL_Sokompact_6
 .byte BANK_LEVEL_Sokompact_7
 .byte BANK_LEVEL_Sokompact_8
 .byte BANK_LEVEL_Sokompact_9
 .byte BANK_LEVEL_Sokompact_10
 .byte BANK_LEVEL_Sokompact_11
 .byte BANK_LEVEL_Sokompact_12
 .byte BANK_LEVEL_Sokompact_13
 .byte BANK_LEVEL_Sokompact_14
 .byte BANK_LEVEL_Sokompact_15
 .byte BANK_LEVEL_Sokompact_16
 .byte BANK_LEVEL_Sokompact_17
 .byte BANK_LEVEL_Sokompact_18
 .byte BANK_LEVEL_Sokompact_19
 .byte BANK_LEVEL_Sokompact_20
 .byte BANK_LEVEL_Sokompact_21
 .byte BANK_LEVEL_Sokompact_22
 .byte BANK_LEVEL_Sokompact_23
 .byte BANK_LEVEL_Sokompact_24
 .byte BANK_LEVEL_Sokompact_25
 .byte BANK_LEVEL_Sokompact_26
 .byte BANK_LEVEL_Sokompact_27
 .byte BANK_LEVEL_Sokompact_28
 .byte BANK_LEVEL_Sokompact_29
 .byte BANK_LEVEL_Sokompact_30
 .byte BANK_LEVEL_Sokompact_31
 .byte BANK_LEVEL_Sokompact_32
 .byte BANK_LEVEL_Sokompact_33
 .byte BANK_LEVEL_Sokompact_34
 .byte BANK_LEVEL_Sokompact_35
 .byte BANK_LEVEL_Sokompact_36
 .byte BANK_LEVEL_Sokompact_37
 .byte BANK_LEVEL_Sokompact_38
 .byte BANK_LEVEL_Sokompact_39
 .byte BANK_LEVEL_Sokompact_40
 .byte BANK_LEVEL_Sokompact_41
 .byte BANK_LEVEL_Sokompact_42
 .byte BANK_LEVEL_Sokompact_43
 .byte BANK_LEVEL_Sokompact_44
 .byte BANK_LEVEL_Sokompact_45
 .byte BANK_LEVEL_Sokompact_46
 .byte BANK_LEVEL_Sokompact_47
 .byte BANK_LEVEL_Sokompact_48
 .byte BANK_LEVEL_Sokompact_49
 .byte BANK_LEVEL_Sokompact_50


 .byte BANK_LEVEL_SokoStation_0
 .byte BANK_LEVEL_SokoStation_1
 .byte BANK_LEVEL_SokoStation_2
 .byte BANK_LEVEL_SokoStation_3
 .byte BANK_LEVEL_SokoStation_4
 .byte BANK_LEVEL_SokoStation_5
 .byte BANK_LEVEL_SokoStation_6
 .byte BANK_LEVEL_SokoStation_7
 .byte BANK_LEVEL_SokoStation_8
 .byte BANK_LEVEL_SokoStation_9
 .byte BANK_LEVEL_SokoStation_10
 .byte BANK_LEVEL_SokoStation_11
 .byte BANK_LEVEL_SokoStation_12
 .byte BANK_LEVEL_SokoStation_13
 .byte BANK_LEVEL_SokoStation_14
 .byte BANK_LEVEL_SokoStation_15
 .byte BANK_LEVEL_SokoStation_16
 .byte BANK_LEVEL_SokoStation_17
 .byte BANK_LEVEL_SokoStation_18
 .byte BANK_LEVEL_SokoStation_19
 .byte BANK_LEVEL_SokoStation_20
 .byte BANK_LEVEL_SokoStation_21
 ;.byte BANK_LEVEL_SokoStation_22
 .byte BANK_LEVEL_SokoStation_23
 .byte BANK_LEVEL_SokoStation_24
 .byte BANK_LEVEL_SokoStation_25
 .byte BANK_LEVEL_SokoStation_26
 .byte BANK_LEVEL_SokoStation_27
 .byte BANK_LEVEL_SokoStation_28
 .byte BANK_LEVEL_SokoStation_29
 .byte BANK_LEVEL_SokoStation_30
 .byte BANK_LEVEL_SokoStation_31
 .byte BANK_LEVEL_SokoStation_32
 .byte BANK_LEVEL_SokoStation_33
 .byte BANK_LEVEL_SokoStation_34
 .byte BANK_LEVEL_SokoStation_35
 .byte BANK_LEVEL_SokoStation_36
 .byte BANK_LEVEL_SokoStation_37
 .byte BANK_LEVEL_SokoStation_38
 .byte BANK_LEVEL_SokoStation_39
 .byte BANK_LEVEL_SokoStation_40
 .byte BANK_LEVEL_SokoStation_41
 .byte BANK_LEVEL_SokoStation_42
 .byte BANK_LEVEL_SokoStation_43
 .byte BANK_LEVEL_SokoStation_44
 .byte BANK_LEVEL_SokoStation_45
 .byte BANK_LEVEL_SokoStation_46
 .byte BANK_LEVEL_SokoStation_47
 .byte BANK_LEVEL_SokoStation_48
 .byte BANK_LEVEL_SokoStation_49
 .byte BANK_LEVEL_SokoStation_50
 .byte BANK_LEVEL_SokoStation_51
 .byte BANK_LEVEL_SokoStation_52
 .byte BANK_LEVEL_SokoStation_53
 .byte BANK_LEVEL_SokoStation_54
 .byte BANK_LEVEL_SokoStation_55
 .byte BANK_LEVEL_SokoStation_56
 .byte BANK_LEVEL_SokoStation_57
 .byte BANK_LEVEL_SokoStation_58
 .byte BANK_LEVEL_SokoStation_59
 .byte BANK_LEVEL_SokoStation_60
 .byte BANK_LEVEL_SokoStation_61
 .byte BANK_LEVEL_SokoStation_62
 .byte BANK_LEVEL_SokoStation_63
 .byte BANK_LEVEL_SokoStation_64
 .byte BANK_LEVEL_SokoStation_65
 .byte BANK_LEVEL_SokoStation_66
 .byte BANK_LEVEL_SokoStation_67
 .byte BANK_LEVEL_SokoStation_68
 .byte BANK_LEVEL_SokoStation_69
 .byte BANK_LEVEL_SokoStation_70
 .byte BANK_LEVEL_SokoStation_71
 .byte BANK_LEVEL_SokoStation_72
 .byte BANK_LEVEL_SokoStation_73
 .byte BANK_LEVEL_SokoStation_74
 .byte BANK_LEVEL_SokoStation_75
 .byte BANK_LEVEL_SokoStation_76
 .byte BANK_LEVEL_SokoStation_77
 .byte BANK_LEVEL_SokoStation_78
 .byte BANK_LEVEL_SokoStation_79
 .byte BANK_LEVEL_SokoStation_80
 .byte BANK_LEVEL_SokoStation_81
 .byte BANK_LEVEL_SokoStation_82
 .byte BANK_LEVEL_SokoStation_83
 .byte BANK_LEVEL_SokoStation_84
 .byte BANK_LEVEL_SokoStation_85
 .byte BANK_LEVEL_SokoStation_86
 .byte BANK_LEVEL_SokoStation_87
 .byte BANK_LEVEL_SokoStation_88
 .byte BANK_LEVEL_SokoStation_89
 .byte BANK_LEVEL_SokoStation_90
 .byte BANK_LEVEL_SokoStation_91
 .byte BANK_LEVEL_SokoStation_92
 .byte BANK_LEVEL_SokoStation_93
 .byte BANK_LEVEL_SokoStation_94
 .byte BANK_LEVEL_SokoStation_95
 .byte BANK_LEVEL_SokoStation_96
 .byte BANK_LEVEL_SokoStation_97
 .byte BANK_LEVEL_SokoStation_98
 .byte BANK_LEVEL_SokoStation_99
; .byte BANK_LEVEL_SokoStation_100
; .byte BANK_LEVEL_SokoStation_101
; .byte BANK_LEVEL_SokoStation_102
 .byte BANK_LEVEL_SokoStation_103
 .byte BANK_LEVEL_SokoStation_104
#if 0
 .byte BANK_LEVEL_SokoStation_105
 .byte BANK_LEVEL_SokoStation_106
 .byte BANK_LEVEL_SokoStation_107
 .byte BANK_LEVEL_SokoStation_108
 .byte BANK_LEVEL_SokoStation_109
#endif


    IF (* - LevelInfoBANK != MAX_LEVEL)
        ECHO "ERROR: Incorrect LevelInfoBANK table!"
        ERR
    ENDIF


    DEFINE_SUBROUTINE GetLevelAddress
    ; returns address,bank of level #
    ; Uses overlay LevelLookup
    ; relies on tables being page-aligned

                clc
                lda levelX
                sta levelTable
                lda levelX+1
                adc #>LevelInfoLO
                sta levelTable+1

                ldy #0
                lda (levelTable),y
                sta Board_AddressR

                lda levelX+1
                adc #>LevelInfoHI
                sta levelTable+1

                lda (levelTable),y
                sta Board_AddressR+1

                lda levelX+1
                adc #>LevelInfoBANK
                sta levelTable+1

                lda (levelTable),y
                sta LEVEL_bank

                rts


   CHECK_BANK_SIZE "LEVELS_TABLES -- full 2K"

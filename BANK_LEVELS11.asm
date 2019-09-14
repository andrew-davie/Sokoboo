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

  NEWBANK LEVELS11

 ;Scoria 3 2009-09-2020  Thomas Reinke
 DEFL Scoria_3_5, "|2 4#|2 #2 3#|3#-*.-4#|#2 .-#-$2 #|#2 *2 $3 #|3#*-6#|2 #-@#|2 #2 #|2 4#"
 DEFL Scoria_3_6, "|2 4#|2 #@-#|2 #$.6#|2 #.$2#3 #|2 #-$3 $-#|3#.2 .#-2#|#2 .#$2#-#|#-#3 #2 #|#-5#-2#|#7 #|9#"
 DEFL Scoria_3_7, "|4#|#2 #-4#|#2 3#2 #|#2 #4 #|2#2 .2*-#|#-$-2$@2#|#2 #2.2#|#2 #2 #|7#"
 DEFL Scoria_3_8, "|2 5#|-2#3 #|2#4 #|#-.-*4#|#2 *$@$-#|3#2 2.-#|2 2#$-3#|3 #2 #|3 4#"
 DEFL Scoria_3_9, "|-5#|2#3 2#|#3 $-2#|#-#$#2 2#|#2 $@#.-#|2#.*.$2 #|-#2 2#.-#|-#3 #-2#|-3#3 #|3 5#"
 DEFL Scoria_3_10, "|3 6#|2 2#4 #|3#@*3 #|#-2$*$3#|#-3.-#|2#3 2#|-2#2 #|2 #2 #|2 4#"
 DEFL Scoria_3_11, "|-5#|2#3 #|#2 #.3#|#-2*2.-#|#4 #-#|#-2#-$-#|#3 2$2#|3#2 @#|2 5#"
 DEFL Scoria_3_12, "|4#|#2 4#|#2 $2 #|#2 #.$2#|2#-#-$-#|#2 .-#.#|#2 .$-@#|3#*2#-#|2 #4 #|2 6#"
 DEFL Scoria_3_13, "|2 4#|2 #2 5#|-2#2 #@2 #|-#-2*2.#-#|2#4 2$-#|#-.$#2 3#|#3 #2 #|8#"
 DEFL Scoria_3_14, "|2 4#|-2#2 #|-#-.-#|2#-$*4#|#2 2.3 #|#2 3$2 #|4#.-3#|3 #@-#|3 4#"
 DEFL Scoria_3_15, "|5#|#3 4#|#-#-#2 #|#4 $-#|3#*#.-2#|-#-*-$*-#|-#2 .-#@#|-4#3 #|4 5#"
 DEFL Scoria_3_16, "|2 5#|3#3 #|#-$-#$2#|#-$2.*@#|#3 .$-#|3#-.3#|2 #2 #|2 #2 #|2 4#"
 DEFL Scoria_3_17, "|3 4#|3 #2 4#|-3#3 $@#|-#3 #$2 #|2#-#-$-3#|#-2.*2.#|#2 $-#-#|4#3 #|3 5#"
 DEFL Scoria_3_18, "|10#|#8 #|#-6#-#|#-#4 #-2#|#-#-#.$#2 #|#-*.@2.3 #|2#$#-$-#2 #|-#-3#-$-2#|-#5 3#|-7#"
 DEFL Scoria_3_19, "|3 4#|3 #2 #|2 2#.$3#|3#-*-.-#|#2 @*$.-#|#3 $-#-#|5#3 #|4 5#"

 ;Sokompact 2005-10-0251  François Marques
 DEFL Sokompact_0, "6#|#4 #|#-$-$2#|#-#@$-#|#-*-#-#|2#-2.-#|-#2 .2#|-5#"
 DEFL Sokompact_1, "|-5#|-#3 #|2#*$@4#|#-.*$3 #|#2 .*$2 #|2#-#.-3#|-#4 #|-6#"
 DEFL Sokompact_2, "|2 5#|-2#3 #|-#2 #-#|2#$2.$#|#-.2$.2#|#-$2.$-#|2#-#@2 #|-#3 3#|-5#"
 DEFL Sokompact_3, "|2 5#|2 #@2 2#|3#.3 #|#-$*$2 #|#2 .-3#|2#-*-#|-#2 2#|-4#"
 DEFL Sokompact_4, "|2 4#|-2#2 #|-#-$-#|2#-*-#|#-2.@2#|#2 *2 #|3#$2 #|2 #2 2#|2 4#"
 DEFL Sokompact_5, "|3 4#|-3#2 #|2#-2$-3#|#-4.2 #|#2 2$3 #|3#-@4#|2 4#"
 DEFL Sokompact_6, "|-6#|-#4 #|2#-2#-#|#2 $.-#|#-3*.#|2#-$@-#|-#3 2#|-5#"
 DEFL Sokompact_7, "|-5#|-#3 3#|2#-2$2 #|#-*-.*.#|#.*.-*-#|#-@2$-2#|3#3 #|2 5#"
 DEFL Sokompact_8, "|2 4#|3#.-#|#-$-.2#|#-#-2.#|#-@-#-#|#-3$-#|2#3 2#|-#2 2#|-4#"
 DEFL Sokompact_9, "|-6#|-#4 #|-#2$@-#|-#2.3#|2#.*2 #|#2 $2 #|#2 #-2#|2#3 #|-5#"
 DEFL Sokompact_10, "|2 4#|-2#@-#|-#-$-#|2#-*-#|#2 2.#|#2 *-#|3#$-#|2 #2 #|2 4#"
 DEFL Sokompact_11, "|2 5#|3#3 #|#2 @#-#|#-#3.2#|#-$.$.-#|2#3$#-#|-#5 #|-7#"
 DEFL Sokompact_12, "|3 #|2 2#|-#2 #|-#-$-#|#-.$.#|#-$.$-#|#-.$.-#|3#@3#|-#2 #|-#2 #|-#2 #|-4#"
 DEFL Sokompact_13, "|2 4#|-2#2 #|-#-.-2#|2#-*2 2#|#-*$*2 #|#2 *3 #|#2 @4#|5#"
 DEFL Sokompact_14, "|-5#|-#3 #|2#-*$3#|#-*@*2 #|#-.*3 #|2#3 3#|-#2 2#|-4#"
 DEFL Sokompact_15, "|-5#|-#-.-2#|2#-$2 #|#-*-*-2#|#-3*2 #|#2 @3 #|8#"
#if 0
 DEFL Sokompact_16, "|-5#|-#3 4#|-#-#4 #|-#2$2.2 #|2#-2*-3#|#-2.2$#|#2 #2 #|2#-@-2#|-5#"
 DEFL Sokompact_17, "|2 4#|2 #2 3#|-2#4 #|2#-$.$-2#|#-.3*.-#|#2 $.$2 #|3#-@-3#|2 #2 2#|2 4#"
 DEFL Sokompact_18, "|2 5#|3#3 4#|#-.$.$@2 #|#2 $.$.2 #|3#-#-4#|2 #3 #|2 5#"
 DEFL Sokompact_19, "|-4#|-#2 #|-#2 2#|-#-.-2#|-#$*2 2#|2#-2*2 #|#3 *$-#|#-@-.3#|3#2 #|2 4#"
 DEFL Sokompact_20, "|2 5#|-2#-@-2#|2#-$.$-2#|#-.3*.-#|#2 $.$2 #|2#5 2#|-3#2 2#|3 4#"
 DEFL Sokompact_21, "|2 4#|-2#2 #|2#-.-3#|#-$2 $-#|#-2.$2 #|5#@-#|4 4#"
 DEFL Sokompact_22, "|-6#|2#4 2#|#3 #.-2#|#-#-@*$-#|#2 .*3 #|4#$-3#|3 #2 #|3 4#"
 DEFL Sokompact_23, "|7#|#2 #2 2#|#2 #3 #|#-.*$#-#|#2 *@2 #|#-.*$3#|2#-#-#|-#3 #|-5#"
 DEFL Sokompact_24, "|2 4#|-2#2 #|2#3 #|#-$-$2#|#-3.-#|#-$.$-#|2#@.$2#|-2#2 #|2 4#"
 DEFL Sokompact_25, "|2 5#|2 #3 #|2#@-#-2#|#2 2$2.2#|#-#.2$.-#|#2 2.2$-#|4#2 3#|3 #2 #|3 4#"
 DEFL Sokompact_26, "|2 5#|2 #3 2#|3#.3 #|#-$2*2 #|#-*@*.2#|#2 *$-#|2#4 #|-6#"
 DEFL Sokompact_27, "|2 4#|-2#-@3#|2#-3$.#|#2 .$2.3#|#2 2.$.2 #|3#.3$2 #|2 #3 4#|2 5#"
 DEFL Sokompact_28, "|3 4#|3 #2 #|2 2#$-3#|3#2 .2 #|#-.*$*2 #|#-#-@-3#|#3 3#|5#"
 DEFL Sokompact_29, "|-5#|-#3 #|-#-#-#|2#2.$3#|#-$*$2 #|#-$2.2 #|#2 @4#|2#2 #|-4#"
 DEFL Sokompact_30, "|4 3#|2 2#2 #|-#-$2 #|#-.*-.#|#2 $2 #|3#@#*#|2 #3 #|2 5#"
 DEFL Sokompact_31, "|4 4#|5#2 #|#2 2#2 #|#3 $*.#|#2 #*@*2#|2#2 .*$-#|-2#-#3 #|2 #3 3#|2 5#"
 DEFL Sokompact_32, "|2 4#|-2#2 2#|-#4 #|2#*$*-2#|#-.@.2 #|#-*$*2 #|#3 4#|5#"
 DEFL Sokompact_33, "|-5#|-#3 3#|2#-*.*-2#|#2 $*$2 #|#2 *.*2 #|3#-@2 2#|2 #2 3#|2 4#"
 DEFL Sokompact_34, "|2 4#|3#2 #|#-$2 3#|#@#.$2 #|#-$-$#-#|2#-.-2.#|-#2 4#|-4#"
 DEFL Sokompact_35, "|-4#|2#2 4#|#-.2$2 #|#-.@.2 #|#-2$.-2#|3#2 2#|2 4#"
 DEFL Sokompact_36, "|5#|#3 #|#3 #|#*+*#|#3 #|#*$*4#|#6 #|#2 #3 #|8#"
 DEFL Sokompact_37, "|2 4#|2 #2 #|3#2 2#|#2 2$-#|#-#*.-#|#-.-.-#|2#$#@2#|-#3 #|-5#"
 DEFL Sokompact_38, "|2 5#|3#-@-3#|#2 .$.2 #|#2 3*2 #|3#$.$3#|2 #3 #|2 #3 #|2 #2 2#|2 5#"
 DEFL Sokompact_39, "|3 2#|2 #2 #|-2#.-#|-#-.-#|2#$.$3#|#@$.$2 #|#-$.3 #|3#2 3#|2 4#"
 DEFL Sokompact_40, "|2 4#|2 #2 #|3#2 #|#-2$-3#|#.-.$.-#|#-.*.2 #|2#$-$3#|-#-@-#|-5#"
 DEFL Sokompact_41, "|-5#|-#-@-#|2#$-$#|#2 $-3#|#-.*.2 #|2#.*.2 #|-#-$-3#|-#-*-#|-#2 2#|-4#"
 DEFL Sokompact_42, "|-4#|-#-@#|-#2 #|2#2$3#|#5 #|#-#3 #|#.*.*2#|2#3 #|-#2 2#|-4#"
 DEFL Sokompact_43, "|3#|#2 4#|#-$@$2 #|#-$#3.#|#2 3*-#|#5 #|4#2 #|4 2#"
 DEFL Sokompact_44, "|3#|#2 6#|#4 $3 #|#2 2*.2*2 #|#3 *@*3 #|10#"
 DEFL Sokompact_45, "|2 4#|2 #2 #|3#2 3#|#3 2$-#|#+2*3.#|#3 2$-#|3#2 3#|2 #2 #|2 4#"
 DEFL Sokompact_46, "|3 4#|3 #2 4#|2 #2 *3 #|3#@*.*2 #|#2 *-$-*-#|#3 2#2 2#|4#-#2 #|5 4#"
 DEFL Sokompact_47, "|3 3#|2 #-@-#|-#-.#.-#|-#2$*2$#|#2 *-*2 #|#3 .3 #|4#.-3#|3 #2 #|3 4#"
 DEFL Sokompact_48, "|-4#|-#2 6#|-#7 #|-#-$@#$#-#|2#.*2.*.-#|#2 *2 *-2#|#-#$2#$2#|#6 #|8#"
 DEFL Sokompact_49, "|-4#|-#2 6#|-#-$3 $-#|-#3 #-#-#|2#3*.2*@#|#2 .2 .-2#|#-#-2#$2#|#6 #|8#"
 DEFL Sokompact_50, "|3 3#|2 #-@-#|-#-$#$-#|-#-.*.-#|#2 *.*2 #|#2 $-$2 #|4#.-3#|3 #2 #|3 4#"
#endif

   CHECK_BANK_SIZE "LEVELS11 -- full 2K"

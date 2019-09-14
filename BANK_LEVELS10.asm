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

  NEWBANK LEVELS10

 DEFL Zone_26_100, "|3 4#|2 2#2 #|3#-.-#|#-$-$.#|#.*3 #|#3 *-#|3#.$2#|2 #$-#|2 #@-#|2 4#"
 DEFL Zone_26_101, "|4#|#@-5#|#.$-.2 #|#-$*.*-#|2#-$2 2#|-#-$-2#|-#-.-#|-#2 2#|-4#"
 DEFL Zone_26_102, "|3 5#|4#.2 #|#-+$.$-#|#-$-2.2#|3#2$-#|2 #-$.#|2 #3 #|2 #3 #|2 5#"
 DEFL Zone_26_103, "|4#|#2 3#|#-$2 #|#2 .$3#|2#$.$.@#|-#.2 $-#|-#-*-3#|-#-.-#|-5#"
 DEFL Zone_26_104, "|2 4#|2 #-@3#|2 #2$2 #|-2#.*2 #|-#-*-*2#|2#-*.-#|#5 #|#3 3#|5#"
 DEFL Zone_26_105, "|4#|#2 2#|#-.-3#|#3 $-#|2#.$2.#|-#-*$@#|-#-.$-#|-#-$3#|-#2 #|-4#"
 DEFL Zone_26_106, "|-4#|-#2 #|2#-$4#|#-.2 $@#|#2 2*-.#|#-*-*2 #|3#2 3#|2 #2 #|2 4#"
 DEFL Zone_26_107, "|2 4#|2 #2 #|3#2 3#|#-$.-$-#|#2 *-.-#|#-$*-3#|2#-.$#|-#-.@#|-5#"
 DEFL Zone_26_108, "|2 4#|3#@-#|#.-2$#|#.-*-3#|2#$.$.-#|-#-*3 #|-#3 3#|-#3 #|-5#"
 DEFL Zone_26_109, "|-4#|-#2 #|-#.-#|-#$-#|2#.-4#|#-*-$@-#|#-*$*2 #|#3 .2 #|8#"

 DEFL Zone_26_110, "|2 4#|2 #2 2#|3#-.-#|#-$*2 2#|#2.-.$-#|#-$*-$@#|3#2 3#|2 #2 #|2 4#"
 DEFL Zone_26_111, "|3 5#|-3#-.-#|2#-$3 #|#-.2 *2#|#3 *-#|3#.$-#|2 #$*-#|2 #-@2#|2 4#"
 DEFL Zone_26_112, "|2 4#|2 #2 3#|2 #$3 #|2 #-.-.#|3#$.-2#|#2 $*-#|#@*-.$#|3#3 #|2 5#"
 DEFL Zone_26_113, "|2 4#|2 #2 #|3#2 3#|#@$2 $-#|#.2*$2.#|#2 $3 #|#.-5#|#2 #|4#"
 DEFL Zone_26_114, "|4#|#2 #|#2 3#|#-$2 2#|#.-2*-#|#-$.*@#|2#3 2#|-#-*-#|-#2 2#|-4#"
 DEFL Zone_26_115, "|2 6#|2 #2 *-#|3#.*2 2#|#2 *-.2 #|#2 $.$2 #|3#-$4#|2 #@-#|2 4#"
 DEFL Zone_26_116, "|4#|#2 4#|#2 $2 #|#.$2.-#|#-*-$.#|#$-*$-#|#2 .@2#|6#"

 ;Rectangled 2014-04-1311  Dries de Clercq
 DEFL Rectangled_0, "6#|#-.*@#|#-.*$#|#2 $-#|#*2$.#|#4 #|#-*.-#|#-2*-#|6#"
 DEFL Rectangled_1, "|6#|#2 @-#|#$2*$#|#.-$.#|#.2$.#|#*$-*#|#-2.-#|#4 #|6#"
 DEFL Rectangled_2, "|6#|#-@2 #|#*2$*#|#*-$.#|#-.*-#|#*-$.#|#.2 *#|#4 #|6#"
 DEFL Rectangled_3, "|6#|#@2.-#|#*2$*#|#2 $-#|#-2*-#|#2 $-#|#.2$.#|#-2.-#|6#"
 DEFL Rectangled_4, "|6#|#.-$+#|#-2*$#|#2 $-#|#*-$.#|#4 #|#$*.$#|#.2 .#|6#"
 DEFL Rectangled_5, "|6#|#-2.@#|#*2$*#|#2 $-#|#.2$.#|#2 $-#|#.2$.#|#-2.-#|6#"
 DEFL Rectangled_6, "|6#|#4 #|#.2$*#|#.$-*#|#.$-.#|#.2$.#|#+$-*#|#4 #|6#"
 DEFL Rectangled_7, "|6#|#+-$.#|#*-$.#|#-$-$#|#-*.-#|#-2$-#|#.$-*#|#.2 .#|6#"
 DEFL Rectangled_8, "|6#|#+-$.#|#*-$.#|#-$-$#|#.$-.#|#-2$-#|#.$-*#|#.2 .#|6#"
 DEFL Rectangled_9, "|6#|#.2 .#|#-$-$#|#.$-.#|#.2$.#|#.$-*#|#$-$-#|#+$-.#|6#"
 DEFL Rectangled_10, "|6#|#.2 .#|#2 $-#|#.2$.#|#-*.-#|#*-$.#|#-3$#|#.-$+#|6#"

 ;Scoria 3 2009-09-2020  Thomas Reinke
 DEFL Scoria_3_0, "2 4#|2 #2 #|-2#2 #|2#2 .#|#-*-*2#|#@#$*-3#|#-*5 #|4#4 #|3 6#"
 DEFL Scoria_3_1, "|2 4#|3#2 #|#2 .-2#|#-#2 @2#|#-$.#$-#|2#.2*2 #|-#-$3 #|-#2 4#|-4#"
 DEFL Scoria_3_2, "|-7#|-#3 @-2#|-#2 #$2 #|2#-$.-#-#|#-$#2 .-#|#2 2.#$2#|3#$.2 #|2 #2 3#|2 4#"
 DEFL Scoria_3_3, "|2 7#|2 #5 #|-2#-3#-#|2#4 #-#|#-$4*+#|#5 #-#|#2 2#3 #|#2 6#|4#"
 DEFL Scoria_3_4, "|9#|#7 #|#-5#-#|#-#3 #-2#|#-#-#-#2 #|#-#.-*.2 #|#-*2 $3 #|4#$*-3#|3 #@-2#|3 4#"


   CHECK_BANK_SIZE "LEVELS10 -- full 2K"

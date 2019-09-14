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

  NEWBANK LEVELS9

 DEFL Zone_26_68, "|-4#|-#-@3#|-#2*.-#|-#-$2 #|2#.#2 #|#3 $-#|#2.2$2#|#4 #|6#"
 DEFL Zone_26_69, "|4#|#2 3#|#.2 .3#|#-$#$-@#|#-$.2*-#|#4 $-#|2#-.-3#|-5#"


 DEFL Zone_26_70, "|-4#|2#@-3#|#-2*2 2#|#2 2*.-#|#-*-$2 #|2#3 3#|-2#2 #|2 #2 #|2 4#"
 DEFL Zone_26_71, "|3 4#|2 2#2 #|2 #3 2#|-2#-2*-#|2#-2.2 #|#-$-2$.#|#-.$@3#|#2 3#|4#"
 DEFL Zone_26_72, "|-4#|-#@-2#|-#-*-#|2#$.-#|#2 .$2#|#*$3 #|#-.-*-#|#4 2#|6#"
 DEFL Zone_26_73, "|2 5#|2 #3 2#|3#-.2 #|#2 $-#.#|#-$@*$-#|3#2*.-#|2 #4 #|2 6#"
 DEFL Zone_26_74, "|4#|#@-3#|#-$-.#|#-*-$2#|2#*-*-#|-#-.*-2#|-#5 #|-3#3 #|3 5#"
 DEFL Zone_26_75, "|7#|#-+-.-2#|#3 *$-#|3#$.2 #|2 #2 *-#|2 #$#$-#|2 #2 .-#|2 6#"
 DEFL Zone_26_76, "|-5#|2#3 3#|#-$#3 #|#-.*$2.#|#-$2 @-#|2#-*$3#|-#-.-#|-5#"
 DEFL Zone_26_77, "|4#|#2 4#|#2 *2 #|#-$2 .#|2#-*#-#|-#2 *-#|-#-$.$#|-2#-.@#|2 5#"
 DEFL Zone_26_78, "|3 4#|3 #2 #|4#2 2#|#3 $.-#|#2 2*2 #|#-$+$#-#|2#-*-.-#|-7#"
 DEFL Zone_26_79, "|2 5#|3#3 #|#.*2.-#|#2 $*-#|#.#3 #|#3 $-#|3#2$2#|2 #-@#|2 4#"
 DEFL Zone_26_80, "|5#|#.2 3#|#-#$2 #|#2 .-.2#|#.*-*$-#|#2 $-$@#|4#2 2#|3 4#"
 DEFL Zone_26_81, "|-6#|-#4 #|-#$*$.#|-#2 #.#|2#-*@-#|#2 *.-#|#-$2 2#|#2 3#|4#"
 DEFL Zone_26_82, "|2 4#|3#.-#|#-$2 #|#2 $-3#|#2.#3 #|#@*.2$-#|2#-*3 #|-7#"
 DEFL Zone_26_83, "|3 5#|3 #@2 #|4#2$-#|#3 .$-#|#-.$#-.#|2#$-.*-#|-#-.2 2#|-6#"
 DEFL Zone_26_84, "|5#|#-.-4#|#4 $@#|2#$-*$*#|-#-#-*-#|-#-.-.-#|-3#3 #|3 5#"
 DEFL Zone_26_85, "|2 4#|2 #2 #|3#2 3#|#2 *2$@#|#-#2 *$#|#.-2.$.#|2#5 #|-7#"
 DEFL Zone_26_86, "|2 4#|2 #2 2#|3#.$-2#|#2 *-$-#|#-$-*$@#|#-#-.-2#|#-.-.-#|7#"
 DEFL Zone_26_87, "|5#|#-+-2#|#$-$-3#|#-*2.2 #|#-$-$2 #|#.$#-3#|#-.2 #|6#"
 DEFL Zone_26_88, "|4#|#2 2#|#.$-5#|#2 2.3 #|2#-$-$2 #|-#$*.-3#|-#@*2 #|-6#"
 DEFL Zone_26_89, "|7#|#3 $.2#|#.-$2 +#|4#$.$#|3 #-*-#|3 #-*-#|3 #3 #|3 #3 #|3 5#"

 DEFL Zone_26_90, "|2 4#|2 #2 #|3#2 #|#2 *-#|#.-.-#|#-$.$2#|2#$*$-#|-#2 .@#|-3#2 #|3 4#"
 DEFL Zone_26_91, "|-7#|-#-*-.-#|-#-.3 #|-#-.$3#|2#$.-#|#.-2$#|#2 $@#|#2 3#|4#"
 DEFL Zone_26_92, "|2 4#|3#2 #|#-2$-2#|#-*3 #|#-.$#-2#|#@*.*2 #|2#3 .-#|-7#"
 DEFL Zone_26_93, "|6#|#-*2 #|#-2.$3#|#2 $3 #|2#2.$2 #|#-2$-3#|#2 +2#|5#"
 DEFL Zone_26_94, "|2 4#|2 #-@#|2 #2$#|2 #-.3#|3#$2.-#|#-$-$2 #|#2 *.-2#|#4 .#|7#"
 DEFL Zone_26_95, "|2 5#|2 #-@.#|2 #-.$#|2 #-*-#|-2#$*-2#|2#2 $2 #|#2 *.2 #|#3 4#|5#"
 DEFL Zone_26_96, "|3 4#|3 #2 #|4#$.2#|#-$4 #|#@.2*.-#|#2$4 #|#.-5#|#2 #|4#"
 DEFL Zone_26_97, "|2 4#|2 #2 #|3#-$3#|#2 $.-.#|#-.-.2 #|3#$*-$#|2 #@*2 #|2 3#2 #|4 4#"
 DEFL Zone_26_98, "|2 4#|2 #2 3#|2 #-.-.#|3#-2*-#|#-@2$.-#|#-$2 $-#|5#.-#|4 #2 #|4 4#"
 DEFL Zone_26_99, "|3 5#|-3#3 #|2#3 $-#|#-$.*-2#|#2.$.-#|#3 .2#|3#2$#|2 #-@#|2 4#"

   CHECK_BANK_SIZE "LEVELS9 -- full 2K"

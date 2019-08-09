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

  NEWBANK LEVELS3

    DEFL _034_R, "-6#3-|-#4-#3-|2#-$.-3#-|#-2$*.$@#-|#-3.#2$2#|4#.4-#|3-3#-#-#|5-#3-#|5-5#"
    DEFL _035_L, "5-3#2-|6#.2#-|#@2-2#*.#-|#-3$2.-#-|2#2-$*.$2#|-#-$2-.2-#|-5#3-#|5-5#"
    DEFL _035_R, "-11#|-#4-@4-#|-#-2$3*$#-#|3#-*.$.-$-#|#3-.*.-4#|#3-2#.2#3-|8#4-"
    DEFL _036_L, "5#2-|#3-3#|#*#-$@#|#.2-$-#|#.*2$-#|#2.#2-#|4#2-#|3-4#"
    DEFL _036_R, "2-5#2-|-2#.2-2#-|-#.*-$-2#|2#2.$-$-#|#.2*.-$@#|#2-$2-$2#|3#4-#-|2-6#-"
    DEFL _037_L, "5-6#|6#4-#|#2-#@2.2$-#|#2-$.3*.-#|#3-$.$-$-#|2#2-#.3-2#|-9#-"
    DEFL _037_R, "9#2-|#7-3#|#-$2-.2*.-#|2#-*.*$3-#|-2#-2*.#2-#|2-2#@$-$-2#|3-3#3-#-|5-5#-"
    DEFL _038_L, "6-4#2-|4-3#@-3#|3-2#2.*$2-#|4#.*.*3-#|#2-2$3-$2-#|#5-6#|3#2-2#5-|2-4#6-"
    DEFL _038_R, "6-6#|4-3#.#-@#|2-3#2.*#$-#|3#-.*2.-$-#|#2-2$2-#-3#|#-$2-#-$-#2-|2#5-3#2-|-7#4-"
    DEFL _039_L, "-7#2-|-#5-#2-|2#-#-$-#2-|#.2*.-3#-|2#@3*2-2#|-2#-2.$2-#|2-2#$#-$-#|3-#5-#|3-7#"
    DEFL _039_R, "4-4#4-|3-2#2-3#2-|2-2#-$.2-#2-|3#-.2*-$3#|#-$-4.3-#|#@$3#-#-#-#|2#4-$2-$-#|-5#3-3#|5-5#2-"
    DEFL _040_L, "6#3-|#3-@#3-|#2-$.3#-|3#$*$.2#|3#-.2*.#|#2-$-.3#|#2-$3-#-|4#3-#-|3-5#-"
    DEFL _040_R, "5-4#-|-5#2-2#|2#.-$2-$-#|#-2.*.$#@#|#-*-.2-$-#|2#-$*-4#|-#3-2#3-|-5#4-"

    DEFL _041_L, "4-3#5-|4-#.4#2-|5#*.$-#2-|#4-3.-3#|#-3$-*.$2-#|2#-@2#.$-$-#|-5#4-2#|5-6#-"
    DEFL _041_R, "-4#3-|2#2-3#-|#-@2$-#-|#-$-#.#-|2#$-2.2#|#2-$*2.#|#2-$-*2#|#3-#.#-|7#-"
    DEFL _042_L, "8#4-|#6-#4-|#-#-$*-#4-|#-#-#.3#3-|#3-#2.-3#-|#3-2*4-2#|5#.-3$-#|4-4#2-@#|7-5#"
    DEFL _042_R, "3-5#4-|2-2#3-#4-|2-#-$-$#4-|3#-*.-2#3-|#@$-#.$-2#2-|#-$2-.*.-3#|3#2.*-$3-#|2-6#3-#|7-5#"
    DEFL _043_L, "-8#4-|-#@$.-.-5#|-#2$*.2*.3-#|2#2-$-.2-#$-#|#-$-2#.#3-2#|#3-8#-|#2-2#8-|4#9-"
    DEFL _043_R, "2-6#-|-2#4-#-|2#@$-#-#-|#-$#$2.#-|#*.*2.*2#|#-$2-$2.#|#-$-$2-2#|#4-3#-|6#3-"
    DEFL _044_L, "7#-|#@4-#-|#$-.2$#-|#3.*-2#|#*$2*2-#|#3-#2-#|#3-#2-#|8#"
    DEFL _044_R, "4#-4#-|#2-3#2-#-|#@$2-#-$2#|#$*$5-#|#-*2.$2#-#|#3.#4-#|2#-.-$4#|-3#2-#3-|3-4#3-"
    DEFL _045_L, "3-4#2-|3-#2.3#|4#$.$-#|#@-#-.*-#|#-$2-2*.#|2#-$-*2-#|-2#-$3-#|2-2#2-3#|3-4#2-"
    DEFL _045_R, "3-6#2-|4#4-#2-|#-$-$2#-3#|#-2$-$-$2-#|#-5.#$-#|#-.*#$2.2-#|2#.-$@5#|-6#4-"
    DEFL _046_L, "10#-|#@3-#3-2#|#-#*$2-2$-#|#-*.$-$3-#|3#.*$-#2-#|2-#.*.-4#|2-#2.-2#3-|2-5#4-"
    DEFL _046_R, "8#3-|#3-4#3-|#-$2-$@3#-|#2-5$-#-|3#3.*2.2#|2-2#2-$3.#|3-#2-5#|3-4#4-"
    DEFL _047_L, "5-3#5-|3-3#.#5-|2-2#2-.#5-|2-#-$#.6#|3#3-.2#3-#|#-$@2*.$-$#-#|#4-2#-$3-#|8#3-2#|7-5#-"
    DEFL _047_R, "4-6#|3-2#3-@#|-3#-3$-#|-#.2-#-$-#|2#.*2-$2-#|#2.-2$#-2#|2#2.#-3#-|-#.3-#3-|-6#3-"



  CHECK_BANK_SIZE "LEVELS3 -- full 2K"

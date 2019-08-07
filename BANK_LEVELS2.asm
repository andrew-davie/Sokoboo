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

  NEWBANK LEVELS2

    DEFL _020_L, "-6#-|-#4-#-|-#-2$-#-|2#-.$3#|#@$.3-#|3#*.*$#|#4-2.#|#3-4#|5#3-"
    DEFL _020_R, "5-4#|6#2-#|#3-#3-#|#-#$.*$-#|#2-3.-2#|#-2$*2-#-|2#@$.-2#-|-6#2-"
    DEFL _021_L, "4-4#3-|4-#2-#3-|5#-$2#2-|#@$3.*.#2-|2#-#-$2.3#|-#-#2$*-$-#|-#-$2-.3-#|-4#-*2-2#|4-6#-"
    DEFL _021_R, "-4#3-|2#@-4#|#-3$2-#|#.*.$2-#|#-.*2-2#|2#.3-#-|-6#-"
    DEFL _022_L, "3-3#2-|3-#@2#-|2-2#$-2#|3#2.*-#|#2-2$.*#|#-#$-.-#|#3-$.-#|2#4-2#|-6#-"
    DEFL _022_R, "-3#4-|-#@2#3-|2#$-4#|#2-2$2-#|#-$.*$-#|#2-3.-#|4#.3#|3-3#2-"
    DEFL _023_L, "6#3-|#4-2#2-|#-$-$-2#-|2#-$.$+2#|-#-2.*.-#|-2#$#-#-#|2-#5-#|2-7#"
    DEFL _023_R, "7#2-|#5-#2-|#2-#2$#2-|#-$-$.3#|2#+2*.*.#|-2#3-3#|2-#2-2#2-|2-4#3-"
    DEFL _024_L, "-9#|-#7-#|-#-#2-$#-#|-#-#.*.#-#|2#2-.*-#-#|#3-.2$2-#|#-$2#2-3#|2#@2#2-#2-|-7#2-"
    DEFL _024_R, "-8#|2#6-#|#-$-*-#-#|#-3.*$-#|#2-*.*.2#|#2-#$-$-#|4#-$2-#|3-2#@3#|4-3#2-"
    DEFL _025_L, "4-4#2-|5#@-2#-|#4-2$-2#|#-3#2-$-#|#-3.2*.-#|#-2$*$2.2#|2#6-#-|-8#-"
    DEFL _025_R, "-6#-|2#.-$-#-|#.*$*-2#|#.*2.$-#|2#3-#@#|-#-$-$-#|-3#2-2#|3-4#-"
    DEFL _026_L, "-6#2-|2#-3.3#|#-$-2*.-#|#2-$-2*-#|#-$-$.$-#|#2-#-@2-#|9#"
    DEFL _026_R, "5-4#|4-2#2-#|-4#3-#|2#2.-$2-#|#.3*$-2#|2#.$-$-#-|-3#-@2#-|3-4#2-"
    DEFL _027_L, "8#-|#3-@2-#-|#-*4$2#|2#*.#3-#|-#3.$2-#|-3#*.$-#|3-#.4#|3-3#3-"
    DEFL _027_R, "7#2-|#5-2#-|#$2*-$-#-|#-*2.2-2#|#2.*3$-#|3#.#3-#|2-4#-@#|5-4#"
    DEFL _028_L, "3-3#4-|4#.#4-|#-$-.#4-|#@#.*5#|#-$.*.3-#|#-2$-*$#-#|#2-#-.$2-#|4#4-2#|3-6#-"
    DEFL _028_R, "9#-|#4-2#@#-|#-2#$#-$2#|#-.-.2$2-#|#-.*.2-#-#|#-#.#$3-#|#-#2*3-2#|#4-4#-|6#4-"
    DEFL _029_L, "-5#3-|-#-@-2#2-|2#$*$-3#|#2.*.$2-#|#.*.$3-#|2#2-$-3#|-3#2-#2-|3-4#2-"
    DEFL _029_R, "-4#4-|-#@-4#-|2#$-$2-2#|#2.3$2-#|#.2*.*$-#|3#2-2.-#|2-#2-$.2#|2-6#-"
    DEFL _030_L, "6-5#|5#-#2-@#|#3-3#2$-#|#2-$-2.-$2#|3#-.*.*-2#|2-3#-.$2-#|4-#3-#-#|4-2#4-#|5-6#"
    DEFL _030_R, "-7#2-|2#-$2-.#2-|#-$-$#.#2-|#-#.$2.#2-|#-#3.$2#-|#2-$#*2-2#|3#2-*2$-#|2-#@5-#|2-8#"
    DEFL _031_L, "-7#2-|-#3-@-3#|-#-2$*2$-#|3#2-*.2-#|#2.2*.*2-#|#$#2-.2-2#|#3-5#-|5#5-"
    DEFL _031_R, "6#-|#2-#+#-|#2-$.2#|#2-2*.#|#-$-.$#|#-$-*.#|#-2$.-#|#-$-.-#|7#"
    DEFL _032_L, "-4#2-|-#2-3#|2#2-2.#|#@2$*.#|#-$2-.#|#-$-#*#|3#3-#|2-5#"
    DEFL _032_R, "9#-|#7-2#|#-$3#-$@#|#2-2.#.$-#|#-.*.2*$-#|#-$.*2-$-#|#2-#.$-3#|8#2-"
    DEFL _033_L, "2-7#-|-2#2-#2-2#|-#2-.*-$-#|-#-$.$-$@#|2#$-2*-3#|#2-$*.*.#-|#3-2.3#-|7#3-"
    DEFL _033_R, "-7#2-|2#2-#@-2#-|#-$-#3-2#|#-$2-$*$-#|#2-*.*.2-#|2#.*2.-$-#|-9#"
    DEFL _034_L, "5-4#-|-5#2-#-|-#-$@$2-#-|2#-#*$.*2#|#3-.2*2.#|#2-$2-4#|4#2-#3-|3-#2-#3-|3-4#3-"

  CHECK_BANK_SIZE "LEVELS2"

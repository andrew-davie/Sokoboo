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

  NEWBANK LEVELS4

    DEFL _048_L, "2-7#-|2-#5-2#|3#$2-#2-#|#-$.3-$-#|#.2*2-4#|#+.#-2#3-|2#$3-#3-|-#4-#3-|-6#3-"
    DEFL _048_R, "5-5#|2-4#3-#|3#-.$-$-#|#2-*3.3#|#2-*.-4#|2#2$*$3-#|-#@$.4-#|-4#2-3#|4-4#2-"
    DEFL _049_L, "4#7-|#2-4#4-|#2-$2-5#|#-$-#-4.#|2#-2$-.-.2#|-#$-#-*#-#-|-#-@#$-#-#-|-4#4-#-|4-6#-"
    DEFL _049_R, "8#2-|#6-3#|#-$2#$.*-#|#-$-$2.*+#|#3-#2.$-#|#-2$#-.3#|2#5-#2-|-7#2-"

    DEFL _050_L, "4-5#3-|4-#-@-#3-|4-#$.$2#2-|-4#-*2-#2-|2#4-*.*3#|#2-$-#2.-$-#|#3-3#4-#|5#-6#"
    DEFL _050_R, "8#|#4-@-#|#2-$*2$#|#-$*2.-#|#*2.$*.#|#2-*#2-#|#-$.3-#|8#"
    DEFL _051_L, "-6#4-|-#2-@-#4-|-#$-*-2#3-|2#-3*.#3-|#2-.*.-#3-|#-#2$2.4#|#4-$-$2-#|3#2-2#3-#|2-9#"
    DEFL _051_R, "-8#-|-#3-#2-#-|2#$-.$2-2#|#-$.*#$2-#|#-*.3-#-#|#3.#$3-#|3#-$@4#|2-#2-2#3-|2-4#4-"
    DEFL _052_L, "5#6-|#.*.2#5-|#@*2.6#|#-*-2$4-#|2#-$3-$2-#|-3#2-5#|3-4#4-"
    DEFL _052_R, "2-7#|2-#4-@#|2-#-2$2-#|4#*.$-#|#3.*.$2#|#-#-#2-#-|#2-$3-#-|5#2-#-|4-4#-"
    DEFL _053_L, "6#6-|#4-4#3-|#2-2$-$-#3-|#2-#-#.-2#2-|2#$#-$.*.3#|-#@$2-.#2.-#|-4#6-#|4-4#2-2#|7-4#-"
    DEFL _053_R, "5-5#|3-3#3-#|-3#3-#-#|2#.$.*2$-#|#2.*3.#-#|2#2$-.-$-#|-#-2$5#|-#@2-#4-|-5#4-"
    DEFL _054_L, "-8#2-|2#@-.*.-#2-|#-2$#*2-3#|#3-$2.*2-#|3#2-$.$2-#|-#-$-#.4#|-#3-3#3-|-5#5-"
    DEFL _054_R, "2-4#5-|3#2-6#|#-$-.#.-$-#|#2-$3.2$@#|#2-.*$.-$-#|3#$.-5#|2-#3-#4-|2-5#4-"
    DEFL _055_L, "2-4#6-|2-#2-2#5-|3#2.-#-4#|#-$.*-#-#2-#|#-$*.*3#$-#|#2-$3.4-#|#3-2$#$3-#|4#-@#2-3#|3-7#2-"
    DEFL _055_R, "5-4#2-|5-#2-#2-|-5#2-2#-|-#2-$2-$-2#|2#$-.#4-#|#3-*#$#$-#|#2-*2.-$@2#|2#3.-4#-|-6#4-"
    DEFL _056_L, "6-5#-|6-#3-#-|-6#$#-#-|2#.*.#2-#-2#|#2-3.*@$2-#|#2-*.#-2$2-#|#-2$-3#3-#|#2-3#-#3-#|4#3-5#"
    DEFL _056_R, "-4#-6#-|-#2-#-#4-#-|-#2-3#-2#$2#|-#$2-@#-2#2-#|2#-2$4.3-#|#2-#3-2.4#|#2-2$5#3-|#4-#7-|6#7-"
    DEFL _057_L, "5-6#|4#-#-.2-#|#2-#-#-2.-#|#2-3#2*.-#|#-$-#-*-$2#|#-$-@*.2-#-|#-2$-2#2-#-|#4-5#-|6#5-"
    DEFL _057_R, "5#4-|#3-3#2-|#+2.2-3#|#.#*$-$-#|#.#.-#$-#|#-$2-$2-#|2#$2#3-#|-#5-2#|-7#-"
    DEFL _058_L, "-6#4-|-#-3.5#|-#-#.*2#2-#|2#-.*$4-#|#-2$*-$-$-#|#@2-2#4-#|7#3-#|6-5#"
    DEFL _058_R, "4-5#-|3-2#3-#-|4#-.#$#-|#-$2-.#-#-|#@-3*.-2#|#-$.2-*2-#|3#*$#3-#|2-#4-3#|2-6#2-"
    DEFL _059_L, "6#5-|#4-#5-|#-$#-5#-|#4-.-$@#-|#-#-2*-#$2#|#-$.*-$3-#|2#$#.-2#2-#|-#-3.2#2-#|-10#"
    DEFL _059_R, "7-3#-|8#.#-|#4-#-2.2#|#-#-2$*.$-#|#5-2.#-#|2#2-2#-2#-#|#2-$-2$2#-#|#3-2#3-@#|11#"

    CHECK_BANK_SIZE "LEVELS4 -- full 2K"

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

  NEWBANK LEVELS5

    DEFL _060_R, "3-6#3-|3-#2.$-#3-|4#.*2-2#2-|#2-2$*3-3#|#3-.+#3$-#|5#.*4-#|4-4#3-#|7-5#"
    DEFL _061_L, "10#-|#2-#2-@2-#-|#2-#-$-#*2#|#-$-#2*-2.#|#4-$.*.$#|4#-2.$2-#|3-3#-$2-#|5-2#3-#|6-5#"
    DEFL _061_R, "4-5#4-|3-2#.2-#4-|4#.*#-4#-|#3-3.2-$@2#|#2-$-$.4$-#|6#.#4-#|5-5#2-#|9-4#"
    DEFL _062_L, "-5#6-|-#3-5#2-|-#2$-#3-#2-|2#-#2-$2-2#-|#5-*#2-#-|#3-#-.#2.2#|5#$3*.-#|4-#@$-.2-#|4-8#"
    DEFL _062_R, "5-5#|3-3#@2.#|-3#3-*2#|-#2-2$*.#-|2#2-$3.#-|#-$2-$-2#-|#2-$4#2-|#3-#5-|5#5-"
    DEFL _063_L, "2-5#6-|2-#3-7#|2-#2-$@2#3-#|4#$#*.#-#-#|#2-$.#.*2-#-#|#3-.*.3$2-#|3#.*7-#|2-11#"
    DEFL _063_R, "2-6#3-|2-#-+.-#3-|2-#$*$-4#|-2#3.#3-#|2#-$.*.3-#|#-$-#$2#-2#|#-2$5-#-|#6-3#-|8#3-"
    DEFL _064_L, "-8#3-|2#2-2#2-#3-|#3-2#2-#3-|#-@-$.$.#3-|3#-$*2.4#|2-#$-#*.3-#|2-#2-$-.-$-#|2-#2-7#|2-4#6-"
    DEFL _064_R, "4#-6#|#2-#-#4-#|#2-3#4-#|#-$*-$-$-2#|#2-3.-#-#-|3#2.#3$#-|2-2#2.-$@#-|3-7#-"
    DEFL _065_L, "2-5#5-|3#3-#5-|#-3$-6#|#-.-#2.#2-@#|2#*2.*.3$-#|#2.$-#.$-$-#|2#.2-2#2-$-#|-6#3-2#|6-5#-"
    DEFL _065_R, "3-5#2-|4#.2-#2-|#2-#2.$#2-|#2-$*.-3#|#2-$2.*$-#|2#3$.3-#|-#@$-.*2-#|-9#"
    DEFL _066_L, "10#3-|#5-#2-4#|#-$2#$*.*$2-#|#@-#-5.#-#|#-$#$2.-#3-#|#2-$2-7#|4#-$-$2-#2-|3-#6-#2-|3-8#2-"
    DEFL _066_R, "2-5#5-|2-#3-2#4-|2-#4-#4-|2-#-*.$5#|2-#-2*2.-$-#|3#2$.#.2#-#|#2-@$.-$2#-#|#3-#6-#|12#"
    DEFL _067_L, "8#3-|#3-@2-#3-|#-2$-2$4#|#2-2#$-$-.#|#-$2#-.*#.#|#2-2#-*.*.#|#2-2#-.-.-#|11#"
    DEFL _067_R, "7#2-4#|#5-2#-#2-#|#-2$2-.3#$-#|2#2-#$*2.3-#|-2#2-*2.#$#-#|2-2#+*2.#-$-#|3-#-$-$3-2#|3-4#3-2#-|6-5#2-"
    DEFL _068_L, "10#|#2-#5-#|#-$#$-$2-#|#-$2-$.2-#|#2-#.*.$2#|#-$#.2*-#-|2#@*3.2#-|-2#-*2-#2-|2-6#2-"
    DEFL _068_R, "5-5#-|3-3#3-#-|3-#2-$2-#-|4#*-2$3#|#3.*.#3-#|#.#.*.#-$-#|#$#-$@$2-2#|#3-3#2-#-|5#-4#-"
    DEFL _069_L, "-6#3-|-#2-$.3#-|-#2-*2.-#-|2#$#.-.-2#|#-$2-#2.-#|#@2$2#-$-#|#-$6-#|7#2-#|6-4#"
    DEFL _069_R, "2-5#4-|-2#3-5#|2#@$-2$3-#|#-$#2-$.*.#|#2-#2-2*2.#|#-$2-#.-3#|4#2-.2#2-|3-5#3-"


   CHECK_BANK_SIZE "LEVELS5 -- full 2K"

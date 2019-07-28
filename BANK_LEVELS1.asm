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

  NEWBANK LEVELS1

  ; "SOKWHOLE" collection...

  DEFL _001_L, "3#|#@#|#$#|#.#|3#"
  DEFL _001_R, "5#|#.$@#|5#"
  DEFL _002_L, "3#2-|#.3#|#*$-#|#2-@#|5#"
  DEFL _002_R, "2-5#-|3#3-2#|#.*-#@-#|2#$3#-#|-#5-#|-7#"
  DEFL _003_L, "4-5#|2-3#3-#|3#.*-#-#|#@$.$#2-#|2#5-2#|-7#-"
  DEFL _003_R, "9#|#7-#|#-*2.2#-#|2#$#$#2-#|-#-@3-2#|-7#-"
  DEFL _004_L, "5#-|#3-2#|#-.*-#|#2-$@#|#2-3#|4#2-"
  DEFL _004_R, "-6#|-#4-#|2#-$*$#|#@$3.#|7#"
  DEFL _005_L, "3-5#|3-#.$-#|3-#.$-#|4#.#-#|#@$-*2-#|2#3-3#|-5#2-"
  DEFL _005_R, "6#2-|#2-@-2#-|#-2#$-2#|#-2#.$-#|#-$3.-#|2#2-#$2#|-2#3-#-|2-5#-"
  DEFL _006_L, "5#3-|#3-3#-|#-#-$.#-|#-#-$.#-|#-#-.*2#|#2-#-$@#|#4-3#|6#2-"
  DEFL _006_R, "3#4-|#@5#|#$4-#|#2.$#-#|2#*.$-#|-#-.-2#|-2#$-#-|2-#2-#-|2-4#-"
  DEFL _007_L, "6#-|#4-#-|#@-*-#-|#-*.3#|2#-$2-#|-2#3-#|2-5#"
  DEFL _007_R, "4#4-|#2-2#3-|#-$.2#2-|#2-*.3#|#2-2*$-#|3#3-@#|2-6#"
  DEFL _008_L, "2-5#|2-#3-#|-2#.*-#|2#@$.2#|#-$2-#-|#-2#-#-|#4-#-|6#-"
  DEFL _008_R, "-5#3-|2#3-2#2-|#-$-*-2#-|#2-*.$-2#|3#2.-$@#|2-7#"
  DEFL _009_L, "-5#-|2#-$.2#|#@$-.-#|2#-$.$#|-#-$2.#|-2#-$.#|2-5#"
  DEFL _009_R, "-3#3-|2#@4#|#-$3-#|#2-$2*#|2#2-*.#|-2#2-.#|2-5#"
  DEFL _010_L, "2-3#-|2-#@#-|3#$#-|#2-.2#|#-$2.#|#-$.$#|#-$.-#|#-$.2#|5#-"
  DEFL _010_R, "4#2-|#2-#2-|#-$3#|#-$2.#|#2-*-#|#-$*-#|2#-+2#|-4#-"
  DEFL _011_L, "-4#2-|-#2.3#|2#$*2.#|#@$-$-#|2#-$2-#|-2#2-2#|2-4#-"
  DEFL _011_R, "2-3#-|-2#@#-|2#-$#-|#-$-2#|#-.*.#|#-*2.#|#-$-$#|2#3-#|-5#"
  DEFL _012_L, "7#3-|#5-2#2-|#-3$2.#2-|2#2-.*$3#|-3#2.-$@#|3-7#"
  DEFL _012_R, "-6#2-|2#2-.-2#-|#@$-*$-2#|2#-$.$2-#|-3#.*2-#|3-#.2-2#|3-5#-"
  DEFL _013_L, "2-5#-|2-#3-2#|2-#-.2-#|3#2*2.#|#@$2-$-#|3#-$2-#|2-2#2-2#|3-4#-"
  DEFL _013_R, "-5#2-|2#3-2#-|#-$3-2#|#-.2*.-#|#3-$*-#|5#@2#|4-3#-"
  DEFL _014_L, "6#4-|#@3-2#3-|#-2#$-4#|#-#-$-*2-#|#-$-2.*2-#|5#2.$-#|4-2#.$-#|5-5#"
  DEFL _014_R, "6#3-|#4-4#|#2-#2-$@#|#-$.*-3#|2#-.*-#2-|-2#.$-#2-|2-#.$-#2-|2-5#2-"
  DEFL _015_L, "2-5#|3#3-#|#@#-$-#|#$*.-2#|#2.*$-#|2#-*2-#|-#4-#|-6#"
  DEFL _015_R, "3-5#|2-2#3-#|2-#4-#|3#-$3#|#.*.*-#-|2#-*2-#-|-#2-$-#-|-3#@2#-|3-3#2-"
  DEFL _016_L, "4-3#2-|5#.3#|#4.*2-#|#$#-*-$-#|#@$-2$-2#|2#4-2#-|-6#2-"
  DEFL _016_R, "5#-|#.2-#-|#.$-#-|#.*-2#|#*-$@#|#2-$-#|2#2-2#|-4#-"
  DEFL _017_L, "5#4-|#3-2#3-|#$3-2#2-|#2.*$-#2-|2#2*.-3#|-#.$2-$@#|-#2-#-3#|-#4-#2-|-6#2-"
  DEFL _017_R, "3-4#-|3-#2-#-|-3#2-#-|-#.*.-#-|3#2*.#-|#3-2$2#|#-#2-$@#|#3-4#|5#3-"
  DEFL _018_L, "6#3-|#4-2#2-|#-$2.-3#|2#-3*2.#|#-$2-$*$#|#4-#@-#|9#"
  DEFL _018_R, "-4#3-|-#2-2#2-|2#-*.2#-|#-$.*@2#|#2-$2*-#|#4-#-#|3#4-#|2-6#"
  DEFL _019_L, "4-5#-|2-3#-*.#-|2-#-$-2.#-|3#-2$*$2#|#@$2-2.2-#|6#3-#|5-5#"
  DEFL _019_R, "2-7#2-|2-#5-2#-|2-#-$*#$-#-|3#-$.*.*#-|#@$-3.$-2#|5#.$3-#|4-2#-2#-#|5-#4-#|5-6#"

  CHECK_BANK_SIZE "LEVELS1"

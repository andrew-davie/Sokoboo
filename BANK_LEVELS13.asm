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

  NEWBANK LEVELS13

 DEFL Sokompact_49, "|-4#|-#2 6#|-#-$3 $-#|-#3 #-#-#|2#3*.2*@#|#2 .2 .-2#|#-#-2#$2#|#6 #|8#"
 DEFL Sokompact_50, "|3 3#|2 #-@-#|-#-$#$-#|-#-.*.-#|#2 *.*2 #|#2 $-$2 #|4#.-3#|3 #2 #|3 4#"

 ;SokoStation 2014-04-05110  Ghislain Martin
 DEFL SokoStation_0, "7#|#4.-#|#-3$-#|#-$@$-#|#-3$-#|#-4.#|7#"
 DEFL SokoStation_1, "|7#|#-2.2 #|#.3$-#|#.$@$.#|#-3$.#|#2 2.-#|7#"
 DEFL SokoStation_2, "|3 #|2 #.#|-#.$.#|#.3$.#|-#-$-#|-#-@-#|-5#"
 DEFL SokoStation_3, "|-5#|2#3 2#|#2 #2 #|#.$@$.#|#-3$-#|#.-.-.#|7#"
 DEFL SokoStation_4, "|7#|#5 #|#-*-*-#|#*-$-*#|#-*.*-#|#2 @2 #|7#"
 DEFL SokoStation_5, "|4 4#5 #|3 #3 #4 #|2 2#-#-5#|-3#2 4.-#-#|6#.3$-2#|5 #.$@$-#|5 #.3$-#-#|5 #4 .2#|5 7#|9 #|7 3#"
 DEFL SokoStation_6, "|15#|#6 @6 #|#-3*5 3*-#|#-*-7$-*-#|#-*-7.-*-#|#-11*-#|#13 #|15#"
 DEFL SokoStation_7, "|6 5#|6 #3 #|6 #-$-#|6 #3 #|6 2#-2#|7 #.#|5#-2#-2#-5#|#3 3#-.-3#3 #|#-$5 @5 $-#|#3 3#-.-3#3 #|5#-2#-2#-5#|7 #.#|8#-8#|#-*-*-*3 *-*-*-#|#7 $7 #|2#2 *-*3 *-*2 2#|17#"
 DEFL SokoStation_8, "|2 5#|2 #3 #|3#$.$3#|#-$3 $-#|#3.@3.#|#-$3 $-#|3#$.$3#|2 #3 #|2 5#"
 DEFL SokoStation_9, "|2 5#|2 #-.-#|3#$.$3#|#-$3 $-#|#2.-@-2.#|#-$3 $-#|3#$.$3#|2 #-.-#|2 5#"
 DEFL SokoStation_10, "|2 5#|2 #3 #|3#$.$3#|#-$-.-$-#|#-2.@2.-#|#-$-.-$-#|3#$.$3#|2 #3 #|2 5#"
 DEFL SokoStation_11, "|2 2#3 2#|-#2 #-#2 #|#-$2 #2 $-#|#2 $-.-$2 #|-#2 *.*2 #|2 #2.@2.#|-#2 *.*2 #|#2 $-.-$2 #|#-$2 #2 $-#|-#2 #-#2 #|2 2#3 2#"
 DEFL SokoStation_12, "|2 7#|2 #.-$-.#|3#-$.$-3#|#@-$.$.$-.#|3#-$.$-3#|2 #.-$-.#|2 7#"
 DEFL SokoStation_13, "|5#-5#|#3.3#3 #|#3.4 @-#|#.-.3#3 #|3#-#-#-3#|2 #$#-#$#|3#-#-#-3#|#3 #-#3 #|#-$-#-#-$-#|#-$-#-#-$-#|#-$-#-#-$-#|#3 #-#3 #|5#-5#"
 DEFL SokoStation_14, "|9#|#-#3.#-#|#-*-.-*-#|#-*-*-*-#|#-*-$-*-#|#-#3$#-#|#3 @3 #|9#"
 DEFL SokoStation_15, "|5 5#|5 #3 #|2 4#-$-4#|2 #2 #3 #2 #|2 #-2#-4#-#|5#.*.*.5#|#3 #*$-$*4 #|#-$-#.-@-.#-$-#|#4 *$-$*#3 #|5#.*.*.5#|2 #-4#-2#-#|2 #2 #3 #2 #|2 4#-$-4#|5 #3 #|5 5#"
 DEFL SokoStation_16, "|5#|#2 .2#|#2 #.2#|2#$-*.2#|#2 $-*.2#|#-*-$-#.#|#-$*-$2 #|#@3 #2 #|9#"
 DEFL SokoStation_17, "|-10#|2#2 #2 *2 5#|#3 #-*-*-#3 #|#-@2 *-$-*2 .-#|#3 #-*-*-#3 #|2#2 #2 *2 5#|-10#"
 DEFL SokoStation_18, "|-10#|2#2 #2 *2 5#|#3 #-*-*-#3 #|#-+2 *-$-*4 #|#3 #-*-*-#3 #|2#2 #2 *2 5#|-10#"
 DEFL SokoStation_19, "|-10#|2#2 #.-$-.#|#3 #-$.$-#|#-@2 $.$.$#|#3 #-$.$-#|2#2 #.-$-.#|-6#-3#|5 #3 #|5 #-.-#|5 #3 #|5 5#"
 DEFL SokoStation_20, "|4 5#|4 #3 #|4 #$.$#|4 #.-.#|5#$.$5#|#-$.$3 $.$-#|#-.-.-@-.-.-#|#-$.$3 $.$-#|5#$.$5#|4 #.-.#|4 #$.$#|4 #3 #|4 5#"
 DEFL SokoStation_21, "|9#|#5.2 #|#4 $#-#|#4.-#-#|#3 2$#-#|#3.2 #-#|#2 3$#-#|#2.3 #@#|#-4$3#|#.5 #|#5$-#|#6 #|8#"
 
   CHECK_BANK_SIZE "LEVELS13 -- full 2K"

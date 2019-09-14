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

  NEWBANK LEVELS17

 DEFL SokoStation_92, "|2 8#|2 #@2 #2 2#|3#-3$-$-#|#3 $3.#-3#|#-$3.#3.$-#|3#-#3.$3 #|2 #-$-3$-3#|2 2#2 #3 #|3 8#"
 DEFL SokoStation_93, "|2 11#|2 #-*2 *2 *-#|3#-*2 *2 *-3#|#3 *2 *2 *3 #|#-+-7*-$-#|#3 *2 *2 *3 #|3#-*2 *2 *-3#|2 #-*2 *2 *-#|2 11#"
 DEFL SokoStation_94, "|-5#3 5#3 5#|2#3 2#-2#3 2#-2#3 2#|#-$-$-3#5 3#-$-$-#|#2 $2 5.@5.2 $2 #|#-$-$-3#5 3#-$-$-#|2#3 2#-2#3 2#-2#3 2#|-5#3 5#3 5#"
 DEFL SokoStation_95, "|-5#3 5#3 5#|2#3 2#-2#3.2#-2#3 2#|#-$-$-3#.3$.3#-$-$-#|#6 3.$@$3.6 #|#-$-$-3#.3$.3#-$-$-#|2#3 2#-2#3.2#-2#3 2#|-5#3 5#3 5#"
 DEFL SokoStation_96, "|7#|#2 .$-#|#$2.$-#|#2.2$-#|#.2$.-#|#.$@2 #|7#"
 DEFL SokoStation_97, "|21#|#3 #3 #3 #3 #3 #|#-#-#-#3 #-#-#3 #-#|#3 #3 #3 #3 #3 #|3#*3#*3#*3#*3#*#|#3 #7 #7 #|#@#$#-#-#-#-#-#-#-#.#|#7 #7 #3 #|3#*3#*3#*3#*3#*#|#3 #3 #3 #3 #3 #|#-#3 #-#-#3 #-#-#-#|#3 #3 #3 #3 #3 #|21#"
 DEFL SokoStation_98, "|12 3#|9 4#2 #2 2#|6 4#5 #-#2.#|3 4#4 $2#-#-#2.#|-3#4 $2#-#2 #-#2 #|#4 $2#-#2 #2 #-#2 #|#-$2#-#2 #2 #3 #3 #|2#-#2 #2 #2 #7 #|#2 #2 #2 4#6 #|#2 #2 4#8 #|#2 4#10 #|4#11 2#|-#@9 3#|2 10#"
 DEFL SokoStation_99, "|-9#|-#7 #|2#-#$#$#$2#|#-$7 #|#3 .#.-#-#|#.#.3#.#.#|#-#-.#.3 #|#7 $-#|2#$#$#$#-2#|-#@6 #|-9#"

;      START_LEVEL SokoStation_100
;      .byte "|8 17#|7 #17*#|6 #3*13 3*#|6 #2*5 $3 $5 2*#|6 #*2 $14 *#|6 #*10 2#2 $2 *#-2#|6 #*9 #2 #4 *2#2 #|"
;      .byte "4#2 #*6 $2 #3 #3 *#3 #|#2 2#-#*9 #4 2#@#4 #|2#2 3#*3 $5 #12 #|-2#2 2#*7 $#14 #|2 2#2 #*-$6 #3 .#5 .#2 #|"
;      .byte "3 4#*8 #3 2#3 #-2#2 #|5 2#*5 $2 #-2.9 2.#|6 #2*-$5 #-2.-#2 #2 #-2.#|6 #3*7 #3 7#2 #|5 3#10*#10 #|4 #3 21#|"
;      .byte "4 #2 2#-#2 #5 #2 #-#2 #|4 4#2 3#7 3#2 2#",0
;      END_LEVEL SokoStation_100

; DEFL SokoStation_101, "|9 #|9 2#|8 3#|8 #-2#|7 2#-3#|7 2#3 2#|5 4#-#-3#|4 3#5 #|6 #-#-#+3#|6 #6 3#|4 5#2 #-#|3 3#7 #|5 #-#-#-5#|5 #8 3#|3 5#-2#-#-#|2 3#9 #|4 #-#-3#-5#|4 #10 3#|2 5#-4#-#-#|-3#11 #|3 #-#-5#-5#|3 #12 3#|-5#-6#-#-#|3#13 #|2 #-#$7#-3#|-2#13 2#|19#|7 5#|7 5#|6 7#"
 ;DEFL SokoStation_102, "|9 #|9 2#|8 3#|8 #@2#|7 2#-3#|7 2#3 2#|5 4#$#-3#|4 3#3 $-#|6 #-#$#$3#|6 #3 $2 3#|4 5#2 #-#|3 3#7 #|5 #-#-#-5#|5 #8 3#|3 5#-2#-#-#|2 3#2 5.2 #|4 #-#-3#-5#|4 #2 5.3 3#|2 5#-4#-#-#|-3#9 $-#|3 #-#$5#-5#|3 #9 $2 3#|-5#$6#-#-#|3#10 $2 #|2 #-#-7#-3#|-2#13 2#|19#|7 5#|7 5#|6 7#"
 DEFL SokoStation_103, "|11#|#5 2#-@#|#2 2#-2#$-#|#3 #$-$2 #|#3.#-$-$-#|#3.-$-$2 #|#3.#-$-$2#|#3*#4 *#|11#"
 DEFL SokoStation_104, "|9#|#3 @3 #|#-5#-#|#-$3 $-#|#2 3$2 #|#-$3 $-#|#.2#-2#.#|#.-.-.-.#|#3 .3 #|9#"
#if 0
 DEFL SokoStation_105, "|4 15#|4 #13 #|5#-5#-5#-5#|#3 #-#3 #-#3 #-#3 #|#-$3 #5 #5 #-+-#|#3 #-#3 #-#3 #-#3 #|2#-2#-2#-2#-2#-2#-2#-2#|-#-#3 #-#3 #-#3 #-#|-#-#5 #5 #5 #|-#-#3 #-#3 #-#3 #-#|-#-5#-5#-5#-#|-#19 #|-21#"
 DEFL SokoStation_106, "|4 15#|4 #6 *6 #|5#-5#-5#-5#|#3 #-#3 #-#3 #-#3 #|#-$3 #5 #5 #-+-#|#3 #-#3 #-#3 #-#3 #|2#-2#-2#-2#-2#-2#-2#-2#|-#-#3 #-#3 #-#3 #-#|-#-#5 #5 #5 #|-#-#3 #-#3 #-#3 #-#|-#-5#-5#-5#-#|-#3 *11 *3 #|-21#"
 DEFL SokoStation_107, "|20#|2#16.2#|#2 2#2 $4 2.4 @#|#-4#$-$3#2.3#2 #|#-4#-$-#-#2.3#2 #|#2 2#4 3#2.#4 #|#-$-$-$8#3$-#|#2 $-$3 3#2 #2 $-#|#-$-$-$2 3#2 #2 $-#|#2 $-$-$-#-#-4$2 #|2#2 #2 #-#-#6 2#|20#"
 DEFL SokoStation_108, "|2 5#|2 #3 #|3#$-$3#|#-$3.$-#|#2 .-.2 #|#-$3.$-#|3#$-$3#|-#.-.-.#|-#-3$-#|-#.$@$.#|-#-3$-#|-#.-.-.#|-7#"
 DEFL SokoStation_109, "|7#|#4 2#|#-3$-#|#-$3.#|#@3$.#|#-$3.#|#-3$.#|2#-3.#|7#"
#endif

   CHECK_BANK_SIZE "LEVELS17-- full 2K"

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

  NEWBANK LEVELS6


  ; Level definitions

    ; "sokhard" collection
    #if 1

    DEFL _102_Natalie, "11#|2#2-#@4.#|2#3-2$.2*#|2#-$2-2$#.#|#2-$#-#2-.#|#2-$-#-2#-#|#9-#|11#"
    DEFL _102_Mirabel, "11#|6#3-2#|2#2-2#$2-2#|2#2-#-2$-2#|#7-3#|#.-#$-#-3#|#.#.-#2-$-#|#3.#-2$#@#|#-2.4-$-#|#2-8#|11#"
    DEFL _102_Oralia, "9#|#2.$.#2-#|#4.2*-#|#-$.2#2-#|2#-$2-$-#|4#$-$-#|#-$3-$-#|#5-#@#|9#"


  ;---------------------------------------------------------------------------------------------------
  ; IMAGE IS ABOVE DEFINITION

  ;  ###########
  ;  #  #      #
  ;  # $# $ $$ #
  ;  #  ##$#$  #
  ;  #  $    #@#
  ;  # $## #  ##
  ;  ##  # .## #
  ;  ##$ #.*. ##
  ;  # ..*. *. #
  ;  # # .. #  #
  ;  ###########

    DEFL _102_Raven, "11#|#2-#6-#|#-$#-$-2$-#|#2-2#$#$2-#|#2-$4-#@#|#-$2#-#2-2#|2#2-#-.2#-#|2#$-#.*.-2#|#-2.*.-*.-#|#-#-2.-#2-#|11#"

  ;  ############
  ;  #@##. #  # #
  ;  #**..$#    #
  ;  #. $..#  # #
  ;  # $#.$#$$$ #
  ;  #         ##
  ;  #  ##  #   #
  ;  ############

    DEFL _103_Adin, "12#|#@2#.-#2-#-#|#2*2.$#4-#|#.-$2.#2-#-#|#-$#.$#3$-#|#9-2#|#2-2#2-#3-#|12#"

  ;  #######___
  ;  #     #___
  ;  #   $$#___
  ;  #.*  .#___
  ;  #$*$#*###_
  ;  #@*... .#_
  ;  #####$ .##
  ;  ___# $ $ #
  ;  ___#     #
  ;  ___#######  (_ = modified by boo from wall)

    DEFL _103_Ajalae, "7#|#5-#|#3-2$#|#.*2-.#|#$*$#*3#|#@*3.-.#|5#$-.2#|3-#-$-$-#|3-#5-#|3-7#"


  ;  ############
  ;  #@#  #     #
  ;  #  # #$#$# #
  ;  # *$       #
  ;  #..##$#$   #
  ;  #..#. #  $ #
  ;  #....# $$$##
  ;  #          #
  ;  ############

    DEFL _103_Arielle, "12#|#@#2-#5-#|#2-#-#$#$#-#|#-*$7-#|#2.2#$#$3-#|#2.#.-#2-$-#|#4.#-3$2#|#10-#|12#"
    DEFL _1XJH_Tara_Gelson, "8#|#2-#2-*#|#2-*-*-#|#-*$-$-#|#2-.#.-#|#3-#-*#|2#-@3-#|8#"
    DEFL _1R7X_Alison, "7#|#2-.2-#|#-$*2$#|#-2.$.#|#@*-$-#|2#.3-#|7#"
    DEFL _1KWD_Cecile_Clayworth, "8#|3#.2-.#|#-$4-#|#-*2#2$#|#3-$-+#|#-*.-*-#|#6-#|8#"
    DEFL _1EKT_Samantha_Gelson, "8#|#-*3-.#|#2-$-*-#|#-.$-$-#|#*-*2-*#|#.#-#2-#|#4-@-#|8#"
    DEFL _0VM5_Andrea_Wadd, "7#|#3-#-#|#-$*2-#|#-.-+-#|#-*2$-#|2#2-.-#|7#"
    DEFL _0PAL_Jill_Leatherby, "7#|#3-3#|#2-2*-#|#3-$-#|#2-$2.#|3#@2-#|7#"
    DEFL _0IZ1_Sophia, "7#|#5-#|#@$.#-#|#*$2-.#|#-2$2-#|#-.-.-#|7#"
    DEFL _0CNH_Alice, "7#|#.4-#|#$*-#-#|#.2-$*#|#-.$2-#|#@-*2-#|7#"


;  START_LEVEL TowC
;   .byte "4-5#|4-#3-#|4-#$2-#|2-3#2-$2#|2-#2-$-$-#|3#-#-2#-#3-6#|#3-#-2#-5#2-2.#|#-$2-$10-2.#|5#-3#-#@2#2-2.#|4-#5-9#|4-7#",0
;  END_LEVEL TowC

;  START_LEVEL SimpleC
;  .byte "7#|#.@-#-#|#$*-$-#|#3-$-#|#-..--#|#--*--#|7#",0
;  END_LEVEL SimpleC

;  START_LEVEL bAlfa_DrFogh
;   .byte "2-4#2-4#|-2#2-2#-#2-#|-#4-3#2-2#|2#2-2*2-#.2-2#|#2-*2-*-#*#2-#|#-*4-2*2-#-#|#-*-2#-*3-#-#|2#-*2-*#*#-#-#|-#$-2*-#-*-#-#|-#@#2-2#5-#|-2#2-4#2-3#|2-#2-#2-4#|2-#2-#|2-4#",0
;  END_LEVEL bAlfa_DrFogh

;  START_LEVEL b51X_Sharpen
;   .byte "-9#3-|-#7-#3-|-#-$-2$-$#3-|3#$#2-$-#3-|#.#3-2$-2#2-|#.3#3-$-#2-|#.#.-$-2#-3#|#3.$-$2#-$-#|#3.$3-$2-@#|#2.3#$3#-2#|#4.#5-#-|12#-",0
;  END_LEVEL b51X_Sharpen

;  START_LEVEL bDarcy_Burnsell101
;   .byte "8#|#2-.-$@#|#.#$*2$#|#2-.-*-#|#2$-2$.#|#.#-#2-#|#.2-.-.#|8#",0
;  END_LEVEL bDarcy_Burnsell101

;  START_LEVEL bAislin101
;  .byte "8#|2#-*-*.#|#2.$-$*#|#-.#-*.#|2#-$-$2#|#-#$-$-#|#2.2-$@#|8#",0
;  END_LEVEL bAislin101

;  START_LEVEL b82X_Sharpen
;  .byte "-11#8-|-#5-#3-2#7-|-#-$-$-$-#2-5#3-|-3#2-5#5-#3-|-#4.#5-3#-#3-|-#.4#2-4#3-#3-|-#4.4-#2-$-2#3-|-#-3.#3-#-3$5#|3#.7#2-$@$3-#|#-$3-5#-$-2#3-#|#-#.#-$6-$3#$-#|#-#.8#2-#2-$-#|#-#3.7-2#-2$-#|#3-7#-$-#-#2-#|5#5-#7-2#|10-9#-",0
;  END_LEVEL b82X_Sharpen

  DEFL Thomas_Reinke16, "-5#|2#3-3#|#6-2#|#-#-2#2-#|#2.*2-#-#|#2-*2-#-#|3#*2$2-#|2-#@-4#|2-4#"


;Level element	Character	ASCII Code
;Wall	#	0x23
;Player	@	0x40
;Player on goal square	+	0x2b
;Box	$	0x24
;Box on goal square	*	0x2a
;Goal square	.	0x2e
;Floor	(Space)	0x20 or underscore

;This level ("Claire", by Lee J Haywood):

;#######
;#.@ # #
;#$* $ #
;#   $ #
;# ..  #
;#  *  #
;#######
;runlength encoded looks like this:

;The rows of the level are separated by "|"s. There has been a discussion in the Yahoo Group about what character should represent an empty square in May 2006. Finally the hyphen has been elected to be the standard character for an empty square. Nevertheless, programs are encouraged to support both, hyphens and underscores.

;If only two level elements are grouped together they may be run length encoded, but needn't to. Example:


    #endif

    ; http://www.sourcecode.se/sokoban/levels
    ; Revenge Collection 7 - Marcus Hof
    ; partial

    DEFL _Hof_0, "6#|#*.*.#4-6#|#2.$.7#3-#|2#2$9-$-#|-#2-$#2-3$.$@2#|-2#2.4#.2-.#|2-#.-10#|2-#.*-$-$-$-$-#|2-#.10-#|2-13#"
    DEFL _Hof_1, "8-11#|6-3#9-#|6-#3-$2#$#2$-#|6-#-2$@2-$4-#|6-3#-$-$2-$#-#|7#.#4-$4-#|#3.-.2-2#2$-$#-3#|2#5.9-#|-2#4.-9#|-8#"
    DEFL _Hof_2, "5-6#|5-#.3-#|2-4#.2$-#|2-#2.$2.-2#|2-#@2#.#-#|-7#-#|2#7-#|#2-$-#2$-#|#2-$2#-#-#|2#7-2#|-7#2-#|3-#-$-.2-#|3-#5-2#|3-7#"
    DEFL _Hof_3, "4-4#|5#2-#|#6-2#|#-2.#.*-#|2#$-2$2-#|-#2-#2-@#|-8#"
    DEFL _Hof_4, "-4#|2#2-11#|#@$11-#|#-10*.-#|#13-#|15#"
    DEFL _Hof_5, "11#|#8-2#|#-5*3-#|#5-*2$@#|#*.4*3-#|#*.7*#|3#5*3#|2-#4*2#|2-6#"
    DEFL _Hof_6, "2-7#|2-#5-#|3#-3*-#|#-$-*+*-#|#3-3*-#|3#5-#|2-#2-4#|2-4#"
    DEFL _Hof_7, "17#|2#13-2#|#-#-$2-$2-$-$*#-#|#3-*.3*.3*-*-#|#-$-$-.@.$-.4-#|#-$2-*-*2.$.2-*-#|#-#-2*-2*-*-*.#-#|2#13-2#|17#"
    DEFL _Hof_8, "5#|#-2.5#|#2-2.-@-6#|#-$-3$2.-3.3#|5#3-3$4-#|4-5#3-2$-#|8-5#2-#|12-4#"
    DEFL _Hof_9, "-6#|-#4-#|2#2$2-7#|#-.#$.#5.#|#-*$2-#-3$-#|#-$.$.2-$@$-#|#5-#-3$-#|7#5.#|6-7#"

    ; Zone 26 2014-04-13117  Dries de Clercq
 DEFL Zone_26_0, "-4#|-#-.4#|2#.4 #|#2.-2#-#|#-#-2#-#|#-$2 $-#|2#-2$3#|-#@2 #|-5#"
 DEFL Zone_26_1, "|-7#|-#5 #|2#.-2#-#|#-.$+#-#|#2 $*#-#|3#-$2 #|2 #2 3#|2 #2 #|2 4#"
 DEFL Zone_26_2, "|-5#|-#3 #|-#$#-3#|-#2 $2 #|2#-.-2.#|#-$2#.-#|#@$3 2#|4#2 #|3 4#"

   CHECK_BANK_SIZE "LEVELS6 -- full 2K"

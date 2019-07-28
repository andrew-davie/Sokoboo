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

  ; Level definitions

    ; "sokhard" collection

    START_LEVEL _102_Natalie
    .byte "11#|2#2-#@4.#|2#3-2$.2*#|2#-$2-2$#.#|#2-$#-#2-.#|#2-$-#-2#-#|#9-#|11#",0
    END_LEVEL _102_Natalie

    START_LEVEL _102_Mirabel
    .byte "11#|6#3-2#|2#2-2#$2-2#|2#2-#-2$-2#|#7-3#|#.-#$-#-3#|#.#.-#2-$-#|#3.#-2$#@#|#-2.4-$-#|#2-8#|11#",0
    END_LEVEL _102_Mirabel

    START_LEVEL _102_Oralia
    .byte "9#|#2.$.#2-#|#4.2*-#|#-$.2#2-#|2#-$2-$-#|4#$-$-#|#-$3-$-#|#5-#@#|9#",0
    END_LEVEL _102_Oralia


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

    START_LEVEL _102_Raven
    .byte "11#|#2-#6-#|#-$#-$-2$-#|#2-2#$#$2-#|#2-$4-#@#|#-$2#-#2-2#|2#2-#-.2#-#|2#$-#.*.-2#|#-2.*.-*.-#|#-#-2.-#2-#|11#",0
    END_LEVEL _102_Raven

  ;  ############
  ;  #@##. #  # #
  ;  #**..$#    #
  ;  #. $..#  # #
  ;  # $#.$#$$$ #
  ;  #         ##
  ;  #  ##  #   #
  ;  ############

    START_LEVEL _103_Adin
    .byte "12#|#@2#.-#2-#-#|#2*2.$#4-#|#.-$2.#2-#-#|#-$#.$#3$-#|#9-2#|#2-2#2-#3-#|12#",0
    END_LEVEL _103_Adin

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

    START_LEVEL _103_Ajalae
    .byte "7#|#5-#|#3-2$#|#.*2-.#|#$*$#*3#|#@*3.-.#|5#$-.2#|3-#-$-$-#|3-#5-#|3-7#",0
    END_LEVEL _103_Ajalae

  ;  ############
  ;  #@#  #     #
  ;  #  # #$#$# #
  ;  # *$       #
  ;  #..##$#$   #
  ;  #..#. #  $ #
  ;  #....# $$$##
  ;  #          #
  ;  ############

    START_LEVEL _103_Arielle
    .byte "12#|#@#2-#5-#|#2-#-#$#$#-#|#-*$7-#|#2.2#$#$3-#|#2.#.-#2-$-#|#4.#-3$2#|#10-#|12#",0
    END_LEVEL _103_Arielle



    START_LEVEL _1XJH_Tara_Gelson
    .byte "8#|#2-#2-*#|#2-*-*-#|#-*$-$-#|#2-.#.-#|#3-#-*#|2#-@3-#|8#",0
    END_LEVEL _1XJH_Tara_Gelson

    START_LEVEL _1R7X_Alison
    .byte "7#|#2-.2-#|#-$*2$#|#-2.$.#|#@*-$-#|2#.3-#|7#",0
    END_LEVEL _1R7X_Alison

    START_LEVEL _1KWD_Cecile_Clayworth
    .byte "8#|3#.2-.#|#-$4-#|#-*2#2$#|#3-$-+#|#-*.-*-#|#6-#|8#",0
    END_LEVEL _1KWD_Cecile_Clayworth

    START_LEVEL _1EKT_Samantha_Gelson
    .byte "8#|#-*3-.#|#2-$-*-#|#-.$-$-#|#*-*2-*#|#.#-#2-#|#4-@-#|8#",0
    END_LEVEL _1EKT_Samantha_Gelson

 START_LEVEL _0VM5_Andrea_Wadd
 .byte "7#|#3-#-#|#-$*2-#|#-.-+-#|#-*2$-#|2#2-.-#|7#",0
 END_LEVEL _0VM5_Andrea_Wadd

 START_LEVEL _0PAL_Jill_Leatherby
 .byte "7#|#3-3#|#2-2*-#|#3-$-#|#2-$2.#|3#@2-#|7#",0
 END_LEVEL _0PAL_Jill_Leatherby

  START_LEVEL _0IZ1_Sophia
  .byte "7#|#5-#|#@$.#-#|#*$2-.#|#-2$2-#|#-.-.-#|7#",0
  END_LEVEL _0IZ1_Sophia

  START_LEVEL _0CNH_Alice
    .byte "7#|#.4-#|#$*-#-#|#.2-$*#|#-.$2-#|#@-*2-#|7#",0
  END_LEVEL _0CNH_Alice

;  START_LEVEL TowC
;   .byte "4-5#|4-#3-#|4-#$2-#|2-3#2-$2#|2-#2-$-$-#|3#-#-2#-#3-6#|#3-#-2#-5#2-2.#|#-$2-$10-2.#|5#-3#-#@2#2-2.#|4-#5-9#|4-7#",0
;  END_LEVEL TowC

;  START_LEVEL SimpleC
;  .byte "7#|#.@-#-#|#$*-$-#|#3-$-#|#-..--#|#--*--#|7#",0
;  END_LEVEL SimpleC

  START_LEVEL bAlfa_DrFogh
   .byte "2-4#2-4#|-2#2-2#-#2-#|-#4-3#2-2#|2#2-2*2-#.2-2#|#2-*2-*-#*#2-#|#-*4-2*2-#-#|#-*-2#-*3-#-#|2#-*2-*#*#-#-#|-#$-2*-#-*-#-#|-#@#2-2#5-#|-2#2-4#2-3#|2-#2-#2-4#|2-#2-#|2-4#",0
  END_LEVEL bAlfa_DrFogh

  START_LEVEL b51X_Sharpen
   .byte "-9#3-|-#7-#3-|-#-$-2$-$#3-|3#$#2-$-#3-|#.#3-2$-2#2-|#.3#3-$-#2-|#.#.-$-2#-3#|#3.$-$2#-$-#|#3.$3-$2-@#|#2.3#$3#-2#|#4.#5-#-|12#-",0
  END_LEVEL b51X_Sharpen

  START_LEVEL bDarcy_Burnsell101
   .byte "8#|#2-.-$@#|#.#$*2$#|#2-.-*-#|#2$-2$.#|#.#-#2-#|#.2-.-.#|8#",0
  END_LEVEL bDarcy_Burnsell101

  START_LEVEL bAislin101
  .byte "8#|2#-*-*.#|#2.$-$*#|#-.#-*.#|2#-$-$2#|#-#$-$-#|#2.2-$@#|8#",0
  END_LEVEL bAislin101

;  START_LEVEL b82X_Sharpen
;  .byte "-11#8-|-#5-#3-2#7-|-#-$-$-$-#2-5#3-|-3#2-5#5-#3-|-#4.#5-3#-#3-|-#.4#2-4#3-#3-|-#4.4-#2-$-2#3-|-#-3.#3-#-3$5#|3#.7#2-$@$3-#|#-$3-5#-$-2#3-#|#-#.#-$6-$3#$-#|#-#.8#2-#2-$-#|#-#3.7-2#-2$-#|#3-7#-$-#-#2-#|5#5-#7-2#|10-9#-",0
;  END_LEVEL b82X_Sharpen

  START_LEVEL Thomas_Reinke16
  .byte "-5#|2#3-3#|#6-2#|#-#-2#2-#|#2.*2-#-#|#2-*2-#-#|3#*2$2-#|2-#@-4#|2-4#",0
  END_LEVEL Thomas_Reinke16

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


   CHECK_BANK_SIZE "LEVELS4 -- full 2K"

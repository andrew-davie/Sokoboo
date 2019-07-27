; Cave definitions
; Sample cave definitions.
; Any cave can be in any bank.  System auto-calculates required bank buffer size in RAM.
; have as many banks as you like.  Add new banks in notBOXDash.asm.

 ;.byte "4-5#|4-#3-#|4-#$2-#|2-3#2-$2#|2-#2-$-$-#|3#-#-2#-#3-6#|#3-#-2#-5#2-2.#|#-$2-$10-2.#|5#-3#-#@2#2-2.#|4-#5-9#|4-7#",0
 ;.byte "-5#6-|-#3-5#2-|-#2$-#3-#2-|2#-#2-$2-2#-|#5-*#2-#-|#3-#-.#2.2#|5#$3*.-#|4-#@$-.2-#|4-8#",0
 ;.byte "3-3#2-|3-#@2#-|2-2#$-2#|3#2.*-#|#2-2$.*#|#-#$-.-#|#3-$.-#|2#4-2#|-6#-",0
 ;.byte "23#|#21 #|#@18#$##|#-#3.#12-#--#|#-#3.#-8$-#-#--#|#-#..$--$6-$#.-$ -#|#-#3-#3-6$.#-#--#|#-#3.#-#-5.#3-.3#|#-17#$-#|#+2- #|23#",0

 START_CAVE _0VM5_Andrea_Wadd
 .byte "7#|#3-#-#|#-$*2-#|#-.-+-#|#-*2$-#|2#2-.-#|7#",0
 END_CAVE _0VM5_Andrea_Wadd

 START_CAVE _0PAL_Jill_Leatherby
 .byte "7#|#3-3#|#2-2*-#|#3-$-#|#2-$2.#|3#@2-#|7#",0
 END_CAVE _0PAL_Jill_Leatherby

  START_CAVE _0IZ1_Sophia
  .byte "7#|#5-#|#@$.#-#|#*$2-.#|#-2$2-#|#-.-.-#|7#",0
  END_CAVE _0IZ1_Sophia

  START_CAVE _0CNH_Alice
    .byte "7#|#.4-#|#$*-#-#|#.2-$*#|#-.$2-#|#@-*2-#|7#",0
  END_CAVE _0CNH_Alice

  START_CAVE TowC
   .byte "4-5#|4-#3-#|4-#$2-#|2-3#2-$2#|2-#2-$-$-#|3#-#-2#-#3-6#|#3-#-2#-5#2-2.#|#-$2-$10-2.#|5#-3#-#@2#2-2.#|4-#5-9#|4-7#",0
  END_CAVE TowC

  START_CAVE SimpleC
  .byte "7#|#.@-#-#|#$*-$-#|#3-$-#|#-..--#|#--*--#|7#",0
  END_CAVE SimpleC

  START_CAVE bAlfa_DrFogh
   .byte "2-4#2-4#|-2#2-2#-#2-#|-#4-3#2-2#|2#2-2*2-#.2-2#|#2-*2-*-#*#2-#|#-*4-2*2-#-#|#-*-2#-*3-#-#|2#-*2-*#*#-#-#|-#$-2*-#-*-#-#|-#@#2-2#5-#|-2#2-4#2-3#|2-#2-#2-4#|2-#2-#|2-4#",0
  END_CAVE bAlfa_DrFogh

  START_CAVE b51X_Sharpen
   .byte "-9#3-|-#7-#3-|-#-$-2$-$#3-|3#$#2-$-#3-|#.#3-2$-2#2-|#.3#3-$-#2-|#.#.-$-2#-3#|#3.$-$2#-$-#|#3.$3-$2-@#|#2.3#$3#-2#|#4.#5-#-|12#-",0
  END_CAVE b51X_Sharpen

  START_CAVE bDarcy_Burnsell101
   .byte "8#|#2-.-$@#|#.#$*2$#|#2-.-*-#|#2$-2$.#|#.#-#2-#|#.2-.-.#|8#",0
  END_CAVE bDarcy_Burnsell101

  START_CAVE bAislin101
  .byte "8#|2#-*-*.#|#2.$-$*#|#-.#-*.#|2#-$-$2#|#-#$-$-#|#2.2-$@#|8#",0
  END_CAVE bAislin101

  START_CAVE b82X_Sharpen
  .byte "-11#8-|-#5-#3-2#7-|-#-$-$-$-#2-5#3-|-3#2-5#5-#3-|-#4.#5-3#-#3-|-#.4#2-4#3-#3-|-#4.4-#2-$-2#3-|-#-3.#3-#-3$5#|3#.7#2-$@$3-#|#-$3-5#-$-2#3-#|#-#.#-$6-$3#$-#|#-#.8#2-#2-$-#|#-#3.7-2#-2$-#|#3-7#-$-#-#2-#|5#5-#7-2#|10-9#-",0
  END_CAVE b82X_Sharpen

  START_CAVE Thomas_Reinke16
  .byte "-5#|2#3-3#|#6-2#|#-#-2#2-#|#2.*2-#-#|#2-*2-#-#|3#*2$2-#|2-#@-4#|2-4#",0
  END_CAVE Thomas_Reinke16
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


   ; ECHO "MAX CAVE SIZE = ", MAX_CAVE_SIZE

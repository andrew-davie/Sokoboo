; Cave definitions

  START_CAVE _057_L
  .byte "5-6#|4#-#-.2-#|#2-#-#-2.-#|#2-3#2*.-#|#-$-#-*-$2#|#-$-@*.2-#-|#-2$-2#2-#-|#4-5#-|6#5-",0
  END_CAVE _057_L



.DIR_UP             = 0
.DIR_RIGHT          = 2
.DIR_DOWN           = 4
.DIR_LEFT           = 6


    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE TRACKS

;    .byte   RECT+CHARACTER_WALL, $01, $04, $15, $11    ; Rect of zBrick from ( 1, 4); length = 21; height = 17
;    .byte   FILL+CHARACTER_WALL, $03, $06, $03, $0F, CHARACTER_FIREFLY; FilledRect of zBrick from ( 3, 6); length = 3; height = 15; fill = zFFly1
    END_CAVE TRACKS
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE CROWD
    END_CAVE CROWD
    ENDIF
        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE WALLS
    END_CAVE WALLS
    ENDIF

        ;------------------------------------------------------------------------------

    ;IFCONST CAVE_NAMED_APOCALYPSE
    START_CAVE APOCALYPSE
    END_CAVE APOCALYPSE
    ;ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE ZIGZAG
    END_CAVE ZIGZAG
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE ENCHANTED_BOXES
    END_CAVE ENCHANTED_BOXES
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE INTERMISSION_1
    END_CAVE INTERMISSION_1
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE INTERMISSION_2
    END_CAVE INTERMISSION_2
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE INTERMISSION_3
    END_CAVE INTERMISSION_3
    ENDIF





    ;ECHO "MAX CAVE SIZE = ", MAX_CAVE_SIZE

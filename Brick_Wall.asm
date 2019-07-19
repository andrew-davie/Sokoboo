    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_WALL", LINES_PER_CHAR

BRICK_WALL_DEF = 0

CHARACTERSHAPE_WALL
CHARACTERSHAPE_WALL0



#if MIRRORED_WALL = NO
CHARACTERSHAPE_WALL_MIRRORED
CHARACTERSHAPE_WALL0_MIRRORED
#endif

#if BRICK_WALL_DEF = 0
 .byte %00000000,%01110111,%01110111,%00000000,%11011101,%11011101,%11011101 ;R
 .byte %01110111,%01110111,%01110111,%00000000,%11011101,%11011101,%11011101 ;G
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;B
#endif

#if BRICK_WALL_DEF = 1
 .byte %01100110 ;R #2 bright color
 .byte %01110111
 .byte %01110111
 .byte %00000000
 .byte %10011001
 .byte %11011101
 .byte %11011101

 .byte %01100110 ;G #1 dark, dirt color
 .byte %01110111
 .byte %01110111
 .byte %00000000
 .byte %10011001
 .byte %11011101
 .byte %11011101

 .byte %01100110 ;B #0 medium, mix color
 .byte %01110111
 .byte %00000000
 .byte %00000000
 .byte %10011001
 .byte %11011101
 .byte %00000000
#endif

#if BRICK_WALL_DEF = 2
 .byte %01100110 ;R #2 bright color
 .byte %01110111
 .byte %01110111
 .byte %00000000
 .byte %10011001
 .byte %11011101
 .byte %11011101

 .byte %11111111 ;G #1 dark, dirt color
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111

 .byte %11111111 ;B #0 medium, mix color
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %00000000
#endif

#if BRICK_WALL_DEF = 3
 .byte %00000000
 .byte %10011001 ;R #2 bright color
 .byte %11011101
 .byte %11011101
;.byte %00000000
 .byte %01100110
 .byte %01110111
 .byte %01110111

 .byte %00000000
 .byte %10011001 ;G #1 dark, dirt color
 .byte %11011101
;.byte %11011101
 .byte %00000000
 .byte %01100110
 .byte %01110111
 .byte %01110111

 .byte %10111011 ;B #0 medium, mix color
 .byte %11111111
 .byte %11111111
 .byte %00000000
 .byte %11101110
 .byte %11111111
 .byte %11111111
;.byte %00000000
#endif


    ;--------------------------------------------------------------------------
#if MIRRORED_WALL = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_WALL_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_WALL_MIRRORED
CHARACTERSHAPE_WALL0_MIRRORED

#if BRICK_WALL_DEF = 0
 .byte %00000000,%11101110,%11101110,%00000000,%10111011,%10111011,%10111011 ;R
 .byte %11101110,%11101110,%11101110,%00000000,%10111011,%10111011,%10111011 ;G
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;B
#endif

#if BRICK_WALL_DEF = 1
 .byte %01100110 ;R
 .byte %11101110
 .byte %11101110
 .byte %00000000
 .byte %10011001
 .byte %10111011
 .byte %10111011

 .byte %01100110 ;G
 .byte %11101110
 .byte %11101110
 .byte %00000000
 .byte %10011001
 .byte %10111011
 .byte %10111011

 .byte %01100110 ;B
 .byte %11101110
 .byte %00000000
 .byte %00000000
 .byte %10011001
 .byte %10111011
 .byte %00000000
#endif

#if BRICK_WALL_DEF = 2
 .byte %01100110 ;R
 .byte %11101110
 .byte %11101110
 .byte %00000000
 .byte %10011001
 .byte %10111011
 .byte %10111011

 .byte %11111111 ;G #1 dark, dirt color
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111

 .byte %11111111 ;B #0 medium, mix color
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %00000000
#endif

#if BRICK_WALL_DEF = 3
 .byte %00000000
 .byte %10011001 ;R
 .byte %10111011
 .byte %10111011
;.byte %00000000
 .byte %01100110
 .byte %11101110
 .byte %11101110

 .byte %00000000
 .byte %10011001 ;G
 .byte %10111011
;.byte %10111011
 .byte %00000000
 .byte %01100110
 .byte %11101110
 .byte %11101110

 .byte %11011101 ;B
 .byte %11111111
 .byte %11111111
 .byte %00000000
 .byte %01110111
 .byte %11111111
 .byte %11111111
;.byte %00000000
#endif

#endif

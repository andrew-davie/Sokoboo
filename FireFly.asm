FIREFLY_DEF = 2

#if FIREFLY_DEF = 0
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FIREFLY", LINES_PER_CHAR
CHARACTERSHAPE_FIREFLY
 .byte %00000000,%00000000,%01100110,%01100110,%00000000,%00000000,%00000000 ;R
 .byte %00000000,%00000000,%01100110,%01100110,%00000000,%00000000,%00000000 ;G
 .byte %00000000,%01100110,%01100110,%01100110,%00000000,%00000000,%00000000 ;B

    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FIREFLY2", LINES_PER_CHAR
CHARACTERSHAPE_FIREFLY2
 .byte %00000000,%11111111,%10011001,%10011001,%10011001,%11111111,%00000000 ;R
 .byte %01100110,%10011001,%10011001,%10011001,%10011001,%01100110,%00000000 ;G
 .byte %11111111,%10011001,%10011001,%10011001,%11111111,%00000000,%00000000 ;B
#endif

#if FIREFLY_DEF = 1
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FIREFLY", LINES_PER_CHAR
CHARACTERSHAPE_FIREFLY
    .byte %11111111 ; R (#3 bright, complementary color)
    .byte %11111111
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %11111111
    .byte %11111111

    .byte %11111111 ; G (#2 basic dirt color, usually the darkest one)
    .byte %11111111
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %11111111
    .byte %11111111

    .byte %11111111 ; B (#1 additional wall/boulder color)
    .byte %11111111
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %11111111
    .byte %11111111

    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FIREFLY2", LINES_PER_CHAR
CHARACTERSHAPE_FIREFLY2
    .byte %00000000 ; R (#3 bright, complementary color)
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000

    .byte %11111111 ; G (#2 basic dirt color, usually the darkest one)
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111

    .byte %11111111 ; B (#1 additional wall/boulder color)
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
#endif

#if FIREFLY_DEF = 2
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FIREFLY", LINES_PER_CHAR
CHARACTERSHAPE_FIREFLY
    .byte %11111111 ; R (#3 bright, complementary color)
    .byte %11111111
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %11111111

    .byte %11111111 ; G (#2 basic dirt color, usually the darkest one)
    .byte %11111111
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %11111111
    .byte %11111111

    .byte %11111111 ; B (#1 additional wall/boulder color)
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %10011001
    .byte %11111111
    .byte %11111111

    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FIREFLY2", LINES_PER_CHAR
CHARACTERSHAPE_FIREFLY2
    .byte %00000000 ; R (#3 bright, complementary color)
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000

    .byte %00000000 ; G (#2 basic dirt color, usually the darkest one)
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000

    .byte %11111111 ; B (#1 additional wall/boulder color)
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
#endif

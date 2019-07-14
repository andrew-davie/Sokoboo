BUTTERFLY_DEF = 2

#if BUTTERFLY_DEF = 0
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FLUTTERBY", LINES_PER_CHAR
CHARACTERSHAPE_FLUTTERBY

    ; an x shape

    .byte %00000000 ;R
    .byte %10011001
    .byte %11111111
    .byte %01100110
    .byte %10011001
    .byte %00000000
    .byte 0

    .byte %10011001 ;G
    .byte %10011001
    .byte %11111111
    .byte %11111111
    .byte %10011001
    .byte %10011001
    .byte 0

    .byte %00000000 ;B
    .byte %10011001
    .byte %01100110
    .byte %11111111
    .byte %10011001
    .byte %00000000
    .byte 0

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FLUTTERBY2", LINES_PER_CHAR
CHARACTERSHAPE_FLUTTERBY2

    ; an x shape (flutter)

    .byte %00000000 ;R
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte 0

    .byte %01100110 ;G
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte 0

    .byte %01100110 ;B
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte 0
#endif

#if BUTTERFLY_DEF = 1
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FLUTTERBY", LINES_PER_CHAR
CHARACTERSHAPE_FLUTTERBY

    ; an x shape

    .byte %10011001 ;R (#3 bright color)
    .byte %11011101
    .byte %11111111
    .byte %01100110
    .byte %11111111
    .byte %10111011
    .byte %10011001

    .byte %00000000 ;G (#2 dirt color)
    .byte %10001000
    .byte %11111111
    .byte %01100110
    .byte %01000100
    .byte %10101010
    .byte %10011001

    .byte %10011001 ;B (#1 wall color)
    .byte %11011101
    .byte %11111111
    .byte %01100110
    .byte %11111111
    .byte %10111011
    .byte %10011001

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FLUTTERBY2", LINES_PER_CHAR
CHARACTERSHAPE_FLUTTERBY2

    ; an x shape (flutter)

    .byte %00000000 ;R
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00100010

    .byte %01100110 ;G
    .byte %01100110
    .byte %01000100
    .byte %00100010
    .byte %01100110
    .byte %01100110
    .byte %01000100

    .byte %01100110 ;B
    .byte %01100110
    .byte %01100110
    .byte %01000100
    .byte %00100010
    .byte %01100110
    .byte %01100110
#endif

#if BUTTERFLY_DEF = 2
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FLUTTERBY", LINES_PER_CHAR
CHARACTERSHAPE_FLUTTERBY

    .byte %10011001 ;R (#3 bright color)
    .byte %10011001
    .byte %10011001
    .byte %00000000
    .byte %10011001
    .byte %10011001
    .byte %10011001

    .byte %10011001 ;G (#2 dirt color)
    .byte %11111111
    .byte %11111111
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000

    .byte %00000000 ;B (#1 wall color)
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %11111111
    .byte %10011001
    .byte %10011001

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_FLUTTERBY2", LINES_PER_CHAR
CHARACTERSHAPE_FLUTTERBY2

    .byte %01100110 ;R
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110

    .byte %01100110 ;G
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000

    .byte %00000000 ;B
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
#endif

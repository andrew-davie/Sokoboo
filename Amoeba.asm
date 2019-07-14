

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA", LINES_PER_CHAR

AMOEBA_DEF = 4

#if AMOEBA_DEF = 0
CHARACTERSHAPE_AMOEBA
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA_MIRRORED
#endif
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %01000100,%10101010,%0,%0,%10101100,%0,%0 ;G
 .byte %01000100,%10101010,%0,%0,%10101100,%0,%0 ;B
    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA_MIRRORED
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %00100010,%01010101,%0,%0,%00110101,%0,%0 ;G
 .byte %01000100,%01010101,%0,%0,%00110101,%0,%0 ;B
#endif
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA2_MIRRORED
#endif
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %11101110,%10001000,%0,%00100010,%0,%0,%0 ;G
 .byte %11101110,%10001000,%0,%00100010,%0,%0,%0 ;G
    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2_MIRRORED
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %01110111,%00010001,%0,%01000100,%0,%0,%0 ;G
 .byte %01110111,%00010001,%0,%01000100,%0,%0,%0 ;G
#endif
#endif

#if AMOEBA_DEF = 1
 ;"ORIGINAL"

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA_MIRRORED
#endif
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %01000100,%10101010,%0,%0,%10101100,%0,%0 ;G
 .byte %01000100,%10101010,%0,%0,%10101100,%0,%0 ;B
    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA_MIRRORED
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %00100010,%01010101,%0,%0,%00110101,%0,%0 ;G
 .byte %01000100,%01010101,%0,%0,%00110101,%0,%0 ;B
#endif
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA2_MIRRORED
#endif
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %11101110,%10001000,%0,%00100010,%0,%0,%0 ;G
 .byte %11101110,%10001000,%0,%00100010,%0,%0,%0 ;G
    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2_MIRRORED
 .byte %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111 ;G
 .byte %01110111,%00010001,%0,%01000100,%0,%0,%0 ;G
 .byte %01110111,%00010001,%0,%01000100,%0,%0,%0 ;G
#endif

#endif

#if AMOEBA_DEF = 2
CHARACTERSHAPE_AMOEBA
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA_MIRRORED
#endif
 .byte %10111011    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %11101110
 .byte %11101110
 .byte %11111111
 .byte %10111011

 .byte %10111011    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %11101110
 .byte %11111111
 .byte %11111111
 .byte %10111011

 .byte %11111111    ; B (#1 additional wall/boulder color)
 .byte %11111111
 .byte %11111111
 .byte %11101110
 .byte %11111111
 .byte %10111011
 .byte %10111011

    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA_MIRRORED
 .byte %11011101    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %01110111
 .byte %01110111
 .byte %11111111
 .byte %11011101

 .byte %11011101    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %01110111
 .byte %11111111
 .byte %11111111
 .byte %11011101

 .byte %11111111    ; B (#1 additional wall/boulder color)
 .byte %11111111
 .byte %11111111
 .byte %01110111
 .byte %11111111
 .byte %11011101
 .byte %11011101
#endif
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA2_MIRRORED
#endif
 .byte %10111011  ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %11101110
 .byte %11101110
 .byte %11111111
 .byte %10111011

 .byte %11111111    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %01000100
 .byte %11101110
 .byte %11111111
 .byte %10111011

 .byte %11111111    ; B (#1 additional wall/boulder color)
 .byte %11111111
 .byte %11101110
 .byte %01000100
 .byte %11111111
 .byte %11111111
 .byte %10111011
    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2_MIRRORED
 .byte %11011101  ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %01110111
 .byte %01110111
 .byte %11111111
 .byte %11011101

 .byte %11111111    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %00100010
 .byte %01110111
 .byte %11111111
 .byte %11011101

 .byte %11111111    ; B (#1 additional wall/boulder color)
 .byte %11111111
 .byte %01110111
 .byte %00100010
 .byte %11111111
 .byte %11111111
 .byte %11011101
#endif
#endif

#if AMOEBA_DEF = 3
CHARACTERSHAPE_AMOEBA
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA_MIRRORED
#endif
 .byte %10111011    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %11101110
 .byte %11101110
 .byte %11111111
 .byte %10111011

 .byte %10111011    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %11101110
 .byte %11111111
 .byte %11111111
 .byte %10111011

 .byte %00000000    ; B (#1 additional wall/boulder color)
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000

    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA_MIRRORED
 .byte %11011101    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %01110111
 .byte %01110111
 .byte %11111111
 .byte %11011101

 .byte %11011101    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %01110111
 .byte %11111111
 .byte %11111111
 .byte %11011101

 .byte %00000000    ; B (#1 additional wall/boulder color)
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
#endif
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA2_MIRRORED
#endif
 .byte %10111011    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %11101110
 .byte %11101110
 .byte %11111111
 .byte %10111011

 .byte %11111111    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %01000100
 .byte %11101110
 .byte %11111111
 .byte %10111011

 .byte %00000000    ; B (#1 additional wall/boulder color)
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2_MIRRORED
 .byte %11011101  ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11111111
 .byte %01110111
 .byte %01110111
 .byte %11111111
 .byte %11011101

 .byte %11111111    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11111111
 .byte %00100010
 .byte %01110111
 .byte %11111111
 .byte %11011101

 .byte %00000000    ; B (#1 additional wall/boulder color)
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
#endif
#endif

#if AMOEBA_DEF = 4
CHARACTERSHAPE_AMOEBA
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA_MIRRORED
#endif
 .byte %10111011    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11101110
 .byte %01000100
 .byte %11101110
 .byte %11111111
 .byte %11111111

 .byte %11111111    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11101110
 .byte %01000100
 .byte %01000100
 .byte %11101110
 .byte %11111111
 .byte %11111111

 .byte %01000100    ; B (#1 additional wall/boulder color)
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %01000100

    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA_MIRRORED
 .byte %11011101    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %01110111
 .byte %00100010
 .byte %01110111
 .byte %11111111
 .byte %11111111

 .byte %11111111    ; G (#2 basic dirt color, usually the darkest one)
 .byte %01110111
 .byte %00100010
 .byte %00100010
 .byte %01110111
 .byte %11111111
 .byte %11111111

 .byte %00100010    ; B (#1 additional wall/boulder color)
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00100010
#endif
    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2
#if MIRRORED_AMOEBA = NO
CHARACTERSHAPE_AMOEBA2_MIRRORED
#endif
 .byte %10111011    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %11101110
 .byte %01000100
 .byte %11101110
 .byte %11111111
 .byte %11111111

 .byte %10111011    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %11101110
 .byte %11101110
 .byte %11111111
 .byte %11111111
 .byte %10111011

 .byte %00000000    ; B (#1 additional wall/boulder color)
 .byte %00010001
 .byte %10101010
 .byte %10101010
 .byte %00010001
 .byte %00000000
 .byte %00000000
    ;--------------------------------------------------------------------------
#if MIRRORED_AMOEBA = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_AMOEBA2_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_AMOEBA2_MIRRORED
 .byte %11011101    ; R (#3 bright, complementary color)
 .byte %11111111
 .byte %01110111
 .byte %00100010
 .byte %01110111
 .byte %11111111
 .byte %11111111

 .byte %11011101    ; G (#2 basic dirt color, usually the darkest one)
 .byte %11111111
 .byte %01110111
 .byte %01110111
 .byte %11111111
 .byte %11111111
 .byte %11011101

 .byte %00000000    ; B (#1 additional wall/boulder color)
 .byte %10001000
 .byte %01010101
 .byte %01010101
 .byte %10001000
 .byte %00000000
 .byte %00000000
#endif
#endif






DIAMOND_DEF = 2

#if DIAMOND_DEF = 0

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2
 .byte %00000000
CHARACTERSHAPE_DIAMOND
 .byte %01000100,%01100110,%01110111,%01110111,%01100110,%01000100,%00000000 ;R
 .byte %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ;B
 .byte %01000100,%01100110,%01110111,%01110111,%01100110,%01000100;,%00000000 ;G

    ;--------------------------------------------------------------------------
;     OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND_MIRRORED", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2_MIRRORED
 .byte %00000000
CHARACTERSHAPE_DIAMOND_MIRRORED
 .byte %00100010,%01100110,%11101110,%11101110,%01100110,%00100010,%00000000 ;R
 .byte %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ;B
 .byte %00100010,%01100110,%11101110,%11101110,%01100110,%00100010,%00000000 ;G

    CHECKPAGE CHARACTERSHAPE_DIAMOND2 ; since we share one byte!

#endif

#if DIAMOND_DEF = 1

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2
    .byte %00000000
CHARACTERSHAPE_DIAMOND
    .byte %00100010
    .byte %01100110
    .byte %11101110
    .byte %11101110
    .byte %01100110
    .byte %00100010
    .byte %00000000 ;R
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %10001000
    .byte %01000100
    .byte %00100010
    .byte %00000000 ;B
    .byte %00100010
    .byte %01100110
    .byte %11101110
    .byte %11101110
    .byte %01100110
    .byte %00100010
;    .byte %00000000 ;G

    ;--------------------------------------------------------------------------
;     OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND_MIRRORED", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2_MIRRORED
    .byte %00000000
CHARACTERSHAPE_DIAMOND_MIRRORED
    .byte %01000100
    .byte %01100110
    .byte %01110111
    .byte %01110111
    .byte %01100110
    .byte %01000100
    .byte %00000000 ;R
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00010001
    .byte %00100010
    .byte %01000100
    .byte %00000000 ;B
    .byte %01000100
    .byte %01100110
    .byte %01110111
    .byte %01110111
    .byte %01100110
    .byte %01000100
    .byte %00000000 ;G

    CHECKPAGE CHARACTERSHAPE_DIAMOND2 ; since we share one byte!

#endif

#if DIAMOND_DEF = 2

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2_MIRRORED
    .byte %00000000
CHARACTERSHAPE_DIAMOND_MIRRORED
    .byte %00100010
    .byte %01100110
    .byte %11101110
    .byte %11101110
    .byte %01100110
    .byte %00100010
    .byte %00000000 ;R
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11101110
    .byte %01100110
    .byte %00100010
    .byte %00000000 ;B
    .byte %00100010
    .byte %01100110
    .byte %11101110
    .byte %11101110
    .byte %01100110
    .byte %00100010
;    .byte %00000000 ;G

    ;--------------------------------------------------------------------------
;     OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND_MIRRORED", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2
    .byte %00000000
CHARACTERSHAPE_DIAMOND
    .byte %01000100
    .byte %01100110
    .byte %01110111
    .byte %01110111
    .byte %01100110
    .byte %01000100
    .byte %00000000 ;R
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01110111
    .byte %01100110
    .byte %01000100
    .byte %00000000 ;B
    .byte %01000100
    .byte %01100110
    .byte %01110111
    .byte %01110111
    .byte %01100110
    .byte %01000100
    .byte %00000000 ;G

    CHECKPAGE CHARACTERSHAPE_DIAMOND2 ; since we share one byte!

#endif

#if DIAMOND_DEF = 3

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2
    .byte %00000000
CHARACTERSHAPE_DIAMOND
    .byte %00100010
    .byte %01100110
    .byte %11101110
    .byte %11101110
    .byte %01100110
    .byte %00100010
    .byte %00000000 ;R
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11101110
    .byte %00000000
    .byte %00000000
    .byte %00000000 ;B
    .byte %00100010
    .byte %01100110
    .byte %11101110
    .byte %11101110
    .byte %01100110
    .byte %00100010
;    .byte %00000000 ;G

    ;--------------------------------------------------------------------------
;     OPTIONAL_PAGEBREAK "CHARACTERSHAPE_DIAMOND_MIRRORED", LINES_PER_CHAR+1
CHARACTERSHAPE_DIAMOND2_MIRRORED
    .byte %00000000
CHARACTERSHAPE_DIAMOND_MIRRORED
    .byte %01000100
    .byte %01100110
    .byte %01110111
    .byte %01110111
    .byte %01100110
    .byte %01000100
    .byte %00000000 ;R
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01110111
    .byte %00000000
    .byte %00000000
    .byte %00000000 ;B
    .byte %01000100
    .byte %01100110
    .byte %01110111
    .byte %01110111
    .byte %01100110
    .byte %01000100
    .byte %00000000 ;G

    CHECKPAGE CHARACTERSHAPE_DIAMOND2 ; since we share one byte!

#endif

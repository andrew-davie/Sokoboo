DIAMOND_DEF = 2

#if DIAMOND_DEF = 2

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_TARGET", LINES_PER_CHAR+1
CHARACTERSHAPE_TARGET2_MIRRORED
    .byte %00000000
CHARACTERSHAPE_TARGET_MIRRORED
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000 ;R
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000 ;B
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
;    .byte %00000000 ;G

    ;--------------------------------------------------------------------------
;     OPTIONAL_PAGEBREAK "CHARACTERSHAPE_TARGET_MIRRORED", LINES_PER_CHAR+1
CHARACTERSHAPE_TARGET2
    .byte %00000000
CHARACTERSHAPE_TARGET
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000 ;R
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000 ;B
    .byte %00000000
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00000000
    .byte %00000000 ;G

    CHECKPAGE CHARACTERSHAPE_TARGET2 ; since we share one byte!

#endif

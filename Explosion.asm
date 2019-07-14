    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_EXPLOSION1", LINES_PER_CHAR
CHARACTERSHAPE_EXPLOSION1                        ; large
CHARACTERSHAPE_EXPLOSION1_MIRRORED               ; we don't worry about mirrored explosions!
 .byte %01000100    ; R (#3 bright, complementary color)
 .byte %10011001
 .byte %00000000
 .byte %10011001
 .byte %00000000
 .byte %10011001
 .byte %00100010

 .byte %01000100    ; G (#2 basic dirt color, usually the darkest one)
 .byte %10011001
 .byte %00100010
 .byte %11011101
 .byte %01000100
 .byte %10011001
 .byte %00100010

 .byte %01000100    ; B (#1 additional wall/boulder color)
 .byte %10011001
 .byte %00100010
 .byte %10111011
 .byte %01000100
 .byte %10011001
 .byte %00100010

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_EXPLOSION2", LINES_PER_CHAR
CHARACTERSHAPE_EXPLOSION2                        ; medium
CHARACTERSHAPE_EXPLOSION2_MIRRORED               ; we don't worry about mirrored explosions!
 .byte %00000000    ; R
 .byte %00100010
 .byte %10001000
 .byte %01100110
 .byte %00010001
 .byte %01000100
 .byte %00000000

 .byte %00000000    ; G
 .byte %00100010
 .byte %10011001
 .byte %01100110
 .byte %10011001
 .byte %01000100
 .byte %00000000

 .byte %00000000    ; B
 .byte %00100010
 .byte %10011001
 .byte %01100110
 .byte %10011001
 .byte %01000100
; .byte %00000000

;    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_EXPLOSION3", LINES_PER_CHAR
CHARACTERSHAPE_EXPLOSION3                        ; small
CHARACTERSHAPE_EXPLOSION3_MIRRORED               ; we don't worry about mirrored explosions!
 .byte %00000000    ; R
 .byte %00000000
 .byte %01000100
 .byte %00000000
 .byte %00100010
 .byte %00000000
 .byte %00000000

 .byte %00000000    ; G
 .byte %00000000
 .byte %01000100
 .byte %00000000
 .byte %00100010
 .byte %00000000
 .byte %00000000

 .byte %00000000    ; B
 .byte %00000000
 .byte %01000100
 .byte %00000000
 .byte %00100010
 .byte %00000000
 .byte %00000000

    CHECKPAGE CHARACTERSHAPE_EXPLOSION2 ; since we share one byte!
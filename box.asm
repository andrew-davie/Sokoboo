    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_BOX", LINES_PER_CHAR
CHARACTERSHAPE_BOX
#if MIRRORED_BOX = NO
CHARACTERSHAPE_BOX_MIRRORED
#endif
 .byte %11111111,%11111111,%10011001,%10011001,%11111111,%11111111,%0 ;R
 .byte %11111111,%11111111,%10011001,%10011001,%11111111,%11111111,%11111111 ;G
 .byte %0,%0,%01100110,%01100110,%0,%0,%0 ;B

    ;--------------------------------------------------------------------------
#if MIRRORED_BOX = YES
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_BOX_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_BOX_MIRRORED
  .byte %11111111,%11111111,%10011001,%10011001,%11111111,%11111111,%0 ;R
  .byte %11111111,%11111111,%10011001,%10011001,%11111111,%11111111,%11111111 ;G
  .byte %0,%0,%01100110,%01100110,%0,%0,%0 ;B
#endif

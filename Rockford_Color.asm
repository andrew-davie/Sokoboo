    OPTIONAL_PAGEBREAK "SpriteColour", LINES_PER_CHAR*2

YELLOW_NTSC = $10   ; hair
ORANGE_NTSC = $30   ; skin
RED_NTSC    = $40   ; shirt
BLUE_NTSC = $A4

YELLOW_PAL  = $20
ORANGE_PAL  = $40
RED_PAL     = $60

SpriteColour
; NTSC
;SpriteColourRED
;    .byte RED_NTSC|$6       ; 0 feet
;    .byte WHITE             ; 3
;    .byte RED_NTSC|$4       ; 6
;    .byte RED_NTSC|$4       ; 9
;    .byte ORANGE_NTSC|$6    ;12
;    .byte ORANGE_NTSC|$8    ;15
;    .byte WHITE             ;18
;SpriteColourGREEN
;    .byte RED_NTSC|$4       ; 1
;    .byte WHITE             ; 4
;    .byte WHITE             ; 7
;    .byte WHITE             ;10
;    .byte ORANGE_NTSC|$8    ;13
;    .byte ORANGE_NTSC|$6    ;16
;    .byte WHITE             ;19
;SpriteColourBLUE
;    .byte WHITE             ; 2
;    .byte RED_NTSC|$4       ; 5
;    .byte RED_NTSC|$4       ; 8
;    .byte ORANGE_NTSC|$4    ;11 neck
;    .byte ORANGE_NTSC|$a    ;14
;    .byte YELLOW_NTSC|$c    ;17 hair
;    .byte WHITE             ;20

SpriteColourRED
 .byte WHITE
 .byte WHITE
 .byte WHITE
 .byte WHITE
 .byte WHITE
 .byte WHITE
 .byte WHITE

;  .byte #$1C;0
;  .byte #$78;3
;  .byte #$52;6
;  .byte #$52;9
;  .byte #$0C;12
;  .byte #$4A;15
;  .byte #$1A;18
SpriteColourGREEN
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE
SpriteColourBLUE
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE
  .byte WHITE

  REPEAT 21
  .byte $20|$6             ; 2
   REPEND

; PAL
;    .byte RED_PAL|$6        ; 0 feet
;    .byte WHITE             ; 3
;    .byte RED_PAL|$4        ; 6
;    .byte RED_PAL|$4        ; 9
;    .byte ORANGE_PAL|$4     ;12
;    .byte ORANGE_PAL|$6     ;15
;    .byte WHITE             ;18
;
;    .byte RED_PAL|$4        ; 1
;    .byte WHITE             ; 4
;    .byte WHITE             ; 7
;    .byte WHITE             ;10
;    .byte ORANGE_PAL|$6     ;13
;    .byte ORANGE_PAL|$4     ;16
;    .byte WHITE             ;19
;
;    .byte WHITE             ; 2
;    .byte RED_PAL|$4        ; 5
;    .byte RED_PAL|$4        ; 8
;    .byte ORANGE_PAL|$2     ;11 neck
;    .byte ORANGE_PAL|$8     ;14
;    .byte YELLOW_PAL|$c     ;17 hair
;    .byte WHITE             ;20

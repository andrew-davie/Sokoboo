;    OPTIONAL_PAGEBREAK "PLAYER", LINES_PER_CHAR * 6 - 1


PLAYER_BLANK = .                ; MUST APPEAR AT TOP AS DATA SHARED BY DIRT
    REPEAT LINES_PER_CHAR   ;-1  ; as we have a "0" in the line below
    .byte 0
    REPEND

PLAYER_RIGHT0
;  X XX
;  XXXX
;  XXX
;  XXX
;   XX
;   XX
;   XX
;   XX
;   XXX
;   XXX
;   XX
;   XX
;   XX
;   XX
;  XXXX
;  XXX X
;  XXX X
;  XXX X
;  XXXX
;   XX
;

                .byte %00101100 ; 0
                .byte %00111000 ; 3
                .byte %00011000 ; 6 etc.
                .byte %00011100
                .byte %00011000
                .byte %00111010
                .byte %00111100

                .byte %00111100 ; 1
                .byte %00011000 ; 4 etc.
                .byte %00011000
                .byte %00011000
                .byte %00011000
                .byte %00111010
                .byte %00011000

                .byte %00111000 ; 2
                .byte %00011000 ; 5 etc.
                .byte %00011100
                .byte %00011000
                .byte %00111100
                .byte %00111010
                .byte 0

PLAYER_RIGHT1

  IF 1 = 1
; X?    XX
; X     X
; X     X
; XX   XX
;  XXXXX
;     XX
;     XX
;     XX
;     XXX
;     XXX
;     XX
;     XX
;     XX
;     XX
;    XXXX
;    XXX X
;    XXX X
;    XXX X
;    XXXX
;     XX

                .byte %01000011 ; 0
                .byte %01100110 ; 3
                .byte %00011000 ; 6 etc.
                .byte %00011100
                .byte %00011000
                .byte %00111010
                .byte %00111100

                .byte %01000010 ; 1
                .byte %00111100 ; 4 etc.
                .byte %00011000
                .byte %00011000
                .byte %00011000
                .byte %00111010
                .byte %00011000

                .byte %01000010 ; 2
                .byte %00011000 ; 5 etc.
                .byte %00011100
                .byte %00011000
                .byte %00111100
                .byte %00111010
                .byte 0
  ELSE
; Alternativly make his neck pixel shorter here.
; This looks more dynamic, but shows a problems with the hair color.
; Maybe if we remove the t-shirt/trousers color look and make him
; look more like an insect (which he acutally is), we can fix this.

; X?    XX
; X     X
; X     X
; XX   XX
;  XXXXX
;     XX
;     XX
;     XX
;     XXX
;     XXX
;     XX
;     XX
;     XX
;    XXXX
;    XXX X
;    XXX X
;    XXX X
;    XXXX
;     XX

                .byte %01000011 ; 0
                .byte %01100110 ; 3
                .byte %00011000 ; 6 etc.
                .byte %00011100
                .byte %00011000
                .byte %00111010
                .byte %00011000

                .byte %01000010 ; 1
                .byte %00111100 ; 4 etc.
                .byte %00011000
                .byte %00011000
                .byte %00111100
                .byte %00111010
                .byte 0

                .byte %01000010 ; 2
                .byte %00011000 ; 5 etc.
                .byte %00011100
                .byte %00011000
                .byte %00111010
                .byte %00111100
                .byte 0
  ENDIF

     ;------------------------------------------------------------------------------

    ; NOTE: PLAYER SHAPES ARE *NOT* RGB
    ; THEY ARE JUST REORDERED THIS WAY FOR THE KERNEL

PLAYER_STAND
; original 15 pixel tall, ours was 18 pixel, stretched to 20 now
; this makes Rockford looks closer to original, slimmer and less fat
; also boulder/diamonds above his head look less levitating now

; XX  XX    XX  XX    XX  XX
;  X  X      X  X      X  X
;  X  X      X  X      X  X
;  XXXX      X  X      X  X
;   XX       XXXX      XXXX
;   XX        XX        XX
; X XX X    X XX X      XX
; X XX X    X XX X      XX
;  XXXX     X XX X    X XX X
;   XX       XXXX     X XX X
;  XXXX       XX      X XX X
; X XX X      XX       XXXX
; X XX X     XXXX       XX
;  XXXX     X XX X      XX
;  X  X     X XX X     XXXX
;           X XX X    X XX X
;            XXXX     X XX X
;            X  X     X XX X
;                      XXXX
;                      X  X

                .byte %01100110 ; 0
                .byte %00100100 ; 3
                .byte %00011000 ; 6 etc.
                .byte %01011010
                .byte %00011000
                .byte %01011010
                .byte %00111100

                .byte %00100100 ; 1
                .byte %00111100 ; 4 etc.
                .byte %00011000
                .byte %01011010
                .byte %00011000
                .byte %01011010
                .byte %00100100

                .byte %00100100 ; 2
                .byte %00011000 ; 5 etc.
                .byte %01011010
                .byte %00111100
                .byte %00111100
                .byte %01011010
                .byte 0

PLAYER_BLINK
; XX  XX
;  X  X
;  X  X
;  X  X
;  XXXX
;   XX
;   XX
;   XX
; X XX X
; X XX X
; X XX X
;  XXXX
;   XX
;   XX
;  XXXX
; XXXXXX
; XXXXXX
; XXXXXX
;  XXXX
;  X  X

                .byte %01100110 ; 0
                .byte %00100100 ; 3
                .byte %00011000 ; 6 etc.
                .byte %01011010
                .byte %00011000
                .byte %01111110
                .byte %00111100

                .byte %00100100 ; 1
                .byte %00111100 ; 4 etc.
                .byte %00011000
                .byte %01011010
                .byte %00011000
                .byte %01111110
                .byte %00100100

                .byte %00100100 ; 2
                .byte %00011000 ; 5 etc.
                .byte %01011010
                .byte %00111100
                .byte %00111100
                .byte %01111110
                .byte 0
    ; 1
PLAYER_TAP0
; XX  XX
;  X  X
;  X  X
;  X  X
;  XXXX
;   XX
;   XX
;   XX
;  XXXX
; X XX X
; X XX X
;  XXXX
;   XX
;   XX
;  XXXX
; X XX X
; X XX X
; X XX X
;  XXXX
;  X  X

                .byte %01100110 ; 0
                .byte %00100100 ; 3
                .byte %00011000 ; 6 etc.
                .byte %01011010
                .byte %00011000
                .byte %01011010
                .byte %00111100

                .byte %00100100 ; 1
                .byte %00111100 ; 4 etc.
                .byte %00011000
                .byte %01011010
                .byte %00011000
                .byte %01011010
                .byte %00100100

                .byte %00100100 ; 2
                .byte %00011000 ; 5 etc.
                .byte %00111100
                .byte %00111100
                .byte %00111100
                .byte %01011010
                .byte 0

PLAYER_TAP1
;     XX
; XX  X
;  X  X
;  X  X
;  XXXX
;   XX
;   XX
;   XX
;  XXXX
; X XX X
; X XX X
;  XXXX
;   XX
;   XX
;  XXXX
; X XX X
; X XX X
; X XX X
;  XXXX
;  X  X

                .byte %00000110 ; 0
                .byte %00100100 ; 3
                .byte %00011000 ; 6 etc.
                .byte %01011010
                .byte %00011000
                .byte %01011010
                .byte %00111100

                .byte %01100100 ; 1
                .byte %00111100 ; 4 etc.
                .byte %00011000
                .byte %01011010
                .byte %00011000
                .byte %01011010
                .byte %00100100

                .byte %00100100 ; 2
                .byte %00011000 ; 5 etc.
                .byte %00111100
                .byte %00111100
                .byte %00111100
                .byte %01011010
                .byte 0

;    CHECKPAGE PLAYER_BLANK
    CHECKPAGE CHARACTERSHAPE_SOIL ; since we share some 0 bytes!

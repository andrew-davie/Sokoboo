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



;.byte %00011000  ;  XXX   ; 0
;.byte %00111100  ;XXXXXX  ; 1
;.byte %01110100  ;XXXX X  ; 2 etc.
;.byte %01111100  ;XXXXXX  ; 3
;.byte %00111000  ;XXXXX   ;4
;.byte %01111100  ; XXXXX  ;5
;.byte %00111000  ;  XXX   ;6
;.byte %11111000  ;XXXXX   ;7
;.byte %11111100  ;XXXXXX  ;8
;.byte %11111100  ;XXXXXX  ;9 etc.
;.byte %10000100  ;X    X  ;10
;.byte %11111100  ;XXXXXX  ;11
;.byte %00001100  ;    XX  ;12
;.byte %01111100  ; XXXXX  ;13
;.byte %01111100  ; XXXXX  ;14
;.byte %01111000  ; XXXX   ;15
;.byte %01111000  ; XXXX   ;16 etc.
;.byte %11111000  ;XXXXX   ;17
;.byte %11101100  ;XXX XX  ;18
;.byte %10111100  ;X XXXX  ;19
;.byte %11001100  ;XX  XX   20


 .byte %01100110 ;20
 .byte %01111100 ;17
 .byte %00111110 ;14
 .byte %01111110 ;11
 .byte %00111100 ; 8
 .byte %00111110  ;5
 .byte %00111010  ;XXXX X  ; 2 etc.

 .byte %01011110 ;19
 .byte %00111100  ; XXXX   ;16 etc.
 .byte %00111110 ;13
 .byte %01000010 ;10
  .byte %00111100  ;XXXXX   ;7
  .byte %00111110  ;XXXXX   ;4
  .byte %00011110  ;XXXXXX  ; 1

 .byte %01110110 ;18
 .byte %00111100 ;15
 .byte %00000110 ;12
 .byte %00111110 ; 9 etc.
 .byte %00010100  ;6
 .byte %00101010  ;XXXXXX  ; 3
 .byte %00001100  ;  XXX   ; 0

;                .byte %11111111 ; 0
;                .byte %11111111 ; 3
;                .byte %11111111 ; 6 etc.
;                .byte %11111111
;                .byte %11111111
;                .byte %11111111
;                .byte %11111110

;                .byte %11111111 ; 1
;                .byte %11111111 ; 4 etc.
;                .byte %11111111
;                .byte %11111111
;                .byte %11111111
;                .byte %11111111
;                .byte %01110100

;                .byte %11111111 ; 2
;                .byte %11111111 ; 5 etc.
;                .byte %11111111
;                .byte %11111111
;                .byte %11111100
;                .byte %00111000
;                .byte 0

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
; also BOX/diamonds above his head look less levitating now

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
    CHECKPAGEX CHARACTERSHAPE_SOIL, "Rockford in Rockford.asm" ; since we share some 0 bytes!

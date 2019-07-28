;    Sokoboo - a Sokoban implementation
;    using a generic tile-based display engine for the Atari 2600
;    Sokoban (倉庫番)™ is © Falcon Co., Ltd.
;
;    Code related to this Sokoban™ implementation was developed by Andrew Davie.
;
;    Code related to the generic tile-based display engine was developed by
;    Andrew Davie and Thomas Jentzsch during 2003-2011 and is
;    Copyright(C)2003-2019 Thomas Jentzsch and Andrew Davie - contacts details:
;    Andrew Davie (andrew@taswegian.com), Thomas Jentzsch (tjentzsch@yahoo.de).
;
;    Code related to music and sound effects uses the TIATracker music player
;    Copyright 2016 Andre "Kylearan" Wichmann - see source code in the "sound"
;    directory for Apache licensing details.
;
;    Some level data incorporated in this program were created by Lee J Haywood.
;    See the copyright notices in the License directory for a list of level
;    contributors.
;
;    Except where otherwise indicated, this software is released under the
;    following licensing arrangement...
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;    see https://www.gnu.org/licenses/gpl-3.0.en.html

;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.

;    OPTIONAL_PAGEBREAK "PLAYER", LINES_PER_CHAR * 6 - 1


PLAYER_BLANK = .
    REPEAT LINES_PER_CHAR   ;-1  ; as we have a "0" in the line below
    .byte 0
    REPEND

PLAYER_RIGHT0

#if 1
 .byte %00011000 ;20
 .byte %00011000 ;20
 .byte %01111110 ;20
 .byte %01111110 ;20
 .byte %01111110 ;20
 .byte %00011000 ;20
 .byte %00011000 ;20

 .byte %00011000 ;20
 .byte %00011000 ;20
 .byte %01111110 ;20
 .byte %01111110 ;20
 .byte %01111110 ;20
 .byte %00011000 ;20
 .byte %00011000 ;20

 .byte %00011000 ;20
 .byte %00011000 ;20
 .byte %01111110 ;20
 .byte %01111110 ;20
 .byte %01111110 ;20
 .byte %00011000 ;20
 .byte %00011000 ;20

#else
 ;push
        .byte #%01110000;$1C 0
        .byte #%01110000;$78 3
        .byte #%00010000;$52 6
        .byte #%00111100;$52 9
        .byte #%00011001;$0C 12
        .byte #%00001100;$4A 15
        .byte #%00001111;$1A18

        .byte #%10100000;$1C 1
        .byte #%00111000;$78 4
        .byte #%00111000;$52 7
        .byte #%00111100;$56 10
        .byte #%00001000;$4A 13
        .byte #%00001100;$4A 16
        .byte #%00001100;$1C 19

        .byte #%11010000;$78 2
        .byte #%00101000;$78 5
        .byte #%00111000;$52 8
        .byte #%00011111;$56 11
        .byte #%00001000;$4A 14
        .byte #%00011010;$4A 17
        .byte #%00001100;$1C 20

#endif

#IF 0
;---Graphics Data from PlayerPal 2600---

Frame0
        .byte #%01110011;$1C
        .byte #%00100110;$1C
        .byte #%00110100;$78
        .byte #%00010100;$78
        .byte #%00011100;$78
        .byte #%00001000;$78
        .byte #%00010000;$52
        .byte #%00111000;$52
        .byte #%00111000;$52
        .byte #%10111000;$52
        .byte #%01111000;$56
        .byte #%00110000;$56
        .byte #%00111100;$0C
        .byte #%00110010;$4A
        .byte #%00010000;$4A
        .byte #%00011000;$4A
        .byte #%00011000;$4A
        .byte #%00110100;$4A
        .byte #%00011110;$1A
        .byte #%00011000;$1C
        .byte #%00011000;$1C
Frame1
        .byte #%00110110;$1C
        .byte #%00100100;$1C
        .byte #%00010100;$78
        .byte #%00010100;$78
        .byte #%00011100;$78
        .byte #%00001000;$78
        .byte #%00010000;$52
        .byte #%00111000;$52
        .byte #%00011000;$52
        .byte #%01111000;$52
        .byte #%00111000;$56
        .byte #%00110110;$56
        .byte #%00111100;$0C
        .byte #%00010000;$4A
        .byte #%00010000;$4A
        .byte #%00011000;$4A
        .byte #%00011000;$4A
        .byte #%00110100;$4A
        .byte #%00011110;$1A
        .byte #%00011000;$1C
        .byte #%00011000;$1C
Frame2
        .byte #%00011000;$1C
        .byte #%00110000;$1C
        .byte #%01010000;$78
        .byte #%00111000;$78
        .byte #%00011000;$78
        .byte #%00001000;$78
        .byte #%00010000;$52
        .byte #%00111000;$52
        .byte #%00111000;$52
        .byte #%00111100;$52
        .byte #%00110100;$56
        .byte #%00111100;$56
        .byte #%00111000;$0C
        .byte #%00010000;$4A
        .byte #%00010000;$4A
        .byte #%00011000;$4A
        .byte #%00011000;$4A
        .byte #%00110100;$4A
        .byte #%00011110;$1A
        .byte #%00011000;$1C
        .byte #%00011000;$1C
Frame3
        .byte #%01110000;$1C
        .byte #%10100000;$1C
        .byte #%11010000;$78
        .byte #%01110000;$78
        .byte #%00111000;$78
        .byte #%00101000;$78
        .byte #%00010000;$52
        .byte #%00111000;$52
        .byte #%00111000;$52
        .byte #%00111100;$52
        .byte #%00111100;$56
        .byte #%00011111;$56
        .byte #%00011001;$0C
        .byte #%00001000;$4A
        .byte #%00001000;$4A
        .byte #%00001100;$4A
        .byte #%00001100;$4A
        .byte #%00011010;$4A
        .byte #%00001111;$1A
        .byte #%00001100;$1C
        .byte #%00001100;$1C
Frame4
        .byte #%00110110;$1C
        .byte #%00010100;$1C
        .byte #%00010100;$78
        .byte #%00010100;$78
        .byte #%00011100;$78
        .byte #%00001100;$78
        .byte #%00010000;$52
        .byte #%00011000;$52
        .byte #%00011100;$52
        .byte #%00111100;$52
        .byte #%00111100;$56
        .byte #%00111100;$56
        .byte #%00111110;$0C
        .byte #%01011010;$4A
        .byte #%10010001;$4A
        .byte #%10011001;$4A
        .byte #%00011000;$4A
        .byte #%00011000;$4A
        .byte #%00011100;$1A
        .byte #%00011000;$1C
        .byte #%00010000;$1C
Frame5
        .byte #%00110110;$1C
        .byte #%00010100;$1C
        .byte #%00010100;$78
        .byte #%00010100;$78
        .byte #%00011100;$78
        .byte #%01001101;$78
        .byte #%01010001;$52
        .byte #%01011011;$52
        .byte #%01011110;$52
        .byte #%00111100;$52
        .byte #%00111100;$56
        .byte #%00011100;$56
        .byte #%00011000;$0C
        .byte #%00011000;$4A
        .byte #%00011000;$4A
        .byte #%00111000;$4A
        .byte #%00001000;$4A
        .byte #%00000000;$4A
        .byte #%00000000;$1A
        .byte #%00000000;$1C
        .byte #%00000000;$1C
;---End Graphics Data---


;---Color Data from PlayerPal 2600---

ColorFrame0
        .byte #$1C;
        .byte #$1C;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$56;
        .byte #$56;
        .byte #$0C;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$1A;
        .byte #$1C;
        .byte #$1C;
ColorFrame1
        .byte #$1C;
        .byte #$1C;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$56;
        .byte #$56;
        .byte #$0C;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$1A;
        .byte #$1C;
        .byte #$1C;
ColorFrame2
        .byte #$1C;
        .byte #$1C;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$56;
        .byte #$56;
        .byte #$0C;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$1A;
        .byte #$1C;
        .byte #$1C;
ColorFrame3
        .byte #$1C;
        .byte #$1C;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$56;
        .byte #$56;
        .byte #$0C;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$1A;
        .byte #$1C;
        .byte #$1C;
ColorFrame4
        .byte #$1C;
        .byte #$1C;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$56;
        .byte #$56;
        .byte #$0C;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$1A;
        .byte #$1C;
        .byte #$1C;
ColorFrame5
        .byte #$1C;
        .byte #$1C;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$78;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$52;
        .byte #$56;
        .byte #$56;
        .byte #$0C;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$4A;
        .byte #$1A;
        .byte #$1C;
        .byte #$1C;
;---End Color Data---
#ENDIF


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

;---Graphics Data from PlayerPal 2600---

PLAYER_RIGHT1
PLAYER_STAND
PLAYER_BLINK
PLAYER_TAP0
PLAYER_TAP1

;;    Sokoboo - a Sokoban implementation
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
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76


;  .byte #$1C;0
;  .byte #$78;3
;  .byte #$52;6
;  .byte #$52;9
;  .byte #$0C;12
;  .byte #$4A;15
;  .byte #$1A;18
SpriteColourGREEN
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
SpriteColourBLUE
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76
 .byte $76

;  REPEAT LINES_PER_CHARACTER        ;???
;  .byte $20|$6             ; 2
;   REPEND

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

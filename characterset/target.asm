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

TARGET_DEF = 2

#if TARGET_DEF = 2

    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_TARGET", LINES_PER_CHAR+1
;CHARACTERSHAPE_TARGET2_MIRRORED
;    .byte %00000000
CHARACTERSHAPE_TARGET
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
CHARACTERSHAPE_TARGET2_MIRRORED
    ds 21,0

    CHECKPAGE CHARACTERSHAPE_TARGET2 ; since we share one byte!

#endif

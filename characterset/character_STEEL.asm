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

    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_STEEL", LINES_PER_CHAR
CHARACTERSHAPE_STEEL
  .byte %00000000,%10001000,%00000000,%00000000,%00100010,%00000000,%00000000 ;R
  .byte %11111111,%11111111,%01110111,%11111111,%11111111,%11011101,%11111111 ;G
  .byte %11111111,%11111111,%01110111,%11111111,%11111111,%11011101,%11111111 ;B

    ;--------------------------------------------------------------------------
    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_STEEL_MIRRORED", LINES_PER_CHAR
CHARACTERSHAPE_STEEL_MIRRORED
  .byte %00000000,%00010001,%00000000,%00000000,%01000100,%00000000,%00000000 ;R
  .byte %11111111,%11111111,%11101110,%11111111,%11111111,%10111011,%11111111 ;G
  .byte %11111111,%11111111,%11101110,%11111111,%11111111,%10111011,%11111111 ;B
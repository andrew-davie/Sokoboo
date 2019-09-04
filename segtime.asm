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

; segtime optimization (averages):
;   lost time = segtime/2 * 64
;   num-segments = (vblank + overscan time) (NTSC 276=62+51=113) / 2 / segtime
;   overhead: num-segments * 8 (assuming minimal INTIM check only)
;
; segtime = 2:
;   lost time = 64
;   num-segments = 28
;   overhead = 224!
; segtime = 3:
;   lost time = 96
;   num-segments = 18
;   overhead = 144!
; segtime = 4:              <--!!!
;   lost time = 128!
;   num-segments = 28
;   overhead = 112
; segtime = 5:
;   lost time = 160!
;   num-segments = 11
;   overhead = 88
; segtime = 6:
;   lost time = 192!
;   num-segments = 9
;   overhead = 72
; segtime = 7:
;   lost time = 224!
;   num-segments = 8
;   overhead = 64
; segtime = 10:
;   lost time = 320!
;   num-segments = 5
;   overhead = 40
; segtime = 20:
;   lost time = 640!
;   num-segments = 2
;   overhead = 16
; segtime = 40:
;   lost time = 1280!
;   num-segments = 1
;   overhead = 8

; optimal INTIM segtime is 4 + 1 = 5,
; below wasted time increases rapidly, above only moderately
; if the overhead becomes larger, optimal segtimes will increase too
; also the lost time will become smaller, if smaller segments can be used instead,
;  so larger segtimes are not that bad then


 MAC SEGTIME
{1} SET {2}
TEST_{1} = 0
 ENDM

    MAC SEGTIME_C
{1} SET ({2}+32)/64 + 2
TEST_{1} = 0
    ENDM


    SEGTIME_C SEGTIME_SCD_DIRECT, 361 + CYCLES_DRAWANOTHER      ;✅ @ 4/8/2019
    SEGTIME_C SEGTIME_SCD_QUICK, 344 + CYCLES_DRAWANOTHER       ;✅ @ 4/8/2019
    SEGTIME_C SEGTIME_SCD_SLOW, 676 + CYCLES_DRAWANOTHER        ;✅ @ 4/8/2019
    SEGTIME_C SEGTIME_SCD_PF0, 88 + CYCLES_DRAWANOTHER          ;✅ @ 4/8/2019 ??

;---------------------------------------------------------------------------------------------------
; Pathways
; StealPart3, not enough time for SCD_SLOW --> 79✅
; if QuickDraw does immediate exit, 58✅


SEGTIME_SCD_MIN = SEGTIME_SCD_PF0

;    SEGTIME_C SEGTIME_SCD_MIN, SEGTIME_SCD_PF0
;---------------------------------------------------------------------------------------------------

    SEGTIME_C SEGTIME_BDF, 2512                 ;✅
    SEGTIME_C SEGTIME_BDS, 68                   ;✅
    SEGTIME_C SEGTIME_DSL, 127                  ;✅
    SEGTIME_C SEGTIME_SWITCHOBJECTS,46          ;✅

    SEGTIME_C MINIMUM_SEGTIME, 95               ;✅ processing slice minimum requirement
    SEGTIME_C SEGTIME_MINIMUM_TIMESLICE, 54     ;✅ abort time maximum requirement for timeslice

        ; Note: we add 1 to the minimum because there's a bit of overhead at the start of the timeslice code which vectors
        ; to the appropriate timeslice.  That timeslice then checks the segtime again -- and in the case of the minimum we
        ; will already have used 55 cycles of the available timeslice to get to the segtime check. Given that there are only
        ; 9 spare cycles in the 'unit' left, it's probably more efficient to abort earlier and save those 55 cycles for other
        ; uses ...


; The following timings have been physicaly timed via code/debugger... the comment shows the worst observed time.
; Generally the allocated segtime should be a bit bigger than the worst observed, to cater for the minor code
; outside the creature itself which might otherwise cause screen time over-run.

; The following are NOT object-related and timing is a bit of manual guesswork/calculation
; Comment may indicate at what value a glitch was DEFINITELY seen. These timings may not be optimal.

    SEGTIME SEGTIME_MAN,18 ;12          ;NFI

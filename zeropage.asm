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

                SEG.U variables
                ORG $80


Platform                        ds 1        ; TV system (%0x=NTSC, %10=PAL-50, %11=PAL-60)

DrawStackPointer                ds 1        ; points to start entry of drawing stack (-1 = nothing to draw)
ObjStackNum                     ds 1        ; which stack in use
ObjStackPtr                     ds 2        ; index to objects on object stack (0 = empty)
BlankStackPtr                   ds 1        ; index to blank object stack (0=empty)
ScreenDrawPhase                 ds 1        ; phase of screen drawing

POS_X                           ds 1
POS_Y                           ds 1
POS_X_NEW                       ds 1
POS_Y_NEW                       ds 1
POS_Type                        ds 1
POS_VAR                         ds 1

TB_X        ds 1
TB_Y        ds 1
TB_PUSHX    ds 1
TB_PUSHY    ds 1
TB_CHAR     ds 1

BufferedJoystick                ds 1        ; player joystick input
PreviousJoystick                ds 1

    ; Scrolling is limited to only show board within the following area...
BoardLimit_Width                ds 1        ; width of current playfield (only used in UnpackLevel)
BoardLimit_Height               ds 1        ; height of current playfield (only used in UnpackLevel)
BoardScrollY                    ds 1        ; scroll position in board (Y)
BoardScrollX                    ds 1        ; scroll position in board (X)
BoardEdge_Right                 = BoardLimit_Width  ; absolute rightmost scroll value
BoardEdge_Bottom                = BoardLimit_Height ; absolute bottommost scroll value
scrollBits                      ds 1

animation_index                 ds 1            ; new
animation                       ds 2
animation_delay                 ds 1
ManX                            ds 1
ManY                            ds 1
ManDrawX                        ds 1
ManDrawY                        ds 1
ManMode                         ds 1
ManLastDirection                ds 1            ; so we don't overwrite animations in-progress
ManTurnStart                    ds 1
ManPushCounter                  ds 1
LookingAround                   ds 1
ManAnimationID                  ds 1
ManNextAnimationID              ds 1            ; -1 for nothing
idleCount                       ds 1

DelayEndOfLevel               ds 1
jtoggle                         ds 1            ; 0/1 toggles joystick on player swapping

LEVEL_bank         ds 1
levelPtr            ds 2

    IF WAIT_FOR_INITIAL_DRAW
blankState          ds 1
    ENDIF

;---------------------------------------------------------------------------
; 2 (shared) demo mode variables:
;demoMode                        = jtoggle       ; bit 7==1 => demo mode
;moveLen                         = jtoggle       ; bits 0..6
;moveIdx                        ds 1

LastSpriteY                     ds 1

;timer                           ds 1

BGColour                        ds 1

; levelx and level have to be consecutive variables!
levelX                            ds 1            ; current player's level (other in scoring bank)
level                           ds 1            ; current player's level (other in scoring bank)
;levelDisplay                     ds 1            ; what to display as the level ID
Throttle                        ds 1            ; frame throttle to prevent super-speeds
;ThrottleSpeed                   ds 1            ; system-dependant throttle speed

BCD_targetsRequired                  ds 1           ; number of un-targeted left to go
BCD_moveCounter                        ds 1            ; BCD seconds for level
BCD_moveCounterHi                      ds 1

takebackIndex               ds 1
takebackBaseIndex                 ds 1
TakebackInhibit                 ds 1

Board_AddressR                  ds 2
Board_AddressW                  ds 2
ROM_Bank                        ds 1            ; last switched ROM bank (not accessible if RAM subsequently switched)
RAM_Bank                        ds 1

ColourTimer                     ds 1            ; colour of BG in scoring area to show level flash/complete
;ColourFlash                     ds 1             ; colour of flash
;extraLifeTimer                  ds 1            ; should be 5 seconds!

    ; extraLifeTimer:
    ;   When non-zero causes Cosmic Ark star effect in background. Used to indicate extra life.

;scoringTimer                    ds 1            ; times the various score displays
;scoringFlags                    ds 1            ; scoring flags are stored here

    ; scoringFlags:
    ; D7            Extra TARGETs in effect (TARGETs collected over requirement score more) ASSUMED BPL/BMI usage
    ; D6            unused
    ; D5            unused
    ; D4            unused
    ; D3            unused
    ; D2            unused
    ; D1    D1-D0   Which display kernel to use for scoring
    ; D0            0 = 2x4     used for TARGETs/time
    ;               1 = 1x6     used for score
    ;               2 = 3x2     used for level/lives/player

NextLevelTrigger                ds 1            ; d7 -- next level.  d6 -- loss of life
BIT_NEXTLEVEL                   = 128
BIT_NEXTLIFE                    = 64

;------------------------------------------------------------------------------

ObjIterator                     ds 1            ; count UP iterator over objects
DSL                             ds 1            ; stack line counter

ethnic                          ds 1
animate_char_index              ds 1

rndHi                           ds 1
rnd                             ds 1
icc_colour                      ds 3
FadeComplete                    ds 1
FadeOutComplete                 ds 1
fadeslow                        ds 1

seconds                         ds 2

 #include "sound/intro1_variables.asm"



OVERLAY_SIZE    SET 24



        ; This overlay variable is used for the overlay variables.  That's OK.
        ; However, it is positioned at the END of the variables so, if on the off chance we're overlapping
        ; stack space and variable, it is LIKELY that that won't be a problem, as the temp variables
        ; (especially the latter ones) are only used in rare occasions.

        ; FOR SAFETY, DO NOT USE THIS AREA DIRECTLY (ie: NEVER reference 'Overlay' in the code)
        ; ADD AN OVERLAY FOR EACH ROUTINE'S USE, SO CLASHES CAN BE EASILY CHECKED

Overlay         ds OVERLAY_SIZE       ;--> overlay (share) variables
                VALIDATE_OVERLAY "DEFINITION"


                ds RESERVED_FOR_STACK

    ECHO "FREE BYTES IN ZERO PAGE = ", $FF - *
    IF * > $FF
        ERR
    ENDIF

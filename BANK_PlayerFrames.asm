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

  NEWBANK PLAYER_FRAMES

;CL0     = $0
;CL1     = $4C   ;yellow
;CL2     = $68
;CL3     = $0C   ; cuffs/trim
;CL4     = $B8   ; jumper
;CL5     = $b2
;CL6     = $66

CL0     = $0
CL1     = 1 ;$2C   ;yellow
CL2     = 2 ;$24
CL3     = 3 ;$6A   ; cuffs/trim
CL4     = 4 ;$44
CL5     = 5 ;$B6   ; pants
CL6     = 6 ;$64



JUMP = $FF
FLIP = $FE

    MAC FLIP
    .byte FLIP,0
    ENDM

    MAC GOTO
    .byte JUMP
    .byte ANIMATION_{1}_ID
    ENDM

    MAC SHOW
    .byte FRAME_{1},{2}
    ENDM


ANIM_INDEX     SET 0
    MAC INSERT_ANIMATION ; {animation address}
ANIMATION_{1}_ID = ANIM_INDEX
    .word Animation_{1}
ANIM_INDEX     SET ANIM_INDEX + 2
    ENDM

ANIM_TABLE
    INSERT_ANIMATION WALK
    INSERT_ANIMATION IDLE
    INSERT_ANIMATION WIN
    INSERT_ANIMATION WIN2
    INSERT_ANIMATION PUSH
;    INSERT_ANIMATION PUSHTRY
    INSERT_ANIMATION PUSHUP
    INSERT_ANIMATION WALK2
    INSERT_ANIMATION TURNAROUND
    INSERT_ANIMATION YAWN
;    INSERT_ANIMATION PUSH_START


Animation_WALK
Animation_WALK2
    SHOW WALK1, 8
    SHOW WALK2, 8
    SHOW WALK3, 8
    SHOW WALK2, 8
    GOTO WALK2


Animation_WIN

Animation_WIN2

    SHOW IDLE1,10
    SHOW IDLE2,10
    SHOW IDLE1,10
    SHOW IDLE2,15
    SHOW IDLE3,15
    GOTO WIN2




Animation_WOBBLE

    ; pretty cool little wobble
    REPEAT 4
        SHOW WALK2, 10
        FLIP
        SHOW LOOK2, 10
    REPEND
    GOTO IDLE



Animation_IDLE

    REPEAT 2
        REPEAT 2
            SHOW BLINK, 2
            SHOW WALK2, 255
        REPEND
        REPEAT 6
            SHOW HANDLIP1, 20
            SHOW HANDLIP2, 20
        REPEND
        REPEAT 2
            SHOW BLINK, 2
            SHOW WALK2, 255
        REPEND
        REPEAT 3
            SHOW TAPFOOT, 10
            SHOW WALK2, 5
        REPEND
    REPEND

    SHOW LOOK3, 3
    SHOW LOOK2, 30
    SHOW LOOK3, 3

    GOTO YAWN


Animation_TURNAROUND

    SHOW LOOK3, 1
    SHOW LOOK2, 1
    SHOW LOOK1, 1
    FLIP
    GOTO IDLE

Animation_YAWN

;    SHOW WALK2, 50
    SHOW IDLE1, 10
    SHOW IDLE2, 10
    SHOW IDLE3, 150
    SHOW IDLE2, 20
    GOTO IDLE


;Animation_PUSHTRY
;    .byte FRAME_PUSH1,20
;    .byte FRAME_PUSH2,20
;    .byte JUMP,ANIMATION_PUSHTRY_ID

;Animation_PUSH_START

;    .byte FRAME_WALK2,2

Animation_PUSH

    SHOW PUSH1, 10
    SHOW PUSH2, 10
    SHOW PUSH3, 10
    SHOW PUSH2, 10
    GOTO PUSH

Animation_PUSHUP
    SHOW PUSH_UP_1, 10
    SHOW PUSH_UP_2, 10
    SHOW PUSH_UP_3, 10
    SHOW PUSH_UP_2, 10
    GOTO PUSHUP


    include "sprites/spriteData.asm"

  CHECK_BANK_SIZE "PLAYER_FRAMES"

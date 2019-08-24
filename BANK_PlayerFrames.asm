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



JUMP = $80
FLIP = $40


;ANIMATION_WALK_ID = JUMP+0
;ANIMATION_IDLE_ID = JUMP+2
;ANIMATION_WIN_ID = JUMP+4
;ANIMATION_PUSH_ID = JUMP+6
;ANIMATION_PUSHTRY_ID = JUMP+8
;ANIMATION_PUSHUP_ID = JUMP+10

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
    INSERT_ANIMATION PUSH
    INSERT_ANIMATION PUSHTRY
    INSERT_ANIMATION PUSHUP
    INSERT_ANIMATION WALK2

Animation_WALK
    .byte FRAME_WALK1,1
    .byte FRAME_WALK2,2
    .byte FRAME_WALK3,3
    .byte FRAME_WALK2,8
Animation_WALK2
    .byte FRAME_WALK1,8
    .byte FRAME_WALK2,8
    .byte FRAME_WALK3,8
    .byte FRAME_WALK2,8
    .byte JUMP,ANIMATION_WALK2_ID

Animation_WIN

#if 0
    REPEAT 2
    .byte FRAME_PUSH1, 10
    .byte FRAME_PUSH2, 10
    .byte FRAME_PUSH3, 10
    .byte FRAME_PUSH2, 10
    REPEND

;    .byte FRAME_WALK2,10

        REPEAT 1
    .byte FRAME_LOOK3, 2
    .byte FRAME_LOOK2, 3
    .byte FRAME_LOOK1, 3
    .byte FLIP, 0
    .byte FRAME_WALK2, 5
        REPEND

    .byte JUMP, ANIMATION_WIN_ID
#endif

    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,10
;    .byte FRAME_IDLE3,10
    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,15
    .byte FRAME_IDLE3,10

        REPEAT 1
    .byte FRAME_LOOK3, 2
    .byte FRAME_LOOK2, 3
    .byte FRAME_LOOK1, 3
    .byte FLIP, 0
    .byte FRAME_WALK2, 3
        REPEND

    .byte JUMP,ANIMATION_WIN_ID

Animation_IDLE

;    .byte FRAME_LOOK2, 3
;    .byte FRAME_LOOK3, 2
;    .byte FRAME_WALK2, 20






    REPEAT 2
    .byte FRAME_WALK2,100
    .byte FRAME_BLINK,2
    REPEND

    REPEAT 3
    .byte FRAME_TAPFOOT,10
    .byte FRAME_WALK2,5
    REPEND

    .byte FRAME_LOOK3,3
    .byte FRAME_LOOK2,30
    .byte FRAME_LOOK3,3

    REPEAT 2
    .byte FRAME_WALK2,100
    .byte FRAME_BLINK,2
    REPEND
    .byte FRAME_LOOKUP,40
    .byte FRAME_WALK2,20

Animation_TURNAROUND

        REPEAT 3
    .byte FRAME_LOOK3, 3
    .byte FRAME_LOOK2, 3
    .byte FRAME_LOOK1, 5
    .byte FLIP, 0
    .byte FRAME_WALK2, 10
        REPEND
;    .byte FRAME_BLINK,1
;    .byte FRAME_WALK2, 2

    .byte JUMP,ANIMATION_IDLE_ID


Animation_YAWN

    .byte FRAME_HANDLIP,40
    .byte FRAME_WALK2,50
    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,10
    .byte FRAME_IDLE3,60
    .byte FRAME_IDLE2,30
    .byte JUMP,ANIMATION_IDLE_ID




Animation_PUSHTRY
    .byte FRAME_PUSH1,30
    .byte FRAME_PUSH1,30
    .byte JUMP,ANIMATION_IDLE_ID

Animation_PUSH
    .byte FRAME_PUSH1,20
    .byte FRAME_PUSH2,20
    .byte FRAME_PUSH3,20
    .byte FRAME_PUSH2,20
    .byte JUMP,ANIMATION_PUSH_ID

Animation_PUSHUP
    .byte FRAME_PUSH_UP_1, 10
    .byte FRAME_PUSH_UP_2,10
    .byte FRAME_PUSH_UP_3,10
    .byte FRAME_PUSH_UP_2,10
    .byte JUMP,ANIMATION_PUSHUP_ID


    include "sprites/spriteData.asm"

  CHECK_BANK_SIZE "PLAYER_FRAMES"

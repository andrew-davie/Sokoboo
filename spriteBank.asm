ANIMATION_WALK_ID = 128+0
ANIMATION_IDLE_ID = 128+2
ANIMATION_WIN_ID = 128+4
ANIMATION_PUSH_ID = 128+6
ANIMATION_PUSHTRY_ID = 128+8
ANIMATION_PUSHUP_ID = 128+10

FRAME_IDLE1 = 3
FRAME_IDLE2 = 4
FRAME_IDLE3 = 5
FRAME_WALK1 = 0
FRAME_WALK2 = 1
FRAME_WALK3 = 2
FRAME_PUSH1 = 6
FRAME_PUSH2 = 7
FRAME_PUSH3 = 8
FRAME_PUSHUP1 = 9
FRAME_PUSHUP2 = 10
FRAME_PUSHUP3 = 11
FRAME_LOOK1 = 12
FRAME_LOOK2 = 13
FRAME_LOOK3 = 14
FRAME_HANDLIP = 15
FRAME_TAPFOOT = 16
FRAME_LOOKUP = 17
FRAME_BLINK = 18



ANIM_TABLE
    .word Animation_Walk
    .word Animation_IDLE
    .word Animation_WIN
    .word Animation_Push
    .word Animation_PushTry


Animation_Walk
    .byte FRAME_WALK1,8
    .byte FRAME_WALK2,8
    .byte FRAME_WALK3,8
    .byte FRAME_WALK2,8
    .byte ANIMATION_WALK_ID

Animation_WIN
    .byte FRAME_WALK2,30
    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,10
;    .byte FRAME_IDLE3,10
    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,10
    .byte FRAME_IDLE3,10
    .byte ANIMATION_IDLE_ID

Animation_IDLE

#if 0
    ; "dance"
    REPEAT 3
    .byte FRAME_TAPFOOT,2
    .byte FRAME_WALK2,1
    REPEND
    REPEAT 2
    .byte FRAME_LOOKUP,5
    .byte FRAME_WALK2,5
    REPEND
        REPEAT 2
    .byte FRAME_LOOK3, 3
    .byte FRAME_LOOK2, 4
    .byte FRAME_LOOK1, 6
    .byte FRAME_LOOK2, 4
    .byte FRAME_LOOK3, 3
    .byte FRAME_WALK2, 2
        REPEND
    REPEAT 1
    .byte FRAME_PUSH1,15
    .byte FRAME_WALK2,2
    REPEND
    .byte FRAME_IDLE1,5
    .byte FRAME_IDLE2,5
;    .byte FRAME_IDLE3,10
    .byte FRAME_IDLE1,5
    .byte FRAME_IDLE2,5
    .byte FRAME_IDLE3,5
    .byte ANIMATION_IDLE_ID
#endif



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

        REPEAT 1
    .byte FRAME_LOOK3, 2
    .byte FRAME_LOOK2, 3
    .byte FRAME_LOOK1, 20
    .byte FRAME_LOOK2, 3
    .byte FRAME_LOOK3, 2
    .byte FRAME_WALK2, 20
        REPEND

    REPEAT 2
    .byte FRAME_WALK2,100
    .byte FRAME_BLINK,2
    REPEND

    .byte FRAME_HANDLIP,40
    .byte FRAME_WALK2,50

Animation_Yawn

    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,10
    .byte FRAME_IDLE3,60
    .byte FRAME_IDLE2,30
    .byte ANIMATION_IDLE_ID




Animation_PushTry
    .byte FRAME_PUSH1,30
    .byte FRAME_PUSH1,30
    .byte ANIMATION_IDLE_ID

Animation_Push
    .byte FRAME_PUSH1,20
    .byte FRAME_PUSH2,20
    .byte FRAME_PUSH3,20
    .byte FRAME_PUSH2,20
    .byte ANIMATION_PUSH_ID

Animation_PushUP
    .byte FRAME_PUSHUP1, 10
    .byte FRAME_PUSHUP2,10
    .byte FRAME_PUSHUP3,10
    .byte FRAME_PUSHUP2,10
    .byte ANIMATION_PUSHUP_ID

FRAME_PTR_LO
    .byte <FRAME_walk_right_3_png ;0
    .byte <FRAME_walk_right_2_png ;1
    .byte <FRAME_walk_right_1_png ;2
    .byte <FRAME_idle_right_1_png ;3
    .byte <FRAME_idle_right_2_png ;4
    .byte <FRAME_idle_right_3_png ;5
    .byte <FRAME_push_right_1_png ;6
    .byte <FRAME_push_right_2_png ;7
    .byte <FRAME_push_right_3_png ;8
    .byte <FRAME_push_up_1_png ;9
    .byte <FRAME_push_up_2_png ;10
    .byte <FRAME_push_up_3_png ;11
    .byte <FRAME_walk_right_2_look_left_png ;12
    .byte <FRAME_walk_right_2_look_left2_png ;13
    .byte <FRAME_walk_right_2_look_left3_png ;14
    .byte <FRAME_handlip_png ;15
    .byte <FRAME_tapfoot_png ;16
    .byte <FRAME_lookup_png ;17
    .byte <FRAME_blink_png ;18

FRAME_PTR_HI
    .byte >FRAME_walk_right_3_png
    .byte >FRAME_walk_right_2_png
    .byte >FRAME_walk_right_1_png
    .byte >FRAME_idle_right_1_png
    .byte >FRAME_idle_right_2_png
    .byte >FRAME_idle_right_3_png
    .byte >FRAME_push_right_1_png
    .byte >FRAME_push_right_2_png
    .byte >FRAME_push_right_3_png
    .byte >FRAME_push_up_1_png
    .byte >FRAME_push_up_2_png
    .byte >FRAME_push_up_3_png
    .byte >FRAME_walk_right_2_look_left_png ;1
    .byte >FRAME_walk_right_2_look_left2_png ;1
    .byte >FRAME_walk_right_2_look_left3_png ;1
    .byte >FRAME_handlip_png ;12
    .byte >FRAME_tapfoot_png
    .byte >FRAME_lookup_png
    .byte >FRAME_blink_png ;17

COLOUR_PTR_LO
    .byte <COLOUR_walk_right_3 ;0
    .byte <COLOUR_walk_right_2 ;1
    .byte <COLOUR_walk_right_1 ;2
    .byte <COLOUR_idle_right_1 ;3
    .byte <COLOUR_idle_right_2 ;4
    .byte <COLOUR_idle_right_3 ;5
    .byte <COLOUR_push_right_1 ;6
    .byte <COLOUR_push_right_2 ;7
    .byte <COLOUR_push_right_3 ;8
    .byte <COLOUR_push_up_1 ;6
    .byte <COLOUR_push_up_2 ;7
    .byte <COLOUR_push_up_3 ;8
    .byte <COLOUR_walk_right_2_look_left ;1
    .byte <COLOUR_walk_right_2_look_left2 ;1
    .byte <COLOUR_walk_right_2_look_left3 ;1
    .byte <COLOUR_handlip
    .byte <COLOUR_tapfoot
    .byte <COLOUR_lookup
    .byte <COLOUR_blink

COLOUR_PTR_HI
    .byte >COLOUR_walk_right_3
    .byte >COLOUR_walk_right_2
    .byte >COLOUR_walk_right_1
    .byte >COLOUR_idle_right_1
    .byte >COLOUR_idle_right_2
    .byte >COLOUR_idle_right_3
    .byte >COLOUR_push_right_1
    .byte >COLOUR_push_right_2
    .byte >COLOUR_push_right_3
    .byte >COLOUR_push_up_1 ;6
    .byte >COLOUR_push_up_2 ;7
    .byte >COLOUR_push_up_3 ;8
    .byte >COLOUR_walk_right_2_look_left ;1
    .byte >COLOUR_walk_right_2_look_left2 ;1
    .byte >COLOUR_walk_right_2_look_left3 ;1
    .byte >COLOUR_handlip
    .byte >COLOUR_tapfoot
    .byte >COLOUR_lookup
    .byte >COLOUR_blink

    include "spriteData.asm"

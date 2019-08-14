FRAME_IDLE1 = 3
FRAME_IDLE2 = 4
FRAME_IDLE3 = 5
FRAME_WALK1 = 0
FRAME_WALK2 = 1
FRAME_WALK3 = 2
FRAME_PUSH1 = 6
FRAME_PUSH2 = 7
FRAME_PUSH3 = 8

Animation_Walk
    REPEAT 5
    .byte FRAME_WALK1,20, FRAME_WALK2,20, FRAME_WALK3,20, FRAME_WALK2,20
    REPEND
    .word Animation_Walk


Animation_WIN
    .byte FRAME_WALK2,30
    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,10
;    .byte FRAME_IDLE3,10
    .byte FRAME_IDLE1,10
    .byte FRAME_IDLE2,10
    .byte FRAME_IDLE3,10
    .word Animation_IDLE

Animation_IDLE
    .byte FRAME_WALK2,127
    .word Animation_IDLE

Animation_PushTry
    .byte FRAME_PUSH1,127
    .byte FRAME_PUSH1,30
    .word Animation_IDLE

Animation_Push
    .byte FRAME_PUSH1,10
    .byte FRAME_PUSH2,10
    .byte FRAME_PUSH3,10
    .byte FRAME_PUSH2,10
    .word Animation_IDLE



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





FRAME_walk_right_3_png .byte 68 ; 23
 .byte 116 ; 20
 .byte 40 ; 17
 .byte 186 ; 14
 .byte 124 ; 11
 .byte 24 ; 8
 .byte 12 ; 5
 .byte 30 ; 2
 .byte 130 ; 22
 .byte 52 ; 19
 .byte 178 ; 16
 .byte 188 ; 13
 .byte 56 ; 10
 .byte 28 ; 7
 .byte 10 ; 4
 .byte 29 ; 1
 .byte 100 ; 21
 .byte 56 ; 18
 .byte 186 ; 15
 .byte 252 ; 12
 .byte 24 ; 9
 .byte 24 ; 6
 .byte 4 ; 3
 .byte 0 ; 0
COLOUR_walk_right_3
 .byte CL6 ; 23
 .byte CL5 ; 20
 .byte CL5 ; 17
 .byte CL4 ; 14
 .byte CL4 ; 11
 .byte CL2 ; 8
 .byte CL2 ; 5
 .byte CL1 ; 2
 .byte CL6 ; 22
 .byte CL5 ; 19
 .byte CL2 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL5 ; 21
 .byte CL5 ; 18
 .byte CL3 ; 15
 .byte CL4 ; 12
 .byte CL3 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL0 ; 0
FRAME_walk_right_2_png .byte 52 ; 23
 .byte 40 ; 20
 .byte 56 ; 17
 .byte 186 ; 14
 .byte 252 ; 11
 .byte 24 ; 8
 .byte 24 ; 5
 .byte 4 ; 2
 .byte 0 ; 22
 .byte 40 ; 19
 .byte 24 ; 16
 .byte 186 ; 13
 .byte 124 ; 10
 .byte 24 ; 7
 .byte 12 ; 4
 .byte 30 ; 1
 .byte 40 ; 21
 .byte 40 ; 18
 .byte 178 ; 15
 .byte 188 ; 12
 .byte 56 ; 9
 .byte 28 ; 6
 .byte 10 ; 3
 .byte 29 ; 0
COLOUR_walk_right_2 .byte CL6 ; 23
 .byte CL5 ; 20
 .byte CL5 ; 17
 .byte CL3 ; 14
 .byte CL4 ; 11
 .byte CL3 ; 8
 .byte CL2 ; 5
 .byte CL2 ; 2
 .byte CL0 ; 22
 .byte CL5 ; 19
 .byte CL5 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL5 ; 21
 .byte CL5 ; 18
 .byte CL2 ; 15
 .byte CL4 ; 12
 .byte CL4 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL1 ; 0
FRAME_walk_right_1_png .byte 68 ; 23
 .byte 76 ; 20
 .byte 40 ; 17
 .byte 186 ; 14
 .byte 124 ; 11
 .byte 24 ; 8
 .byte 12 ; 5
 .byte 30 ; 2
 .byte 130 ; 22
 .byte 28 ; 19
 .byte 178 ; 16
 .byte 188 ; 13
 .byte 56 ; 10
 .byte 28 ; 7
 .byte 10 ; 4
 .byte 29 ; 1
 .byte 108 ; 21
 .byte 56 ; 18
 .byte 186 ; 15
 .byte 252 ; 12
 .byte 24 ; 9
 .byte 24 ; 6
 .byte 4 ; 3
 .byte 0 ; 0
COLOUR_walk_right_1 .byte CL6 ; 23
 .byte CL5 ; 20
 .byte CL5 ; 17
 .byte CL4 ; 14
 .byte CL4 ; 11
 .byte CL2 ; 8
 .byte CL2 ; 5
 .byte CL1 ; 2
 .byte CL6 ; 22
 .byte CL5 ; 19
 .byte CL2 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL5 ; 21
 .byte CL5 ; 18
 .byte CL3 ; 15
 .byte CL4 ; 12
 .byte CL3 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL0 ; 0
TestFrame
FRAME_push_right_2_png .byte 38 ; 23
 .byte 20 ; 20
 .byte 60 ; 17
 .byte 56 ; 14
 .byte 60 ; 11
 .byte 25 ; 8
 .byte 24 ; 5
 .byte 4 ; 2
 .byte 64 ; 22
 .byte 20 ; 19
 .byte 40 ; 16
 .byte 56 ; 13
 .byte 62 ; 10
 .byte 25 ; 7
 .byte 12 ; 4
 .byte 30 ; 1
 .byte 52 ; 21
 .byte 60 ; 18
 .byte 48 ; 15
 .byte 56 ; 12
 .byte 63 ; 9
 .byte 29 ; 6
 .byte 10 ; 3
 .byte 29 ; 0
COLOUR_push_right_2 .byte CL5 ; 23
 .byte CL6 ; 20
 .byte CL6 ; 17
 .byte CL3 ; 14
 .byte CL4 ; 11
 .byte CL3 ; 8
 .byte CL2 ; 5
 .byte CL2 ; 2
 .byte CL5 ; 22
 .byte CL6 ; 19
 .byte CL6 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL6 ; 21
 .byte CL6 ; 18
 .byte CL5 ; 15
 .byte CL4 ; 12
 .byte CL4 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL1 ; 0
FRAME_idle_right_2_png .byte 44 ; 23
 .byte 40 ; 20
 .byte 56 ; 17
 .byte 56 ; 14
 .byte 254 ; 11
 .byte 178 ; 8
 .byte 48 ; 5
 .byte 8 ; 2
 .byte 0 ; 22
 .byte 40 ; 19
 .byte 56 ; 16
 .byte 56 ; 13
 .byte 254 ; 10
 .byte 186 ; 7
 .byte 24 ; 4
 .byte 60 ; 1
 .byte 40 ; 21
 .byte 40 ; 18
 .byte 40 ; 15
 .byte 56 ; 12
 .byte 186 ; 9
 .byte 48 ; 6
 .byte 20 ; 3
 .byte 58 ; 0
COLOUR_idle_right_2 .byte CL5 ; 23
 .byte CL6 ; 20
 .byte CL6 ; 17
 .byte CL3 ; 14
 .byte CL4 ; 11
 .byte CL3 ; 8
 .byte CL2 ; 5
 .byte CL2 ; 2
 .byte CL0 ; 22
 .byte CL6 ; 19
 .byte CL6 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL6 ; 21
 .byte CL6 ; 18
 .byte CL5 ; 15
 .byte CL4 ; 12
 .byte CL4 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL1 ; 0
FRAME_idle_right_3_png .byte 44 ; 23
 .byte 40 ; 20
 .byte 56 ; 17
 .byte 56 ; 14
 .byte 56 ; 11
 .byte 178 ; 8
 .byte 48 ; 5
 .byte 8 ; 2
 .byte 0 ; 22
 .byte 40 ; 19
 .byte 56 ; 16
 .byte 56 ; 13
 .byte 254 ; 10
 .byte 186 ; 7
 .byte 24 ; 4
 .byte 60 ; 1
 .byte 40 ; 21
 .byte 40 ; 18
 .byte 40 ; 15
 .byte 56 ; 12
 .byte 254 ; 9
 .byte 178 ; 6
 .byte 20 ; 3
 .byte 58 ; 0
COLOUR_idle_right_3 .byte CL5 ; 23
 .byte CL6 ; 20
 .byte CL6 ; 17
 .byte CL3 ; 14
 .byte CL4 ; 11
 .byte CL3 ; 8
 .byte CL2 ; 5
 .byte CL2 ; 2
 .byte CL0 ; 22
 .byte CL6 ; 19
 .byte CL6 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL6 ; 21
 .byte CL6 ; 18
 .byte CL5 ; 15
 .byte CL4 ; 12
 .byte CL4 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL1 ; 0
FRAME_push_right_3_png .byte 70 ; 23
 .byte 114 ; 20
 .byte 24 ; 17
 .byte 56 ; 14
 .byte 62 ; 11
 .byte 25 ; 8
 .byte 12 ; 5
 .byte 30 ; 2
 .byte 128 ; 22
 .byte 62 ; 19
 .byte 48 ; 16
 .byte 56 ; 13
 .byte 63 ; 10
 .byte 29 ; 7
 .byte 10 ; 4
 .byte 29 ; 1
 .byte 100 ; 21
 .byte 60 ; 18
 .byte 56 ; 15
 .byte 60 ; 12
 .byte 25 ; 9
 .byte 24 ; 6
 .byte 4 ; 3
 .byte 0 ; 0
COLOUR_push_right_3 .byte CL5 ; 23
 .byte CL6 ; 20
 .byte CL6 ; 17
 .byte CL4 ; 14
 .byte CL4 ; 11
 .byte CL2 ; 8
 .byte CL2 ; 5
 .byte CL1 ; 2
 .byte CL5 ; 22
 .byte CL6 ; 19
 .byte CL5 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL6 ; 21
 .byte CL6 ; 18
 .byte CL3 ; 15
 .byte CL4 ; 12
 .byte CL3 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL0 ; 0
FRAME_push_right_1_png .byte 70 ; 23
 .byte 98 ; 20
 .byte 40 ; 17
 .byte 56 ; 14
 .byte 62 ; 11
 .byte 25 ; 8
 .byte 12 ; 5
 .byte 30 ; 2
 .byte 128 ; 22
 .byte 30 ; 19
 .byte 48 ; 16
 .byte 56 ; 13
 .byte 63 ; 10
 .byte 29 ; 7
 .byte 10 ; 4
 .byte 29 ; 1
 .byte 100 ; 21
 .byte 60 ; 18
 .byte 56 ; 15
 .byte 60 ; 12
 .byte 25 ; 9
 .byte 24 ; 6
 .byte 4 ; 3
 .byte 0 ; 0
COLOUR_push_right_1 .byte CL5 ; 23
 .byte CL6 ; 20
 .byte CL6 ; 17
 .byte CL4 ; 14
 .byte CL4 ; 11
 .byte CL2 ; 8
 .byte CL2 ; 5
 .byte CL1 ; 2
 .byte CL5 ; 22
 .byte CL6 ; 19
 .byte CL5 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL6 ; 21
 .byte CL6 ; 18
 .byte CL3 ; 15
 .byte CL4 ; 12
 .byte CL3 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL0 ; 0
FRAME_idle_right_1_png .byte 44 ; 23
 .byte 40 ; 20
 .byte 56 ; 17
 .byte 186 ; 14
 .byte 252 ; 11
 .byte 24 ; 8
 .byte 24 ; 5
 .byte 4 ; 2
 .byte 0 ; 22
 .byte 40 ; 19
 .byte 56 ; 16
 .byte 186 ; 13
 .byte 124 ; 10
 .byte 24 ; 7
 .byte 12 ; 4
 .byte 30 ; 1
 .byte 40 ; 21
 .byte 40 ; 18
 .byte 170 ; 15
 .byte 188 ; 12
 .byte 56 ; 9
 .byte 28 ; 6
 .byte 10 ; 3
 .byte 29 ; 0
COLOUR_idle_right_1 .byte CL6 ; 23
 .byte CL5 ; 20
 .byte CL5 ; 17
 .byte CL3 ; 14
 .byte CL4 ; 11
 .byte CL3 ; 8
 .byte CL2 ; 5
 .byte CL2 ; 2
 .byte CL0 ; 22
 .byte CL5 ; 19
 .byte CL5 ; 16
 .byte CL4 ; 13
 .byte CL4 ; 10
 .byte CL2 ; 7
 .byte CL2 ; 4
 .byte CL1 ; 1
 .byte CL5 ; 21
 .byte CL5 ; 18
 .byte CL2 ; 15
 .byte CL4 ; 12
 .byte CL4 ; 9
 .byte CL2 ; 6
 .byte CL2 ; 3
 .byte CL1 ; 0

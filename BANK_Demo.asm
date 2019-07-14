;    NEWBANK DEMO_BANK
    DEFINE_1K_SEGMENT DEMO

MOVE_NONE   = ~0
MOVE_RIGHT  = ~%10000000
MOVE_LEFT   = ~%01000000
MOVE_DOWN   = ~%00100000
MOVE_UP     = ~%00010000

    DEFINE_SUBROUTINE AdvanceJoystick

                lda #$F0
                sta BufferedJoystick            ; processed joystick OK, so clear any direction bits
                sta BufferedJoystick+1

                bit demoMode
                bpl noAdvance
                dec moveLen
                bmi noAdvance
                inc moveIdx
                ldy moveIdx
                lda MoveLenTbl-1,y      ; 4
                sta moveLen             ; 3

noAdvance       rts

;===============================================================================
; code starts here
;===============================================================================

    DEFINE_SUBROUTINE GetJoystickForDemoMode ; = 42/49/49

                bit demoMode                    ; 3
                bpl .normalMode                 ; 2/3= 5/6

    ; if in demo mode, the joystick direction is returned by the demo date

                lda INPT4                       ; 4
                bpl .exitDemo                   ; 2/3= 6/7      interrupt demo
                sta BufferedButton

                ldy moveIdx                     ; 3
                lda MoveDirTbl-1,y              ; 4
                bne .setMove                    ; 3 = 29

.exitDemo       lda NextLevelTrigger            ; 3
                and #<(~BIT_NEXTLEVEL)          ; 2
                sta NextLevelTrigger            ; 3
                rts                             ; 6

.setMove        sta BufferedJoystick            ; 3
                sta BufferedJoystick+1          ; 3

.normalMode     rts                             ; 6

;-------------------------------------------------------------------------------

MoveLenTbl
    .byte   $80|32  ; MOVE_NONE
    .byte   $80|0   ; MOVE_UP
    .byte   $80|6   ; MOVE_RIGHT
    .byte   $80|1   ; MOVE_DOWN
    .byte   $80|8   ; MOVE_RIGHT  ; D1    148
    .byte   $80|5   ; MOVE_NONE
    .byte   $80|1   ; MOVE_DOWN
    .byte   $80|3   ; MOVE_RIGHT
    .byte   $80|2   ; MOVE_UP
    .byte   $80|0   ; MOVE_LEFT   ; D2    144
    .byte   $80|5   ; MOVE_NONE
    .byte   $80|0   ; MOVE_UP
    .byte   $80|10  ; MOVE_RIGHT
    .byte   $80|0   ; MOVE_DOWN
    .byte   $80|1   ; MOVE_RIGHT
    .byte   $80|5-1 ; MOVE_NONE   ;       141
    .byte   $80|5   ; MOVE_DOWN
    .byte   $80|0+1 ; MOVE_RIGHT
    .byte   $80|3   ; MOVE_DOWN
    .byte   $80|2 ;+1 ; MOVE_LEFT   ; D3    139+1     fixes broken demo!
    .byte   $80|4   ; MOVE_NONE
    .byte   $80|0   ; MOVE_DOWN
    .byte   $80|0   ; MOVE_LEFT   ; D4
    .byte   $80|3   ; MOVE_RIGHT
    .byte   $80|2+1 ; MOVE_LEFT   ; D5
    .byte   $80|4   ; MOVE_NONE
    .byte   $80|3   ; MOVE_UP
    .byte   $80|4   ; MOVE_LEFT   ; D6
    .byte   $80|0   ; MOVE_UP
    .byte   $80|4   ; MOVE_NONE
    .byte   $80|4   ; MOVE_LEFT   ; D7+8
    .byte   $80|3   ; MOVE_DOWN   ; D9
    .byte   $80|2   ; MOVE_LEFT   ; D10   133+1
    .byte   $80|4   ; MOVE_NONE
    .byte   $80|2   ; MOVE_UP
    .byte   $80|7   ; MOVE_LEFT
    .byte   $80|0   ; MOVE_UP
    .byte   $80|4+1 ; MOVE_LEFT   ; D11
    .byte   $80|0   ; MOVE_DOWN
    .byte   $80|5+1 ; MOVE_LEFT
    .byte   $80|3   ; MOVE_DOWN
    .byte   $80|0   ; MOVE_RIGHT  ; D12   130
    .byte   $80|4   ; MOVE_NONE
    .byte   $80|1   ; MOVE_DOWN
    .byte   $80|3   ; MOVE_RIGHT
    .byte   $80|4   ; MOVE_DOWN
    .byte   $80|3   ; MOVE_LEFT   ; D13   127
    .byte   $80|1+1 ; MOVE_UP
    .byte   $80|1   ; MOVE_RIGHT
    .byte   $80|2   ; MOVE_UP
    .byte   $80|15  ; MOVE_RIGHT  ; D14   125
    .byte   $80|4   ; MOVE_NONE
    .byte   $80|0   ; MOVE_DOWN
    .byte   $80|4   ; MOVE_RIGHT
    .byte   $80|0   ; MOVE_DOWN
    .byte   $80|3   ; MOVE_RIGHT
    .byte   $80|1   ; MOVE_DOWN   ; D15/6 122
    .byte   $80|4   ; MOVE_NONE
    .byte   $80|4   ; MOVE_RIGHT
    .byte   $80|3+1 ; MOVE_UP     ;       121
    .byte   $80|4   ; MOVE_RIGHT
    .byte   $80|4   ; MOVE_NONE   ;       119
    .byte   $80|127 ; MOVE_DOWN   ; 329 points

MoveDirTbl
    .byte   MOVE_NONE
    .byte   MOVE_UP
    .byte   MOVE_RIGHT
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT  ; D1    148
    .byte   MOVE_NONE
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT
    .byte   MOVE_UP
    .byte   MOVE_LEFT   ; D2    144
    .byte   MOVE_NONE
    .byte   MOVE_UP
    .byte   MOVE_RIGHT
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT
    .byte   MOVE_NONE   ;       141
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT
    .byte   MOVE_DOWN
    .byte   MOVE_LEFT   ; D3    139
    .byte   MOVE_NONE
    .byte   MOVE_DOWN
    .byte   MOVE_LEFT   ; D4
    .byte   MOVE_RIGHT
    .byte   MOVE_LEFT   ; D5
    .byte   MOVE_NONE
    .byte   MOVE_UP
    .byte   MOVE_LEFT   ; D6
    .byte   MOVE_UP
    .byte   MOVE_NONE
    .byte   MOVE_LEFT   ; D7/8
    .byte   MOVE_DOWN   ; D9
    .byte   MOVE_LEFT   ; D10   134
    .byte   MOVE_NONE
    .byte   MOVE_UP
    .byte   MOVE_LEFT
    .byte   MOVE_UP
    .byte   MOVE_LEFT   ; D11
    .byte   MOVE_DOWN
    .byte   MOVE_LEFT
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT  ; D12   129
    .byte   MOVE_NONE
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT
    .byte   MOVE_DOWN
    .byte   MOVE_LEFT   ; D13   127
    .byte   MOVE_UP
    .byte   MOVE_RIGHT
    .byte   MOVE_UP
    .byte   MOVE_RIGHT  ; D14   125
    .byte   MOVE_NONE
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT
    .byte   MOVE_DOWN
    .byte   MOVE_RIGHT
    .byte   MOVE_DOWN   ; D15/6 122
    .byte   MOVE_NONE
    .byte   MOVE_RIGHT
    .byte   MOVE_UP     ;       121
    .byte   MOVE_RIGHT
    .byte   MOVE_NONE   ;       119
    .byte   MOVE_DOWN   ; 329 points


    ;------------------------------------------------------------------------------
    MAC CHECKSOUNDS
                lda soundIdxLst+1
                cmp #OFSS_MAGIC_WALL+1          ; Amoeba or Magic Wall?
                bcs .waitForIt
                STOP_CHANNEL 1                  ; yes, stop repeating sounds
                lda soundIdxLst
.waitForIt
    ENDM
    ;------------------------------------------------------------------------------

   DEFINE_SUBROUTINE NextCave

                CHECKSOUNDS                 ; wait until all sounds are over
                bne .skipNextLevel

    ; Now do the actual switching

                lda NextLevelTrigger
                and #<(~BIT_NEXTLEVEL)
                sta NextLevelTrigger

    ; Next level is due. Point to the next cave, but if we're at the end of playable caves,
    ; then increment the level number. This is completely circular, so we eventually wrap
    ; the cave back to 0 and start afresh. The level maxes out at P5 then remains at the top.

NextCaveAlong   lda cave
                clc
                adc #CAVE_DATA_SIZE
                cmp #MAX_CAVENUM
                bcc .caveOK

                ldx level
                cpx #NUM_LEVELS-1
                bcs .skipIncLevel
                inc level
.skipIncLevel

                lda #0
.caveOK         sta cave
.skipNextLevel  rts


    CHECK_BANK_SIZE "DEMO_BANK"

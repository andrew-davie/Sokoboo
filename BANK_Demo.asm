;    NEWBANK DEMO_BANK
    DEFINE_1K_SEGMENT DEMO

MOVE_NONE   = ~0
MOVE_RIGHT  = ~%10000000
MOVE_LEFT   = ~%01000000
MOVE_DOWN   = ~%00100000
MOVE_UP     = ~%00010000

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

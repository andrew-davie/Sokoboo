    DEFINE_1K_SEGMENT DEMO


   DEFINE_SUBROUTINE NextLevelX

    ; Now do the actual switching

                lda NextLevelTrigger
                and #<(~BIT_NEXTLEVEL)
                sta NextLevelTrigger

    ; Next level is due. Point to the next level, but if we're at the end of playable levels,
    ; then increment the level number. This is completely circular, so we eventually wrap
    ; the level back to 0 and start afresh.

                lda levelX
                clc
                adc #LEVEL_DEFINITION_SIZE
                cmp #LEVELNUM
                bcc .level_ok

                lda #0
.level_ok       sta levelX
                rts


    CHECK_BANK_SIZE "DEMO_BANK"

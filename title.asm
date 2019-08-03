
                lda #1
                sta POS_Y

filx            lda #9
                sta POS_X

                lda #BANK_GetBoardAddressW
                sta SET_BANK
                ldy POS_Y
                jsr GetBoardAddressW
                stx RAM_Bank
filline
                clc
                lda POS_X
                tay
                adc #CHARACTER_TITLE_0_0
                sta POS_Type

                IF MULTI_BANK_BOARD = YES
                ldx RAM_Bank
                ELSE
                ldx #BANK_BOARD
                ENDIF

                jsr PutBoardCharacter

                dec POS_X
                bpl filline
                dec POS_Y
                bpl filx




NewFrameStart2

                bit NextLevelTrigger
                ;bpl NextLevelLevel2               ; game-triggered next level
                ;bvs RestartLevelNextPlayer       ; loss of life

    ; Note: VSYNC must NOT be on when starting a new level! Else you get annoying TV signals.

                lda #%1110                       ; VSYNC ON
.loopVSync2     sta WSYNC
                sta VSYNC
                lsr
                bne .loopVSync2                 ; branch until VYSNC has been reset

 ; moved *after* the loop since this allows to *increase* timer values by 1!

                ldx Platform
                ldy VBlankTime,x
                sty TIM64T

                jsr StealCharDraw               ; NOTE THIS IS THE *ONLY* AREA BIG ENOUGH FOR > 30 INTIM NEEDS
                lda #$22
                sta COLUBK
    ;---------------------------------------------------------------------------
    ; START OF DISPLAY

                lda #BANK_SCORING               ; 2
                sta SET_BANK_RAM                ; 3
                jsr DrawDigits                  ; 6 = 11

    ;---------------------------------------------------------------------------
    ; A 42-cycle timing window in the screen draw code.  Perform any general
    ; per-frame code here, provided it takes exactly 42 cycles to execute.
    ; TJ: Well, not exactly 42 cycles, but it works! :)
                                            ;       @09
                sta COLUBK                  ; 3     value comes from subroutine
                                            ; + the 'black' left-side of top screen colour change when look-around is actually a HMOVE bar, so we can't fix it :)


;                inc Throttle                ; 5     speed limiter
                SLEEP 5                     ;       TODO: optimize for space

                lda #%00010101              ; 2     double width missile, double width player
                dex                         ; 2     = $6f, stars effect!
                stx HMM0                    ; 3     @24, exactly 21 cycles after the HMOVE

                sta NUSIZ0                  ; 3
                sty VDELP0                  ; 3     y = 0!

                SLEEP 10
                ;iny                         ; 2     this relies on Y == 0 before...
                ;cpy extraLifeTimer          ; 3     ..,and bit 0 is set in A
                ;adc #2                      ; 2
                ;sta ENAM0                   ; 3     dis/enable Cosmic Ark star effect

                lda ManLastDirection        ; 3
                sta REFP0                   ; 3

                lda #BANK_SCREENMARKII1     ; 2
                sta SET_BANK_RAM            ; 3
                jsr DrawTheScreen           ; 6     @57 from RAM, no less!!
                                            ;       @66
                lda #BANK_PostScreenCleanup ; 2
                sta SET_BANK                ; 3
                jsr PostScreenCleanup       ; 6+x

                ;lda #BANK_SelfModDrawPlayers; 2
                ;sta SET_BANK                ; 3
                ;jsr SelfModDrawPlayers      ; 6+x

                ;jsr StealCharDraw

OverscanBD2      lda INTIM                   ;4
                bne OverscanBD2              ;2/3
                beq NewFrameStart2

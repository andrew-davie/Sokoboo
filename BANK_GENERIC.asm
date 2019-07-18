    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

            NEWBANK GENERIC_BANK_1



    DEFINE_1K_SEGMENT DECODE_CAVE_SHADOW
            include "DecodeCave.asm"

            CHECK_HALF_BANK_SIZE "GENERIC_BANK_1 (DECODE_CAVE)"

    ;------------------------------------------------------------------------------
    ; ... the above is a RAM-copied section -- the following is ROM-only.  Note that
    ; we do not configure a 1K boundary, as we con't really care when the above 'RAM'
    ; bank finishes.  Just continue on from where it left off...
    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE Cart_Init ; in GENERIC_BANK_1

    ; Note the variables from the title selection are incredibly transient an can be stomped
    ; at any time.  So they need to be used immediately.


    ; odd usage below is to prevent any possibility of variable stomping/assumptions

                lda sCave                                       ; cave # from title select
                pha
                lda sPlayers
                ldx sLevel                                      ; level # from title select
                ldy sJoysticks
                sty jtoggle
                stx level
                sta MenCurrent                                  ; = #players
                pla
                sta cave                                        ; make an immediate copy to safe variables!

    IF FINAL_VERSION
                asl
                asl
                adc cave                                       ; *5 because it only cycles 0/1/2/3 equaing to caves 0/5/10/15
                sta cave
    ENDIF
                sta startCave

    ; multiply with CAVE_DATA_SIZE (5):
                asl
                asl
                adc cave
                sta cave

                lda #1
                sta whichPlayer                                 ; will switch to 0 on 1st go

                lda #NUM_LIVES<<4                               ; 3 lives
                ldx MenCurrent                                  ; = sPlayers
                beq opg
                lda #NUM_LIVES<<4|NUM_LIVES
opg             sta MenCurrent                                  ; P2P1 nybble each

    ;---------------------------------------------------------------------------

                lda #0
                sta SWBCNT                      ; console I/O always set to INPUT
                sta SWACNT                      ; set controller I/O to INPUT
                sta HMCLR

    ; cleanup remains of title screen
                sta GRP0
                sta GRP1
                sta GRP0

                sta ScreenDrawPhase             ; sequences the sections of gameplay/screen drawing

;    IFCONST DEBUG_CREATURE
;                sta worstTime
;    ENDIF

                lda #%100                       ; players/missiles BEHIND BG
                sta CTRLPF
                sta rnd                         ; anything non-0

                lda #$FF
                sta DrawStackPointer

                lda #DIRECTION_BITS
                sta ManLastDirection

                lda #0
;                sta ObjStackPtr                 ; object stack index of last entry
;                sta ObjStackPtr+1
;                sta ObjStackNum
;                sta ObjIterator

                sta sortPtr
                lda #<(-1)
                sta sortRequired

; read high score from SaveKey and store in highScoreSK,
; which is transferred to high score variable in RAM by GeneralScoringSetups
                jmp ReadSaveKey

;LEVEL0CREATURE  .byte TYPE_MAN,         0,      3,      5
;                .byte -1

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE SwapPlayersGeneric

    ; at the start of a cave (or player, doesn't matter) we grab the current state of the colour/B&W switch
    ; into the gameMode variable.

                lda gameMode
                and #~(BW_SWITCH|GAMEMODE_PAUSED)
                sta gameMode
                lda SWCHB
                and #BW_SWITCH
                ora gameMode                    ; COLOR/B&W @start of level stored in gameMode -- so now we just detect a CHANGE is pause
                sta gameMode                    ; also, BIT7=0 -- system is NOT paused


    ; restart cave
                lda NextLevelTrigger
                and #<(~BIT_NEXTLIFE)
                sta NextLevelTrigger

    ; if new high score was set by SwapPlayers, update it:

                jmp WriteSaveKey


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE CreateCreatures ; GENERIC_BANK_1


    ; Calculate rightmost value for scrolling edge.  .

                sta ROM_Bank

                sec
                lda BoardLimit_Width
                sbc #SCREEN_WIDTH-1
                sta BoardEdge_Right              ; absolute rightmost scroll value
  IF INITIAL_SCROLL = YES
                sbc #1
                cmp BoardScrollX
                bcs .Xok
                sta BoardScrollX
                sec
.Xok
  ENDIF

;                sec                        already set
                lda BoardLimit_Height
                sbc #SCREEN_LINES-1
                sta BoardEdge_Bottom            ; absolute bottommost scroll value
  IF INITIAL_SCROLL = YES
                sbc #1
                cmp BoardScrollY
                bcs .Yok
                sta BoardScrollY
.Yok
  ENDIF

    ; kludge position scroll roughly at player

;TODO: "correct" BD scrolling.
; The game scrolls from the players last position (no difference between 1st and 2nd player)

  IF INITIAL_SCROLL = NO
;                sec                    already set
                lda ManX
                sbc #5
                bcs notL0
                lda #0
notL0           sta BoardScrollX


                sec
                lda ManY
                sbc #5                    ; TJ: why 5???
                bcs notU0
                lda #0
notU0           sta BoardScrollY
  ENDIF

                lda #0
                sta ManMode
                sta ManDelayCount

                lda #AnimateBLANK-Manimate ;0 ;<AnimateBLANK ;STAND
                sta ManAnimation
                ;lda #>AnimateBLANK ;
                ;sta ManAnimation+1

                lda #$FF
                sta LastSpriteY

                lda #DIRECTION_BITS
                sta ManLastDirection

                bit amoebaFlag                      ; AMOEBA_PRESENT?
                bvc .noAmoeba

                ldx amoebaMaxX
                stx amoebaX
                ldy amoebaMaxY
                sty amoebaY
                lda #1
                sta amoebaStepCount
                sta amoebaCount                     ; doesn't matter to be 1 too big here initially
;               lda #0
                ;sta amoebaFlag                     ; now initialised in DecodeCave
;               sta amoebaCount
                lda magicAmoebaTime                 ; setup slow growth time
                sta MagicAmoebaFlag                 ;
.noAmoeba

                rts

    ;-------------------------------------------------------------------------------------

    DEFINE_SUBROUTINE LevelInit ; in GENERIC_BANK_1

                lda #0
                sta ObjStackPtr
                sta ObjStackPtr+1               ; kill all creatures
                sta ObjStackNum
                sta ObjIterator

                sta scrollBits
                sta ScreenDrawPhase

                sta BGColour
                sta ColourTimer
                sta extraLifeTimer              ; Cosmic Ark stars off

                sta soundIdxLst
                sta soundIdxLst+1
                sta newSounds

                sta AUDV0
                sta AUDV1                           ; turn off music while levels init
;                sta AUDC0

                sta ManLastDirection
                sta ManPushCounter

                sta sortPtr                     ; sort stopped
                lda #<(-1)
                sta sortRequired                ; nothing needed
                sta DrawStackPointer


                lda #MAGIC_WALL_DORMANT
                sta MagicAmoebaFlag

                lda #DISPLAY_LIVES
                sta scoringFlags
                lda #SCORING_TIMER_FIRST                 ; We want the first timer display to be long, to show level and lives
                sta scoringTimer
                rts

    ;-------------------------------------------------------------------------------------


    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE Resync
                RESYNC
Ret             rts

    ;---------------------------------------------------------------------------
Manimate
AnimateSTAND
AnimateSTOPPED
    .byte 127
    .byte <PLAYER_STAND
    ;.byte 10
    ;.byte < PLAYER_BLINK
    ;.byte 127
    ;.byte < PLAYER_STAND
    ;.byte 0
    ;.word AnimateTAP

AnimateTAP
    ;.byte 128, %0                   ; reflect off, always tap with left foot
    ;.byte 8
    ;.byte < PLAYER_TAP0
    ;.byte 8
    ;.byte < PLAYER_TAP1
    ;.byte 8
    ;.byte < PLAYER_TAP0
    ;.byte 8
    ;.byte < PLAYER_TAP1
    ;.byte 8
    ;.byte < PLAYER_TAP0
    ;.byte 8
    ;.byte < PLAYER_TAP1
    .byte 0
    .byte AnimateSTAND-Manimate ;word AnimateSTAND

AnimateRIGHT
    .byte 128, %0                   ; reflect off
    .byte 5
    .byte < PLAYER_RIGHT0
    .byte 5
    .byte < PLAYER_RIGHT1
    .byte 0
    .byte AnimateRIGHT-Manimate ;word AnimateRIGHT

AnimateLEFT
    .byte 128, %1000                ; reflect ON
    .byte 5
    .byte < PLAYER_RIGHT0
    .byte 5
    .byte < PLAYER_RIGHT1
    .byte 0
    .byte AnimateLEFT-Manimate ;word AnimateLEFT

;AnimateUP
;    .byte 128, %0                ; reflect off
;    .byte 5
;    .byte < PLAYER_TAP
;    .byte 128, %1000
;    .byte 5
;    .byte < PLAYER_TAP
;    .byte 0
;    .word AnimateUP

AnimateUP                           ; keep last reflection, like in original game
    .byte 5
    .byte < PLAYER_RIGHT0
    .byte 5
    .byte < PLAYER_RIGHT1
    .byte 0
    .byte AnimateUP-Manimate ;word AnimateUP

AnimateBLANK
    .byte 127
    .byte < PLAYER_BLANK
    .byte 0
    .byte AnimateBLANK-Manimate ;word AnimateBLANK

AnimateEND
    CHECKPAGEX Manimate, "AnimateEND @ BANK_GENERIC"
    ;---------------------------------------------------------------------------


    DEFINE_SUBROUTINE TrackPlayer ; =145; in GENERIC_BANK_1

                lda LookingAround               ; 3
                bmi Ret                         ; 2/3=5/6   don't track when looking around

    ; Contribution by Thomas Jentzsch

; scrolling constants:
.SCRL_START_LEFT    = 3                                 ; 3
.SCRL_STOP_LEFT     = 3 ;SCREEN_WIDTH-5                    ; 5 scrolls 5-3+1 = 3 pixel
.SCRL_START_RIGHT   = SCREEN_WIDTH-.SCRL_START_LEFT     ; 7
.SCRL_STOP_RIGHT    = SCREEN_WIDTH-.SCRL_STOP_LEFT      ; 5
.SCRL_LEFT_BIT      = %00010001
.SCRL_RIGHT_BIT     = %00100010
.SCRL_X_BITS        = .SCRL_LEFT_BIT|.SCRL_RIGHT_BIT

.SCRL_START_UP      = 2                                 ; 2
.SCRL_STOP_UP       = 2 ;SCREEN_LINES-5                    ; 3 scrolls 3-2+1 = 2 pixel
.SCRL_START_DOWN    = SCREEN_LINES-.SCRL_START_UP       ; 6
.SCRL_STOP_DOWN     = SCREEN_LINES-.SCRL_STOP_UP        ; 5
.SCRL_UP_BIT        = %01000100
.SCRL_DOWN_BIT      = %10001000
.SCRL_Y_BITS        = .SCRL_UP_BIT|.SCRL_DOWN_BIT

; *** horizontal scrolling (unoptimized version): ***

    ; check for enabling horizontal scrolling:
                lda ManX                        ; 3
                sec                             ; 2
                sbc BoardScrollX                ; 3
                tay                             ; 2         for later use
                lda #.SCRL_LEFT_BIT             ; 2
                cpy #.SCRL_START_LEFT           ; 2         <3?
                bmi .startXScroll               ; 2/3       yes, scroll left
                cpy #.SCRL_START_RIGHT          ; 2         <8?
                bmi .skipStartXScroll           ; 2/3       no
                lda #.SCRL_RIGHT_BIT            ; 2 = 22    yes, scroll right
.startXScroll:
                and #.SCRL_X_BITS >> 4          ; 2
                ora scrollBits                  ; 3
                sta scrollBits                  ; 3 =  8
.skipStartXScroll:

    ; do horizontal scrolling:
                lda scrollBits                  ; 3
                and #.SCRL_X_BITS >> 4          ; 2
                beq .skipXScroll                ; 2/3
                and #.SCRL_RIGHT_BIT            ; 2
                bne .xScrollRight               ; 2/3=11/12

    ; scroll left:
                lda BoardScrollX                ; 3         already at left edge?
                beq .stopXScroll                ; 2
                dec BoardScrollX                ; 5
                cpy #.SCRL_STOP_LEFT-1          ; 2
                bpl .stopXScroll                ; 2/3=15
                bmi .skipXScroll                ; 3
;---------------------------------------
.xScrollRight:
                ldx BoardScrollX                ; 3
                inx                             ; 2
                cpx BoardEdge_Right             ; 3         already at right edge?
                bpl .stopXScroll                ; 2/3
                stx BoardScrollX                ; 3
                cpy #.SCRL_STOP_RIGHT+1         ; 2
                bpl .skipXScroll                ; 2/3=17/18
.stopXScroll:
                lda scrollBits                  ; 3
                and #(~(.SCRL_X_BITS >> 4))     ; 2
                sta scrollBits                  ; 3 =  8
.skipXScroll:
; worst case: 22 + 8 + 12 + 17 + 8 = 67

; *** vertical scrolling (unoptimized version): ***

    ; check for enabling vertical scrolling:
                lda ManY                        ; 3
                sec                             ; 2
                sbc BoardScrollY                ; 3
                tay                             ; 2         for later use
                lda #.SCRL_UP_BIT               ; 2
                cpy #.SCRL_START_UP             ; 2         <2?
                bmi .startYScroll               ; 2/3       yes, scroll up
                cpy #.SCRL_START_DOWN           ; 2         <6?
                bmi .skipStartYScroll           ; 2/3
                lda #.SCRL_DOWN_BIT             ; 2 = 22    yes, scroll down
.startYScroll:
                and #.SCRL_Y_BITS >> 4          ; 2
                ora scrollBits                  ; 3
                sta scrollBits                  ; 3 =  8
.skipStartYScroll:

    ; do vertical scrolling:
                lda scrollBits                  ; 3
                and #.SCRL_Y_BITS               ; 2
                beq .skipYScroll                ; 2/3
                and #.SCRL_DOWN_BIT             ; 2
                bne .yScrollDown                ; 2/3=11/12

    ; scroll up
                lda BoardScrollY                ; 3
                beq .stopYScroll                ; 2
                dec BoardScrollY                ; 5
                cpy #.SCRL_STOP_UP-1            ; 2
                bpl .stopYScroll                ; 2/3=15
                bmi .skipYScroll                ; 3
;---------------------------------------
.yScrollDown:
                ldx BoardScrollY                ; 3
                inx                             ; 2
                cpx BoardEdge_Bottom      ;     ; 3
                bpl .stopYScroll                ; 2/3
                stx BoardScrollY                ; 3
                cpy #.SCRL_STOP_DOWN+1          ; 2
                bpl .skipYScroll                ; 2/3=17/18
.stopYScroll:
                lda scrollBits                  ; 3
                and #(~(.SCRL_Y_BITS >> 4))     ; 2
                sta scrollBits                  ; 3 =  8
.skipYScroll:
; worst case: 22 + 8 + 12 + 17 + 8 = 67

EarlyAbortx     rts                             ; 6 =  6
; total: 5+67*2+6 = 145

    ;------------------------------------------------------------------------------



; worst case time from positive last check to rts: 123
; cycles until 0-check: 15
; minimum cycles available after last positive check until timer turns 0: (MINIMUM_SORT_TIME-1)*64+1
; MINIMUM_SORT_TIME = 3 = 129
; MINIMUM_SORT_TIME = 4 = 193 <- ok

;------------------------------------------------------------------------------

;    DEFINE_SUBROUTINE PrepareTimeVector ; = 27

;                ldx ScreenDrawPhase             ; 3           ; current phase of drawing
;                lda TS_PhaseVectorLO,x          ; 4
;                sta TS_Vector                   ; 3
;                lda TS_PhaseVectorHI,x          ; 4
;                sta TS_Vector+1                 ; 3

;                lda TS_PhaseBank,x              ; 4
                ;sta ROM_Bank                    ; 4        GUESS!  SEEMS TO RUN OK WITHOUT THIS.
;                rts                             ; 6

;------------------------------------------------------------------------------

; This is a GOOD home for these tables.  Move AD's tables here and fix code appropriately

    DEFINE_SUBROUTINE TS_PhaseVectorLO

    ; Gives LO byte of addresses of subroutines for timeslice processing

                .byte <ProcessObjStack
                .byte <DrawFullScreen
                .byte <BuildDrawStack
                .byte <DrawAIntoStack
                .byte <SwitchObjects

TS_PhaseVectorHI

    ; Gives HI byte of addresses of subroutines for timeslice processing

                .byte >ProcessObjStack
                .byte >DrawFullScreen
                .byte >BuildDrawStack
                .byte >DrawAIntoStack
                .byte >SwitchObjects

TS_PhaseBank

    ; Gives bank of subroutines for timeslice processing

                .byte BANK_ProcessObjStack
                .byte BANK_DrawFullScreen
                .byte BANK_DRAW_BUFFERS ;BANK_BuildDrawStack
                .byte BANK_DRAW_BUFFERS ;BANK_BuildDrawStack2
                .byte BANK_SwitchObjects

;------------------------------------------------------------------------------
lookColour2     .byte $02, $02
                .byte $04, $04

OverscanTime
    .byte OVERSCAN_TIM_NTSC, OVERSCAN_TIM_NTSC
    .byte OVERSCAN_TIM_PAL, OVERSCAN_TIM_NTSC




    DEFINE_SUBROUTINE PostScreenCleanup

                iny                             ; --> 0

                sty COLUBK                      ; starts colour change bottom score area, wraps to top score area
                                                ; + moved here so we don't see a minor colour artefact bottom of screen when look-arounding

                sty PF0                         ; why wasn't this here?  I saw colour glitching in score area!
                                                ; TJ: no idea why, but you had removed it in revision 758 ;)
                                                ; completely accidental -- one of our cats may have deleted it.
                sty PF1
                sty PF2
                sty ENAM0
                sty GRP0                        ; when look-scrolling, we can see feet at the top if these aren't here
                sty GRP1                        ; 30/12/2011 -- fix dots @ top!



    ; D1 VBLANK turns off beam
    ; It needs to be turned on 37 scanlines later

                lda #%01000010                  ; bit6 is not required
                sta VBLANK                      ; end of screen - enter blanking

    ;------------------------------------------------------------------------------
    ; This is where the PAL system has a bit of extra time on a per-frame basis.

                ldx Platform
                lda OverscanTime,x
                sta TIM64T

    ; Background colour priorities. Increasing order of priority...
    ;      black -- nothing happening
    ;      looking around                       lookingAround<0                 BLUE
    ;      when paused                          gameMode... BIT7                RED
    ;      when the door opens (flash)          ColourTimer>0                   WHITE


                lda LookingAround
                bpl nolooker                    ; if not looking around, that will do nicely
                ldy #0 ;sok
;                ldy lookColour2,x               ; otherwise, use the lookaround colour as the base
nolooker        sty BGColour                    ; 'BASE' colour pause reverts TO when unpaused

                lda ThrottleSpeed
                clc
                adc Throttle
                bcs noVerflo
                sta Throttle
noVerflo


    ;----------------------------------------------------------------------------------------------
    ; handle pause button for 2600 and 7800

    ; Timings:  NOT including palette setting or platform detect
    ; 2600:     no button press:    11 cycles
    ;           with button press:  21 cycles
    ; 7800      no button press:    16 cycles
    ;           with button press:  21 cycles



BW_SWITCH   = $08           ; NOTE: Shares bit position with SWCHB COLOUR/B&W SWITCH

                bit gameMode
                bvc .pause7800              ; 7800 platform

    ; 2600 pause logic...

                lda SWCHB
                eor gameMode
                and #BW_SWITCH
                beq .setPauseCol            ; no different to original state = no pause change
                bne .buttonDown             ; unconditional

    ; 7800 pause logic...

    ; When the button is pressed, we check if it's the FIRST time it's pressed.
    ; This FIRST time is indicated by the PFLAG7800 being clear.  If it's the first time, we toggle the pause
    ; flag (BIT6) AND we toggle the PFLAG7800 so continued button-down does nothing.  When the button is
    ; released, then we again toggle the PFLAG7800, allowing a FIRST time check once again, when the button
    ; is next pressed.

.pause7800      lda #BW_SWITCH
                bit SWCHB
                beq .pausePress
                ora gameMode                ; not pressed, so enable first time press
                bne .fixPause               ; unconditional

.pausePress     bit gameMode
                beq .setPauseCol            ; NOT the first time in pause - so do nothing new

        ; Button is down, and we have detected it as a FIRST-TIME button press.

.buttonDown     eor gameMode                ; toggle first time flag(7800) or current switch state(2600)
                eor #GAMEMODE_PAUSED        ; toggle pause flag
.fixPause       sta gameMode

.setPauseCol    lda gameMode                ; are we paused?
                bpl .exitPause              ; only show pause colour when actually paused

                ldx Platform
                lda pscol,x
                sta BGColour                ; set main screen background colour.  RED is paused.

.exitPause

    ;----------------------------------------------------------------------------------------------

    ; has to be done AFTER screen display, because it disables the effect!
                lda rnd                     ; 3     randomly reposition the Cosmic Ark missile
                sta HMM0                    ; 3     this assumes that HMOVE is called at least once/frame

    ; "Flash" has highest BG colour priority

                ldx ColourTimer
                beq noFlashBG
                dec ColourTimer
                lda #WHITE
                sta BGColour
noFlashBG

                lda extraLifeTimer
                beq alreadyBlack2
                dec extraLifeTimer
alreadyBlack2

    ; Handle the player joystick reading. We do it *every frame* so that we can incorporate a two-frame
    ; buffer.  This is designed to give a little better responsiveness to the 'quick tap' movement.

                lda BufferedJoystick            ; previous frame
                sta BufferedJoystick+1          ; -> buffered

    ; Create a 'standardised' joystick with D4-D7 having bits CLEAR if the appropriate direction is chosen.
    ; P2 is shifted UP, so we don't need to worry in usage elsewhere (it's same format as a P1 joystick)

                lda whichPlayer                 ; 3
                and jtoggle                     ; 3
                tax                             ; 2

                lda INPT4,x                     ; 4
                sta BufferedButton              ; 3 = 15

                lda SWCHA                       ; 4

                dex                             ; 2
                bmi notP2                       ; 2/3= 8/9

                asl                             ; 2
                asl                             ; 2
                asl                             ; 2
                asl                             ; 2 =  8
notP2           sta BufferedJoystick            ; 3


    ; "Scoring timer" reset stomp comment

                lda scoringTimer
                beq timer0now
                dec scoringTimer
                bne timer0now
                lda scoringFlags
                and #<(~DISPLAY_FLAGS)      ;       switches to time display
                sta scoringFlags
timer0now

                ; fall through

    ;-------------------------------------------------------------------------------------
    ; Player animation happens *every* frame so that we get good animation speeds.  Note that
    ; the player animation consists of running a small animation 'program', and then actually drawing
    ; the player.  The draw is the neat bit, because all it does is update some self-modifying pointers
    ; inside the actual draw kernel in the appropriate bank.


    DEFINE_SUBROUTINE AnimatePlayers ; in GENERIC_BANK_1

    ; Optimised 7/1/2012 -- single page tables

    ; This interesting code performs the animations for the player(s) and sets the
    ; pointers INSIDE the row bank for the draw code to point to the correct player
    ; shape.  Kind of neat, as it doesn't require any shape copying (=speed!)


    ; Cycle the player through his animation list.  The animation of a player is a direct
    ; pointer to the actual shape used to display the player.  This shape is in turn
    ; written to the current bank's self-modifying locations for the draw.  Since
    ; we are effectively drawing from this current bank, the same code can be used
    ; to 'undraw' the player as required.


    ; x = player index
    ; sets ManAnimation = FRAME to display for player
    ; ManAnimation = index of player program into Manimate list

                bit gameMode
                bmi AnimationOK                     ; don't animate during pause

                dec ManDelayCount
                bpl AnimationOK

ReloadAnimation ldy ManAnimation
ContinueAnim    lda Manimate,y                      ; delay count
                bne NewFrameOK
                lda Manimate+1,y
                tay
                jmp ContinueAnim

NewFrameOK      bpl doDelay

                iny                                 ; handle a REFLECT
                lda ManLastDirection
                and #%11110111
                ora Manimate,y
                sta ManLastDirection

                iny
                bne ContinueAnim

doDelay         sta ManDelayCount

                iny
                lda Manimate,y
                sta ManAnimationFrameLO

                iny
                sty ManAnimation

AnimationOK     rts



pscol       .byte $40, $40
            .byte $60, $60

;------------------------------------------------------------------------------

    include "i2c_v2.2.inc"

    i2c_subs

HandleSaveKey SUBROUTINE

SAVEKEY_ADR     = $0600         ;           reserved address for Boulder Dash (64 bytes)

; SK Memory Map:
;               cave    level
; $0600-$0602   A       1
; $0603-$0605   A       2
; $0606-$0608   A       3
; $0609-$060b   A       4
; $060c-$060e   A       5
; $060f-$0611   E       1
; $0612-$0614   E       2
; $0615-$0617   E       3
; $0618-$061a   unused
; $061b-$061d   unused
; $061e-$0620   I       1
; $0621-$0623   I       2
; $0624-$0626   I       3
; $0627-$0629   unused
; $062a-$062c   unused
; $062d-$062f   M       1
; $0630-$0632   M       2
; $0633-$0635   M       3
; $0636-$063f   unused

;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE ReadSaveKey ; = 2371

; assume no SaveKey found:
    lda     #$ff                ; 2         return $ff if no SaveKey found
    sta     highScoreSK+2       ; 3

; setup SaveKey:
    lda     startCave           ; 3         load start cave*5 and level
    ldx     level               ; 3
    jsr     SetupSaveKey        ;6+853
    bcc     NoSKfound           ; 2/3

    ;    lda     #$34
    ;    sta     COLUBK

; start read
    jsr     i2c_stopwrite       ;6+42       end of "fake" write
    jsr     i2c_startread       ;6+284      Start signal and $a1 command byte

; read high score:
    ldx     #3-1                ; 2 = 1187
.loopRead
    jsr     i2c_rxbyte          ;6+333      read byte from EEPROM
    cmp     #$ff                ; 2         EEPROM slot empty?
    bne     .skipEmpty          ; 2/3        no, skip clear
    lda     #0                  ; 2         clear EEPROM slot
.skipEmpty
    sta     highScoreSK,x       ; 4
    dex                         ; 2
    bpl     .loopRead           ; 2/3= 354

; stop read:
    jmp     i2c_stopread        ;3+92=95    terminate read

;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE WriteSaveKey ; = 1751

; check if new high score:
    ldx     highScoreSK         ; 3
    inx                         ; 2
    beq     NoSKfound           ; 2/3       no new high score, abort

; setup SaveKey:
    lda     startCave           ; 3         load start cave*5 and level
    ldx     startLevel          ; 3
    jsr     SetupSaveKey        ; 6+853
    bcc     NoSKfound           ; 2/3

    ;    lda     #$64
    ;    sta     COLUBK

; write high score:
    ldx     #3-1                ; 2 = 841
.loopWrite
    lda     highScoreSK,x       ; 4
    jsr     i2c_txbyte          ;6+264      transmit to EEPROM
    dex                         ; 2
    bpl     .loopWrite          ; 2/3= 837

; stop write:
    jmp     i2c_stopwrite       ; 3+42= 45  terminate write and commit to memory


;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE SetupSaveKey ; = 853

; calculate slot;
; a = cave (5*n): A=$00; E=$05; I=$0a; M=$0f
; x = level (0..4)
    sta     offsetSK            ; 3
    txa                         ; 2
    clc                         ; 2
    adc     offsetSK            ; 3
    sta     offsetSK            ; 3
    asl                         ; 2         multiply by 3
    adc     offsetSK            ; 3
    adc     #<SAVEKEY_ADR       ; 2
    tax                         ; 2 = 22
; detect SaveKey:
    jsr     i2c_startwrite      ;6+280
    bne     .exitSK             ; 2/3

; setup address:
    clv                         ; 2
    lda     #>SAVEKEY_ADR       ; 2         upper byte of address
    jsr     i2c_txbyte          ;6+264
    txa                         ; 2         x = lower byte offset
    jmp     i2c_txbyte          ;3+264      returns C==1

.exitSK
    clc
NoSKfound
    rts
  ENDIF


            CHECK_BANK_SIZE "GENERIC_BANK_1 -- full 2K"

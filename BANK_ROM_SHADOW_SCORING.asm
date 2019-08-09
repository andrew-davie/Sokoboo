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

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------
                NEWBANK ROM_SHADOW_OF_BANK_SCORING


SCORE_COL           = $9a ;WHITE ;-2
SCORE_COL_HIGH_NTSC = $44     ; works for SECAM and NTSC
SCORE_COL_HIGH_PAL  = $66


DigitVectorLOr
    .byte   <ZeroR-1, <OneR-1, <TwoR-1, <ThreeR-1, <FourR-1, <FiveR-1, <SixR-1, <SevenR-1, <EightR-1, <NineR-1
    .byte   <BLANKR-1, <DequalsR-1, <DplusR-1, <ClockR-1
DigitVectorLO
    .byte   <ZeroL-1, <OneL-1, <TwoL-1, <ThreeL-1, <FourL-1, <FiveL-1, <SixL-1, <SevenL-1, <EightL-1, <NineL-1
    .byte   <BLANKL-1


ID_BLANK    = 10        ; DO NOT MAKE 0
ID_TARGET  = 11
ID_EXTRA    = 12
ID_CLOCK    = 13
ID_HEAD     = ID_BLANK+16+1

; score patch adresses:
SMTblLSB
SMTblTargets:
    .byte SM_TARGET0+1-SM_BASE, SM_TARGET2+1-SM_BASE
SMTblTime:
    .byte SM_Time0+1-SM_BASE, SM_Time2+1-SM_BASE
SMTblScore:
    .byte SMDIGIT5+1-SM_BASE, SMDIGIT3+1-SM_BASE, SMDIGIT1+1-SM_BASE
SMTblMSB
    .byte SM_TARGET1+1-SM_BASE, SM_TARGET3+1-SM_BASE
    .byte SM_Time1+1-SM_BASE, SM_Time3+1-SM_BASE
    .byte SMDIGIT4+1-SM_BASE, SMDIGIT2+1-SM_BASE, SMDIGIT0+1-SM_BASE

SM_OFS_TARGETS = SMTblTargets - SMTblLSB
SM_OFS_TIME     = SMTblTime     - SMTblLSB
SM_OFS_SCORE    = SMTblScore    - SMTblLSB

CharVectorLO
    .byte   <BLANKL-1
    .byte   <CharA-1, <CharB-1, <CharC-1, <CharD-1
    .byte   <CharE-1, <CharF-1, <CharG-1, <CharH-1
    .byte   <CharI-1, <CharJ-1, <CharK-1, <CharL-1
    .byte   <CharM-1, <CharN-1, <CharO-1, <CharP-1
;    .byte   <OneL-1,  <TwoL-1,  <ThreeL-1,<FourL-1

    ; Digit shape definitions are at start of bank so that we don't have page boundary
    ; crossing issues.

;        .byte 0             ; required!

DIGIT_H     = 7; height of a score digit

BLANKL  ds 7,0



NineL
  .byte %00011110
  .byte %00000010
  .byte %00000010
  .byte %11111110
  .byte %10000010
  .byte %10000010
  .byte %11111110

SixL
  .byte %11111110
  .byte %10000010
  .byte %10000010
  .byte %11111110
  .byte %10000000
  .byte %10000000
  .byte %11110000

;    .byte %01111100
;    .byte %11000010
;    .byte %11000010
;    .byte %11111100
;    .byte %11000000
;    .byte %01100000
;    .byte %00111000
EightL


  .byte %11111110
  .byte %10000010
  .byte %10000010
  .byte %11111110
  .byte %10000010
  .byte %10000010
  .byte %11111110

;  .byte %01111100
;  .byte %10000110
;  .byte %10000110
;  .byte %01111100
;  .byte %01000110
;  .byte %01000110
;  .byte %00111100
ZeroL
;  .byte %01111100
;  .byte %10000110
;  .byte %10000110
;  .byte %10000110
;  .byte %10000110
;  .byte %01000110
;  .byte %00111100

 .byte %11111110
 .byte %10000010
 .byte %10000010
 .byte %10000010
 .byte %10000010
 .byte %10000010
 .byte %11111110

ThreeL
  .byte %11111110
  .byte %00000010
  .byte %00000010
  .byte %00011110
  .byte %00000010
  .byte %00000010
  .byte %11111110
OneL
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000

SevenL

  .byte %00010000
  .byte %00010000
  .byte %00010000
  .byte %00011110
  .byte %00000010
  .byte %00000010
;  .byte %11111110

;    .byte %00010000
;    .byte %00010000
;    .byte %00010000
;    .byte %00011000
;    .byte %00001100
;    .byte %10000110
;    ;.byte %11111110
TwoL:
  .byte %11111110
  .byte %10000000
  .byte %10000000
  .byte %11111110
  .byte %00000010
  .byte %00000010
  .byte %11111110

FiveL
    .byte %11111110
    .byte %00000010
    .byte %00000010
    .byte %11111110
    .byte %10000000
    .byte %10000000
    .byte %11110000

FourL
  .byte %00010000
  .byte %00010000
  .byte %00010000
  .byte %11111110
  .byte %10010000
  .byte %10010000
  .byte %10010000


ZL
  .byte %01111111
  .byte %01000000
  .byte %01000000
  .byte %01111111
  .byte %00000001
  .byte %00000001
  .byte %00001111

EL
  .byte %01111111
  .byte %01000000
  .byte %01000000
  .byte %01111000
  .byte %01000000
  .byte %01000000
  .byte %01111111

RL
  .byte %01001000
  .byte %01001000
  .byte %01001000
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01111111

PL
  .byte %01000000
  .byte %01000000
  .byte %01000000
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01111111

AL
  .byte %01000001
  .byte %01000001
  .byte %01000001
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01111111

GL
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01001111
  .byte %01000000
  .byte %01000000
  .byte %01111111


; level "name" characters (left only!):

CharN
CharK:
CharH:
CharA
CharJ:
CharP:
CharB
CharO
CharC
CharI:
CharD
CharG
CharE
CharL:
CharF
CharM:
  ds 7,0

charPlace
        .byte %00001100
        .byte %00001100
        .byte %00001100
        .byte %00001100
        .byte %00001100
        .byte %00000000
        .byte %00001100

    ;-------------------------------------------------------------------------------------
PosTbl:
        .byte $40
        .byte $31, $22, $13, $04, $f5, $e6, $d7, $c8
        .byte $b9


    ;------------------------------------------------------------------------------
    ; RAM-BASED SUBROUTINES...
    ; NOTE: When calling these routines, remember you are actually calling the ROM routine
    ; as it is the ROM bank that is switched in.  The first thing to do to access the RAM
    ; is to switch the appropriate RAM bank in.  It would be nicer to be able to direct-call
    ; the RAM-based routine.

                ALIGN 256           ; so SM code needs no HI table

SM_BASE  = .

;#IF 0 ;{
;    DEFINE_SUBROUTINE Score3x3
;
;        sta     RESP0
;         sta     RESP1
;         lda     #$$000
;          sta     GRP0
;          lda     #$$009
;          sta     GRP1
;          lda     #$$202
;          sta     ENABL
;          nop
;          nop
;          nop
;          lda     #$$016
;          ldy     #$$100
;          ldx     #$$109
;          sta     GRP0    ; Critical time is right here
;          stx     GRP1
;          sty     GRP0
;          sta     RESP0
;          sta     RESP1
;          ldx     #$$116
;          lda     #$$209
;          stx     GRP0
;          sta     GRP1
;          lda     #$$200
;          sta     GRP0
;          sta     RESP0
;          sta     RESP1
;          lda     #$$216
;          nop
;          sta     GRP0
;
;            rts
;#ENDIF ;}


    ;------------------------------------------------------------------------------
Score1x6Fix SUBROUTINE
    DEFINE_SUBROUTINE DrawDigits1x6
;                                           @07
        tsx                     ; 2

        jsr PrepareDrawDigits   ;56 = 58    @65

        stx tmpStack            ; 3 =  3

LoopDraw1x6:                    ;
SMDIGIT0
        lda ZeroR-1,y           ; 4
        sta WSYNC               ; 3
;---------------------------------------------------------------
        sta HMOVE               ; 3
        SLEEP 3                 ; 3 =  6
        sta GRP0                ; 3
SMDIGIT1
        lda ZeroL-1,y           ; 4
        sta GRP1                ; 3
SMDIGIT2
        lda ZeroR-1,y           ; 4
        sta GRP0                ; 3 = 17
SMDIGIT5
        ldx ZeroL-1,y           ; 4
        txs                     ; 2
SMDIGIT3
        ldx ZeroL-1,y           ; 4
SMDIGIT4
        lda ZeroR-1,y           ; 4
        sta HMCLR               ; 3
        stx GRP1                ; 3
        sta GRP0                ; 3 = 23

        tsx                     ; 2
        stx GRP1                ; 3
        sta GRP0                ; 3 =  8

        dey                     ; 2
        CHECKPAGE_BNE LoopDraw1x6;2/3= 5    @58/59

        ldx tmpStack            ; 3
        txs                     ; 2
ExitDigitKernel6:
        SLEEP 3                 ; 3
        jmp ExitDigitKernel     ; 3 = 11    @69


    ;------------------------------------------------------------------------------
Score2x4Fix SUBROUTINE
    DEFINE_SUBROUTINE DrawDigits2x4


    ; Subroutine by Thomas Jentzsch.  Magic!
    ; This subroutine draws two 4-digit scores on the screen, side-by-side. Amazing!

    ;sta COLUBK

        jsr PrepareDrawDigits   ;56 = 56    @63

        sta HMOVE               ; 3
        SLEEP 4                 ; 4  =  7

LoopDraw2x4:                    ;           @70
SM_TARGET3
        lda DequalsR-1,y        ; 4                 G
;---------------------------------------------------------------
        sta GRP0                ; 3
SM_TARGET2
        lda ZeroL-1,y           ; 4                 A
        sta GRP1                ; 3
SM_TARGET1
        lda ZeroR-1,y           ; 4                 M
        sta GRP0                ; 3
SM_TARGET0
        ldx ZeroL-1,y           ; 4                 E
        sta RESP0               ; 3 = 28    @22
        sta RESP1               ; 3 =  3    @25
SM_Time3
        lda ClockR-1,y          ; 4                 O
        stx GRP1                ; 3
        sta GRP0                ; 3
SM_Time2
        lda ZeroL-1,y           ; 4                 V
        sta GRP1                ; 3
SM_Time1
        lda ZeroR-1,y           ; 4                 E
        sta GRP0                ; 3
        sta RESP0               ; 3 = 27    @52 (was 54)
        sta RESP1               ; 3 =  3    @55
SM_Time0
        lda ZeroL-1,y           ; 4                 R
        sta GRP1                ; 3
        sta GRP0                ; 3
        dey                     ; 2
        CHECKPAGE_BNE LoopDraw2x4;2/3=15    @70

ExitDigitKernel:                ;           @69
        sty GRP0                ; 3
        sty GRP1                ; 3
;---------------------------------------------------------------
        sty GRP0                ; 3         @02

    ; Contribution by Thomas Jentzsch
    ; Rewrite/Optimised for single sprite AD

        ldx ManDrawX            ; 3
        lda PosTbl,x            ; 4
        sta HMP0                ; 3
        and #$0f                ; 2
        beq .zeroPos            ; 2/3=15
        tax                     ; 2
.loopWait:
        dex                     ; 2
        bne .loopWait           ; 2/3= 6
.zeroPos:
        ldx #$70                ; 2         magic value #1 for Cosmic Ark stars
        sta RESP0               ; 3 =  5    @22..67 (@look around!)
        lda BGColour                ; 3
        stx HMM0                ; 3         for extra life stars!
        sta WSYNC               ; 3
;    sta WSYNC
;    sta WSYNC
;---------------------------------------------------------------
        sta HMOVE               ; 3
        sta COLUBK
        rts                     ; 6         @09

    ;------------------------------------------------------------------------------
Score3x2Fix SUBROUTINE
    DEFINE_SUBROUTINE DrawDigits3x2
;                                           @07
        lda #%010110            ; 2
        ldy #$f0-1              ; 2                 moved slightly out of center to match 1x6 display position
        jsr PrepareDrawDigits2  ;49 = 53    @60

        lda #0
        sta VDELP1
LoopDraw3x2:                    ;
        sta WSYNC               ; 3
;---------------------------------------------------------------
        sta HMOVE               ; 3 =  3
        lda CharP-1,y           ; 4
        sta GRP0                ; 3
SMPLAYER
        lda OneR-1,y            ; 4
        sta GRP1                ; 3 = 14    @17
        lda charPlace-1,y           ; 4
SMMEN
        ldx ThreeR-1,y          ; 4 =  8
        SLEEP 5                 ;   =  5
        sta GRP0                ; 3
SMLEVELX
        lda CharA-1,y           ; 4
        sta HMCLR               ; 3 = 10    @40
        stx GRP1                ; 3 =  3    @43
        sta GRP0                ; 3
SMLEVEL
        lda OneR-1,y            ; 4
        sta GRP1                ; 3 = 10    @53

        dey                     ; 2
        CHECKPAGE_BNE LoopDraw3x2;2/3= 5    @58
;                                           @57
        SLEEP 3                 ; 3
        jmp ExitDigitKernel6    ; 9 = 12    @69  'BEQ' WAS A DANGEROUS ASSUMPTION OF STATUS FLAG!!


    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE DrawDigits

VblankLoopGame
        ;jsr StealCharDraw
        ldy INTIM
        bne VblankLoopGame

        sty VBLANK              ; 3         <-- 0
        lda scoringFlags        ; 3
        and #DISPLAY_FLAGS                ; 2
        tax                     ; 2

;    DEFINE_SUBROUTINE DrawDigit2
;
;    ; Generic interface to scoring routine

        lda ScoreKernelLo,x     ; 4

        sta WSYNC               ; 3
;---------------------------------------------------------------
        sta SMJUMP+1+RAM_WRITE  ; 4
SMJUMP:
        jmp DrawDigits1x6       ; 3 =  7    @07

ScoreKernelLo:
        .byte <Score2x4Fix      ; TARGETs, time
        .byte <Score1x6Fix      ; score
        .byte <Score3x2Fix      ; player, lives, level
        .byte <Score1x6Fix      ; high score

    CHECKPAGE DrawDigits1x6     ; AD: the jump requires all in the same page, so let's enforce that

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE PrepareDrawDigits
;                                           @13
        ldy #$d1                ; 2
        lda #%010011            ; 2
        sta VDELP1              ; 3 =  7
PrepareDrawDigits2:              ;          @17/20
        sty VDELP0              ; 3 =  3

        sta NUSIZ1              ; 3
        sta NUSIZ0              ; 3 =  6

        sta.w REFP0             ; 4                 bit 3 is always clear
        sta RESP0               ; 3         @33/36
        sta RESP1               ; 3 = 10    @36/39

        sty HMP0                ; 3
        iny                     ; 2
        sty HMP1                ; 3 =  8
SMCOLOR
        ldy #SCORE_COL          ; 2
        sty COLUP0              ; 3
        sty COLUP1              ; 3 =  8

        ldy #DIGIT_H            ; 2
        rts                     ; 6 =  8
; total: 27


    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE UpdateScore
; a = added score value

    ; initially switch to score:
        ldy #DISPLAY_SCORE
        sty newDisplay

        clc
        sed
        ldy #SM_OFS_SCORE
.loopScore
        adc ScoreCurrent-SM_OFS_SCORE,y
        sta ScoreCurrent-SM_OFS_SCORE+RAM_WRITE,y
        php
    ; *** bonus life every 500 points: ***
;        cpy #SM_OFS_SCORE+1
;        bne .skipBonusLife
;        tax

;        and #$0f
;        beq .bonusLife                      ; 000?
;        cmp #$05
;        bne .noBonusLife                    ; 500?
;.bonusLife:
    ; add extra life, limited to 9

;        lda ManCount
;        and #$0f
;        cmp #9
;        bcs .noBonusLife
;        inc ManCount

    ; bonus life has priority over score:
;        lda #DISPLAY_LIVES
;        sta newDisplay
        ;lda #EXTRA_LIFE_TIMER
        ;sta extraLifeTimer

.noBonusLife:
        txa
.skipBonusLife:
        jsr SetupBCDPtr
        plp
        lda #0
        bcs .loopScore
        cld

    ; switch display
        lda scoringFlags
        and #DISPLAY_FLAGS
        cmp newDisplay                      ; lower priority than current?
        beq .restartTime
        bcs .skipNew
        eor scoringFlags                    ; remove existing score mode
        ora newDisplay                      ; switch to new score mode
        sta scoringFlags
.restartTime:
        lda #SCORING_TIMER                  ; maybe always restart timer?
        sta scoringTimer
.skipNew:

        rts

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE SwapPlayers

    ; assume no new high score:
        ldy #-1
        sty highScoreSK

    ; update highscore after last live:
        lda ManCount
        and #$0f                            ; player has lives left?
        bne .playerAlive                    ; YES, so we don't check high score

    ; check for a new high score:
;        ldy #-1
        clc                                 ; score has to be at least 1 bigger!
.loopCheckHighScore
        iny
        lda ScoreCurrent,y
        sbc HighScore,y
        tya
        eor #2
        bne .loopCheckHighScore
        bcc .noHighScore

    ; new high score, update:
        ldx #5-1
.loopSetHighScore
        lda ScoreCurrent,x
        sta HighScore+RAM_WRITE,x
        sta highScoreSK,x
        dex
        bpl .loopSetHighScore
.noHighScore

.playerAlive
        lda ManCount
        and #$f0                            ; other player has lives left?
        beq .otherPlayerDead                ; NO, so we don't swap scores

    ; save the current player variables to the player's backup:
        ldy #3-1
.swapScore
        ldx PlayerScores,y
        lda ScoreCurrent,y
        sta PlayerScores+RAM_WRITE,y
        txa
        sta ScoreCurrent+RAM_WRITE,y
        dey
        bpl .swapScore

    ; swap levelx and level:
        ldx #1
.loopLevelXLevel
        ldy PlayerLevelX,x
        lda levelX,x
        sta PlayerLevelX+RAM_WRITE,x
        sty levelX,x
        dex
        bpl .loopLevelXLevel

.otherPlayerDead
        rts

    ;---------------------------------------------------------------------------

HighScoreColTbl:
    .byte   SCORE_COL_HIGH_NTSC, SCORE_COL_HIGH_NTSC
    .byte   SCORE_COL_HIGH_PAL, SCORE_COL_HIGH_PAL

    DEFINE_SUBROUTINE GeneralScoringSetups

                ldy #SM_OFS_SCORE
.loopScore2
                lda scoringFlags
                and #DISPLAY_FLAGS
                cmp #DISPLAY_HIGH
                ldx Platform
                lda HighScoreColTbl,x
                tax
                lda HighScore-SM_OFS_SCORE,y
                bcs .showHighScore
                ldx #SCORE_COL
                lda ScoreCurrent-SM_OFS_SCORE,y
.showHighScore
                stx SMCOLOR+1+RAM_WRITE
                jsr SetupBCDPtr
                cpy #SM_OFS_SCORE+3
                bcc .loopScore2

    ; display number of lives in leftmost digit of middle score XX nX XX

                ;lda ManCount
                ;and #$0f
                ;tay
                ;lda DigitVectorLOr,y
                ;sta SMMEN+1+RAM_WRITE

    ; modify player number pointer (Xp XX XX)

                ;ldy whichPlayer
                ;lda DigitVectorLOr+1,y
                ;sta SMPLAYER+1+RAM_WRITE

        ; fall through

;    ;---------------------------------------------------------------------------

    ; modify levelx character pointer (XX XX cX)

                ;ldx #<charPlace-1
                ;lda levelDisplay
                ;cmp #$80
                ;and #$1f
                ;tay
                ;bcs .intermission
                ;ldx CharVectorLO,y
                ;ldy level
;.intermission
                ;stx SMLEVELX+1+RAM_WRITE

    ; modify level number pointer (XX XX Xl)

                ;lda DigitVectorLOr+1,y
                ;sta SMLEVEL+1+RAM_WRITE

    ;---------------------------------------------------------------------------

                jmp SetupTimePtr                ; modify time pointers

    ;------------------------------------------------------------------------------
;    DEFINE_SUBROUTINE SetupGameOverPtr

;                ldy #8-1
;.loopGameOver:
;                ldx SMGameOverOfs,y
;                lda SMGameOverPtr,y
;                sta SM_BASE+1+RAM_WRITE,x
;                dey
;                bpl .loopGameOver

;                rts

;SMGameOverOfs:
;                .byte <SM_TARGET3-SM_BASE, <SM_TARGET2-SM_BASE
;                .byte <SM_TARGET1-SM_BASE, <SM_TARGET0-SM_BASE
;                .byte <SM_Time3-SM_BASE, <SM_Time2-SM_BASE
;                .byte <SM_Time1-SM_BASE, <SM_Time0-SM_BASE
;SMGameOverPtr:
;                .byte <CharG-1, <CharAL-1, <CharM-1, <CharEL-1
;                .byte <CharO-1, <CharVL-1, <CharE-1, <CharRL-1

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawTargetsRequired
; Show current TARGET counter in the top left

                ldy #SM_OFS_TARGETS
                lda targetsRequired
                jsr SetupBCDPtr

                lda #ID_TARGET<<4                  ; if no extra targets, display the normal icon
                bit scoringFlags                    ;
                bpl SetupBCDPtr
                lda #ID_EXTRA<<4                    ; otherwise, display the extra icon
                bvc SetupBCDPtr
                ora #1                              ; display 1xx targets
                bne SetupBCDPtr                     ; unconditional

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE DrawTime

    ; mid-digit-change, but we may be required to flash/display
                ldy #SM_OFS_TIME
    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE SetupTimePtr

                lda moveCounter
                jsr SetupBCDPtr
                lda moveCounter+1
                ora #ID_CLOCK<<4

        ; fall through

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE SetupBCDPtr

; a = BCD value
; y = SM table offset

                pha
                and #$0f
                tax
                lda DigitVectorLO,x         ; low nibble: left aligned chars
                ldx SMTblLSB,y
                sta SM_BASE+RAM_WRITE,x
                pla
                lsr
                lsr
                lsr
                lsr
                tax
                lda DigitVectorLOr,x        ; high nibble: right aligned chars
                ldx SMTblMSB,y
                sta SM_BASE+RAM_WRITE,x

                iny

                lda ROM_Bank
RTS:
                rts

    OPTIONAL_PAGEBREAK "LeftDigits", (DIGIT_H*13)     ; cannot index across page!

  IF <. = 0
        .byte 0             ; required!
  ENDIF

BLANKR
        .ds DIGIT_H, 0

DequalsR
        .byte %00000000
        .byte %00000000
        .byte %11110000
        .byte %00000000
        .byte %11110000
        .byte %00000000
        .byte %11110000
DplusR
        .byte %00010000
        .byte %00101000
        .byte %01101100
        .byte %11000110
        .byte %01101100
        .byte %00101000
        .byte %00010000

ClockR
        .byte %00000000
        .byte %01001000
        .byte %11111100
        .byte %01001000
        .byte %01001000
        .byte %11111100
        .byte %01001000
NineR
  .byte %00001111
  .byte %00000001
  .byte %00000001
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01111111
SixR
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01111111
  .byte %01000000
  .byte %01000000
  .byte %01111000
EightR
;  .byte %00111110
;  .byte %01000011
;  .byte %01000011
;  .byte %00111110
;  .byte %00100011
;  .byte %00100011
;  .byte %00011110


  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01111111

ZeroR
  .byte %01111111
  .byte %01000001
  .byte %01000001
  .byte %01000001
  .byte %01000001
  .byte %01000001
  .byte %01111111

;        .byte %00111110
;        .byte %01000011
;        .byte %01000011
;        .byte %01000011
;        .byte %01000011
;        .byte %00100011
;        .byte %00011110
ThreeR
  .byte %01111111
  .byte %00000001
  .byte %00000001
  .byte %00001111
  .byte %00000001
  .byte %00000001
  .byte %01111111
OneR
        .byte %00001000
        .byte %00001000
        .byte %00001000
        .byte %00001000
        .byte %00001000
        .byte %00001000
        .byte %00001000

SevenR
  .byte %00001000
  .byte %00001000
  .byte %00001000
  .byte %00001111
  .byte %00000001
  .byte %00000001
  .byte %01111111

TwoR
  .byte %01111111
  .byte %01000000
  .byte %01000000
  .byte %01111111
  .byte %00000001
  .byte %00000001
  .byte %01111111
FiveR
  .byte %01111111
  .byte %00000001
  .byte %00000001
  .byte %01111111
  .byte %01000000
  .byte %01000000
  .byte %01111000
FourR
  .byte %00001000
  .byte %00001000
  .byte %00001000
  .byte %01111111
  .byte %01001000
  .byte %01001000
  .byte %01001000

;CharAL:
;    .byte %11100110
;    .byte %11100110
;    .byte %11111110
;    .byte %11100110
;    .byte %11100110
;    .byte %01111100
;    .byte %00111000
;CharEL:
;    .byte %11111110
;    .byte %11111110
;    .byte %11100000
;    .byte %11100000
;    .byte %11111100
;    .byte %11100000
;    .byte %11111110
;CharRL:
;    .byte %11100110
;    .byte %11100110
;    .byte %11111100
;    .byte %11111100
;    .byte %11100110
;    .byte %11100110
;    .byte %11111100
;CharVL:
;    .byte %00111000
;    .byte %01111100
;    .byte %11100110
;    .byte %11100110
;    .byte %11100110
;    .byte %11100110
;    .byte %11100110

    CHECKPAGE   BLANKR

    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE GameInitialise

    ; copy loaded SK high score into scoring RAM:
                ldx #3-1
.loopCopyHighScore
                lda highScoreSK,x
                cmp #$ff
                beq .noSaveKey
                sta HighScore+RAM_WRITE,x
                dex
                bpl .loopCopyHighScore
.noSaveKey

    ; clear both players scores
                ldy #2*3-1
                lda #0
.loopClearScore
                sta ScoreCurrent+RAM_WRITE,y
                dey
                bpl .loopClearScore

    ; copy levelX and level for other player and SaveKey:
                lda levelX
                sta PlayerLevelX+RAM_WRITE
                lda startingLevel
                sta StartLevelX+RAM_WRITE
                lda level
                sta PlayerLevel+RAM_WRITE
                sta StartLevel+RAM_WRITE
                rts

    ;---------------------------------------------------------------------------

ScoreCurrent    ds 3, 0
; start levelx and level have to be after ScoreCurrent!
StartLevelX       .byte 0
StartLevel      .byte 0
PlayerScores    ds 3, 0
; levelx and level have to be consecutive variables!
PlayerLevelX      .byte 0
PlayerLevel     .byte 0
HighScore       ds 3+2, 0 ; two extra bytes to save code



    ;------------------------------------------------------------------------------

    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_BANK_SCORING"

    ;------------------------------------------------------------------------------

    ; LEVEL DATA banks can go anywhere - *EXCEPT* for the same bank as the level
    ; decoder.  Ironic, isn't it?  They calculate a constant -- MAX_LEVEL_SIZE
    ; which is used as a buffer size inside UnpackLevel.  It's not important if
    ; this is defined before or after, as once the levels have processed it will be
    ; correct. Note, that levels should all be defined BEFORE *OR* AFTER the
    ; UnpackLevel code -- but that they should not be both, nor in the same bank.
    ; TODO: verify above is still valid


    CHECK_BANK_SIZE "ROM_SHADOW_OF_BANK_SCORING -- full 2K"

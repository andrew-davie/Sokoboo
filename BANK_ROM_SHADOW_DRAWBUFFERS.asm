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

                NEWBANK ROM_SHADOW_OF_BANK_DRAW_BUFFERS

    ; NOTE: Access to these buffers must NOT overlap pages...
    ; NOTE: We get auto-initialisation of these variables from the ROM values by
    ; copying the whole bank into the RAM bank.  Neato.

DRAW_STACK_SIZE      =   SCREEN_ARRAY_SIZE      ; <-- TJ TRY CHANGING THIS TO (SAY) 15  (!!)



DrawStack       ds DRAW_STACK_SIZE,0                    ; a stack of character #'s to draw
DrawFlag        ds SCREEN_ARRAY_SIZE,0                  ; holds new character to draw at position

                OPTIONAL_PAGEBREAK "ScreenBuffer", SCREEN_ARRAY_SIZE

    ; D7 of ScreenBuffer indicates if a DirectDraw is to be used to draw this character
    ; Note: this may actually cause two characters to be drawn -- for the price of one.  This is *exactly*
    ; what we want to happen!

ScreenBuffer    ds SCREEN_ARRAY_SIZE,0                    ; the char buffer for delta-drawing


    ;------------------------------------------------------------------------------
    ; RAM-BASED SUBROUTINES...
    ; NOTE: When calling these routines, remember you are actually calling the ROM routine
    ; as it is the ROM bank that is switched in.  The first thing to do to access the RAM
    ; is to switch the appropriate RAM bank in.  It would be nicer to be able to direct-call
    ; the RAM-based routine.



    ;------------------------------------------------------------------------------


waitForDraw    rts                             ; 6

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawStackUpdate ;=196 (+13 for fall-through bit)

    ; Parse the DrawFlags buffer and create a draw stack
    ; so that the actual draw doesn't need to scan for characters to draw.


 ;@TJ -- let's see if we see any bad lag/shear in screen drawing without this wait in.
 ; symptoms would be missing parts of screen when scrolling.
 ; Gameplay (not visual) lag noticed - re-enabled 11/8/11
 ; disabled for sokoban 27/7/2019

                ;lda DrawStackPointer
                ;bpl waitForDraw                 ; Wait for previously not-drawn characters to be drawn

                lda INTIM                       ;4
                cmp #SEGTIME_BDS                ;2
                bcc waitForDraw                 ;2/3
                STRESS_TIME SEGTIME_BDS


    ; Now that all characters are drawn, recalculate/move sprite. Doing this here prevents the player
    ; moving into the middle of dirt, or BOXs when pushing, or TARGETs when grabbing.

;                sec            already set
                lda ManY                        ;3
                sbc BoardScrollY                ;3
                sta ManDrawY                    ;3

                sec                             ;2
                lda ManX                        ;3
                sbc BoardScrollX                ;3
                cmp #SCREEN_WIDTH               ;2
                bcc onsc                        ;2/3

    ; if the man is offscreen, we have a timing issue between the horizontal positioning code and the player
    ; draw code.  The following gets around this by setting the Y offscreen (causing the player draw code to
    ; blank the graphic) and leaving the X alone (so we don't see a brief flash in left of screen).

                lda #SCREEN_LINES               ;2
                sta ManDrawY                    ;3
                bne skipsc                      ;3               unconditional

onsc            sta ManDrawX                    ;3
skipsc

                inc timer                       ;5
                jsr AnimateCharReplacements2    ;3+28

                inc ScreenDrawPhase             ;5

                lda #SCREEN_ARRAY_SIZE-1        ;2
                sta DSL                         ;3

    ; fall through...
    ;---------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawIntoStack

                tsx                             ;2
                stx save_SP                     ;3
                ldx DrawStackPointer            ;3
                txs                             ;2 = 10

                ldy DSL                         ;3

    ; worst-case DrawStackOne loop = 61 cycles per character (+11 for first one)
    ; + exit cost which is +10 cycles
    ; TJ: I count 63
    ;   + 14 for the wtf2 exit
    ;   + 22 for the end of loop exit

    ; This loops 80 times/frame and is called 1-2 times/frame, so any saving inside the loop will make up for a lot of overhead outside
    ; For 80 iterations that is 640 cycles, just for checking INTIM
    ; Worst case we would have ~5000. Though that will most likely never happen, we have to optimize for it, since
    ; it also will require a lot of CPU time for updating the screen data.

    ; TODO: optimize!
    ;
    ; idea #4: the mixed draw idea (two different characters have to be redrawn),
    ; first do a QuickDraw and then a SlowDraw, faster than two SlowDraws
    ; costs some detection time here, but saves ~240 cylces for drawing the two

.loopDrawStack  lda INTIM                       ;4
                cmp #SEGTIME_DSL                ;2
                bcc .exitDrawStack              ;2/3= 8/9
                STRESS_TIME SEGTIME_DSL

                lda DrawFlag,y                  ;4
                cmp ScreenBuffer,y              ;4              Is the character already there the same as the new one?
                beq .next0                      ;2/3=10/11      yes, so we don't draw anything

    ; Character is NOT the same. Figure out how it should be drawn.
    ; If it is in column 0 or 5 then it can be DirectDrawn (indirectly found by a A:A compare)
    ; If it is the same as its paired character (sharing same PF byte) then it can be DirectDrawn
    ; The top bit of the ScreenBuffer character indicates the DirectDrawn hint

                ldx PairedCharacter,y           ;4              the "paired" character for this one
                cmp DrawFlag,x                  ;4              same as partner character in new drawn screen?
                bne .notPaired0                 ;2/3=10/11

    ; Consider two 'paired' characters. Either A:A or A:B
    ; When we're scanning, and we check the first, if they are NOT paired, then the second character
    ; can be considered in isolation -- its check comes later, will determine itself if the pair can be written
    ; If, however, the first character IS paired, then the write below will cause the second check to FAIL
    ; on the comparison, so the character will not be added to the draw stack. So our first character will
    ; do the job of drawing BOTH characters to the screen.

                sta ScreenBuffer+RAM_WRITE,x    ;5              mark paired character as drawn already (!!)
                ora #$80                        ;2 =  7         DirectDraw this character 'pair'

    ; In the case of columns 0 and 5, the X and Y registers will be the same -- no problemo, because
    ; the last write(below) marks the character as to be direct-drawn.

.notPaired0     sta ScreenBuffer+RAM_WRITE,y    ;5              NEW character to draw + DirectDraw flag (128)

    ; The following 'pla' really just increments the draw-stack pointer.  Value is unimportant. Unusual!

                pla                             ;4              ASSUMPTION IS WE DON'T OvERFLOW DRAW STACK
                tya                             ;2
                tsx                             ;2              << now X holds drawstackpointer
                sta DrawStack+RAM_WRITE,x       ;5 = 18         index of character to draw

.next0          dey                             ;2
                bmi .finishedDrawStack          ;2/3= 4/5

    ; unrolled 2nd loop:
                lda DrawFlag,y                  ;4
                cmp ScreenBuffer,y              ;4              Is the character already there the same as the new one?
                beq .next1                      ;2/3=10/11      yes, so we don't draw anything

                ldx PairedCharacter,y           ;4              the "paired" character for this one
                cmp DrawFlag,x                  ;4              same as partner character in new drawn screen?
                bne .notPaired1                 ;2/3=10/11

                sta ScreenBuffer+RAM_WRITE,x    ;5              mark paired character as drawn already (!!)
                ora #$80                        ;2 =  7         DirectDraw this character 'pair'

.notPaired1     sta ScreenBuffer+RAM_WRITE,y    ;5              NEW character to draw + DirectDraw flag (128)

                pla                             ;4              ASSUMPTION IS WE DON'T OvERFLOW DRAW STACK
                tya                             ;2
                tsx                             ;2
                sta DrawStack+RAM_WRITE,x       ;5 = 18         index of character to draw

.next1          dey                             ;2
                bpl .loopDrawStack              ;2/3= 4/5
;worst case: 111-4
;40 loops(-4), max. 2 calls(+20) -> -160+40=-120, +8 bytes

   ; THE FOLLOWING OPTIMISATION IS STUFFED IF PROCESSOBJSTACK is not first in the vector processor!

.finishedDrawStack
                inc ScreenDrawPhase             ;5 =  5
                tsx                             ;2
                stx DrawStackPointer            ;3

        ; Handle the pause for first turning ON the visible screen. We want to wait until the
        ; draw stack is empty (thus all characters have been drawn) on that initial startup

;    IF WAIT_FOR_INITIAL_DRAW
;                bpl notVisibleYet
;                ldx #0
;                stx blankState
;notVisibleYet
;    ENDIF


                ldx save_SP                     ;3
                txs                             ;2 = 10

                ;jmp SwitchObjects

                rts                             ;6 =  6

.exitDrawStack
                sty DSL                         ;3 =  3
                tsx                             ;2
                stx DrawStackPointer            ;3
                ldx save_SP                     ;3
                txs                             ;2 = 10
                rts                             ;6 =  6

PairedCharacter

SOFF   SET 0
    REPEAT SCREEN_LINES
        .byte SOFF,SOFF+2,SOFF+1,SOFF+4,SOFF+3,SOFF+5,SOFF+7,SOFF+6,SOFF+9,SOFF+8
SOFF    SET SOFF + SCREEN_WIDTH
    REPEND

    ;------------------------------------------------------------------------------
    ; Gives character replacements used during screen drawing.
    ; The character from the board is morphed via this array into an actual character
    ; to draw.  This allows global animation and replacment of characters without
    ; individual objects needing to do this.  Note, the draw-time replacement happens,
    ; not board-time.

CharReplacement ; in RAM -- BANK_DRAW_BUFFERS

    ; Converts a character # to an animated creature type
    ; The array is indexed by CHARACTER_...

                .byte CHARACTER_BLANK       ;  0
                .byte CHARACTER_SOIL        ;  1
                .byte CHARACTER_BOX         ;  2
ANIM_TARGET     .byte CHARACTER_TARGET      ;  3  XOR'd to give flashing target squares
                .byte CHARACTER_TARGET2     ;  4
                .byte CHARACTER_MANOCCUPIED ;  5
                .byte CHARACTER_STEEL       ;  6
                .byte CHARACTER_WALL        ;  7
                .byte CHARACTER_BOX_ON_TARGET      ;  8    box on target
                .byte CHARACTER_BLANK       ;  9

    #if DIGITS
        .byte CHARACTER_0
        .byte CHARACTER_1
        .byte CHARACTER_2
        .byte CHARACTER_3
        .byte CHARACTER_4
        .byte CHARACTER_5
        .byte CHARACTER_6
        .byte CHARACTER_7
        .byte CHARACTER_8
        .byte CHARACTER_9
    #endif

    #if TROPHY
        .byte CHARACTER_TROPHY_0_0, CHARACTER_TROPHY_1_0, CHARACTER_TROPHY_2_0, CHARACTER_TROPHY_3_0
        .byte CHARACTER_TROPHY_0_1, CHARACTER_TROPHY_1_1, CHARACTER_TROPHY_2_1, CHARACTER_TROPHY_3_1
        .byte CHARACTER_TROPHY_0_2, CHARACTER_TROPHY_1_2, CHARACTER_TROPHY_2_2, CHARACTER_TROPHY_3_2
        .byte CHARACTER_TROPHY_0_3, CHARACTER_TROPHY_1_3, CHARACTER_TROPHY_2_3, CHARACTER_TROPHY_3_3
        .byte CHARACTER_TROPHY_0_4, CHARACTER_TROPHY_1_4, CHARACTER_TROPHY_2_4, CHARACTER_TROPHY_3_4
    #endif

    IF (* - CharReplacement != CHARACTER_MAXIMUM)
        ECHO "ERROR: Incorrect CharReplacement table!"
        ERR
    ENDIF
    CHECKPAGEX CharReplacement, "CharReplacement in BANK_ROM_SHADOW_DRAWBUFFERS"


    DEFINE_SUBROUTINE AnimateCharReplacements2 ;139

    ; This manages character animation on a per-object basis.  Morph/animate these
    ; characters individually or as required.  Change will affect all characters
    ; of the same type in the visible display.

    ; -------------------------------------------

    ; handle the non-mandatory animating things

                lda timer                                     ;3
                and #1                                        ;2
                bne nothingAnimates                           ;2/3

                lda scrollBits                                ;3
                bne nothingAnimates                           ;2/3            DON'T animate if we scrolled

                lda ANIM_TARGET                               ;4
                eor #CHARACTER_TARGET^CHARACTER_TARGET2       ;2
                sta ANIM_TARGET + RAM_WRITE                   ;4 = 22         TARGET

nothingAnimates rts                                           ;6 = 28 if animating, less if not

    ;------------------------------------------------------------------------------


    OPTIONAL_PAGEBREAK "ROW_BankChar", SCREEN_LINES * SCREEN_WIDTH
    DEFINE_SUBROUTINE ROW_BankChar

.BANK       SET BANK_SCREENMARKII1
        REPEAT SCREEN_LINES
            REPEAT SCREEN_WIDTH
                .byte .BANK
            REPEND
.BANK       SET .BANK + 1
        REPEND

    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_BANK_DRAW_BUFFERS"


    CHECK_BANK_SIZE "ROM_SHADOW_OF_BANK_DRAW_BUFFERS -- full 2K"

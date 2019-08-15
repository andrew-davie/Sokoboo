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
                NEWBANK ROM_SHADOW_OF_RAMBANK_CODE

    ; This is essentially a ROM mirror of a RAM bank.
    ; The contents of this bank are copied to each of the ROW banks on startup, and
    ; this gives a 1:1 correspondence between the data/addresses defined here, and
    ; the addresses in the switched-in RAM bank.

    ; Note: Bankswitching code between any of these banks guarantees the code can
    ; continue to run -- because, of course, the same code is still at the same
    ; memory address.

_PROFILE_DRAW    = YES

    MAC PROFILE_DRAW ; {label}
      IF _PROFILE_DRAW
        inc     Profile{1}
        bne     $skip
        inc     Profile{1}+1
$skip
      ENDIF
    ENDM


    DEFINE_SUBROUTINE DrawTheScreen

    ; Thomas Jentzsch strikes again.  And Andrew Davie too ;)
    ; A refactor of the kernel to improve the timing.
    ; Experimental refactor to remove the blank line...

    ; adjust here so that the first line of the kernel starts exactly at cycle 67
    ; (since TJ said it could start up to 5 cycles earlier than #67).

; TODO: remove GRP1 and COLUP1 access (or use higher resolution player)
                                                            ;           @57
                SLEEP 3                                     ; 3

                ldx #<(BANK_SCREENMARKII1)                  ; 2                 == 0!!!
                bpl NextALineStart                          ; 3 =  8    @65     unconditional

Proc2                                                       ; 5
                SLEEP 3                                     ; 3         @64
                bpl ScanBLUEBD                              ; 3 = 11    @67     unconditional

ScanRED                                                     ;           @60
SM_PF0_REDl     lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3         @67
                lda ScreenBitmapRED+0*LINES_PER_CHAR,y      ; 4
                sta PF1                                     ; 3 = 14    @74
;SELFMOD_PLAYERCOL_RED
                lda SpriteColourRED,y                       ; 4
                ;lda #$66
                ;nop
                sta COLUP0                                  ; 3         @05
                sta COLUP1                                  ; 3 = 10    @08

    ; TIMING COUNTS ARE WRONG FROM HERE, DUE TO ABOVE CYCLE LOSS

SELFMOD_RED
                lda #0                                      ; 2
                sta COLUPF                                  ; 3 =  5    @13

SELFMOD_PLAYER0_RED
                lda ShapePlayerRED,y                        ; 4
                sta GRP0                                    ; 3 =  7    @20

                lda ScreenBitmapRED+1*LINES_PER_CHAR,y      ; 4
                sta PF2                                     ; 3 =  7    @27

SM_PF0_REDr     lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3         @34
                lda ScreenBitmapRED+2*LINES_PER_CHAR,y      ; 4
                sta PF1                                     ; 3         @41
                lda ScreenBitmapRED+3*LINES_PER_CHAR,y      ; 4
                sta PF2                                     ; 3 = 21    @48     must be >=48! :-)

SELFMOD_PLAYER1_RED
                lda ShapePlayerRED,y                        ; 4
                sta.w GRP1                                  ; 4 =  8    @56   VDELed!

                dey                                         ; 2
                bpl Proc2                                   ; 2(3)      --> 61 if taken

SELFMOD_X       inx                                         ; 2
                stx SET_BANK_RAM                            ; 3         SWITCH TO CORRECT ROW BANK (OR EXIT BANK)
;EXIT_RETURN_HERE
NextALineStart:
                ldy #LINES_PER_CHAR/3-1                     ; 2 = 11    @67
ScanBLUEBD                                                  ;           @67     let's start as late as possible

    ;------------------------------------------------------------------------------

SM_PF0_BLUEl    lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3 =  7    @74
;SELFMOD_PLAYERCOL_BLUE
                lda SpriteColourBLUE,y                      ; 4
                ;lda #$66
                ;nop
                sta COLUP1                                  ; 3         @05
                sta COLUP0                                  ; 3 = 10    @08

SELFMOD_BLUE
                lda #0                                      ; 2
                sta COLUPF                                  ; 3 =  5    @13

SELFMOD_PLAYER0_BLUE
                lda ShapePlayerBLUE,y                       ; 4
                sta GRP0                                    ; 3 =  7    @20

                lda ScreenBitmapBLUE+0*LINES_PER_CHAR,y     ; 4
                sta PF1                                     ; 3         @27     <=27! :-)
                lda ScreenBitmapBLUE+1*LINES_PER_CHAR,y     ; 4
                sta PF2                                     ; 3 = 14    @34

SM_PF0_BLUEr    lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3         @41
                lda ScreenBitmapBLUE+2*LINES_PER_CHAR,y     ; 4
                sta PF1                                     ; 3         @48
                lda ScreenBitmapBLUE+3*LINES_PER_CHAR,y     ; 4
                sta PF2                                     ; 3 = 21    @55

SELFMOD_PLAYER1_BLUE
                lda ShapePlayerBLUE,y                       ; 4
                sta GRP1                                    ; 3 =  7    VDELed! @62

    ;------------------------------------------------------------------------------

ScanGREEN                                                   ;           @62
SM_PF0_GREENl   lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3 =  7    @69
;SELFMOD_PLAYERCOL_GREEN
                lda SpriteColourGREEN,y                     ; 4
                ;lda #$66
                ;nop
                sta COLUP1                                  ; 3         @00
                sta COLUP0                                  ; 3 = 10    @03

SELFMOD_GREEN
                lda #0                                      ; 2
                sta COLUPF                                  ; 3 =  5    @08

SELFMOD_PLAYER0_GREEN
                lda ShapePlayerGREEN,y                      ; 4
                sta GRP0                                    ; 3 =  7    @15

                lda ScreenBitmapGREEN+0*LINES_PER_CHAR,y    ; 4
                sta PF1                                     ; 3         @22
                lda ScreenBitmapGREEN+1*LINES_PER_CHAR,y    ; 4
                sta PF2                                     ; 3 = 14    @29

SM_PF0_GREENr   lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3         @36
                lda ScreenBitmapGREEN+2*LINES_PER_CHAR,y    ; 4
                sta PF1                                     ; 3         @43
                lda ScreenBitmapGREEN+3*LINES_PER_CHAR,y    ; 4
                sta PF2                                     ; 3 = 21    @50

SELFMOD_PLAYER1_GREEN
                lda ShapePlayerGREEN,y                      ; 4
                sta GRP1                                    ; 3 =  7    @57     VDELed!

                jmp ScanRED                                 ; 3         @60

    ;------------------------------------------------------------------------------

;     OPTIONAL_PAGEBREAK "PLAYER BLANK SHAPE", LINES_PER_CHAR

ShapePlayer         = PLAYER_BLANK
ShapePlayerBLUE     = ShapePlayer   ; low adresses patched
ShapePlayerGREEN    = ShapePlayer   ; low adresses patched
ShapePlayerRED      = ShapePlayer   ; low adresses patched

CHARACTERSHAPE_MANOCCUPIED = PLAYER_BLANK
CHARACTERSHAPE_BLANK = PLAYER_BLANK


PLAYER_COLOUR
SpriteColourRED
    REPEAT LINES_PER_CHAR/3
 .byte $24
    REPEND
SpriteColourGREEN
    REPEAT LINES_PER_CHAR/3
 .byte $24
    REPEND
SpriteColourBLUE
    REPEAT LINES_PER_CHAR/3
 .byte $24
    REPEND


    ;------------------------------------------------------------------------------

;*** Ideas: ***
; - separate data for left and right nibble (saves 88 cycles, 63 cycles or
;   13.5% on average), also unrolling would be more effective than now
; - use CharacterDataVecHI for mirrored/unmirrored (saves cycles and bytes,
;   see EXPERIMENTAL)
; - special QuickDraw routine for PF0 (~165 cycles, but only ~2% usage)
; - stack AI (reordering for less setup code and cycle usage, maybe better use
;   bidirectional linked list instead)
; - calculate mirrored gfx data into RAM (saves ROM)

;*** average cycle calculation (10% blanks, all columns equally frequent): ***
;currently:
; 72%*539 (!unrolled)
;+ 8%*304 (unrolled)
;+20%*269 (unrolled)
;--------
;=   ~466.2 cycles on average

;alternative #1:
; 72%*522 (unrolled)
;+ 8%*352 (!unrolled)
;+20%*307 (!unrolled)
;--------
;=   ~465.4 cycles on average


MIRROR          = 1
DIRECT          = $80

    ;------------------------------------------------------------------------------
    ; Here we don't draw into a buffer, but directly patch the kernel
    ; VERY fast!
    ;
    ; TODO: check if DirectDraw for PF1/2 can be handle efficiently like this too
    ; Problem: SlowDraw cannot assume that the other nibble is set correctly anymore

PF0Draw                                         ; 25 cycles until here

                ldx INTIM                       ; 4
                cpx #SEGTIME_SCD_PF0            ; 2
                bcc ExitDraw                    ; 2(3)=8
                STRESS_TIME SEGTIME_SCD_PF0                     ; ok!

                and #<(~DIRECT)                 ; 2
                tax                             ; 2 =  4

                tya                             ; 2
                asl                             ; 2         no mirrored chars in PF0
                tay                             ; 2 =  6
;                clc                             ; 2

                lda CharacterDataVecHI,y        ; 4
                sta SM_PF0_REDl  +RAM_WRITE+2,x ; 5
                sta SM_PF0_GREENl+RAM_WRITE+2,x ; 5
                sta SM_PF0_BLUEl +RAM_WRITE+2,x ; 5 = 19

                lda CharacterDataVecLO,y        ; 4
                sta SM_PF0_REDl  +RAM_WRITE+1,x ; 5
                adc #LINES_PER_CHAR/3-1         ; 2         CF is set!
                sta SM_PF0_GREENl+RAM_WRITE+1,x ; 5
                adc #LINES_PER_CHAR/3           ; 2
                sta SM_PF0_BLUEl +RAM_WRITE+1,x ; 5 = 23

                jmp DrawAnother                 ; 3 =  3

    ; Timing for PF0Draw
    ; 88
    ; total: 37+70+6 = 113 => 113/64 + 1.4 = 3.17 = 4 (or 3?)


    ;------------------------------------------------------------------------------
    ; Direct draw draws to PF0, which only has one active member of the character
    ; pair -- so it can be a direct copy.  Quicker still!

DirectDraw                                      ; 37 cycles until here

 ;ldy #16
                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_DIRECT         ; 2
                bcc ExitDraw                    ; 2(3)=8
                STRESS_TIME SEGTIME_SCD_DIRECT                     ; ok!

    ; TIME REQUIRED FROM HERE (9/JAN)
    ; 16 + 20 + 20 + 2 + ( 8 * 32 ) - 1  + (42 SUFFIX)
    ; = 323 --> /64 = 5.04 USE 7

                lda CharacterDataVecHI,y        ; 4
                sta SM3LOAD+RAM_WRITE+2         ; 4
                sta SM3LOADb+RAM_WRITE+2        ; 4
                sta SM3LOADc+RAM_WRITE+2        ; 4 = 16

                lda CharacterDataVecLO,y        ; 4
                sta SM3LOAD+RAM_WRITE+1         ; 4
                adc #LINES_PER_CHAR/3 - 1       ; 2         CF is set!
                sta SM3LOADb+RAM_WRITE+1        ; 4
                adc #LINES_PER_CHAR/3           ; 2
                sta SM3LOADc+RAM_WRITE+1        ; 4 = 20

                lda CharAddressLO,x             ; 4         ScreenBitmap(COL) LO byte
                sta SM3STORE+RAM_WRITE+1        ; 4
                adc #LINES_PER_CHAR/3           ; 2
                sta SM3STOREb+RAM_WRITE+1       ; 4
                adc #LINES_PER_CHAR/3           ; 2
                sta SM3STOREc+RAM_WRITE+1       ; 4 = 20

                ldy #LINES_PER_CHAR/3 - 1       ; 2 =  2
TSFill3
SM3LOAD         lda $F000,y                     ; 4+
SM3STORE        sta ScreenBitmap+RAM_WRITE,y    ; 5
SM3LOADb        lda $F000,y                     ; 4+
SM3STOREb       sta ScreenBitmap+RAM_WRITE,y    ; 5
SM3LOADc        lda $F000,y                     ; 4+
SM3STOREc       sta ScreenBitmap+RAM_WRITE,y    ; 5 = 27

                dey                             ; 2
                CHECKPAGE_BPL TSFill3           ; 3(2)=5

                jmp DrawAnother                 ; 3

    ; Timing for DirectDraw
    ; 17+8+16+20+20+2+(32*7)-1+3 = 309 (was: 302 + 3)
    ; total: 37+309+6 = 352 => 352/64 + 1.4 = 6.90 = 7 (= SEGTIME_SLOWDRAW-5)

ExitDraw
                rts

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE StealPart3                ; 18 CYCLES HERE

                lda MOD10,x                     ; 4
                bmi PF0Draw                     ; 2/3
                lsr                             ; 2
                tax                             ; 2
                tya                             ; 2
                rol                             ; 2         allows for mirrored char = * | 1
                tay                             ; 2
                bcs  DirectDraw                 ; 2(3)      when draw stack was built, bit 7 flags direct-drawn character
                                                ;           => +19 starting DirectDraw BUT WHO CARES AS IT'S ONLY AFTER THAT COUNTS

                lda CharacterDataVecHI,y        ; 4
                bpl QuickDraw                   ; 2(3)=42   special-case blank characters for extra speed
                                                ;           => 42 starting QuickDraw
                sta SMEOR1+RAM_WRITE+2          ; 4 =  4

                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_SLOW           ; 2
                bcc ExitDraw                    ; 2(3)=8
                STRESS_TIME SEGTIME_SCD_SLOW                     ; ok!

    ; TIME REQUIRED FROM HERE (9/JAN)
    ; 8 + 16 + 8 + 2 + (24 * 24) -1 + (42 OVERHEAD WHEN RETURNING)
    ; = 651

                lda CharacterDataVecLO,y        ; 4
                sta SMEOR1+RAM_WRITE+1          ; 4 =  8

                lda CharAddressLO,x             ; 4         ScreenBitmap(COL) LO byte
                sta SMLOAD+RAM_WRITE+1          ; 4
                sta SMEOR2+RAM_WRITE+1          ; 4
                sta SMSTORE+RAM_WRITE+1         ; 4 = 16

                lda CharMaskNeg,x               ; 4         masks out left or right
                sta SMMASK+RAM_WRITE+1          ; 4 =  8

SlowDraw        ldy #LINES_PER_CHAR - 1         ; 2 =  2

    ; A very nice bit of Thomas Jentzsch replacement magic giving 77 cycle savings.
    ; Rewrite for self-modification by Andrew Davie giving another 90 cycles :)

TSFill

SMLOAD          lda ScreenBitmap,y              ; 4
SMEOR1          eor $F000,y                     ; 4
SMMASK          and #0                          ; 2
SMEOR2          eor ScreenBitmap,y              ; 4         using ScreenBitmap here avoids setting high-pointer
SMSTORE         sta ScreenBitmap+RAM_WRITE,y    ; 5 = 19

                dey                             ; 2
                CHECKPAGE_BPL TSFill            ; 3(2)=5

                jmp DrawAnother                 ; 3

    ; Timing for "SLOW" draw
    ; 22+4+8+8+16+8+2+(21*24)-1+3 = 574 (was: 566 + 3)
    ; total: 37+574+6 = 617 => 628/64 + 1.4 = 11.04 = 12 (= SEGTIME_SLOWDRAW)


   ;------------------------------------------------------------------------------
    ; QuickDraw is for drawing BLANK characters.  It just has to mask out the
    ; existing character data, so can be special-cased from the normal character
    ; draw, saving roughly 230 cycles.

QuickDraw                                       ; 42 cycles until here

                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_QUICK          ; 2         SEE TIMING CALCS BELOW
                bcc ExitDraw                    ; 2(3)=8
                STRESS_TIME SEGTIME_SCD_QUICK                     ; ok!

    ; TIME REQUIRED FROM HERE (9/JAN)
    ;   = 32 + 4 + 2 + ( 8 * 38 ) - 1 + 3  + (42 SUFFIX)
    ;   = 386 --> /64 = 5.43. USE 7

                lda CharAddressLO,x             ; 4         ScreenBitmap(COL) LO byte
                sta SM2LOAD+RAM_WRITE+1         ; 4
                sta SM2STORE+RAM_WRITE+1        ; 4
                adc #LINES_PER_CHAR/3 - 1       ; 2         CF is set!
                sta SM2LOADb+RAM_WRITE+1        ; 4
                sta SM2STOREb+RAM_WRITE+1       ; 4
                adc #LINES_PER_CHAR/3           ; 2
                sta SM2LOADc+RAM_WRITE+1        ; 4
                sta SM2STOREc+RAM_WRITE+1       ; 4 = 32

                ldy CharMask,x                  ; 4 =  4    masks out left or right

                ldx #LINES_PER_CHAR/3 - 1       ; 2 =  2
TSFill2
                tya                             ; 2
SM2LOAD         and ScreenBitmap,x              ; 4+
SM2STORE        sta ScreenBitmap+RAM_WRITE,x    ; 5
                tya                             ; 2
SM2LOADb        and ScreenBitmap,x              ; 4+
SM2STOREb       sta ScreenBitmap+RAM_WRITE,x    ; 5
                tya                             ; 2
SM2LOADc        and ScreenBitmap,x              ; 4+
SM2STOREc       sta ScreenBitmap+RAM_WRITE,x    ; 5 = 33

                dex                             ; 2
                CHECKPAGE_BPL TSFill2           ; 3(2)=5

                jmp DrawAnother                 ; 3

    ; Timing for QuickDraw
    ; 23+8+32+4+2+(7*38)-1+3 = 337 (was: 330 + 3)
    ; total: 37+337+6 = 380 => 380/64 + 1.4 = 7.34 = 8 (= SEGTIME_SLOWDRAW-4)


   ;------------------------------------------------------------------------------


CharAddressLO ;[abs char location % 10]

    ; Gives the absolute screen buffer address of the first line of the given character
    ; Where character number is 0-9

            .byte < ( ScreenBitmap + ( 0 * LINES_PER_CHAR ))  ; 1
            .byte < ( ScreenBitmap + ( 0 * LINES_PER_CHAR ))  ; 2
            .byte < ( ScreenBitmap + ( 1 * LINES_PER_CHAR ))  ; 3
            .byte < ( ScreenBitmap + ( 1 * LINES_PER_CHAR ))  ; 4
            .byte < ( ScreenBitmap + ( 2 * LINES_PER_CHAR ))  ; 6
            .byte < ( ScreenBitmap + ( 2 * LINES_PER_CHAR ))  ; 7
            .byte < ( ScreenBitmap + ( 3 * LINES_PER_CHAR ))  ; 8
            .byte < ( ScreenBitmap + ( 3 * LINES_PER_CHAR ))  ; 9
;            .byte < ( ScreenBitmap + ( 0 * LINES_PER_CHAR ))  ; 0 PF0
;            .byte < ( ScreenBitmap + ( 3 * LINES_PER_CHAR ))  ; 5 PF0

CharMask ; [abs char location % 10]

    ; Gives the mask for any char of the screen (per row)
    ; Note, this is hardwired to the screen format of 6 bytes/line

            .byte $0F       ; 1
            .byte $F0       ; 2
CharMaskNeg:
            .byte $F0       ; 3/1
            .byte $0F       ; 4/2
            .byte $0F       ; 6/3
            .byte $F0       ; 7/4
            .byte $F0       ; 8/6
            .byte $0F       ; 9/7
            .byte $0F       ; -/8
            .byte $F0       ; -/9
MOD10
    REPEAT SCREEN_LINES
;        .byte (8*2), MIRROR+0*2, MIRROR+1*2, 2*2, 3*2
;        .byte (9*2), MIRROR+4*2, MIRROR+5*2, 6*2, 7*2
        .byte DIRECT
        .byte MIRROR+0*2, MIRROR+1*2, 2*2, 3*2
        .byte DIRECT+SM_PF0_BLUEr-SM_PF0_BLUEl  ; works only if distances between PF= writes are identical!
        .byte MIRROR+4*2, MIRROR+5*2, 6*2, 7*2
    REPEND

    ;------------------------------------------------------------------------------

    OPTIONAL_PAGEBREAK "SCREEN_BITMAP", SCREEN_BITMAP_SIZE

ScreenBitmap    ds SCREEN_BITMAP_SIZE,0                      ; character bitmap row (10 chars wide)
ScreenBitmapRED     = ScreenBitmap + LINES_PER_CHAR/3*0
ScreenBitmapGREEN   = ScreenBitmap + LINES_PER_CHAR/3*1
ScreenBitmapBLUE    = ScreenBitmap + LINES_PER_CHAR/3*2

    CHECKPAGEX ScreenBitmap, "ScreenBitmap"


;--------------------------------------------------------------------------

    DEFINE_SUBROUTINE SelfModDrawPlayers ; copied to ROW RAM BANKS

    ; Now the player(s) have animated, update the appropriate shape pointers
    ; in the draw code.

    ; Sets the shapes to a blank player -- effectively erasing

                lda LastSpriteY
                ldx #<PLAYER_BLANK
                jsr SetSelfModPlayer

    ; Now we've erased, we write the new shape

                lda ManDrawX
                cmp #SCREEN_WIDTH
                bcs NoMod                               ; skip if off visible screen

                lda ManDrawY
                sta LastSpriteY

                ldx ManAnimationFrameLO

SetSelfModPlayer
                cmp #SCREEN_LINES                       ; only erase/draw if was/is onscreen
                bcs NoMod
                adc #BANK_SCREENMARKII1
                sta SET_BANK_RAM                        ; switch old/new bank in

                txa
                sta SELFMOD_PLAYER0_RED+RAM_WRITE+1     ; lo of frame
                adc #LINES_PER_CHAR/3
                sta SELFMOD_PLAYER0_GREEN+RAM_WRITE+1
                adc #LINES_PER_CHAR/3
                sta SELFMOD_PLAYER0_BLUE+RAM_WRITE+1

NoMod           rts

    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE (1K)"

    include "player.asm"        ; 6 * LINES_PER_CHAR          MUST FOLLOW DIRT.ASM as data is shared

   ;------------------------------------------------------------------------------

; The acutal colour palette to use for the player. The player may be any "ethnicity" which refers
; to the colours for a frame. The skin could be asian/black/caucasian, the cloting could be anything.
; Each ethnicity is defined as first 8 bytes for NTSC and then 8 bytes for PAL. The 8 bytes refer
; to the "CL#" index values defined in the player COLOUR frames. So, an index is grabbed from the
; player frame, it is adjusted to add the base ethnicity and the NTSC/PAL, and that gives the base
; for reading 8 successive bytes for CL0..CL7 from the frame definitions.

EthnicityColourPalette

    ; ETHNICITY 0
    .byte $0, $0A,$0A,$0A,$0A,$0A,$0A,$0A           ; NTSC
    .byte $0, $20,$32,$44,$56,$68,$7A,$8C           ; PAL

    ; ETHNICITY 1
    .byte $0, $0A,$0A,$0A,$0A,$0A,$0A,$0A           ; NTSC
    .byte $0, $20,$32,$44,$56,$68,$7A,$8C           ; PAL

    ; ETHNICITY 2
    .byte $0, $0A,$0A,$0A,$0A,$0A,$0A,$0A           ; NTSC
    .byte $0, $20,$32,$44,$56,$68,$7A,$8C           ; PAL

    ; ETHNICITY 3
    .byte $0, $0A,$0A,$0A,$0A,$0A,$0A,$0A           ; NTSC
    .byte $0, $20,$32,$44,$56,$68,$7A,$8C           ; PAL

   ;------------------------------------------------------------------------------

    ;ECHO "TOTAL ROW-BANK CODE REQUIREMENT = ", * - BANK_START

    ;------------------------------------------------------------------------------




OBJTYPE    SET 0
    MAC DEFINE_CHARACTER
CHARACTER_{1}    = OBJTYPE
OBJTYPE    .SET OBJTYPE + 1
    ENDM

; Modifications to character #/order must also ensure the following are correct...
;   CharacterDataVecLO/HI         in this file
;   MoveVecLO/HI                  in BANK_INITBANK
;   CharReplacement               in BANK_ROM_SHADOW_DRAWBUFFERS

    DEFINE_CHARACTER BLANK
    DEFINE_CHARACTER SOIL
    DEFINE_CHARACTER BOX
    DEFINE_CHARACTER TARGET
    DEFINE_CHARACTER TARGET2
    DEFINE_CHARACTER MANOCCUPIED
    DEFINE_CHARACTER STEEL
    DEFINE_CHARACTER WALL
    DEFINE_CHARACTER BOX_ON_TARGET
    DEFINE_CHARACTER NOGO

#if DIGITS
    DEFINE_CHARACTER 0
    DEFINE_CHARACTER 1
    DEFINE_CHARACTER 2
    DEFINE_CHARACTER 3
    DEFINE_CHARACTER 4
    DEFINE_CHARACTER 5
    DEFINE_CHARACTER 6
    DEFINE_CHARACTER 7
    DEFINE_CHARACTER 8
    DEFINE_CHARACTER 9
#endif

#if TROPHY

    DEFINE_CHARACTER TROPHY_0_0
    DEFINE_CHARACTER TROPHY_1_0
    DEFINE_CHARACTER TROPHY_2_0
    DEFINE_CHARACTER TROPHY_3_0

    DEFINE_CHARACTER TROPHY_0_1
    DEFINE_CHARACTER TROPHY_1_1
    DEFINE_CHARACTER TROPHY_2_1
    DEFINE_CHARACTER TROPHY_3_1

    DEFINE_CHARACTER TROPHY_0_2
    DEFINE_CHARACTER TROPHY_1_2
    DEFINE_CHARACTER TROPHY_2_2
    DEFINE_CHARACTER TROPHY_3_2

    DEFINE_CHARACTER TROPHY_0_3
    DEFINE_CHARACTER TROPHY_1_3
    DEFINE_CHARACTER TROPHY_2_3
    DEFINE_CHARACTER TROPHY_3_3

    DEFINE_CHARACTER TROPHY_0_4
    DEFINE_CHARACTER TROPHY_1_4
    DEFINE_CHARACTER TROPHY_2_4
    DEFINE_CHARACTER TROPHY_3_4
#endif

    DEFINE_CHARACTER MAXIMUM


CharacterDataVecLO

; Two entries per character.  2nd is ptr to mirrored character
; Characters don't have to be mirrored, obviously -- use the same pointer for both!

  .byte <CHARACTERSHAPE_BLANK
  .byte <CHARACTERSHAPE_BLANK
  .byte <CHARACTERSHAPE_SOIL
  .byte <CHARACTERSHAPE_SOIL_MIRRORED
  .byte <CHARACTERSHAPE_BOX
  .byte <CHARACTERSHAPE_BOX_MIRRORED
  .byte <CHARACTERSHAPE_TARGET
  .byte <CHARACTERSHAPE_TARGET_MIRRORED
  .byte <CHARACTERSHAPE_BLANK
  .byte <CHARACTERSHAPE_BLANK
  .byte <CHARACTERSHAPE_BLANK ; man occupied
  .byte <CHARACTERSHAPE_BLANK
  .byte <CHARACTERSHAPE_STEEL
  .byte <CHARACTERSHAPE_STEEL_MIRRORED
  .byte <CHARACTERSHAPE_WALL
  .byte <CHARACTERSHAPE_WALL_MIRRORED
  .byte <CHARACTERSHAPE_BOX_ON_TARGET
  .byte <CHARACTERSHAPE_BOX_ON_TARGET_MIRRORED
  .byte <CHARACTERSHAPE_BLANK                     ; unkillable man
  .byte <CHARACTERSHAPE_BLANK                     ; unkillable man

    #if DIGITS
    .byte <CHARACTERSHAPE_0, <CHARACTERSHAPE_0_MIRRORED
    .byte <CHARACTERSHAPE_1, <CHARACTERSHAPE_1_MIRRORED
    .byte <CHARACTERSHAPE_2, <CHARACTERSHAPE_2_MIRRORED
    .byte <CHARACTERSHAPE_3, <CHARACTERSHAPE_3_MIRRORED
    .byte <CHARACTERSHAPE_4, <CHARACTERSHAPE_4_MIRRORED
    .byte <CHARACTERSHAPE_5, <CHARACTERSHAPE_5_MIRRORED
    .byte <CHARACTERSHAPE_6, <CHARACTERSHAPE_6_MIRRORED
    .byte <CHARACTERSHAPE_7, <CHARACTERSHAPE_7_MIRRORED
    .byte <CHARACTERSHAPE_8, <CHARACTERSHAPE_8_MIRRORED
    .byte <CHARACTERSHAPE_9, <CHARACTERSHAPE_9_MIRRORED
    #endif

    #if TROPHY
    .byte <CHARACTERSHAPE_TROPHY_0_0, <CHARACTERSHAPE_TROPHY_0_0
    .byte <CHARACTERSHAPE_TROPHY_1_0, <CHARACTERSHAPE_TROPHY_1_0
    .byte <CHARACTERSHAPE_TROPHY_2_0, <CHARACTERSHAPE_TROPHY_2_0
    .byte <CHARACTERSHAPE_TROPHY_3_0, <CHARACTERSHAPE_TROPHY_3_0

    .byte <CHARACTERSHAPE_TROPHY_0_1, <CHARACTERSHAPE_TROPHY_0_1
    .byte <CHARACTERSHAPE_TROPHY_1_1, <CHARACTERSHAPE_TROPHY_1_1
    .byte <CHARACTERSHAPE_TROPHY_2_1, <CHARACTERSHAPE_TROPHY_2_1
    .byte <CHARACTERSHAPE_TROPHY_3_1, <CHARACTERSHAPE_TROPHY_3_1

    .byte <CHARACTERSHAPE_TROPHY_0_2, <CHARACTERSHAPE_TROPHY_0_2
    .byte <CHARACTERSHAPE_TROPHY_1_2, <CHARACTERSHAPE_TROPHY_1_2
    .byte <CHARACTERSHAPE_TROPHY_2_2, <CHARACTERSHAPE_TROPHY_2_2
    .byte <CHARACTERSHAPE_TROPHY_3_2, <CHARACTERSHAPE_TROPHY_3_2

    .byte <CHARACTERSHAPE_TROPHY_0_3, <CHARACTERSHAPE_TROPHY_0_3
    .byte <CHARACTERSHAPE_TROPHY_1_3, <CHARACTERSHAPE_TROPHY_1_3
    .byte <CHARACTERSHAPE_TROPHY_2_3, <CHARACTERSHAPE_TROPHY_2_3
    .byte <CHARACTERSHAPE_TROPHY_3_3, <CHARACTERSHAPE_TROPHY_3_3

    .byte <CHARACTERSHAPE_TROPHY_0_4, <CHARACTERSHAPE_TROPHY_0_4
    .byte <CHARACTERSHAPE_TROPHY_1_4, <CHARACTERSHAPE_TROPHY_1_4
    .byte <CHARACTERSHAPE_TROPHY_2_4, <CHARACTERSHAPE_TROPHY_2_4
    .byte <CHARACTERSHAPE_TROPHY_3_4, <CHARACTERSHAPE_TROPHY_3_4
    #endif

  IF * - CharacterDataVecLO != CHARACTER_MAXIMUM*2
    ECHO "ERROR: Incorrect CharacterDataVecLO table!"
    ERR
  ENDIF


 ;ds 20,0

;---------------------------------------------------------------------------

CharacterDataVecHI

    .byte >CHARACTERSHAPE_BLANK
    .byte >CHARACTERSHAPE_BLANK
    .byte >CHARACTERSHAPE_SOIL
    .byte >CHARACTERSHAPE_SOIL_MIRRORED
    .byte >CHARACTERSHAPE_BOX
    .byte >CHARACTERSHAPE_BOX_MIRRORED
    .byte >CHARACTERSHAPE_TARGET
    .byte >CHARACTERSHAPE_TARGET_MIRRORED
    .byte >CHARACTERSHAPE_BLANK
    .byte >CHARACTERSHAPE_BLANK
    .byte >CHARACTERSHAPE_BLANK ; man occupied
    .byte >CHARACTERSHAPE_BLANK
    .byte >CHARACTERSHAPE_STEEL
    .byte >CHARACTERSHAPE_STEEL_MIRRORED
    .byte >CHARACTERSHAPE_WALL
    .byte >CHARACTERSHAPE_WALL_MIRRORED
    .byte >CHARACTERSHAPE_BOX_ON_TARGET
    .byte >CHARACTERSHAPE_BOX_ON_TARGET_MIRRORED
    .byte >CHARACTERSHAPE_BLANK                     ; unkillable man
    .byte >CHARACTERSHAPE_BLANK                     ; unkillable man

    #if DIGITS
    .byte >CHARACTERSHAPE_0, >CHARACTERSHAPE_0_MIRRORED
    .byte >CHARACTERSHAPE_1, >CHARACTERSHAPE_1_MIRRORED
    .byte >CHARACTERSHAPE_2, >CHARACTERSHAPE_2_MIRRORED
    .byte >CHARACTERSHAPE_3, >CHARACTERSHAPE_3_MIRRORED
    .byte >CHARACTERSHAPE_4, >CHARACTERSHAPE_4_MIRRORED
    .byte >CHARACTERSHAPE_5, >CHARACTERSHAPE_5_MIRRORED
    .byte >CHARACTERSHAPE_6, >CHARACTERSHAPE_6_MIRRORED
    .byte >CHARACTERSHAPE_7, >CHARACTERSHAPE_7_MIRRORED
    .byte >CHARACTERSHAPE_8, >CHARACTERSHAPE_8_MIRRORED
    .byte >CHARACTERSHAPE_9, >CHARACTERSHAPE_9_MIRRORED
    #endif

    #if TROPHY
    .byte >CHARACTERSHAPE_TROPHY_0_0, >CHARACTERSHAPE_TROPHY_0_0
    .byte >CHARACTERSHAPE_TROPHY_1_0, >CHARACTERSHAPE_TROPHY_1_0
    .byte >CHARACTERSHAPE_TROPHY_2_0, >CHARACTERSHAPE_TROPHY_2_0
    .byte >CHARACTERSHAPE_TROPHY_3_0, >CHARACTERSHAPE_TROPHY_3_0

    .byte >CHARACTERSHAPE_TROPHY_0_1, >CHARACTERSHAPE_TROPHY_0_1
    .byte >CHARACTERSHAPE_TROPHY_1_1, >CHARACTERSHAPE_TROPHY_1_1
    .byte >CHARACTERSHAPE_TROPHY_2_1, >CHARACTERSHAPE_TROPHY_2_1
    .byte >CHARACTERSHAPE_TROPHY_3_1, >CHARACTERSHAPE_TROPHY_3_1

    .byte >CHARACTERSHAPE_TROPHY_0_2, >CHARACTERSHAPE_TROPHY_0_2
    .byte >CHARACTERSHAPE_TROPHY_1_2, >CHARACTERSHAPE_TROPHY_1_2
    .byte >CHARACTERSHAPE_TROPHY_2_2, >CHARACTERSHAPE_TROPHY_2_2
    .byte >CHARACTERSHAPE_TROPHY_3_2, >CHARACTERSHAPE_TROPHY_3_2

    .byte >CHARACTERSHAPE_TROPHY_0_3, >CHARACTERSHAPE_TROPHY_0_3
    .byte >CHARACTERSHAPE_TROPHY_1_3, >CHARACTERSHAPE_TROPHY_1_3
    .byte >CHARACTERSHAPE_TROPHY_2_3, >CHARACTERSHAPE_TROPHY_2_3
    .byte >CHARACTERSHAPE_TROPHY_3_3, >CHARACTERSHAPE_TROPHY_3_3

    .byte >CHARACTERSHAPE_TROPHY_0_4, >CHARACTERSHAPE_TROPHY_0_4
    .byte >CHARACTERSHAPE_TROPHY_1_4, >CHARACTERSHAPE_TROPHY_1_4
    .byte >CHARACTERSHAPE_TROPHY_2_4, >CHARACTERSHAPE_TROPHY_2_4
    .byte >CHARACTERSHAPE_TROPHY_3_4, >CHARACTERSHAPE_TROPHY_3_4
    #endif


    IF * - CharacterDataVecHI != CHARACTER_MAXIMUM*2
        ECHO "ERROR: Incorrect CharacterDataVecHI table!"
        ERR
    ENDIF

    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE -- 1K"

    ; Here there's another 1K of usable ROM....
    ; Anything here is ONLY accessible if the bank is switched in as a ROM bank
    ; WE CAN'T HAVE ANYTHING REQUIRED IN THE ROM_SHADOW (IN RAM) IN THIS HALF

    CHECK_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE -- full 2K"

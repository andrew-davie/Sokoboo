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

    DEFINE_SUBROUTINE DrawTheScreen

    ; Thomas Jentzsch strikes again.  And Andrew Davie too ;)
    ; A refactor of the kernel to improve the timing.
    ; Experimental refactor to remove the blank line...

    ; adjust here so that the first line of the kernel starts exactly at cycle 67
    ; (since TJ said it could start up to 5 cycles earlier than #67).

; TODO: remove GRP1 and COLUP1 access (or use higher resolution player)
                                                            ;           @57
                SLEEP 6                                     ; 3

                ldx #<(BANK_SCREENMARKII1)                  ; 2                 == 0!!!
                bpl NextALineStart                          ; 3 =  8    @65     unconditional

Proc2                                                       ; 5
                SLEEP 3                                     ; 3         @64
                bpl ScanBLUEBD                              ; 3 = 11    @67     unconditional

    DEFINE_SUBROUTINE ScanRED                                                     ;           @60
SM_PF0_REDl     lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3         @67
                lda ScreenBitmapRED+0*LINES_PER_CHAR,y      ; 4
                sta PF1                                     ; 3 = 14    @74
;SELFMOD_PLAYERCOL_RED
                lda PLAYER0_COLOUR,y                       ; 4
                ;lda #$66
                ;nop
                sta COLUP0                                  ; 3         @05
                SLEEP 3
                ;sta COLUP1                                  ; 3 = 10    @08

    ; TIMING COUNTS ARE WRONG FROM HERE, DUE TO ABOVE CYCLE LOSS

SELFMOD_RED
                lda #0                                      ; 2
                sta COLUPF                                  ; 3 =  5    @13

SELFMOD_PLAYER0_RED
                lda ShapePlayerRED,y                        ; 4
                sta GRP0                                    ; 3 =  7    @20

                lda ScreenBitmapRED+1*LINES_PER_CHAR,y      ; 4
                sta PF2                                     ; 3 =  7    @27

SM_PF0_REDr     lda #CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3         @34
                lda ScreenBitmapRED+2*LINES_PER_CHAR,y      ; 4
                sta PF1                                     ; 3         @41
                lda ScreenBitmapRED+3*LINES_PER_CHAR,y      ; 4
                sta PF2                                     ; 3 = 21    @48     must be >=48! :-)

SELFMOD_PLAYER1_RED
                lda ShapePlayerRED,y                        ; 4
                ;sta.w GRP1                                  ; 4 =  8    @56   VDELed!
                SLEEP 4

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
                lda PLAYER0_COLOUR+2*LINES_PER_CHAR/3,y                      ; 4
                ;lda #$66
                ;nop
                ;sta COLUP1                                  ; 3         @05
                SLEEP 3
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
                ;sta GRP1                                    ; 3 =  7    VDELed! @62
                SLEEP 3

    ;------------------------------------------------------------------------------

ScanGREEN                                                   ;           @62
SM_PF0_GREENl   lda CHARACTERSHAPE_BLANK,y                  ; 4
                sta PF0                                     ; 3 =  7    @69
;SELFMOD_PLAYERCOL_GREEN
                lda PLAYER0_COLOUR+LINES_PER_CHAR/3,y                     ; 4
                ;lda #$66
                ;nop
                ;sta COLUP1                                  ; 3         @00
                SLEEP 3
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
                ;sta GRP1                                    ; 3 =  7    @57     VDELed!
                SLEEP 3

                jmp ScanRED                                 ; 3         @60

    ;------------------------------------------------------------------------------

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

PF0Draw                                         ; 25✅ cycles until here

                ldx INTIM                       ; 4
                cpx #SEGTIME_SCD_PF0            ; 2
                bcc ExitDraw                    ; 2(3)=8✅

                and #<(~DIRECT)                 ; 2
                tax                             ; 2 =  4✅

                tya                             ; 2
                asl                             ; 2         no mirrored chars in PF0
                tay                             ; 2 =  6✅
;                clc                             ; 2

                lda CharacterDataVecHI,y        ; 4
                sta SM_PF0_REDl  +RAM_WRITE+2,x ; 5
                sta SM_PF0_GREENl+RAM_WRITE+2,x ; 5
                sta SM_PF0_BLUEl +RAM_WRITE+2,x ; 5 = 19✅

                lda CharacterDataVecLO,y        ; 4
                sta SM_PF0_REDl  +RAM_WRITE+1,x ; 5
                adc #LINES_PER_CHAR/3-1         ; 2         CF is set!
                sta SM_PF0_GREENl+RAM_WRITE+1,x ; 5
                adc #LINES_PER_CHAR/3           ; 2
                sta SM_PF0_BLUEl +RAM_WRITE+1,x ; 5 = 23✅

                jmp DrawAnother                 ; 3 =  [25]+8+4+6+19+24+3 = 88✅ entering DrawAnother

    ; Timing for PF0Draw
    ; 88
    ; total: 37+70+6 = 113 => 113/64 + 1.4 = 3.17 = 4 (or 3?)


    ;------------------------------------------------------------------------------
    ; Direct draw draws to PF0, which only has one active member of the character
    ; pair -- so it can be a direct copy.  Quicker still!

DirectDraw                                      ; 37✅ cycles until here

                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_DIRECT         ; 2
                bcc ExitDraw                    ; 2(3)=8
                                                ; => [37]+(9)+6rts = 51 cycles if draw exits

                                                ; @ [37]+8 =45✅

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

                                                ; @45+16+20+20+2 = @103
TSFill3                                         ; 8*{...
SM3LOAD         lda $F000,y                     ; 4+
SM3STORE        sta ScreenBitmap+RAM_WRITE,y    ; 5
SM3LOADb        lda $F000,y                     ; 4+
SM3STOREb       sta ScreenBitmap+RAM_WRITE,y    ; 5
SM3LOADc        lda $F000,y                     ; 4+
SM3STOREc       sta ScreenBitmap+RAM_WRITE,y    ; 5 = 27

                dey                             ; 2
                CHECKPAGE_BPL TSFill3           ; 3(2)=5 ...32✅} = 8*32-1 = 255

                jmp DrawAnother                 ; 3
                                                ; => @103+255+3 = 361✅ entering DrawAnother

ExitDraw        rts                             ; 6

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE StealPart3                ; [18]✅ CYCLES TO HERE

                lda MOD10,x                     ; 4
                bmi PF0Draw                     ; 2/3 --> 25 cycles entering PF0Draw

                lsr                             ; 2
                tax                             ; 2
                tya                             ; 2
                rol                             ; 2           allows for mirrored char = * | 1
                tay                             ; 2
                bcs  DirectDraw                 ; 2(3) = 18✅ when draw stack was built, bit 7 flags direct-drawn character
                                                ; ==> [18]+{19) = 37 @ start of DirectDraw

                lda CharacterDataVecHI,y        ; 4
                bpl QuickDraw                   ; 2(3) = 6(7)   special-case blank characters for extra speed
                                                ; => [18]+18+(7) = 43✅ starting QuickDraw
                                                ; +15 => 58✅ if QuickDraw exits

                                                ; @ 24

                sta SMEOR1+RAM_WRITE+2          ; 4

                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_SLOW           ; 2
                bcc ExitDraw                    ; 2(3) = 8
                                                ; => [18]+55+6rts=79✅ cycles if we decline

                                                ; @36
                                                ; [18]+36 = @54

                lda CharacterDataVecLO,y        ; 4
                sta SMEOR1+RAM_WRITE+1          ; 4 =  8

                lda CharAddressLO,x             ; 4         ScreenBitmap(COL) LO byte
                sta SMLOAD+RAM_WRITE+1          ; 4
                sta SMEOR2+RAM_WRITE+1          ; 4
                sta SMSTORE+RAM_WRITE+1         ; 4 = 16

                lda CharMaskNeg,x               ; 4         masks out left or right
                sta SMMASK+RAM_WRITE+1          ; 4 =  8

SlowDraw        ldy #LINES_PER_CHAR - 1         ; 2 =  2 => @88+

    ; A very nice bit of Thomas Jentzsch replacement magic giving 77 cycle savings.
    ; Rewrite for self-modification by Andrew Davie giving another 90 cycles :)

TSFill                                          ; 24*{...✅

SMLOAD          lda ScreenBitmap,y              ; 4
SMEOR1          eor $F000,y                     ; 4
SMMASK          and #0                          ; 2
SMEOR2          eor ScreenBitmap,y              ; 4         using ScreenBitmap here avoids setting high-pointer
SMSTORE         sta ScreenBitmap+RAM_WRITE,y    ; 5 = 19

                dey                             ; 2
                CHECKPAGE_BPL TSFill            ; 3(2)=5  ...24}-1 = 575✅

                jmp DrawAnother                 ; 3 = @88+575+3 = @676✅


   ;------------------------------------------------------------------------------
    ; QuickDraw is for drawing BLANK characters.  It just has to mask out the
    ; existing character data, so can be special-cased from the normal character
    ; draw, saving roughly 230 cycles.

QuickDraw                                       ; [43]✅ cycles until here

                lda INTIM                       ; 4
                cmp #SEGTIME_SCD_QUICK          ; 2
                bcc ExitDraw                    ; 2(3)=8(9)
                                                ; =>[43]+(9)+6rts =58✅ if exit
    ;@[43]+8=51✅

                lda CharAddressLO,x             ; 4         ScreenBitmap(COL) LO byte
                sta SM2LOAD+RAM_WRITE+1         ; 4
                sta SM2STORE+RAM_WRITE+1        ; 4
                adc #LINES_PER_CHAR/3 - 1       ; 2         CF is set!
                sta SM2LOADb+RAM_WRITE+1        ; 4
                sta SM2STOREb+RAM_WRITE+1       ; 4
                adc #LINES_PER_CHAR/3           ; 2
                sta SM2LOADc+RAM_WRITE+1        ; 4
                sta SM2STOREc+RAM_WRITE+1       ; 4 = 32✅

                ldy CharMask,x                  ; 4         masks out left or right

                ldx #LINES_PER_CHAR/3 - 1       ; 2         =32+4+2+8*{...✅
TSFill2
                tya                             ; 2
SM2LOAD         and ScreenBitmap,x              ; 4+
SM2STORE        sta ScreenBitmap+RAM_WRITE,x    ; 5
                tya                             ; 2
SM2LOADb        and ScreenBitmap,x              ; 4+
SM2STOREb       sta ScreenBitmap+RAM_WRITE,x    ; 5
                tya                             ; 2
SM2LOADc        and ScreenBitmap,x              ; 4+
SM2STOREc       sta ScreenBitmap+RAM_WRITE,x    ; 5 = 33✅

                dex                             ; 2
                CHECKPAGE_BPL TSFill2           ; 3(2) = 5  ...} = 32+4+2+8*38-1
                                                ;                => 341✅

                jmp DrawAnother                 ; 3 = 344

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

    ; Update the appropriate shape pointers in the draw code.
    ; First, set the shape to a blank player -- effectively erasing

                ldx LastSpriteY
                bmi erased                                  ; offscreen
                cpx ManDrawY
                beq NoMod                                   ; same line, so all should be OK already

                stx SET_BANK_RAM                            ; switch old bank in (this code too!!!!)

                lda #<PLAYER_BLANK                          ; "erase"
                sta SELFMOD_PLAYER0_RED+RAM_WRITE+1
                lda #<PLAYER_BLANK + LINES_PER_CHAR/3
                sta SELFMOD_PLAYER0_GREEN+RAM_WRITE+1
                lda #<PLAYER_BLANK + 2*LINES_PER_CHAR/3
                sta SELFMOD_PLAYER0_BLUE+RAM_WRITE+1

    ; Now we've erased, we write the new shape

erased          ldx ManDrawY
                stx LastSpriteY
                bmi NoMod

                stx SET_BANK_RAM                            ; switch new bank in (this code too!!!!)

                lda #<PLAYER0_SHAPE                         ; draw buffer holding the new frame shape
                sta SELFMOD_PLAYER0_RED+RAM_WRITE+1
                lda #<PLAYER0_SHAPE + LINES_PER_CHAR/3
                sta SELFMOD_PLAYER0_GREEN+RAM_WRITE+1
                lda #<PLAYER0_SHAPE + 2*LINES_PER_CHAR/3
                sta SELFMOD_PLAYER0_BLUE+RAM_WRITE+1

NoMod           rts

    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE (1K)"

   ;------------------------------------------------------------------------------

; The acutal colour palette to use for the player. The player may be any "ethnicity" which refers
; to the colours for a frame. The skin could be asian/black/caucasian, the cloting could be anything.
; Each ethnicity is defined as first 8 bytes for NTSC and then 8 bytes for PAL. The 8 bytes refer
; to the "CL#" index values defined in the player COLOUR frames. So, an index is grabbed from the
; player frame, it is adjusted to add the base ethnicity and the NTSC/PAL, and that gives the base
; for reading 8 successive bytes for CL0..CL7 from the frame definitions.

EthnicityColourPalette

; CL0     = BLACK
; CL1     = HAT
; CL2     = SKIN
; CL3     = CUFFS/TRIM
; CL4     = JUMPER
; CL5     = PANTS
; CL6     = SHOES
; CL7     = UNUSED

; CL7 = NOT USABLE

; (*) = unchecked/converted

    MAC COLOUR_GROUP
    ; NTSC...
    .byte 0
    .byte {1}+{2}
    .byte {3}+{4}
    .byte {5}+{6}
    .byte {7}+{8}
    .byte {9}+{10}
    .byte {11}+{12}
    .byte 0

    ; PAL...
    .byte 0
    NTSC_TO_PAL {1}, {2}
    NTSC_TO_PAL {3}, {4}
    NTSC_TO_PAL {5}, {6}
    NTSC_TO_PAL {7}, {8}
    NTSC_TO_PAL {9}, {10}
    NTSC_TO_PAL {11}, {12}
    .byte 0
    ENDM

    ; USE NTSC COLOUR+INTENSITY. WILL AUTO-ADD PAL EQUIVALENT...
    ;               HAT     FACE    TRIM    JUMPER  PANTS  SHOES
    COLOUR_GROUP    $10,$A, $40,$8, $00,$C, $80,$8, $90,6, $10,6   ; 0
    COLOUR_GROUP    $10,$A, $F0,$8, $60,$C, $50,$4, $70,6, $40,6   ; 1
    COLOUR_GROUP    $40,$6, $E0,$8, $00,$C, $C0,$4, $90,6, $20,6   ; 2
    COLOUR_GROUP    $30,$A, $50,$8, $10,$C, $40,$4, $60,6, $E0,8   ; 3

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
    DEFINE_CHARACTER BOX_ON_TARGET2
    DEFINE_CHARACTER NOGO
    DEFINE_CHARACTER TARGET1
    DEFINE_CHARACTER TARGET3
    DEFINE_CHARACTER TARGET5
    DEFINE_CHARACTER TARGET7

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
  .byte <CHARACTERSHAPE_BOX_ON_TARGET2
  .byte <CHARACTERSHAPE_BOX_ON_TARGET2_MIRRORED
  .byte <CHARACTERSHAPE_BLANK                     ; unkillable man
  .byte <CHARACTERSHAPE_BLANK                     ; unkillable man
  .byte <CHARACTERSHAPE_TARGET1
  .byte <CHARACTERSHAPE_TARGET1_MIRRORED
  .byte <CHARACTERSHAPE_TARGET3
  .byte <CHARACTERSHAPE_TARGET3_MIRRORED
  .byte <CHARACTERSHAPE_TARGET5
  .byte <CHARACTERSHAPE_TARGET5_MIRRORED
  .byte <CHARACTERSHAPE_TARGET7
  .byte <CHARACTERSHAPE_TARGET7_MIRRORED

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
    .byte >CHARACTERSHAPE_BOX_ON_TARGET2
    .byte >CHARACTERSHAPE_BOX_ON_TARGET2_MIRRORED
    .byte >CHARACTERSHAPE_BLANK                     ; unkillable man
    .byte >CHARACTERSHAPE_BLANK                     ; unkillable man
    .byte >CHARACTERSHAPE_TARGET1
    .byte >CHARACTERSHAPE_TARGET1_MIRRORED
    .byte >CHARACTERSHAPE_TARGET3
    .byte >CHARACTERSHAPE_TARGET3_MIRRORED
    .byte >CHARACTERSHAPE_TARGET5
    .byte >CHARACTERSHAPE_TARGET5_MIRRORED
    .byte >CHARACTERSHAPE_TARGET7
    .byte >CHARACTERSHAPE_TARGET7_MIRRORED

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


    IF * - CharacterDataVecHI != CHARACTER_MAXIMUM*2
        ECHO "ERROR: Incorrect CharacterDataVecHI table!"
        ERR
    ENDIF


;     OPTIONAL_PAGEBREAK "PLAYER BLANK SHAPE", LINES_PER_CHAR

ShapePlayer         = PLAYER0_SHAPE ;BLANK
ShapePlayerBLUE     = ShapePlayer   ; low adresses patched
ShapePlayerGREEN    = ShapePlayer   ; low adresses patched
ShapePlayerRED      = ShapePlayer   ; low adresses patched

CHARACTERSHAPE_MANOCCUPIED = PLAYER_BLANK
CHARACTERSHAPE_BLANK = PLAYER_BLANK


; The following are the RAM buffers into which the player shape and colour data are copied
; The self-mod draw vectors point to this OR to a **blank** shape.

    OPTIONAL_PAGEBREAK "PLAYER_BLANK", LINES_PER_CHAR
PLAYER_BLANK
    ds LINES_PER_CHAR, 0            ; P1
    CHECKPAGEX PLAYER_BLANK, "PLAYER_BLANK in BANK_ROM_SHADOW_RAMBANK.asm"

    OPTIONAL_PAGEBREAK "PLAYER0_SHAPE", LINES_PER_CHAR
PLAYER0_SHAPE
    ds LINES_PER_CHAR,0
    CHECKPAGEX PLAYER0_SHAPE, "PLAYER0_SHAPE in BANK_ROM_SHADOW_RAMBANK.asm"

    OPTIONAL_PAGEBREAK "PLAYER0_COLOUR", LINES_PER_CHAR           ; BOTH on same page
PLAYER0_COLOUR
    ds LINES_PER_CHAR,0
    CHECKPAGEX PLAYER0_COLOUR, "PLAYER0_COLOUR in BANK_ROM_SHADOW_RAMBANK.asm"

ExistingFrame   .byte -1
LastYScroll     .byte -1
BandOffset      .byte 20
PlatformBase    .byte 0

ColourBandsGreen

; NTSC...

    ds 2,$16
    ds 2,$28
    ds 3,$36
    ds 2,$48
    ds 2,$58
    ds 3,$68
    ds 2,$7A
    ds 3,$8C
    ds 2,$9A
    ds 2,$AA
    ds 2,$B8
    ds 2,$C8
    ds 2,$D8
    ds 3,$E8
    ;ds 3,$F8

; PAL...

    ds 3,$28
    ds 2,$48
    ds 3,$68
    ds 2,$88
    ds 3,$A8
    ds 3,$C8
    ds 2,$D8
    ds 3,$B8
    ds 3,$98
    ds 2,$78
    ds 3,$58
    ds 3,$38



    DEFINE_SUBROUTINE FixColours



                ldy BoardScrollY
                cpy LastYScroll
                beq BandsNotChanged
                sty LastYScroll+RAM_WRITE

                lda Platform
                and #%10
                asl
                asl
                asl
                asl
                sta PlatformBase+RAM_WRITE

                tya
                clc
                adc BandOffset
                and #31
                ora PlatformBase
                tay

                ldx #0
LoopBankLines   lda PlatformBase
                stx SET_BANK_RAM
                sta PlatformBase+RAM_WRITE

                lda ColourBandsGreen,y
                sta SELFMOD_GREEN+RAM_WRITE+1

                iny
                tya
                and #31
                ora PlatformBase
                tay

                inx
                cpx #SCREEN_LINES
                bcc LoopBankLines

BandsNotChanged rts


    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE -- 1K"

    ; Here there's another 1K of usable ROM....
    ; Anything here is ONLY accessible if the bank is switched in as a ROM bank
    ; WE CAN'T HAVE ANYTHING REQUIRED IN THE ROM_SHADOW (IN RAM) IN THIS HALF

    CHECK_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE -- full 2K"

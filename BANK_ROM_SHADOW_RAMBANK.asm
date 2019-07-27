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
SELFMOD_PLAYERCOL_RED
                lda SpriteColourRED,y                       ; 4
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
SELFMOD_PLAYERCOL_BLUE
                lda SpriteColourBLUE,y                      ; 4
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
SELFMOD_PLAYERCOL_GREEN
                lda SpriteColourGREEN,y                     ; 4
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

    #include "playerColour.asm"    ; 1 * LINES_PER_CHAR bytes


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
    ; 7+63 = 70
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
    ; 16 + 20 + 20 + 2 + ( 7 * 32 ) - 1  + (42 SUFFIX)
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
    ; 8 + 16 + 8 + 2 + (21 * 23) -1 + (42 OVERHEAD WHEN RETURNING)
    ; = 558 --> /64 = 8.71 INTIM --> USE 10

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
    ;   = 32 + 4 + 2 + ( 7 * 38 ) - 1 + 3  + (42 SUFFIX)
    ;   = 348 --> /64 = 5.43. USE 7

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

    include "target.asm"         ; 2 * LINES_PER_CHAR + 2 bytes
    ds 30 ; todo - fixes a graphical glitch so we have a page boundary issue somewhwere


    OPTIONAL_PAGEBREAK "SCREEN_BITMAP", SCREEN_BITMAP_SIZE

ScreenBitmap    ds SCREEN_BITMAP_SIZE,$0         ; character bitmap row (10 chars wide)
ScreenBitmapRED     = ScreenBitmap + LINES_PER_CHAR/3*0
ScreenBitmapGREEN   = ScreenBitmap + LINES_PER_CHAR/3*1
ScreenBitmapBLUE    = ScreenBitmap + LINES_PER_CHAR/3*2

    CHECKPAGEX ScreenBitmap, "ScreenBitmap"

;--------------------------------------------------------------------------
;    CHARACTER_SET

    ;ECHO "TOTAL ROW-BANK CODE REQUIREMENT = ", * - BANK_START


    DEFINE_SUBROUTINE SelfModDrawPlayers ; copied to ROW RAM BANKS

    ; Now the player(s) have animated, update the appropriate shape pointers
    ; in the draw code.

    ; Sets the shapes to a blank player -- effectively erasing
                lda LastSpriteY
                ldx #<PLAYER_BLANK
                jsr SetSelfModPlayer

    ; Now we've erased, we write the new shape

;                sec
;                lda ManDrawX
;                sbc BoardScrollX
;                cmp #SCREEN_WIDTH                       ; disabled because we assume always onscreen
;                bcs NoMod                               ; skip if off visible screen

                lda ManDrawX
                cmp #SCREEN_WIDTH                       ; disabled because we assume always onscreen
                bcs NoMod                               ; skip if off visible screen

                ;lda LookingAround
                ;bne NoMod

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
                adc #LINES_PER_CHAR/3 ;boo-1
                sta SELFMOD_PLAYER0_GREEN+RAM_WRITE+1
                adc #LINES_PER_CHAR/3 ;boo-1
                sta SELFMOD_PLAYER0_BLUE+RAM_WRITE+1

NoMod
                rts

    CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE (1K)"

    include "player.asm"        ; 6 * LINES_PER_CHAR          MUST FOLLOW DIRT.ASM as data is shared
    include "filler.asm"            ; 2 * LINES_PER_CHAR bytes
   ;------------------------------------------------------------------------------

    ;ECHO "TOTAL ROW-BANK CODE REQUIREMENT = ", * - BANK_START

    ;------------------------------------------------------------------------------



;       CHECK_HALF_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE"


    ; Here there's another 1K of usable ROM....
    ; BUT!!! WE CAN'T HAVE ANYTHING REQUIRED IN THE ROM_SHADOW (IN RAM) IN THIS HALF

;-----------------------------------------------------------
; Stella 3E autodetect signature, can live anywhere
                .byte $85, $3E, $A9, $00
;-----------------------------------------------------------

           CHECK_BANK_SIZE "ROM_SHADOW_OF_RAMBANK_CODE -- full 2K"

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



TIA_BASE_ADDRESS = $40

                processor 6502
                include "vcs.h"
                include "macro.h"

                include "segtime.asm"

;FIXED_BANK             = 3 * 2048           ;-->  8K ROM tested OK
;FIXED_BANK              = 7 * 2048          ;-->  16K ROM tested OK
FIXED_BANK             = 15 * 2048           ; ->> 32K
;FIXED_BANK             = 239 * 2048         ;--> 480K ROM tested OK (KK/CC2 compatibility)
;FIXED_BANK             = 127 * 2048         ;--> 256K ROM tested OK
;FIXED_BANK             = 255 * 2048         ;--> 512K ROM tested OK (CC2 can't handle this)

YES                     = 1
NO                      = 0

DEBUG                   = NO

TJ_MODE                 = NO                ; some changes which TJ prefers
AD_MODE                 = YES                ; some changes which AD prefers

 IF TJ_MODE && AD_MODE
     ECHO "ERROR: Both TJ_MODE and AD_MODE set. Can't do both TJ and AD at the same time!"
     ERR
 ENDIF


                  ; Note: you may also need to change the emulator "-format" switch in the Makefile.


;===================================
FINAL_VERSION                   = NO           ; this OVERRIDES any selections below and sets everything correct for a final release
;===================================

;-------------------------------------------------------------------------------
; The following should be YES for the final or DEMO version
EMBED_COPYRIGHT                 SET YES         ; place embedded copyright notice in binary (hex string)

;-------------------------------------------------------------------------------
; The following are optional YES/NO depending on phase of the moon
L276                            SET YES         ; use 276 line display for NTSC
;-------------------------------------------------------------------------------

NUMPLAYERS      = 1                             ; 1-indexed
NUM_LEVELS      = 5
NUM_LIVES       SET 3                           ; use -1 for unlimited lives

;-------------------------------------------------------------------------------
; DO NOT MODIFY THE BELOW SETTINGS -- USE THE ONES ABOVE!
; Here we make sure everyting is OK based on the single switch -- less chance for accidents
 IF FINAL_VERSION = YES
L276                            SET YES         ; use 276 line display for NTSC

NUM_LIVES                       SET 3           ; use -1 for unlimited lives
 ENDIF

;-------------------------------------------------------------------------------

COMPILE_ILLEGALOPCODES          = 1
RESERVED_FOR_STACK              = 12            ; bytes guaranteed not overwritten by variable use


PUSH_LIMIT                      = 1           ; slowdown when pushing on a BOX

; time bonus countdown constants:
EXTRA_LIFE_TIMER            = 255               ; Cosmic Ark star effect on extra life. Should be 5 seconds like in original
SCORING_TIMER               =  60               ; ~1.0 second
SCORING_TIMER_FIRST         = 150               ; begin level timer is long to show level/lives clearly

DIRECTION_BITS              = %111              ; for ManLastDirection

FACE_LEFT                   = 3

MAX_THROTTLE                = 160               ; must be small enough to allow ~2 * max add value overflow (<256 - 2*max throttle value!)

;scoring flags contants:
DISPLAY_FLAGS               = %11
DISPLAY_TIME                = %00
DISPLAY_SCORE               = %01
DISPLAY_LIVES               = %10
DISPLAY_HIGH                = %11

;------------------------------------------------------------------------------

MIRRORED_BOX            = YES
MIRRORED_STEEL              = YES
MIRRORED_WALL               = YES

;------------------------------------------------------------------------------

SCREEN_WIDTH                = 10                ; board characters per line (DIFFICULT TO CHANGE)

SCREEN_LINES                = 8                 ; number of scanlines in screen buffer
LINES_PER_CHAR              = 21                ; MULTIPLE OF 3 SO RGB INTERFACES CHARS OK

SCREEN_ARRAY_SIZE           = SCREEN_WIDTH * SCREEN_LINES


SET_BANK                    = $3F               ; write address to switch ROM banks
SET_BANK_RAM                = $3E               ; write address to switch RAM banks


; color constants:
WHITE                       = $0e               ; bright white, for NTSC and PAL

YELLOW_NTSC                 = $10
YELLOW_PAL                  = $20


RAM_3E                      = $1000
RAM_SIZE                    = $400
RAM_WRITE                   = $400              ; add this to RAM address when doing writes


RND_EOR_VAL                 = $b4


; Platform constants:
PAL                 = %10
PAL_50              = PAL|0
PAL_60              = PAL|1


    IF L276
VBLANK_TIM_NTSC     = 50                        ; NTSC 276 (Desert Falcon does 280, so this should be pretty safe)
    ELSE
VBLANK_TIM_NTSC     = 50                        ; NTSC 262
    ENDIF
VBLANK_TIM_PAL      = 85 ;85                        ; PAL 312 (we could increase this too, if we want to, but I suppose the used vertical screen size would become very small then)

    IF L276
OVERSCAN_TIM_NTSC   = 60 ;24 ;51                        ; NTSC 276 (Desert Falcon does 280, so this should be pretty safe)
    ELSE
OVERSCAN_TIM_NTSC   = 8 ;51                        ; NTSC 262
    ENDIF
OVERSCAN_TIM_PAL    = 67                        ; PAL 312 (we could increase this too, if we want to, but I suppose the used vertical screen size would become very small then)

    IF L276
SCANLINES_NTSC      = 276                       ; NTSC 276 (Desert Falcon does 280, so this should be pretty safe)
    ELSE
SCANLINES_NTSC      = 262                       ; NTSC 262
    ENDIF
SCANLINES_PAL       = 312


;------------------------------------------------------------------------------
; MACRO definitions

ROM_BANK_SIZE               = $800

            MAC NEWBANK ; bank name
                SEG {1}
                ORG ORIGIN
                RORG $F000
BANK_START      SET *
{1}             SET ORIGIN / 2048
ORIGIN          SET ORIGIN + 2048
_CURRENT_BANK   SET {1}
            ENDM

            MAC DEFINE_1K_SEGMENT ; {seg name}
                ALIGN $400
SEGMENT_{1}     SET *
BANK_{1}        SET _CURRENT_BANK
            ENDM

            MAC CHECK_BANK_SIZE ; name
.TEMP = * - BANK_START
    ECHO {1}, "(2K) SIZE = ", .TEMP, ", FREE=", ROM_BANK_SIZE - .TEMP
#if ( .TEMP ) > ROM_BANK_SIZE
    ECHO "BANK OVERFLOW @ ", * - ORIGIN
    ERR
#endif
            ENDM


            MAC CHECK_HALF_BANK_SIZE ; name
    ; This macro is for checking the first 1K of ROM bank data that is to be copied to RAM.
    ; Note that these ROM banks can contain 2K, so this macro will generally go 'halfway'
.TEMP = * - BANK_START
    ECHO {1}, "(1K) SIZE = ", .TEMP, ", FREE=", ROM_BANK_SIZE/2 - .TEMP
#if ( .TEMP ) > ROM_BANK_SIZE/2
    ECHO "HALF-BANK OVERFLOW @ ", * - ORIGIN
    ERR
#endif
            ENDM


            MAC OVERLAY ; {name}
    SEG.U OVERLAY_{1}
    org Overlay
            ENDM

    ;--------------------------------------------------------------------------

    MAC VALIDATE_OVERLAY
        LIST OFF
        #if * - Overlay > OVERLAY_SIZE
            ERR
        #endif
        LIST ON
    ENDM

    ;--------------------------------------------------------------------------
    ; Macro inserts a page break if the object would overlap a page

    MAC OPTIONAL_PAGEBREAK ; { string, size }
        LIST OFF
        IF (>( * + {2} -1 )) > ( >* )
EARLY_LOCATION  SET *
            ALIGN 256
            ECHO "PAGE BREAK INSERTED FOR ", {1}
            ECHO "REQUESTED SIZE = ", {2}
            ECHO "WASTED SPACE = ", *-EARLY_LOCATION
            ECHO "PAGEBREAK LOCATION = ", *
        ENDIF
        LIST ON
    ENDM


    MAC CHECK_PAGE_CROSSING
        LIST OFF
#if ( >BLOCK_END != >BLOCK_START )
    ECHO "PAGE CROSSING @ ", BLOCK_START
#endif
        LIST ON
    ENDM

    MAC CHECKPAGE
        LIST OFF
        IF >. != >{1}
            ECHO ""
            ECHO "ERROR: different pages! (", {1}, ",", ., ")"
            ECHO ""
        ERR
        ENDIF
        LIST ON
    ENDM

    MAC CHECKPAGEX
        LIST OFF
        IF >. != >{1}
            ECHO ""
            ECHO "ERROR: different pages! (", {1}, ",", ., ") @ {0}"
            ECHO {2}
            ECHO ""
        ERR
        ENDIF
        LIST ON
    ENDM


    MAC CHECKPAGE_BNE
        LIST OFF
        IF 0;>(. + 2) != >{1}
            ECHO ""
            ECHO "ERROR: different pages! (", {1}, ",", ., ")"
            ECHO ""
            ERR
        ENDIF
        LIST ON
            bne     {1}
    ENDM

    MAC CHECKPAGE_BPL
        LIST OFF
        IF (>(.+2 )) != >{1}
            ECHO ""
            ECHO "ERROR: different pages! (", {1}, ",", ., ")"
            ECHO ""
            ERR
        ENDIF
        LIST ON
            bpl     {1}
    ENDM

  MAC ALIGN_FREE
FREE SET FREE - .
    align {1}
FREE SET FREE + .
    echo "@", ., ":", FREE
  ENDM

    MAC STRESS_TIME
      IF TEST_{1} = 1


      ;LIST OFF
; has to be put *directly* after cmp #SEGTIME_... , bcc abort
      ;LIST ON
    echo "***** WARNING! STRESS_TIME enabled @", ., "! *****"
            bne . - 7   ; branches to lda INTIM
      ENDIF
    ENDM

IDENTITY    SET 0
    MAC IDENT ; {object}
#if DEBUG=YES
        lda #IDENTITY
        sta debug_ident
        lda {1}
        sta debug_object
#endif
IDENTITY    SET IDENTITY + 1
    ENDM

    ;--------------------------------------------------------------------------

    MAC VECTOR              ; just a word pointer to code
        .word {1}
    ENDM


    MAC DEFINE_SUBROUTINE               ; name of subroutine
BANK_{1}        = _CURRENT_BANK         ; bank in which this subroutine resides
                SUBROUTINE              ; keep everything local
{1}                                     ; entry point
    ENDM



    ;--------------------------------------------------------------------------

    MAC NEWRAMBANK ; bank name
                SEG.U {1}
                ORG ORIGIN
                RORG RAM_3E
BANK_START      SET *
{1}             SET ORIGIN / RAM_SIZE
ORIGIN          SET ORIGIN + RAM_SIZE
    ENDM

    MAC VALIDATE_RAM_SIZE
        #if * - RAM_3E > RAM_SIZE
            ERR
        #endif
    ENDM

    MAC NEXT_RANDOM
; update random value:
                lda rnd                                         ; 3
                lsr                                             ; 2
        IFCONST rndHi
                ror rndHi                                       ; 5     16 bit LFSR
        ENDIF
                bcc .skipEOR                                    ; 2/3
                eor #RND_EOR_VAL                                ; 2
.skipEOR
                sta rnd                                         ; 3 = 14/19
    ENDM

    MAC RESYNC
; resync screen, X and Y == 0 afterwards
        lda #%10                        ; make sure VBLANK is ON
        sta VBLANK

        ldx #8                          ; 5 or more RESYNC_FRAMES
.loopResync
        VERTICAL_SYNC

        ldy #SCANLINES_NTSC/2 - 2
        lda Platform
        eor #PAL_50                     ; PAL-50?
        bne .ntsc
        ldy #SCANLINES_PAL/2 - 2
.ntsc
.loopWait
        sta WSYNC
        sta WSYNC
        dey
        bne .loopWait
        dex
        bne .loopResync
    ENDM

    MAC SET_PLATFORM
; 00 = NTSC
; 01 = NTSC
; 10 = PAL-50
; 11 = PAL-60
        lda SWCHB
        rol
        rol
        rol
        and #%11
        eor #PAL
         sta Platform                    ; P1 difficulty --> TV system (0=NTSC, 1=PAL)
    ENDM

;  IF TJ_MODE
;    MAC GET_RAM_BYTE_FROM_RAM ; = 29
;        ldy #{1}                        ; 2     read bank
;        ldx #{2}                        ; 2     return bank
;        jsr GetRAMByteFromRAM           ;25
;    ENDM
;
;    MAC PUT_RAM_BYTE_FROM_RAM ; = 30
;        ldy #{1}                        ; 2     write bank
;        ldx #{2}                        ; 2     return bank
;        jsr PutRAMByteFromRAM           ;26
;    ENDM
;
;    MAC GET_RAM_BYTE_FROM_RAM_ADR ; = 39
;        ldx #<{1}                       ; 2
;        stx addressR                    ; 3
;        ldx #>{1}                       ; 2
;        stx addressR+1                  ; 3
;        GET_RAM_BYTE_FROM_RAM {2}, {3}  ;29
;    ENDM
;
;    MAC PUT_RAM_BYTE_FROM_RAM_ADR ; = 40
;        ldx #<{1}                       ; 2
;        stx addressW                    ; 3
;        ldx #>({1}+RAM_WRITE)           ; 2
;        stx addressW+1                  ; 3
;        PUT_RAM_BYTE_FROM_RAM {2}, {3}  ;30
;    ENDM
;  ENDIF

    MAC NOP_B       ; unused
        .byte   $82
    ENDM

    MAC NOP_W
        .byte   $0c
    ENDM

;------------------------------------------------------------------------------


    #include "zeropage.asm"


;------------------------------------------------------------------------------
; OVERLAYS!
; These variables are overlays, and should be managed with care
; That is, variables are ALREADY DEFINED, and we're reusing RAM for other purposes

; EACH OF THESE ARE VARIABLES (TEMPORARY) USED BY ONE ROUTINE (AND IT'S SUBROUTINES)
; THAT IS, LOCAL VARIABLES.  USE 'EM FREELY, THEY COST NOTHING

; TOTAL SPACE USED BY ANY OVERLAY GROUP SHOULD BE <= SIZE OF 'Overlay'



;------------------------------------------------------------------------------
    OVERLAY BuildDrawFlags

BDF_DrawFlagAddress     ds 2                ; destination address of draw flag (mirrors ScreenBuffer)
BDF_DrawFlagAddress2    ds 2                ; dito + SCREEN_WIDTH/2
BDF_BoardAddress        ds 2                ; source address from Board
BDF_BoardAddress2       ds 2                ; dito + SCREEN_WIDTH/2
;  IF MULTI_BANK_BOARD = YES                 ; commented, else DASM freaks out because MULTI_BANK_BOARD is calculated below
BDF_BoardBank           ds 1                ; holds bank of current line
;  ENDIF
DHS_Line                ds 1
DHS_Stack               ds 1                ; for restoring SP
    ;ECHO "FREE BYTES IN OVERLAY_BuildDrawFlags = ", OVERLAY_SIZE - ( * - Overlay )
    VALIDATE_OVERLAY

;------------------------------------------------------------------------------

    OVERLAY Process

BOXLeft         ds 1
BOXRight        ds 1
restorationCharacter  ds 1

    VALIDATE_OVERLAY

;------------------------------------------------------------------------------

    OVERLAY Animate
halftimer           ds 1
    VALIDATE_OVERLAY

;------------------------------------------------------------------------------

    OVERLAY TitleScreen
colour_table           ds 2
    VALIDATE_OVERLAY

;------------------------------------------------------------------------------

                OVERLAY TimeSlice

TS_Vector           ds 2                ; vector to correct processing code
    ;ECHO "FREE BYTES IN OVERLAY_TimeSlice = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY

;------------------------------------------------------------------------------

                OVERLAY CopyROMShadowToRAM

O_CopyCount         ds 1
O_ROM_Source_Bank   ds 1
O_Index             ds 1
    ;ECHO "FREE BYTES IN OVERLAY_CopyROMShadowToRAM = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY

;------------------------------------------------------------------------------

                OVERLAY Scoring
tmpStack            ds 1
newDisplay          = tmpStack
; also for UpdateTimer
tmpSound            = tmpStack
                VALIDATE_OVERLAY


;------------------------------------------------------------------------------

                OVERLAY SaveKey

dummySK             ds 3        ; avoid getting overwritten by CopyROMShadowToRAM
highScoreSK         ds 3
startingLevel           ds 1        ; levelx * 5
startLevel          ds 1
offsetSK            ds 1        ; for calculating the SK slot address

                VALIDATE_OVERLAY

;------------------------------------------------------------------------------

                OVERLAY DrawMan

MAN_Move            ds 2

    ;ECHO "FREE BYTES IN OVERLAY_DrawMan = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY

;------------------------------------------------------------------------------

                OVERLAY ProcessObjStack

POS_Vector          ds 2

    ;ECHO "FREE BYTES IN OVERLAY_ProcessObjStack = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY

;------------------------------------------------------------------------------

                OVERLAY ScoreLineOverlay

S0              ds 2                    ; used for addressing digits of score
S1              ds 2
S2              ds 2
S3              ds 2
S4              ds 2
S5              ds 2

stkp            ds 1
sreg            ds 1
loop            ds 1

    ;ECHO "FREE BYTES IN ScoreLineOverlay = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY

;------------------------------------------------------------------------------


                OVERLAY UnpackLevelOverlay

base_x          ds 1
base_y          ds 1
upk_length      ds 1
upk_column      ds 1
upk_temp      ds 1

    ;ECHO "FREE BYTES IN UnpackLevelOverlay = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY

;------------------------------------------------------------------------------

                OVERLAY ManProcessing
actionVector        ds 2
                VALIDATE_OVERLAY

                OVERLAY SetPlatformColours
colorIdx            ds 1
                VALIDATE_OVERLAY

                OVERLAY SwapPlayers
tmpX                ds 1
                VALIDATE_OVERLAY

                OVERLAY DrawIntoStack
save_SP             ds 1
                VALIDATE_OVERLAY

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

    ; NOW THE VERY INTERESTING '3E' RAM BANKS
    ; EACH BANK HAS A READ-ADDRESS AND A WRITE-ADDRESS, WITH 2k TOTAL

ORIGIN          SET 0
                NEWRAMBANK BANK_SCREENMARKII1

    ; NOTE: THIS BANK JUST *LOOKS* EMPTY.
    ; It actually contains everything copied from the ROM copy of the ROW RAM banks.
    ; The variable definitions are also in that ROM bank (even though they're RAM :)

SCREEN_BITMAP_SIZE      = 4 * LINES_PER_CHAR

    ; These banks (there are #SCREEN_LINES of them) hold a RAM copy of the screen draw
    ; code.  This code is self-modifying, in that the colour values for each scanline
    ; are set to NTSC or PAL values on startup -- thus, the single binary can run
    ; on either format system.  The main purpose for copying the draw code to RAM,
    ; though, is to free up space in the fixed bank (which is incredibly valuable).

    ; A neat feature of having multiple copies of the same code in different RAM banks
    ; is that we can use that code to switch between banks, and the system will happily
    ; execute the next instruction from the newly switched-in bank without a problem.

    ; Now we have the actual graphics data for each of the rows.  This consists of an
    ; actual bitmap (in exact PF-style format, 6 bytes per line) into which the
    ; character shapes are masked/copied. The depth of the character shapes may be
    ; changed by changing the #LINES_PER_CHAR value.  Note that this depth should be
    ; a multiple of 3, so that the RGB scanlines match at character joins.

    ; The next part of the graphics data is a bitmap sprite buffer -- space for two
    ; sprites' graphics shape and colour data.  The shape and colour may be set as
    ; part of the draw routine *every* scanline (though the system currently uses
    ; one colour shared between both players).

                VALIDATE_RAM_SIZE

    ; We have one bank for each screen row.  These banks are duplicates of the above,
    ; accessed via the above labels but with the appropriate bank switched in.

    ;------------------------------------------------------------------------------

    REPEAT SCREEN_LINES - 1
        NEWRAMBANK .DUMMY
        VALIDATE_RAM_SIZE
    REPEND

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

                NEWRAMBANK BANK_DRAW_BUFFERS
; VARS DEFINED IN ROM_SHADOW_OF_BANK_DRAW_BUFFERS
; SELF-MODIFYING SUBROUTINES MAY BE PRESENT IN THIS BANK TOO!
                VALIDATE_RAM_SIZE

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

                NEWRAMBANK BANK_SCORING
; VARS DEFINED IN ROM_SHADOW_OF_BANK_SCORING
; SELF-MODIFYING SUBROUTINES MAY BE PRESENT IN THIS BANK TOO!
                VALIDATE_RAM_SIZE

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

                NEWRAMBANK BANK_DECODE_LEVEL
; VARS DEFINED IN BANK_DECODE_LEVEL_SHADOW
; SELF-MODIFYING SUBROUTINES MAY BE PRESENT IN THIS BANK TOO!
                VALIDATE_RAM_SIZE

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

                NEWRAMBANK BANK_OBJSTACK

    ; The objects are a list of X,Y positions into the BOARD.  Each of these is a board
    ; position of something that needs to be processed.  These things include anything
    ; that animates.  Objects which no longer need processing do not re-add themselves
    ; to the object stack.  There are two stacks -- the one being processed, and the
    ; one for the next processing iteration.

    ; Note: These are referenced by ObjStackNum, as is the BLANK_STACK paired bank set.

OBJ_STACK_SIZE  = 128

    ; WARNING: THESE MUST NOT CROSS PAGE BOUNDARIES!!!

ObjStackX       ds OBJ_STACK_SIZE
ObjStackY       ds OBJ_STACK_SIZE
ObjStackVar     ds OBJ_STACK_SIZE       ; for general use

; SortedObjPtr is now in the middle of a page, thus allowing to address with -1
SortedObjPtr    ds OBJ_STACK_SIZE                               ; list of indexes of objects (sorted)

ObjStackType    ds OBJ_STACK_SIZE       ; type of object

    ECHO "FREE RAM IN BANK_OBJSTACK = ", RAM_SIZE - ( * - BANK_START )

                VALIDATE_RAM_SIZE

    ;------------------------------------------------------------------------------

                NEWRAMBANK BANK_OBJSTACK2
    ; THIS IS A MIRROR OF BANK_OBJSTACK -- DO NOT MODIFY OR USE!!
                VALIDATE_RAM_SIZE

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

                NEWRAMBANK BANK_BOARD

    ; Now the interesting 'BOARD' -- which in reality is a free-form system of M*N
    ; rows and columns.  We need to reserve enough RAM for the board's entirety, but
    ; don't really care much how it overlaps the 1K bank limit.  The code accessing
    ; the board *MUST* calculate and take account of the correct RAM bank to switch
    ; when accessing.

    ; The system is fairly free-form, in that it rearranges the memory and tables
    ; automatically based on the sizes set in these constants. The board may overlay
    ; MULTIPLE banks -- just as long as any particular LINE does not cross a bank
    ; we're doing OK.

    ; NOTE: Assumption is that board lines CANNOT CROSS page boundaries.

; now fits into one single bank (if we don't reserve too much space for code)

SIZE_BOARD_X    = 40
SIZE_BOARD_Y    = 22
#if 0
; have to precalculate it here, else DASM freaks out:
.BOARD_SIZE SET 0
.BOARD_LOCATION SET 0
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_SIZE SET .BOARD_SIZE - .BOARD_LOCATION
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
.BOARD_SIZE SET .BOARD_SIZE + .BOARD_LOCATION
              ENDIF
.BOARD_SIZE SET .BOARD_SIZE + SIZE_BOARD_X
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X
            REPEND

SIZE_BOARD      = .BOARD_SIZE
#endif
  IF SIZE_BOARD > RAM_SIZE
MULTI_BANK_BOARD = YES
  ELSE
MULTI_BANK_BOARD = NO                       ; timings: [-..]
  ENDIF

Board           ds SIZE_BOARD               ; Note, we can only access this in
                                            ; 1024 byte chunks, switching RAM
                                            ; banks as we go.  In other words,
                                            ; this overlaps multiple banks!

    NEWRAMBANK BANK_TAKEBACK
TakeBackX    ds 256
TakeBackY    ds 256
TakeBackA    ds 256

    ; free space here (but hard to use)
    ; So we need to calculate where the next free bank is!
    ; TODO: This looks dodgy.  Check..

ORIGIN          SET ( * + RAM_SIZE - 1 ) / RAM_SIZE
ORIGIN          SET ORIGIN * RAM_SIZE



    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

;------------------------------------------------------------------------------

;    IFNCONST MAX_LEVEL_SIZE
MAX_LEVEL_SIZE SET 0
;    ENDIF

    MAC START_LEVEL ; {name}
LEVEL_START  SET *
BANK_LEVEL_{1} = _CURRENT_BANK
LEVEL_{1}    SUBROUTINE
MAX_LEVEL_NUMBER SET MAX_LEVEL_NUMBER + 1
; ECHO "current MAX_LEVEL_NUMBER = ", MAX_LEVEL_NUMBER
    ENDM


    MAC END_LEVEL ; {name}
                .byte 0
LEVEL_SIZE_{1}  = * - LEVEL_START
    IF LEVEL_SIZE_{1} > MAX_LEVEL_SIZE
MAX_LEVEL_SIZE SET LEVEL_SIZE_{1}
    ENDIF
    ENDM


    MAC DEFL
      START_LEVEL {1}
      .byte {2},0
      END_LEVEL {1}
    ENDM

;--------------------------------------------------------------------------------

ORIGIN      SET $00000

            include "BANK_ROM_SHADOW_RAMBANK.asm"
            include "BANK_ROM_SHADOW_DRAWBUFFERS.asm"
            include "BANK_ROM_SHADOW_SCORING.asm"
            include "BANK_GENERIC.asm"
            include "BANK_LEVELS1.asm"
            include "BANK_LEVELS2.asm"
            include "BANK_LEVELS3.asm"
            include "BANK_LEVELS4.asm"
            include "BANK_LEVELS5.asm"
            include "BANK_LEVELS6.asm"
            include "titleScreen.asm"
            include "BANK_INITBANK.asm"         ; MUST be after banks that include levels -- otherwise MAX_LEVELBANK is not calculated properly
            include "BANK_FIXED.asm"

            END

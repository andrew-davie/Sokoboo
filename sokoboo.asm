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

ORIGIN          SET 0
ORIGIN_RAM      SET 0

                include "segtime.asm"

;FIXED_BANK             = 3 * 2048           ;-->  8K ROM tested OK
;FIXED_BANK              = 7 * 2048          ;-->  16K ROM tested OK
FIXED_BANK             = 15 * 2048           ; ->> 32K
;FIXED_BANK             = 31 * 2048           ; ->> 64K
;FIXED_BANK             = 239 * 2048         ;--> 480K ROM tested OK (KK/CC2 compatibility)
;FIXED_BANK             = 127 * 2048         ;--> 256K ROM tested OK
;FIXED_BANK             = 255 * 2048         ;--> 512K ROM tested OK (CC2 can't handle this)

YES                     = 1
NO                      = 0

;===================================
FINAL_VERSION                   = NO           ; this OVERRIDES any selections below and sets everything correct for a final release
;===================================

;-------------------------------------------------------------------------------
; The following are optional YES/NO depending on phase of the moon
L276                            SET YES         ; use 276 line display for NTSC
;-------------------------------------------------------------------------------
; DO NOT MODIFY THE BELOW SETTINGS -- USE THE ONES ABOVE!
; Here we make sure everyting is OK based on the single switch -- less chance for accidents
 IF FINAL_VERSION = YES
L276                            SET YES         ; use 276 line display for NTSC
 ENDIF

;-------------------------------------------------------------------------------

COMPILE_ILLEGALOPCODES          = 1
RESERVED_FOR_STACK              = 12            ; bytes guaranteed not overwritten by variable use

PALETTE_INTENSITY_ADJUST        = 2
PUSH_LIMIT                      = 6           ; slowdown when pushing on a BOX

; time bonus countdown constants:
EXTRA_LIFE_TIMER            = 255               ; Cosmic Ark star effect on extra life. Should be 5 seconds like in original
SCORING_TIMER               =  60               ; ~1.0 second
SCORING_TIMER_FIRST         = 150               ; begin level timer is long to show level/lives clearly

DIRECTION_BITS              = %111              ; for ManLastDirection

MAX_THROTTLE                = 160               ; must be small enough to allow ~2 * max add value overflow (<256 - 2*max throttle value!)

;scoring flags contants:
DISPLAY_FLAGS               = %11
DISPLAY_TIME                = %00
DISPLAY_SCORE               = %01
DISPLAY_LIVES               = %10
DISPLAY_HIGH                = %11

;------------------------------------------------------------------------------

DIGITS = NO
WAIT_FOR_INITIAL_DRAW = YES             ; blank until all initial tiles drawn

;------------------------------------------------------------------------------

SCREEN_WIDTH                = 10                ; board characters per line (DIFFICULT TO CHANGE)

SCREEN_LINES                = 8                 ; number of scanlines in screen buffer
LINES_PER_CHAR              = 24                ; MULTIPLE OF 3 SO RGB INTERFACES CHARS OK

SCREEN_ARRAY_SIZE           = SCREEN_WIDTH * SCREEN_LINES


SET_BANK                    = $3F               ; write address to switch ROM banks
SET_BANK_RAM                = $3E               ; write address to switch RAM banks


; color constants:
WHITE                       = $0e               ; bright white, for NTSC and PAL

RAM_3E                      = $1000
RAM_SIZE                    = $400
RAM_WRITE                   = $400              ; add this to RAM address when doing writes

RND_EOR_VAL                 = $b4


; Platform constants:
PAL                 = %10
PAL_50              = PAL|0
PAL_60              = PAL|1


    IF L276
VBLANK_TIM_NTSC     = 48                        ; NTSC 276 (Desert Falcon does 280, so this should be pretty safe)
    ELSE
VBLANK_TIM_NTSC     = 50                        ; NTSC 262
    ENDIF
VBLANK_TIM_PAL      = 85 ;85                        ; PAL 312 (we could increase this too, if we want to, but I suppose the used vertical screen size would become very small then)

    IF L276
OVERSCAN_TIM_NTSC   = 35 ;24 ;51                        ; NTSC 276 (Desert Falcon does 280, so this should be pretty safe)
    ELSE
OVERSCAN_TIM_NTSC   = 8 ;51                        ; NTSC 262
    ENDIF
OVERSCAN_TIM_PAL    = 41                        ; PAL 312 (we could increase this too, if we want to, but I suppose the used vertical screen size would become very small then)

    IF L276
SCANLINES_NTSC      = 276                       ; NTSC 276 (Desert Falcon does 280, so this should be pretty safe)
    ELSE
SCANLINES_NTSC      = 262                       ; NTSC 262
    ENDIF
SCANLINES_PAL       = 312


;------------------------------------------------------------------------------
; MACRO definitions

    include "macro2.h"

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
            ECHO "Overlay ", {1}, "too big"
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
                ORG ORIGIN_RAM
                RORG RAM_3E
BANK_START      SET *
{1}             SET ORIGIN_RAM / RAM_SIZE
ORIGIN_RAM      SET ORIGIN_RAM + RAM_SIZE
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

    MAC LOAD_ANIMATION
                lda #<Animation_{1}
                sta animation
                lda #>Animation_{1}
                sta animation+1
                lda #0
                sta animation_delay
                lda #ANIMATION_{1}_ID
                sta ManAnimationID
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
    OVERLAY GenerateHighScoreCode

decimal         ds 12                   ; MUST be 1st - same var as codeDigit
binMoves        ds 2
encoding         ds 5
randomiser      ds 1

    VALIDATE_OVERLAY "GenerateHighScoreCode"

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
    VALIDATE_OVERLAY "BuildDrawFlags"

;------------------------------------------------------------------------------

    OVERLAY ColourFixer

PlatformBase            ds 1
BandOffsetTemp          ds 1

    VALIDATE_OVERLAY "ColourFixer"

    OVERLAY LevelLookup
levelTable              ds 2
    VALIDATE_OVERLAY "LevelLookup"

;------------------------------------------------------------------------------

    OVERLAY Animator
frame_ptr       ds 2
colour_ptr      ds 2
bank            ds 1
ethnicity       ds 1
    VALIDATE_OVERLAY "Animator"


    OVERLAY Process

BOXLeft         ds 1
BOXRight        ds 1
restorationCharacter  ds 1

    VALIDATE_OVERLAY "Process"

;------------------------------------------------------------------------------


    OVERLAY Animate
halftimer           ds 1
    VALIDATE_OVERLAY "Animate"

;------------------------------------------------------------------------------

    OVERLAY TitleScreen
colour_table           ds 2
digit1                  ds 2
digit2                  ds 2
digitstar               ds 2
digit                   ds 3
digitick                ds 1
targetDigit             ds 3
endwait                 ds 1
;colourindex             ds 1
digitHundreds           ds 2
selector                ds 1
walkSpeed               ds 1
manc                    ds 2
wallColour              ds 1
adjustColour            ds 1
    VALIDATE_OVERLAY "TitleScreen"



    OVERLAY CodeScreen
codeDigit       ds 12               ; MUST be 1st - same var as decimal
bigdigit0       ds 2
bigdigit1       ds 2
bigdigit2       ds 2
bigdigit3       ds 2
codeTemp        ds 1
codeDelay       ds 2
    VALIDATE_OVERLAY "CodeScreen"


;------------------------------------------------------------------------------

                OVERLAY TimeSlice

TS_Vector           ds 2                ; vector to correct processing code
    ;ECHO "FREE BYTES IN OVERLAY_TimeSlice = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY "TimeSlice"

;------------------------------------------------------------------------------

                OVERLAY CopyROMShadowToRAM

O_CopyCount         ds 1
O_ROM_Source_Bank   ds 1
O_Index             ds 1
    ;ECHO "FREE BYTES IN OVERLAY_CopyROMShadowToRAM = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY "CopyROMShadowToRAM"

;------------------------------------------------------------------------------

                OVERLAY Scoring
tmpStack            ds 1
newDisplay          = tmpStack
; also for UpdateTimer
tmpSound            = tmpStack
                VALIDATE_OVERLAY "Scoring"


;------------------------------------------------------------------------------

                OVERLAY SaveKey

dummySK             ds 3        ; avoid getting overwritten by CopyROMShadowToRAM
highScoreSK         ds 3
startingLevel           ds 1        ; levelx * 5
startLevel          ds 1
offsetSK            ds 1        ; for calculating the SK slot address

                VALIDATE_OVERLAY "SaveKey"

;------------------------------------------------------------------------------

                OVERLAY DrawMan

MAN_Move            ds 2

    ;ECHO "FREE BYTES IN OVERLAY_DrawMan = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY "DrawMan"

;------------------------------------------------------------------------------

                OVERLAY ProcessObjStack

POS_Vector          ds 2

    ;ECHO "FREE BYTES IN OVERLAY_ProcessObjStack = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY "ProcessObjStack"

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
                VALIDATE_OVERLAY "ScoreLineOverlay"

;------------------------------------------------------------------------------


                OVERLAY UnpackLevelOverlay

base_x                  ds 1
base_y                  ds 1
upk_length              ds 1
upk_column              ds 1
upk_temp                ds 1
;icc_colour              ds 3

    ;ECHO "FREE BYTES IN UnpackLevelOverlay = ", OVERLAY_SIZE - ( * - Overlay )
                VALIDATE_OVERLAY "UnpackLevelOverlay"

;------------------------------------------------------------------------------

                OVERLAY ManProcessing
actionVector        ds 2
                VALIDATE_OVERLAY "ManProcessing"

                OVERLAY DrawIntoStack
save_SP             ds 1
                VALIDATE_OVERLAY "DrawIntoStack"

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

    ; NOW THE VERY INTERESTING '3E' RAM BANKS
    ; EACH BANK HAS A READ-ADDRESS AND A WRITE-ADDRESS, WITH 2k TOTAL

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

SIZE_BOARD_X    = 32 ;
SIZE_BOARD_Y    = 32

    IF SIZE_BOARD_X * SIZE_BOARD_Y > RAM_SIZE
        ECHO "ERROR: Board too big for single bank usage"
        ERR
    ENDIF



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

TAKEBACK_MASK       = $3F

TakeBackPreviousX   ds $40
TakeBackPreviousY   ds $40
TakeBackPushX       ds $40
TakeBackPushY       ds $40
TakeBackPushChar    ds $40

    ; reverting...
    ; A prevoius position
    ;           POS_VAR = board
    ;           board = MANOCCUPIED
    ;           manx,y = x,y
    ; B current position (MANX,Y)
    ;           board = POS_VAR
    ; C push position
    ;           BOARD = PREV_BOARD
    ; TAKEBACK_PREV_X, TAKEBACK_PREV_Y, TAKEBACK_PUSH_X,PUSH_Y,TAKEBACK_PUSH_PREV
    ;


    ; free space here (but hard to use)
    ; So we need to calculate where the next free bank is!
    ; TODO: This looks dodgy.  Check..

;ORIGIN          SET ( * + RAM_SIZE - 1 ) / RAM_SIZE
;ORIGIN          SET ORIGIN * RAM_SIZE



    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

;------------------------------------------------------------------------------

;    IFNCONST MAX_LEVEL_SIZE
MAX_LEVEL_SIZE SET 0
;    ENDIF


MAX_LEVEL_NUMBER SET 0
    MAC START_LEVEL ; {name}
LEVEL_START  SET *
BANK_LEVEL_{1} = _CURRENT_BANK
LEVEL_{1}    SUBROUTINE
MAX_LEVEL_NUMBER SET MAX_LEVEL_NUMBER + 1
; ECHO "current MAX_LEVEL_NUMBER = ", MAX_LEVEL_NUMBER
    ENDM


    MAC END_LEVEL ; {name}
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

;ORIGIN      SET 0

            include "BANK_ROM_SHADOW_RAMBANK.asm"
            include "BANK_ROM_SHADOW_DRAWBUFFERS.asm"
            include "BANK_ROM_SHADOW_SCORING.asm"
            include "BANK_GENERIC.asm"
            include "BANK_LEVELS_TABLES.asm"
            include "BANK_LEVELS1.asm"
            include "BANK_LEVELS2.asm"
            include "BANK_LEVELS3.asm"
            include "BANK_LEVELS4.asm"
            include "BANK_LEVELS5.asm"
;            include "BANK_LEVELS6.asm"
;            include "BANK_LEVELS7.asm"
;            include "BANK_LEVELS8.asm"
;            include "BANK_LEVELS9.asm"
;            include "BANK_LEVELS10.asm"
;            include "BANK_LEVELS11.asm"
;            include "BANK_LEVELS12.asm"
;            include "BANK_LEVELS13.asm"
;            include "BANK_LEVELS14.asm"
;            include "BANK_LEVELS15.asm"
;            include "BANK_LEVELS16.asm"
;            include "BANK_LEVELS17.asm"
            include "BANK_PlayerFrames.asm"
            include "titleScreen.asm"
            include "levelScreen.asm"
            include "coder.asm"
            include "BANK_INITBANK.asm"         ; MUST be after banks that include levels -- otherwise MAX_LEVELBANK is not calculated properly

    ; MUST BE LAST...
            include "BANK_FIXED.asm"

            ;END


                SEG.U variables
                ORG $80


GAMEMODE_2600                   = 64
GAMEMODE_PAUSED                 = 128

gameMode                        ds 1        ; bit7=0: 7800; bit7=1: 2600.  bit 6=1: paused: bit3: toggle bit for B/W
Platform                        ds 1        ; TV system (%0x=NTSC, %10=PAL-50, %11=PAL-60)
; above variables are preserved ALL the time!

rnd                             ds 1
rndHi                           ds 1        ; to get better random values

DrawStackPointer                ds 1        ; points to start entry of drawing stack (-1 = nothing to draw)
ObjStackNum                     ds 1        ; which stack in use
ObjStackPtr                     ds 2        ; index to objects on object stack (0 = empty)
BlankStackPtr                   ds 1        ; index to blank object stack (0=empty)
ScreenDrawPhase                 ds 1        ; phase of screen drawing

POS_X                           ds 1
POS_Y                           ds 1
POS_X_NEW                       ds 1
POS_Y_NEW                       ds 1
POS_Type                        ds 1
POS_VAR                         ds 1

BufferedJoystick                ds 2        ; player joystick input
BufferedButton                  ds 2        ; player button press

    ; Scrolling is limited to only show board within the following area...
BoardLimit_Width                ds 1        ; width of current playfield (only used in UnpackLevel)
BoardLimit_Height               ds 1        ; height of current playfield (only used in UnpackLevel)
BoardScrollY                    ds 1        ; scroll position in board (Y)
BoardScrollX                    ds 1        ; scroll position in board (X)
BoardEdge_Right                 = BoardLimit_Width  ; absolute rightmost scroll value
BoardEdge_Bottom                = BoardLimit_Height ; absolute bottommost scroll value
scrollBits                      ds 1

;MagicAmoebaFlag                 ds 1        ; status of magic wall and amoeba

whichPlayer                     ds 1        ; 0 = P1, 1 = P2
manAnimationIndex               ds 1
ManX                            ds 1
ManY                            ds 1
ManDrawX                        ds 1
ManDrawY                        ds 1
ManMode                         ds 1
ManDelayCount                   ds 1
ManAnimation                    ds 2
ManAnimationFrameLO             ds 1
ManLastDirection                ds 1            ; so we don't overwrite animations in-progress
ManPushCounter                  ds 1
LookingAround                   ds 1
ManCount                      ds 1            ; player life counter
jtoggle                         ds 1            ; 0/1 toggles joystick on player swapping
circle_d                        ds 2
circ_x                 ds 1
circ_y                  ds 1
circ_char             ds 1
circ_scratch          ds 1
cave_bank         ds 1
;---------------------------------------------------------------------------
; 2 (shared) demo mode variables:
demoMode                        = jtoggle       ; bit 7==1 => demo mode
moveLen                         = jtoggle       ; bits 0..6
moveIdx                         = whichPlayer

LastSpriteY                     ds 1

timer                           ds 1

BGColour                        ds 1

; cave and level have to be consecutive variables!
cave                            ds 1            ; current player's cave (other in scoring bank)
level                           ds 1            ; current player's level (other in scoring bank)
levelDisplay                     ds 1            ; what to display as the cave ID
Throttle                        ds 1            ; frame throttle to prevent super-speeds
ThrottleSpeed                   ds 1            ; system-dependant throttle speed

targetsRequired                  ds 1           ; number of un-targeted left to go
moveCounter                        ds 1            ; BCD seconds for level
moveCounterHi                      ds 1
color                           ds 3            ; RGB for NTSC, RGB for PAL
Board_AddressR                  ds 2
Board_AddressW                  ds 2
ROM_Bank                        ds 1            ; last switched ROM bank (not accessible if RAM subsequently switched)
RAM_Bank                        ds 1

ColourTimer                     ds 1            ; colour of BG in scoring area to show level flash/complete
extraLifeTimer                  ds 1            ; should be 5 seconds!

    ; extraLifeTimer:
    ;   When non-zero causes Cosmic Ark star effect in background. Used to indicate extra life.

scoringTimer                    ds 1            ; times the various score displays
scoringFlags                    ds 1            ; scoring flags are stored here

    ; scoringFlags:
    ; D7            Extra diamonds in effect (diamonds collected over requirement score more) ASSUMED BPL/BMI usage
    ; D6            unused
    ; D5            unused
    ; D4            unused
    ; D3            unused
    ; D2            unused
    ; D1    D1-D0   Which display kernel to use for scoring
    ; D0            0 = 2x4     used for diamonds/time
    ;               1 = 1x6     used for score
    ;               2 = 3x2     used for level/lives/player

NextLevelTrigger                ds 1            ; d7 -- next level.  d6 -- loss of life
BIT_NEXTLEVEL                   = 128
BIT_NEXTLIFE                    = 64
BIT_GOTOLOGO                    = 1

;amoebaX                         ds 1        ; x-pos of currently scanned cell
;amoebaY                         ds 1        ; y-pos of currently scanned cell
;amoebaFlag                      ds 1        ; current status of amoeba

    ; constants for amoebaFlag:
NOT_ENCLOSED                    = %00000001 ;
SCAN_FINISHED                   = %00000010 ; indicates that one scan finished and the next one has to wait
FINISHEDDIAMOND                 = %00100000 ;
AMOEBA_PRESENT                  = %01000000 ; set during the very first amoeba object init
TODIAMOND                       = %10000000 ;

;---------------------------------------------------------------------------

sortRequired                    ds 1
sortPtr                         ds 1

;---------------------------------------------------------------------------
; sound driver needs 6 bytes:
soundIdxLst                     ds 2            ; index of current sound
decayIdxLst                     ds 2            ; index of current note
decayTimeLst                    ds 2            ; remaining lenght of current note
soundBonusPts                   = decayIdxLst   ; shared, used for bonus points count down (channel 0!)
newSounds                       ds 1

;------------------------------------------------------------------------------

ObjIterator                     ds 1            ; count UP iterator over objects
DSL                             ds 1            ; stack line counter

 #include "sound/intro1_variables.asm"



OVERLAY_SIZE    SET 16



        ; This overlay variable is used for the overlay variables.  That's OK.
        ; However, it is positioned at the END of the variables so, if on the off chance we're overlapping
        ; stack space and variable, it is LIKELY that that won't be a problem, as the temp variables
        ; (especially the latter ones) are only used in rare occasions.

        ; FOR SAFETY, DO NOT USE THIS AREA DIRECTLY (ie: NEVER reference 'Overlay' in the code)
        ; ADD AN OVERLAY FOR EACH ROUTINE'S USE, SO CLASHES CAN BE EASILY CHECKED

Overlay         ds OVERLAY_SIZE       ;--> overlay (share) variables
                VALIDATE_OVERLAY


                ds RESERVED_FOR_STACK

    ECHO "FREE BYTES IN ZERO PAGE = ", $FF - *
    IF * > $FF
        ERR
    ENDIF

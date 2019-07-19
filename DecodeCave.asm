;TODOs:
;+ load cave from ROM
;- remove delimiter
;+ variable board sizes
;- use Andrew's character ids
;+ store other cave parameter (times, diamonds, points etc.)

    ;---------------------------------------------------------------------------
    ; Board area must not overlap page boundary, as writing code uses indexing to save

    OPTIONAL_PAGEBREAK "BOARD_DATA_AREA", MAX_CAVE_SIZE
BOARD_DATA_AREA
    ds MAX_CAVE_SIZE,$FF

    ;---------------------------------------------------------------------------

;ThrottleSpeedTbl
;; based on MAX_THROTTLE = 160, NTSC_276/PAL (312/276=1.13)
;    .byte   19, 22  ; level 1 (E1: 5.60s) 1,16; 1.00/1.00 (1.00)
;    .byte   22, 26  ; level 2 (E2  4.80s) 1,18  1.16/1.18 (1.17)
;    .byte   24, 28  ; level 3 (E3: 4.40s) 1,16  1.26/1.27 (1.27)
;    .byte   26, 30  ; level 4 (E4: 4.17s) 1,15  1.37/1.36 (1.34)
;    .byte   27, 31  ; level 5 (E5: 4.00s) 1,14; 1.42/1.41 (1.40)

    DEFINE_SUBROUTINE UnpackLevel

; *** local constants for cava data: ***

.NUM_RANDOM         = 4                 ; number of random objects

.SIZE_OFS           =  1                ; -1
.MAGIC_OFS          =  3
.WORTH_OFS          =  4
.EXTRA_WORTH_OFS    =  5
.DIAMONDS_OFS       = 11
.TIME_OFS           = 16
.RND_INIT_OFS       = $04+2             ; -1
.RND_OBJECT_OFS     = $18+3             ; -3
.RND_VALUE_OFS      = $1c+3             ; -3
.COLOR_OFS          = $13+2

.STRUCT_OFFSET      = $20+3             ; -3
.STRUCT_DELIMITER   = $ff
.STRUCTURE_MASK     = %11000000

.STRUCT_SINGLE      = %00 << 6
;.STRUCT_LINE        = LINE
;.STRUCT_FILLED      = FILL
;.STRUCT_RECTANGLE   = RECT
.STRUCT_LINE        = %01 << 6
.STRUCT_FILLED      = %10 << 6
.STRUCT_RECTANGLE   = %11 << 6
;POINT               = .STRUCT_POINT
FILL                = .STRUCT_FILLED
LINE                = .STRUCT_LINE
RECT                = .STRUCT_RECTANGLE

.DIR_UP             = 0
.DIR_RIGHT          = 2
.DIR_DOWN           = 4
.DIR_LEFT           = 6


                sta RAM_Bank

    ; Setup for NTSC/PAL based on P1 difficulty (0=NTSC, 1=PAL)
    ; Set the throttle speed based on system.

             DEFINE_SUBROUTINE PlatformSelect

    ; has to be done before decoding the cave to have the platform right:
                SET_PLATFORM


    ;------------------------------------------------------------------------------
    ; Copy the ROM cave data into our local RAM cave data buffer.  Note that the
    ; system is automatically setup so that the biggest cave will cause the available
    ; buffer to increase during compile time.  So all we really need to do here is
    ; copy the appropriate amount of data for the cave from ROM elsewhere, and then
    ; let the system run just as it was before.

    ; Note that cave is an index to 4-byte entry table, so please use CAVE_NAMED_*
    ; for cave reference numbers.

;                sta RAM_Bank

                lda NextLevelTrigger
                ora #BIT_NEXTLEVEL
                sta NextLevelTrigger



                lda #BANK_UnpackLevel                ; the *ROM* bank of this routine (NOT RAM)
                sta ROM_Bank                        ; GetROMByte returns to this bank

                ldy cave
                lda CaveInformation,y
                sta Board_AddressR
                lda CaveInformation+1,y
                sta Board_AddressR+1                ; source of the board data (bank handled later)

                lda CaveInformation+3,y             ; size of the board data in bytes
                sta SMLimit+RAM_WRITE+1             ; might as well use self-modifying

                lda CaveInformation+4,y
                sta levelDisplay                     ; what to display as the cave ID.

                ldx #0
                stx caveTimeFrac                    ; now the 1st second is fully available
                stx amoebaFlag
CopyBoardData   stx savex

    ; We are using GetROMByte to get *any* byte from ROM (although it was designed
    ; just to get a board-character).  Should be OK.

                ldy cave
                lda CaveInformation+2,y             ; bank of the board data
                ldy #0
                jsr GetROMByte                      ; note, this returns to ROM -- but that's a copy of us!!
                ldy RAM_Bank                        ; RAM bank we are *actually* running from
                sty SET_BANK_RAM                    ; and switch 'ourself' back in.  Sneaky.

                ldx savex
                sta BOARD_DATA_AREA + RAM_WRITE,x   ; save byte from ROM into our local RAM buffer

                inc Board_AddressR
                bne NoPage
                inc Board_AddressR+1                ; point to next byte of data
NoPage

                inx
SMLimit         cpx #0                              ; byte count (self) modified by board size
                bne CopyBoardData


    ;------------------------------------------------------------------------------


                lda     #<BOARD_DATA_AREA
                sta     ptrCave
                lda     #>BOARD_DATA_AREA
                sta     ptrCave+1

; colors are organised in 3 NTSC/PAL pairs (medium mixcolor, dark color, bright mixcolor)
                lda     Platform
                cmp     #PAL
                ldy     #.COLOR_OFS+5
                bcs     .originalPlatform
                dey
.originalPlatform:
                ldx     #3-1
.copyCols:
                lda     (ptrCave),y
                sta     color,x
                dey
                dey
                dex
                bpl     .copyCols

                ldy     #.SIZE_OFS
                lda     (ptrCave),y
                sta     BoardLimit_Width
                sta     BoundingWall+RAM_WRITE+3
                iny
                lda     (ptrCave),y
                sta     BoardLimit_Height
                sta     BoundingWall+RAM_WRITE+4

;*** 1. load some cave data ***
                iny                             ;           Y == 3 == .MAGIC_OFS
                lda     (ptrCave),y
                sta     magicAmoebaTime

                iny                             ;           Y == 4 == .WORTH_OFS
                lda     (ptrCave),y
                ;jsr     Convert2BCD
                sta     diamondsWorth                           ; now BCD in cave data

                ldy     #.EXTRA_WORTH_OFS
                lda     (ptrCave),y
                ;jsr     Convert2BCD
                sta     diamondsExtraWorth                      ; now BCD in cave data

                lda     #.TIME_OFS
                jsr     GetLevelDataBCD
                sta     caveTime
                stx     caveTimeHi

                lda     #.DIAMONDS_OFS
                jsr     GetLevelDataBCD
                sta     diamondsNeeded              ;       should never be 0

; *** 2. create random objects ***
; set initial random seed for level:
                lda     #0
                sta     randSeed1
                lda     #.RND_INIT_OFS
                jsr     GetLevelData
                sta     randSeed2

; setup pointers:
                lda     #.RND_VALUE_OFS
                ldx     #2
                jsr     AddPointer                  ;       set ptrCave+2 to random values
                lda     #.RND_OBJECT_OFS
                jsr     AddPointer0                 ;       set ptrCave+0 to random objects

; loop the board:
                ldy     #1
.loopRows:
                sty     POS_Y
                ldx     #0
.loopColumns:
                stx     POS_X
; get random object type:
                jsr     NextRandom                  ;       a = randSeed1
                ldy     #.NUM_RANDOM-1
.loopRandom:
                cmp     (ptrCave+2),y
                bcc     .exitRandom
                dey
                bpl     .loopRandom
                lda     #CHARACTER_SOIL             ;       default character (dirt), = 0
                NOP_W
.exitRandom:
  lda     #CHARACTER_SOIL             ;       default character (dirt), = 0
;                lda     (ptrCave),y
                sta     POS_Type

; put new object on board:
                jsr     PutBoardCharacterFromRAM
; goto next board cell:
                ldx     POS_X
                inx
                cpx     BoardLimit_Width
                bcc     .loopColumns
                ldy     POS_Y
                iny
                cpy     BoardLimit_Height
                bcc     .loopRows

; *** 3. draw the bounding steel wall: ***
                ;lda     #<(BoundingWall)
                ;sta     ptrCave
                ;lda     #>(BoundingWall)
                ;sta     ptrCave+1
                ;jsr     DecodeBoundary

; ...and decode the structures...
                lda     #<(BOARD_DATA_AREA)
                sta     ptrCave
                lda     #>(BOARD_DATA_AREA)
                sta     ptrCave+1
                jsr     DecodeStructures

;*** 4. activate all objects: ***

ActivateObjects:

                ldy BoardLimit_Height
.loopY
                dey
                sty POS_Y
                ldx BoardLimit_Width
.loopX
                dex
                stx POS_X
                jsr GetBoardCharacter__CALL_FROM_RAM__          ;6+61(A)
                tax
                lda CharToType2,x
                bmi .skipActivate

                sta POS_Type                    ;       creature TYPE
                tax
                lda #0
                sta POS_VAR

                jsr InsertObjectStackFromRAM    ;6+94(B)

; handle special types:
                ldx POS_X                       ;       x coordinate
                ldy POS_Y                       ;       y coordinate
                lda POS_Type
                cmp #TYPE_MAN
                bne .skipActivate

; insert man:
                stx ManX
                sty ManY

.skipActivate   ldx POS_X                       ;       x coordinate
                bne .loopX
                ldy POS_Y                       ;       y coordinate
                bne .loopY


; adjusts playing speed based on level:

                lda #NUM_LEVELS-1               ; intermissions run at full speed
                bit levelDisplay
                bmi .intermission3
                lda level
.intermission3
                ;asl
                ;asl
                ;ora Platform
                ;lsr
                ;tax
                ;lda ThrottleSpeedTbl,x
                lda #24 ; arbitrary
                sta ThrottleSpeed
                rts


    ;------------------------------------------------------------------------------


NULL_TYPE = 255

CharToType2

    ; Converts a character # to a creature type
    ; add 128 if character is NOT to be added as a creature on board draw

                .byte NULL_TYPE             ; blank
                .byte NULL_TYPE             ; soil
                .byte NULL_TYPE              ;+ SPECIAL_ADD
                .byte NULL_TYPE
                .byte NULL_TYPE              ;+ SPECIAL_ADD
                .byte NULL_TYPE              ;+ SPECIAL_ADD
                .byte TYPE_MAN
                .byte NULL_TYPE
                .byte NULL_TYPE            ;+ ALTERNATE_FACE                ; character_flutterby2
                .byte NULL_TYPE
                .byte NULL_TYPE              ;+ ALTERNATE_FACE                ; character_firefly2
                .byte NULL_TYPE            ;+ NOT_ADDED
                .byte NULL_TYPE            ;+ NOT_ADDED
                .byte NULL_TYPE            ;+ NOT_ADDED
                .byte NULL_TYPE            ;+ NOT_ADDED
                .byte NULL_TYPE              ; steel wall
                .byte NULL_TYPE              ; plain brick wall
                .byte NULL_TYPE             ;+ NOT_ADDED
                .byte NULL_TYPE             ;+ NOT_ADDED
                .byte NULL_TYPE
                .byte NULL_TYPE
                .byte NULL_TYPE
                .byte TYPE_SELECTOR ;EXPLOSION3                 ; overload explosion character
                .byte NULL_TYPE

                ; The following two will NEVER APPEAR ON BOARD DECODE DATA so can be skipped
                ;.byte TYPE_BOX                              ; falling BOX
                ;.byte TYPE_DIAMOND
                ;.byte TYPE_MAN                                 ; unkillable man

                 ; --> see also MoveVec
                 ; --> see also UnpackLevel's table


GetLevelDataBCD; SUBROUTINE
                jsr     GetLevelData

Convert2BCD; SUBROUTINE
                ldx     #0
                ldy     #<(-1)
.loop:
                iny
                cpy     #10
                bcc     .ok
                ldy     #0
                inx
.ok:
                sec
                sbc     #10
                bcs     .loop
                adc     #10
                ora     Mult16Tbl,y
                rts

Y SET 0
Mult16Tbl:
    REPEAT 10
    .byte   Y
Y SET Y + $10
    REPEND

GetLevelData:; SUBROUTINE
                clc
                adc     level
                tay
                lda     (ptrCave),y
                rts

AddPointer0:
                ldx     #0
AddPointer:
                clc
                adc     ptrCave
                sta     ptrCave,x
                lda     ptrCave+1
                adc     #0
                sta     ptrCave+1,x
                rts


NextRandom:
                lda     randSeed1
                ror
                ror
                and     #$80
                sta     tempRand1                   ;       TempRand1 = (RandSeed1 & 1) << 7

                lda     randSeed2
                lsr
                sta     tempRand2                   ;       TempRand2 = RandSeed2 >> 1

;                lda     randSeed2
;                and     #$01
;                lsr
                lda     #$00
                ror
                adc     randSeed2                   ;       C=0!
                adc     #$13                        ;       C=?
                sta     randSeed2                   ;       RandSeed2 = RandSeed2 << 7 + RandSeed2 + $13

                lda     randSeed1
                adc     tempRand1                   ;       C=?
                adc     tempRand2                   ;       C=?
                sta     randSeed1
Exit:
                rts


DecodeStructures:
                lda     #.STRUCT_OFFSET
.loopStructures:
                jsr     AddPointer0
DecodeBoundary:
; load structure type and object:
                ldy     #0
                lda     (ptrCave),y
                cmp     #.STRUCT_DELIMITER
                beq     Exit
                and     #(~.STRUCTURE_MASK) & $FF
                sta     POS_Type
                eor     (ptrCave),y
                asl
                rol
                rol
                sta     structType
; load structure values:
                ldy     #1
                lda     (ptrCave),y                 ;       +1
                sta     column
                iny
                lda     (ptrCave),y                 ;       +2
                sec
                sbc     #2                          ;       cave starts at row 2 in C64 original
                sta     row
                iny
                lda     (ptrCave),y                 ;       +3
                sta     length
                iny
                lda     (ptrCave),y                 ;       +4
                sta     height                      ;       == direction for LINE

; process structure:
                ldx     structType
                bne     .skipSingle
; draw single object:
                ldx     column
                stx     POS_X
                lda     row
                sta     POS_Y
                jsr     PutBoardCharacterFromRAM

.nextStructure:
                ldx     structType
                lda     StructureSizeTbl,x
                bne     .loopStructures         ; 3     unconditional
;    DEBUG_BRK

.skipSingle:
                dex
                bne     .skipLine
; draw a line:
                jsr     DrawLine                ;       a == direction
                beq     .nextStructure          ; 3     unconditional
;    DEBUG_BRK

.skipLine:
                dex
                bne     .skipFilled
; draw a filled rectangle:
                jsr     DrawRectangle

                ldy     #5
                lda     (ptrCave),y             ;       +5
                sta     POS_Type

                inc     column
                dec     height
                dec     length
.loopFill:
                inc     row
                jsr     DrawLineRight
                dec     height
                bne     .loopFill
                beq     .nextStructure          ; 3     unconditional

.skipFilled:
; draw a rectangle:
                jsr     DrawRectangle
                beq     .nextStructure          ; 3     unconditional
;    DEBUG_BRK

DrawLineRight:
                lda     #.DIR_RIGHT
DrawLine:
                ldx     column
                ldy     row
; direction is set outside
                stx     POS_X
                sty     POS_Y
DrawNextHLine:
                ldx     length
                NOP_W
DrawNextVLine:
                ldx     height
                sta     direction
                stx     tmpLength
.loopLine:
                jsr     PutBoardCharacterFromRAM
                ldy     direction
                lda     POS_X
                clc
                adc     ColumnDirTbl,y
                sta     POS_X
                lda     POS_Y
                clc
                adc     RowDirTbl,y
                sta     POS_Y
                dec     tmpLength
                bne     .loopLine
                rts


DrawRectangle:
                dec     length
                dec     height

                jsr     DrawLineRight

                lda     #.DIR_DOWN
                jsr     DrawNextVLine
                lda     #.DIR_LEFT
                jsr     DrawNextHLine
                lda     #.DIR_UP
                bpl     DrawNextVLine           ; 3     unconditional
;    DEBUG_BRK


CAVENUM         SET 0
CAVE_DATA_SIZE  = 5

                MAC ADD_CAVE ; {name}
CAVE_ACTIVE_{1} SET 1
CAVE_NAMED_{1}  = CAVENUM
    .byte <CAVE_{1}
    .byte >CAVE_{1}
    .byte BANK_CAVE_{1}
    .byte CAVE_SIZE_{1}
    .byte {2}                                   ; display as #.  $80 indicates intermission.
CAVENUM         SET CAVENUM + CAVE_DATA_SIZE
                ENDM

CaveInformation

                ; The ordering here corresponds to the ordering when playing...
  IF FINAL_VERSION = YES || DEMO_VERSION = NO
                    ADD_CAVE INTRO,1
                    ADD_CAVE ROOMS,2
                    ADD_CAVE MAZE,3
                    ADD_CAVE BUTTERFLIES,4
                    ADD_CAVE INTERMISSION_1,$80|$0

                    ADD_CAVE GUARDS,5
                    ADD_CAVE FIREFLY_DENS,6
                    ADD_CAVE AMOEBA,7
                    ADD_CAVE ENCHANTED_WALL,8

                    ADD_CAVE INTERMISSION_2,$80|$1



    ENDIF

    ;---------------------------------------------------------------------------


RowDirTbl:
    .byte   -1, -1;, 0, 1, 1, 1, 0, -1
ColumnDirTbl:
    .byte   0, 1, 1, 1, 0, -1, -1, -1

StructureSizeTbl:
    .byte   3, 5, 6, 5


;foreground color is ignored (white instead), except for amoeba levels G and M (light green)

; structure for the bounding steel wall:
BoundingWall:
    .byte   .STRUCT_RECTANGLE|CHARACTER_STEEL, 0, 2, 99, 99 ; bounding steel wall
    .byte   .STRUCT_DELIMITER

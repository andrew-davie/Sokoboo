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

CAVENUM         SET 0
CAVE_DATA_SIZE  = 4

                MAC ADD_CAVE ; {name}
CAVE_ACTIVE_{1} SET 1
CAVE_NAMED_{1}  = CAVENUM
    .byte <CAVE_{1}
    .byte >CAVE_{1}
    .byte BANK_CAVE_{1}
    .byte CAVE_SIZE_{1}
CAVENUM         SET CAVENUM + CAVE_DATA_SIZE
                ENDM

CaveInformation

                ; The ordering here corresponds to the ordering when playing...
    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    ;ADD_CAVE _057_L
    ADD_CAVE _0VM5_Andrea_Wadd
    ADD_CAVE _0PAL_Jill_Leatherby
    ADD_CAVE _0IZ1_Sophia
    ADD_CAVE _0CNH_Alice
    ADD_CAVE TowC
    ADD_CAVE SimpleC
    ADD_CAVE Thomas_Reinke16
    ADD_CAVE bDarcy_Burnsell101
    ADD_CAVE bAlfa_DrFogh
    ADD_CAVE bAislin101
    ADD_CAVE b82X_Sharpen
    ADD_CAVE b51X_Sharpen
    ENDIF

; undo/rewind
; move counter
;counter of #targets left
; digits
; character/animations
; cave table pointers
; color randomize
; more levels
; (timer)?
; hihg "score"  and savekey
; password for level unlocks
; title screen


finX
  ; now put the soil in - fill from the outsides

                lda #CHARACTER_SOIL
                sta POS_Type

                lda #SIZE_BOARD_Y-1
                sta POS_Y

xlin            lda #SIZE_BOARD_X-1
                sta POS_X
zap1            jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg2a
                cmp #0
                bne endzap1
                jsr PutBoardCharacterFromRAM
kg2a            dec POS_X
                bpl zap1

endzap1         lda #0
                sta POS_X
zap2            jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg2
                cmp #0
                bne endzap2
                jsr PutBoardCharacterFromRAM
kg2             inc POS_X
                lda POS_X
                cmp #SIZE_BOARD_X
                bne zap2

endzap2         dec POS_Y
                bpl xlin


                lda #SIZE_BOARD_X-1
                sta POS_X

ylin            lda #SIZE_BOARD_Y-1
                sta POS_Y
zapy1           jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg3
                cmp #0
                bne endzapy1
                jsr PutBoardCharacterFromRAM
kg3             dec POS_Y
                bpl zapy1

endzapy1        lda #0
                sta POS_Y
zapy2            jsr GetBoardCharacter__CALL_FROM_RAM__
                cmp #CHARACTER_SOIL
                beq kg3b
                cmp #0
                bne endzapy2
                jsr PutBoardCharacterFromRAM
kg3b                inc POS_Y
                lda POS_Y
                cmp #SIZE_BOARD_Y
                bne zapy2

endzapy2        dec POS_X
                bpl ylin
                rts

    DEFINE_SUBROUTINE RegisterOneMoreTarget

              sed
              clc
              lda targetsRequired
              adc #1
              sta targetsRequired
              cld
              rts


  DEFINE_SUBROUTINE UnpackLevel

              sta RAM_Bank

  ; has to be done before decoding the cave to have the platform right:
              SET_PLATFORM

              lda #CHARACTER_BLANK
              sta POS_Type

              lda #SIZE_BOARD_Y-1
              sta POS_Y
xyLine        lda #SIZE_BOARD_X-1
              sta POS_X
xyClear       jsr PutBoardCharacterFromRAM
              dec POS_X
              bpl xyClear
              dec POS_Y
              bpl xyLine

              lda #6
              sta base_x
              sta base_y

              lda NextLevelTrigger
              ora #BIT_NEXTLEVEL
              sta NextLevelTrigger

              ldy cave
              sec
              lda CaveInformation,y
              sbc #1
              sta Board_AddressR
              lda CaveInformation+1,y
              sbc #0
              sta Board_AddressR+1
              lda CaveInformation+2,y
              sta cave_bank

              lda #BANK_UnpackLevel               ; the *ROM* bank of this routine (NOT RAM)
              sta ROM_Bank                        ; GetROMByte returns to this bank

              ;NEXT_RANDOM
              ;and #$F0
              ;ora #$A
              lda #$8a ;ba
              sta color
              lda #$44
              ;lda #$A0
              sta color+1
              lda #$2a ;lda #$9C
              sta color+2

              lda #$00
              sta moveCounter
              sta moveCounterHi

              lda #$00                      ; BCD reminder!
              sta targetsRequired           ; # of targets that do NOT have boxes on them

              ;lda #SIZE_BOARD_X
              ;sta BoardLimit_Width
              ;lda #SIZE_BOARD_Y
              ;sta BoardLimit_Height
              ;lda #$5
              ;sta targetsRequired              ;       should never be 0

              lda #24 ; arbitrary
              sta ThrottleSpeed

  ; first fill bg with character_soil
  ; then rle unpack level
  ; change level colours

              lda #0
              sta POS_X
              sta POS_Y
              sta BoardLimit_Width
              sta BoardLimit_Height

GetNextItem

              lda #1
              sta upk_length
              lda #0
              sta upk_column         ; reuse var - this flags a digit already

Get2          inc Board_AddressR
              bne addrOK
              inc Board_AddressR+1
addrOK

              lda cave_bank
              ldy #0
              jsr GetROMByte
              sta upk_temp       ;scratch


              cmp #0
              bne parse
              jmp  finX
parse
              cmp #"9"+1
              bcs notDigit
              cmp #"0"
              bcc notDigit

              lda upk_column
              beq firstDig

              lda upk_length
              asl
              asl
              asl
              adc upk_length
              adc upk_length

firstDig      clc
              adc upk_temp
              sec
              sbc #"0"
              sta upk_length
              inc upk_column     ; flag we have seen a digit
              jmp Get2

notDigit      cmp #"|"          ; newline
              bne checkWall

    ; Handle new-line
              lda #0
              sta POS_X
              inc POS_Y


              lda POS_Y
              cmp BoardLimit_Height
              bcc wOK2
              sta BoardLimit_Height ;???^^^
wOK2

              jmp GetNextItem

checkWall     cmp #"#"          ; wall
              bne checkForGap
              lda #CHARACTER_WALL
              bne WriteChars

checkForGap   cmp #32
              beq writeGap
              cmp #"-"
              beq writeGap
              cmp #"_"
              bne checkForMan

writeGap      lda #CHARACTER_BLANK
              jmp WriteChars

checkForMan
              cmp #"+"            ; player on goal square
              bne notPlayerGoal

              jsr RegisterOneMoreTarget

              ; put goal square, init player with POS_VAR = CHARACTER_TARGET

              lda #CHARACTER_TARGET
              bne genPlayer

notPlayerGoal
               cmp #"@"            ; player on normal square
               bne checkBox

              lda #CHARACTER_BLANK

genPlayer

              sta POS_VAR                     ; character man is on

              clc
              lda POS_X
              pha
              adc base_x
              sta POS_X
              sta ManX

              lda POS_Y
              pha
              adc base_y
              sta POS_Y
              sta ManY

              ; POS_X     x position
              ; POS_Y     y position
              ; POS_VAR   CHARACTER UNDER MAN TO RESTORE
              ; POS_Type  type of object

              lda #TYPE_MAN
              sta POS_Type                    ;       creature TYPE
              jsr InsertObjectStackFromRAM    ;6+94(B)

              lda #0
              sta manAnimationIndex

              pla
              sta POS_Y
              pla
              sta POS_X

              lda #CHARACTER_MANOCCUPIED
              jmp WriteChars

checkBox      cmp #"$"
              bne checkBoxTarget

              lda #CHARACTER_BOX
              bne WriteChars

checkBoxTarget  cmp #"*"
              bne checkTarget

              lda #CHARACTER_BOX_ON_TARGET
              bne WriteChars

checkTarget   cmp #"."
              beq targ
              jmp GetNextItem
targ

              lda #CHARACTER_TARGET

WriteChars    sta POS_Type

Wc2x              clc
              lda POS_X
              pha
              adc base_x
              sta POS_X

              lda POS_Y
              pha
              adc base_y
              sta POS_Y

              jsr PutBoardCharacterFromRAM

              lda POS_Type
              cmp #CHARACTER_TARGET
              bne notargdet
              jsr RegisterOneMoreTarget
notargdet

              pla
              sta POS_Y
              pla
              sta POS_X

              clc
              adc #1
              sta POS_X

              cmp BoardLimit_Width
              bcc wOK
              sta BoardLimit_Width
wOK

              dec upk_length
              bne Wc2x
              jmp GetNextItem

finishedUnpack

              rts
#endif

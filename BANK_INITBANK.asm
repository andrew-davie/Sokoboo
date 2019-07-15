
            NEWBANK INITBANK

    .byte   0   ; to avoid extra cycle when accessing via BoardLineStartLO-1,y

    DEFINE_SUBROUTINE BoardLineStartLO

    ; Gives the start address (LO) of each board line

.BOARD_LOCATION SET Board
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
                .byte <.BOARD_LOCATION
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X
            REPEND
    CHECKPAGE BoardLineStartLO

SIZE_BOARD = .BOARD_LOCATION-Board  ; verify calculated value

;------------------------------------------------------------------------------

BoardLineStartHiR

    ; Gives the start address (HI) of each board line
    ; Note this caters for the memory wrapping when we go from bank to bank, as
    ; the board overlays multiple banks!

.BOARD_LOCATION SET Board
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
                .byte >( .BOARD_LOCATION & $13FF )      ; cater for mirroring of memory images
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X
            REPEND
    CHECKPAGE BoardLineStartHiR
;------------------------------------------------------------------------------

BoardLineStartHiW

    ; Gives the start address (HI) of each board line
    ; Note this caters for the memory wrapping when we go from bank to bank, as
    ; the board overlays multiple banks!

.BOARD_LOCATION SET Board
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
                .byte >( ( .BOARD_LOCATION & $13FF ) + RAM_WRITE )      ; cater for mirroring of memory images
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X
            REPEND
    CHECKPAGE BoardLineStartHiW

;------------------------------------------------------------------------------
    IF MULTI_BANK_BOARD = YES
BoardBank
    ENDIF
    ; Gives the RAM bank of the start of the board row for a given row.

.BOARD_LOCATION SET Board - RAM_3E
            REPEAT SIZE_BOARD_Y
              IF >.BOARD_LOCATION != >(.BOARD_LOCATION + SIZE_BOARD_X-1)
.BOARD_LOCATION SET .BOARD_LOCATION - <.BOARD_LOCATION + 256
              ENDIF
    IF MULTI_BANK_BOARD = YES
                .byte BANK_BOARD + (.BOARD_LOCATION / RAM_SIZE)            ; actual bank #
    ENDIF
.BOARD_LOCATION SET .BOARD_LOCATION + SIZE_BOARD_X      ; note, we CANNOT cross a page boundary within a row
            REPEND
    IF MULTI_BANK_BOARD = YES
    CHECKPAGE BoardBank
    ENDIF


    ;------------------------------------------------------------------------------

CopyROMShadowToRAM_F000
                lda #>$F000

    DEFINE_SUBROUTINE CopyROMShadowToRAM ; in INITBANK

    ; Function copies a RAM prototype ROM bank into the destination RAM bank.  Typically
    ; the variable definitions are in the ROM shadow because this allows auto-initialisation
    ; of the variable contents from ROM declarations, but still allows access to them as
    ; variables when the correct RAM bank is switched in.  Code is also, of course, copied
    ; into the RAM destination so that code is callable whenever the ROM *or* RAM bank is
    ; switched in.  Further, if multiple copies are made to multiple RAM banks, then the
    ; code co-lives in all banks and may run even as bankswitching occurs between those
    ; banks -- by the very code itself.

    ; Note: Relies on ROM_Bank having being set via CALL mechanism to call this function
                sta Board_AddressR+1
                stx O_ROM_Source_Bank           ; source bank
                sty RAM_Bank                    ; destination bank

                ldy #0
                sty Board_AddressR
                sty Board_AddressW
                lda #>($1000+RAM_WRITE)
                sta Board_AddressW+1

    ; Iterate 4 pages (1K) for complete bank copy

                lda #4
                sta O_CopyCount

CopyPage        sty O_Index
                lda O_ROM_Source_Bank
                jsr GetROMByte                  ; get byte from ROM shadow bank
                ;tax
                ldy O_Index
                ldx RAM_Bank
                jsr PutBoardCharacter           ;6+21(A)        write byte to RAM bank

                ldy O_Index
                iny
                bne CopyPage

                inc Board_AddressR+1
                inc Board_AddressW+1

                dec O_CopyCount
                bne CopyPage

                ldy RAM_Bank                    ; TODO: remove!?
                rts


    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE SetPlatformColours ; in INITBANK

    ; Now modify the hardwired colours so that we're correctly switched for NTSC/PAL
    ; The platform (0=NTSC, 1=PAL) is set from the right difficulty switch
    ; Note: This relies on DrawTheScreen starting on page boundary so that the (),y
    ; addressing will not violate the page-crossing restriction of 3E.

    ; TODO: adapt for fast vertical scrolling

;                sty RAM_Bank                    ; we assume we called CopyROMShadowToRAM before

                lda #<DrawTheScreen             ; = 0
                sta Board_AddressW
                lda #>( DrawTheScreen + RAM_WRITE )
                sta Board_AddressW+1

    ; first, set the x index (with last one being a RTS ($60))

                ldx RAM_Bank
                cpx #SCREEN_LINES-1             ; might become variable when vertical scrolling
                bne .skipPatch
                lda #$60                        ; rts
                ldy #<SELFMOD_X
                jsr PutBoardCharacter           ;6+21(A)        set index/rts
.skipPatch

                ldx #3-1
.loopColor
                stx colorIdx
; set PF colors
                lda color,x
                ldy SelfModColOfsTbl,x
                ;tax
                ldx RAM_Bank
                jsr PutBoardCharacter           ;6+21(A)        copy PF colour RED/GREEN/BLUE to self-modifying RAM
; set player colors
                ldx colorIdx
                lda SelfModePlayerTbl,x
                ldy Platform
                cpy #PAL
                bcc .platform0
                adc #LINES_PER_CHAR-1           ; C==1!
.platform0:
                ldy SelfModPlayerColOfsTbl,x
                ;tax
                ldx RAM_Bank
                jsr PutBoardCharacter           ;6+21(A)        copy player colour RED/GREEN/BLUE to self-modifying RAM
; loop
                ldx colorIdx
                dex
                bpl .loopColor

                ldy RAM_Bank
                rts

SelfModColOfsTbl:
    .byte   <(SELFMOD_BLUE+1), <(SELFMOD_GREEN+1), <(SELFMOD_RED+1)
SelfModePlayerTbl:
    .byte   <SpriteColourBLUE, <SpriteColourGREEN, <SpriteColourRED
SelfModPlayerColOfsTbl:
    .byte   <(SELFMOD_PLAYERCOL_BLUE+1), <(SELFMOD_PLAYERCOL_GREEN+1), <(SELFMOD_PLAYERCOL_RED+1)


DrawLineStartLO

    ; Gives the start address of each line in the draw flags buffer

.DRAW_LOCATION  SET DrawFlag
            REPEAT SCREEN_LINES
                .byte <.DRAW_LOCATION
.DRAW_LOCATION  SET .DRAW_LOCATION + SCREEN_WIDTH
            REPEND


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardAddressRW ; in INITBANK
    ; Must share same bank as BoardLineStart tables

                lda BoardLineStartLO,y          ; 4
                sta Board_AddressR              ; 3
                sta Board_AddressW              ; 3
                lda BoardLineStartHiR,y         ; 4
                sta Board_AddressR+1            ; 3         READ address
                ora #>RAM_WRITE                 ; 2
                sta Board_AddressW+1            ; 3         WRITE address
    IF MULTI_BANK_BOARD = YES
                ldx BoardBank,y                 ; 4 = 26    switch this on return
    ELSE
                ldx #BANK_BOARD                 ; 2
    ENDIF
                rts                             ; 6 = 32[-2]

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardAddressR ;=24[-2](A)

                lda BoardLineStartLO,y          ; 4
                sta Board_AddressR              ; 3
                lda BoardLineStartHiR,y         ; 4
                sta Board_AddressR+1            ; 3     READ address
    IF MULTI_BANK_BOARD = YES
                lda BoardBank,y                 ; 4     switch this on return
    ELSE
                lda #BANK_BOARD                 ; 2
    ENDIF
                rts                             ; 6[-2]

    ;------------------------------------------------------------------------------

    ; +------+------+------+
    ; |*     | a(0) |      |   *= where Temp_board_address1 points
    ; +------+------+------+
    ; | d(3) | X(4) | b(1) |
    ; +------+------+------+
    ; |      | c(2) |      |
    ; +------+------+------+


    DEFINE_SUBROUTINE GetBoardAddress4 ;=72[-16](C)

                ldy POS_Y                       ;3

                lda BoardLineStartLO-1,y        ;4
                sta Temp_Board_Address1         ;3
                lda BoardLineStartLO+1-1,y      ;4
                sta Temp_Board_Address2         ;3
                lda BoardLineStartLO+2-1,y      ;4
                sta Temp_Board_Address3         ;3
                lda BoardLineStartHiR-1,y       ;4
                sta Temp_Board_Address1+1       ;3
                lda BoardLineStartHiR+1-1,y     ;4
                sta Temp_Board_Address2+1       ;3
                lda BoardLineStartHiR+2-1,y     ;4
                sta Temp_Board_Address3+1       ;3
    IF MULTI_BANK_BOARD = YES
                lda BoardBank+1-1,y             ;4
                sta Temp_Bank2                  ;3
                lda BoardBank+2-1,y             ;4
                sta Temp_Bank3                  ;3
                lda BoardBank-1,y               ;4
                ;sta Temp_Bank                  ;   this becomes switched in RAM bank in normal usage
    ELSE
                lda #BANK_BOARD                 ;2
    ENDIF
                ldy POS_X                       ;3
                rts                             ;6 = 72[-16]

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE GetBoardAddressW ;=24[-2](A)

    ; Must share same bank as BoardLineStart tables

                lda BoardLineStartLO,y          ;4
                sta Board_AddressW              ;3
                lda BoardLineStartHiW,y         ;4
                sta Board_AddressW+1            ;3 WRITE address
    IF MULTI_BANK_BOARD = YES
                ldx BoardBank,y                 ;4 switch this on return
    ELSE
                ldx #BANK_BOARD                 ;2
    ENDIF
QRet            rts                             ;6

    ;------------------------------------------------------------------------------

    IF 0 ;{
    ;IF DEMO_VERSION = YES && FINAL_VERSION = NO
    DEFINE_SUBROUTINE ProcessSelector ; in INITBANK

                sta ROM_Bank

    ; This object handles the selection of screen and level

                jsr MoveViaJoystick
                jsr InsertObjectStack           ;6+76(B)         re-insert object at same position

                asl NextLevelTrigger
                lda BufferedButton                       ; button pressed?
                asl
                ror NextLevelTrigger

                lda POS_VAR
                and #31
                sta caveDisplay
                asl
                asl
                adc caveDisplay                ; *5
                sta cave

    ; Note: we can only select level 1,2,3,4
    ; Didn't have enough bits in the POS_VAR variable to hold 0-4 for level and 0-34 for cave... eh?
                lda POS_VAR
                lsr
                lsr
                lsr
                lsr
                lsr
                sta level


                ldx Platform                    ; P1 difficulty --> TV system (0=NTSC, 1=PAL)
                lda ThrottlePerSystem,x
                sta ThrottleSpeed               ; only for selection screen

                rts
ThrottlePerSystem
                .byte   19
                .byte   21
    ENDIF ;}

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE ProcessExplosion ; in INITBANK

    ; Explosion object delays for 4 animation frames and
    ; then replaces itself with a character or diamond (and generates diamond creature).
    ; If blanks are generated, these are pushed to the blank-stack.
                sta ROM_Bank

    ; Check if the board character is our (last) written explosion character
    ; if NOT, then something's happened (another explosion over the top, perhaps...?) so die.

                ldy POS_Y                       ;3
                jsr GetBoardAddressR            ;6+24[-2](A)
                ldy POS_X
                jsr GetBoardCharacter
                eor POS_VAR
                asl
                bne QRet                        ; something happened -- not expected char so die


                inc POS_VAR
                lda POS_VAR                     ; d7 = diamond/blank, rest = animation index
                and #~$80
                cmp #CHARACTER_EXPLOSION3+1
                beq PostExplosion
                pha

                ldy POS_Y
                jsr GetBoardAddressW
                ldy POS_X
                pla
                jsr PutBoardCharacter           ; write new post-explosion character

                ;inc POS_VAR                     ; frame and diamond/blank flag
                jmp InsertObjectStack           ;6+76(B)         re-insert object


    DEFINE_SUBROUTINE PostExplosion

                lda POS_VAR
                bpl ExplosionBlank
                lda #VAR_JUST_GENERATED
                sta POS_VAR                     ; NOT a falling diamond -- fixes chained butterfly explosion
                ldy POS_Y
                jsr GetBoardAddressW
                ldy POS_X
                lda #CHARACTER_DIAMOND
                jsr PutBoardCharacter           ; write new post-explosion character

    ; Become an active diamond (in case it needs to fall)

                lda #TYPE_DIAMOND
                sta POS_Type
                jmp InsertObjectStack           ;3+76(B)         and return

ExplosionBlank

    ; Place this square onto the blank stack so creatures may fall into it

                ldy POS_Y
                jsr GetBoardAddressW
                ldy POS_X
                lda #CHARACTER_BLANK
                jsr PutBoardCharacter               ; write new post-explosion character

                lda #BANK_DRAW_BUFFERS
                jmp InsertBlankStack2               ;6+51(A) place object on blank stack and return

    ;------------------------------------------------------------------------------
;Amoeba is stuff that grows randomly. If trapped such that it can't grow any more, it "suffocates" and turns into
; diamonds. If it grows too large, it turns into boulders. Fireflies and butterflies will explode on contact with
; amoeba. Every scan, a count is kept of how many amoeba have been found. For each amoeba found during the current scan,
; it does these things:
;
;If there were too many (see below) amoeba found in the scan during the last frame, the amoeba is considered to have
; grown too large, and so all amoeba found in this scan frame are quietly replaced with boulders. Failing that, if it
; was determined in the scan during the last frame that the amoeba was completely enclosed (could not grow), then each
; amoeba is quietly replaced with a diamond. Failing that, if there have been no amoeba found during the current scan
; that had the potential to grow, then a check is made to see whether this amoeba could grow. If it is possible for it
; to grow, then the flag is changed to indicate that there is at least one amoeba in existance that can grow during this
; frame. If the amoeba did not turn into a diamond or a boulder (in steps 1 or 2 above), it may or may not attempt to
; grow. A random number is generated to decide whether the amoeba will attempt grow: it has a 4/128 chance (about 3%)
; normally, or a 4/16 chance (25%) in some circumstances. If the decision is that the amoeba will atempt to grow, it
; randomly chooses one of the four directions to grow in. If that direction contains a space or dirt, the amoeba grows
; to fill that spot. The new amoeba just grown does not itself get the chance to grow until the next frame (ie the new
; amoeba is marked as "amoeba, scanned this frame"). How many is too many? For the Commodore 64 implementation of
; Boulder Dash, "too many" amoeba (the point where they turn into boulders) is 200 or more. Since other implementations
; of Boulder Dash may permit cave sizes other than 40 x 22 (= 880 squares), I suggest that "too many" is defined as
; being 200/880 = 22.7% of the total number of squares available in the cave. In other words, once 22.7% or more of the
; cave is occupied by amoeba, it should turn into boulders. When is it 3% and when 25%? Initially, the amoeba growth
; probability is 4/128 (about 3%). Once the "amoeba slow growth time" has elapsed, the amoeba suddenly starts growing a
; lot quicker (amoeba growth probability = 25%). The "amoeba slow growth time" is set on a cave-by-cave basis, and is in
; seconds.

; TODOs:
; ? maybe scan in a different order to hide scanning character (step x rows and y columns)
; - the processing of the whole board should be done at a fixed speed

    DEFINE_SUBROUTINE ProcessAmoeba ; in INITBANK

; This routine gets priority over everything, so it really needs to use as LITTLE time as it possibly can.
                sta ROM_Bank

; before we start a new scan wait a minimum number of scan calls (keeps the  Amoeba speed more constant)
                ldx amoebaStepCount             ; 3
                beq .doScan                     ; 2/3
                dex                             ; 2
                bne .notZero
                lda amoebaFlag                  ; 3     when the count reaches zero, we are allowed to start a new scan
                and #(<~SCAN_FINISHED)          ; 2
                sta amoebaFlag                  ; 3
                ldx #MIN_AMOEBA_SCAN-1          ; 2
.notZero
                stx amoebaStepCount             ; 3                                ;
                lda amoebaFlag                  ; 3
                and #SCAN_FINISHED
                bne ambRet
.doScan
                lda #FINISHEDDIAMOND
                bit amoebaFlag
                bne ambRet                      ;
                bpl aCycle                      ; not TODIAMOND, run only once

                jsr nextAmobPos                 ; 3 scans/frame, do quicker if converting to diamonds/boulders

    ; Scan amoeba position

aCycle          jsr nextAmobPos                 ; 2 scans/frame

nextAmobPos
;                ldy amoebaY                     ; 3    TODO: replace following code
;                jsr GetBoardAddressR
;                ldy amoebaX                     ; 3

                ldx amoebaY                     ; 3
                ldy amoebaX                     ; 3
                lda BoardLineStartLO,x          ; 4
                sta Board_AddressR              ; 3
                lda BoardLineStartHiR,x         ; 4
                sta Board_AddressR+1            ; 3
    IF MULTI_BANK_BOARD = YES
                lda BoardBank,x                 ; 4
                sta RAM_Bank                    ; 3
    ELSE
                lda #BANK_BOARD                 ; 2
    ENDIF

                jsr GetBoardCharacter           ;6+20(A)

                lda CharToType,x                ; 4
                cmp #TYPE_AMOEBA                ; 2
                beq .isAmoeba
                jmp .nextPos                    ; 2/3=61    All that work to see if square is an amoeba

.isAmoeba:

                lda amoebaY                     ; 3
                sta POS_Y                       ; 3
                ldy amoebaX                     ; 3
                sty POS_X                       ; 3 = 12

                bit amoebaFlag                  ; 3         TODIAMOND?
                bpl normalOperate               ; 2/3= 5/6

                lda amoebaCount                 ; 3
                cmp #TOO_MUCH_AMOEBA            ; 2
                ldx #CHARACTER_DIAMOND          ; 2
                bcc diam                        ; 2/3
                ldx #CHARACTER_BOX          ; 2
diam                                            ;   = 10/11
;amoebaToRocksOrDiamonds

                lda Board_AddressR              ; 3
                sta Board_AddressW              ; 3
                lda Board_AddressR+1            ; 3
                ora #>RAM_WRITE                 ; 2
                sta Board_AddressW+1            ; 3

                lda CharToType,x                ;       X = boulder/diamond character shape
                sta POS_Type
                txa
    IF MULTI_BANK_BOARD = YES
                ldx RAM_Bank
    ELSE
                ldx #BANK_BOARD                 ; 2
    ENDIF
                jsr PutBoardCharacter           ;29

    ; To reduce object count, and increase speed on conversion, only add objects if they have a blank around them.

                jsr GetSurroundingChars         ;6+161[-28](C)

                lda Surround+1
                and Surround+2
                and Surround+3
                bne .nextPosBne                 ; if NONE of the L/R or D squares are blank, then don't generate creature

                sta POS_VAR
                beq .insertObject               ; 3     unconditional
;----------------------------------------------------------
ambRet
                rts
;----------------------------------------------------------
normalOperate
                inc amoebaCount

                jsr GetSurroundingChars         ;6+161[-28](C)

    ; if any of the UDLR are soil or blank, then amoeba is NOT enclosed

                lda #CHARACTER_SOIL                    ; blank/soil ?
                cmp Surround
                bcs notEnclosed
                cmp Surround+1
                bcs notEnclosed
                cmp Surround+2
                bcs notEnclosed
                cmp Surround+3
                bcc .nextPos                    ;       enclosed

notEnclosed     lda amoebaFlag
                ora #NOT_ENCLOSED
                sta amoebaFlag                  ; found a blank for amoeba (OR there are ghosts around) so it's OK to continue

    ; If the amoeba did not turn into a diamond or a boulder (in steps 1 or 2 above), it may or may not attempt to
    ; grow. A random number is generated to decide whether the amoeba will attempt grow: it has a 4/128 chance (about 3%)
    ; normally, or a 4/16 chance (25%) in some circumstances. If the decision is that the amoeba will atempt to grow,
    ; it randomly chooses one of the four directions to grow in. If that direction contains a space or dirt, the amoeba
    ; grows to fill that spot. The new amoeba just grown does not itself get the chance to grow until the next frame
    ; (ie the new amoeba is marked as "amoeba, scanned this frame")

                NEXT_RANDOM                     ; need it to change as we do multiple loops of amoeba per call
                cmp #SLOW_GROW
                eor rndHi                       ; to become independent from previous random value, due to the simplicity of the LFSR
                                                ; there is a bg chance of consecutive numbers becoming dependent
                                                ; @AD: remove it and you will see the "stuck" Amoeba
                bcc .growAmoeba                 ; slow things down -- only do the amoeba occasionally
; reenable if FAST_GROW becomes too fast
                cmp #FAST_GROW
                bcs .nextPos
.loopFastGrow
                ldx MagicAmoebaFlag
                inx                             ; AMOEBA_FAST_GROW?
.nextPosBne
                bne .nextPos                    ;  no
.growAmoeba
    ; TJ: The original checks only ONCE. This slows down the grow rate of a large Amoeba, since the
    ; chance to select and occupied space become larger.
    ; NEW: ADs loop code, but only for fast grow

    ; we *know* at least one direction is blank.
    ; Choose circularly until we find one;

    ; neat bit of code, and yes it's correct.
    ; 1st time through we don't care about carry.  Thereafter it's set.

                adc #0
                and #3
                tay
                ldx Surround,y
                cpx #CHARACTER_SOIL+1                  ; allow only blank/soil for amoeba growth
                bcs .loopFastGrow
;                bcs .nextPos

                ;clc
                lda amoebaX
                adc RDirX,y
                sta POS_X

; Note: The scan box increases during the scan, more efficient would be to increase it afterwards
;  but that would require at least another byte and gain not that much speed.
; update scan box width:
                cmp amoebaMinX
                bcs .skipNewMinX
                sta amoebaMinX
.skipNewMinX
                cmp amoebaMaxX
                bcc .skipNewMaxX
                sta amoebaMaxX
                clc
.skipNewMaxX

;                clc
                lda amoebaY
                adc RDirY,y
                sta POS_Y
; update scan box height:
                cmp amoebaMinY
                bcs .skipNewMinY
                sta amoebaMinY
.skipNewMinY
                cmp amoebaMaxY
                bcc .skipNewMaxY
                sta amoebaMaxY
.skipNewMaxY

    ; Bypass object creation -- just write the amoeba character directly

                ldy POS_Y
                jsr GetBoardAddressW            ;6+24[-2]
                ldy POS_X
                lda #CHARACTER_AMOEBA
                jsr PutBoardCharacter
                jmp .nextPos

.insertObject
                jsr InsertObjectStack           ;6+76(B)

.nextPos
; scan next column:
                dec amoebaX
                ldx amoebaX
                cpx amoebaMinX
                bcs .exit

; scan next row:
                ldx amoebaMaxX
                stx amoebaX

                dec amoebaY
                ldy amoebaY
                cpy amoebaMinY
                bcs .exit

; start complete new boxed scan:
                ldy amoebaMaxY
                sty amoebaY

    ; This happens at the completion of each board scan
    ; IF we're totally enclosed, OR we're too big, then the interesting stuff happens!

                lda amoebaFlag                  ;       TODIAMOND?
                bmi .convertedToDiamonds

                ldx amoebaCount
                cpx #TOO_MUCH_AMOEBA
                bcs .tooMany

                lsr                            ;        NOT_ENCLOSED?
                bcc .enclosed

    ; reset per-scan variables as we're starting a complete new scan at this point
                asl                             ; 2     clears NOT_ENCLOSED bit
dontConvertIt   ora #SCAN_FINISHED              ; 2     indicate that we finshed last scan
                sta amoebaFlag                  ; 3

                lda #0                          ; 2     has to be done here. Do NOT move!!!
                sta amoebaCount                 ; 3
; (re)enable sound with each new scan (e.g. after being disabled by crack or time sound)
                START_SOUND SOUND_AMOEBA
                rts

;-------------------------------------------------------------------------------
.enclosed
                asl
.tooMany
; enclosed or too many, so set todiamonds
                ora #TODIAMOND
                sta amoebaFlag                  ;       force "to boulder" or "to diamond"
.exit
Rts
                rts

;-------------------------------------------------------------------------------
; the amoeba was converted in to either diamonds or boulders, so it dies here
.convertedToDiamonds
                ora #FINISHEDDIAMOND
                sta amoebaFlag

                STOP_SOUND 1, OFSS_AMOEBA
                rts

;-------------------------------------------------------------------------------


OBJTYPE    SET 0
    MAC DEFINE_CHARACTER
CHARACTER_{1}    = OBJTYPE
OBJTYPE    .SET OBJTYPE + 1
    ENDM

        ; Modifications to character #/order must also ensure the following are correct...
        ;   CharacterDataVecLO[...]         in BANK_FIXED.asm
        ;   CharacterDataVecHI[...]         in BANK_FIXED.asm
        ;   GenericCharFlag[...]            in BANK_FIXED.asm
        ;   MoveVecLO[...]                  in BANK_INITBANK.asm
        ;   MoveVecHI[...]                  in BANK_INITBANK.asm
        ;   CharToType[...]                 in BANK_FIXED.asm
        ;   CharToType2[...]                in DecodeCave.asm

                DEFINE_CHARACTER BLANK
                DEFINE_CHARACTER SOIL
                DEFINE_CHARACTER BOX
                DEFINE_CHARACTER AMOEBA
                DEFINE_CHARACTER DIAMOND
                DEFINE_CHARACTER DIAMOND2
                DEFINE_CHARACTER MANOCCUPIED
                DEFINE_CHARACTER FLUTTERBY
                DEFINE_CHARACTER FLUTTERBY2
                DEFINE_CHARACTER FIREFLY
                DEFINE_CHARACTER FIREFLY2
                DEFINE_CHARACTER WALL0
                DEFINE_CHARACTER WALL1
                DEFINE_CHARACTER WALL2
                DEFINE_CHARACTER WALL3
                DEFINE_CHARACTER STEEL
                DEFINE_CHARACTER WALL
                DEFINE_CHARACTER EXITDOOR
                DEFINE_CHARACTER EXITDOOR2
                DEFINE_CHARACTER EXPLOSION
                DEFINE_CHARACTER EXPLOSION1
                DEFINE_CHARACTER EXPLOSION2
                DEFINE_CHARACTER EXPLOSION3
                DEFINE_CHARACTER AMOEBA2
                DEFINE_CHARACTER BOX_FALLING
                DEFINE_CHARACTER DIAMOND_FALLING
                DEFINE_CHARACTER NOGO

                DEFINE_CHARACTER MAXIMUM

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE PushBox ; in INITBANK

    ; Note: FALLING boulders are not really boulders. They are falling boulders. They are a different
    ; character type, so will not get to this code. So you can't push falling objects :)

                sta ROM_Bank

    ; Determine if the boulder is pushable
    ; we use the joystick to calculate the subsequent square
;;;

      lda BufferedJoystick
      lsr
      lsr
      lsr
      lsr
      pha
      tay

      clc
      lda POS_Y_NEW
      adc JoyMoveY,y
      tay
      jsr GetBoardAddressRW

      pla
      tay

      clc
      lda POS_X_NEW
      adc JoyMoveX,y
      pha
      tay

    IF MULTI_BANK_BOARD = YES
                lda RAM_Bank
    ELSE
                lda #BANK_BOARD                 ; 2
    ENDIF
                jsr GetBoardCharacter           ;6+20(A)
                cmp #CHARACTER_DIAMOND
                beq canPush
                cmp #CHARACTER_BLANK
                bne cannotPush

canPush         pla
                tay

                inc ManPushCounter
                lda ManPushCounter
                eor #PUSH_LIMIT
                bne cannotPush2                         ; nice 'get to 0' optimisation
                sta ManPushCounter

    IF MULTI_BANK_BOARD = YES
                ldx RAM_Bank
    ELSE
                ldx #BANK_BOARD                 ; 2
    ENDIF
                lda #CHARACTER_BOX
                jsr PutBoardCharacter           ;6+21(A)

                ldx POS_Y_NEW
                stx POS_Y
                ldy POS_X_NEW
                sty POS_X

                jsr BlankOriginalLocationXY       ;6+87[-2](A)        and stacks newly blank position for checking -- also causing boulder to fall!

                START_SOUND SOUND_BOULDER

                lda BufferedButton                   ; button pressed?
                bpl PushWithButton
                jmp MovePlayer              ; now there's a gap, player should move in

cannotPush      pla
                ;lda #0
                ;sta ManPushCounter
PushWithButton
cannotPush2
timeout
                rts

Bango
                jsr BigBang                         ;6+1732[-58](B)
                bcc timeout                         ;2/3

                jmp NextObject                      ;??? >-- should be OK. Creature dies.

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE PROCESS_FLUTTERBY ;=521[-32](B) if moving worst case
    DEFINE_SUBROUTINE PROCESS_FIREFLY

                lda INTIM                       ;4
                cmp #SEGTIME_BUTTERFLY          ;2
                bcc timeout                     ;2/3
                STRESS_TIME SEGTIME_BUTTERFLY


    ; The butterfly and firefly are wall-huggers.
    ; Algorithm:  current direction (0-3) encoded in POS_VAR.  +8 for fireflies.
    ; Butterfly: Try to turn right (direction++&3). Now try to move forward.
    ; If no move, then repeat above for all directions.
    ; Firefly: same as above, but turning anti-clockwise.

                jsr GetSurroundingChars         ;6+161[-28](C) (return BANK is OK)

    ; Check surrounding squares for proximity to anything that causes butterfly/firefly
    ; to explode.  These include man, amoeba.

;                ldx Surround                    ;3
                lda GenericCharFlag,x           ;4
                ldx Surround+1                  ;3
                ora GenericCharFlag,x           ;4
                ldx Surround+2                  ;3
                ora GenericCharFlag,x           ;4
                ldx Surround+3                  ;3
                ora GenericCharFlag,x           ;4 = 25

    ;TODO: here we could check if we've hit the man (via GenericCharFlag) and trigger a manual kill
    ; so even if the man doesn't check the squares he DOES know he's dead.

                and #GENERIC_MASK_KILLSBUTTERFLY;2
                bne Bango                       ;2/3               (-> 206@Bango)

    ; If the butterfly/firefly board character is not the object's type -- something must have
    ; happened (eg: boulder/diamond falling, man moving) and so the object should die.

                ldx Surround+4                  ;3     current position
                lda CharToType,x                ;4
                cmp POS_Type                    ;3
                bne Bango                       ;2/3

                ldy POS_VAR                     ;3     Current movement direction
                lda Directional,y               ;4
                tax                             ;2
                and #3                          ;2
                tay                             ;2
                lda Surround,y                  ;4
                beq MoveThatWay                 ;2/(3+277[-4](B))

    ; Failed to turn, try to go straight ahead

                lda POS_VAR                     ;3
                and #3                          ;2
                tay                             ;2
                lda Surround,y                  ;4
                beq MoveThatWayStraight         ;2/(3+274[-4](B))

    ; turn LEFT, as we can't turn right or go straight ahead

                ldy POS_VAR                     ;3
                lda Directional+2,y             ;4
                sta POS_VAR                     ;3
                jmp ReInsertObject              ;3+98(B)        (animation now happens automatically)

    ;------------------------------------------------------------------------------
MoveThatWay ;=276[-4](B)

                stx POS_VAR                     ;3

MoveThatWayStraight ;=273[-4](B)

                jsr BlankOriginalLocation       ;6+93[-2](A)

                lda POS_VAR                     ;3
                and #3                          ;2
                tax                             ;2

                clc                             ;2
                lda POS_Y                       ;3
                adc RDirY,x                     ;4
                sta POS_Y                       ;3

                tay                             ;2

                lda BoardLineStartLO,y          ;4
                sta Board_AddressW              ;3
                lda BoardLineStartHiW,y         ;4
                sta Board_AddressW+1            ;3              WRITE address

                clc                             ;2
                lda POS_X                       ;3
                adc RDirX,x                     ;4
                sta POS_X                       ;3

    IF MULTI_BANK_BOARD = YES
                ldx BoardBank,y                 ;4              switch this on return
    ELSE
                ldx #BANK_BOARD                 ;2
    ENDIF
                tay                             ;2              a == POS_X
                lda Surround+4                  ;3
                jmp PutBoardCharacterButterfly  ;3+110[-2](B)


   ;------------------------------------------------------------------------------

; IF the creature runs out of time to do stuff, then rts HOWEVER the creature must eventually do something
;  as it will be continually called in available time-slices until it does. This can lockup the system.

; if the creature is done, and is alive next cycle, then jump ReInsertObject

; if the creature dies then jump NextObject



RDirY           .byte -1    ;,0,1,0
RDirX           .byte 0,1   ;,0,-1
DirPushModX      .byte 0,-1,1,0
DirPushModY      .byte -1,0,0,1
Directional     .byte 1,2,3,0,1,2, 0,0, 11,8,9,10,11,8


    ;------------------------------------------------------------------------------

; Thomas, the auto-calculation of these was causing DASM to get confused and abort assembling.
; I don't particularly know why; probably because of the cave variable-size array and the values
; changing from pass to pass. I've put in the hardwired values and it seems to be OK now.

MANMODE_STARTUP     = 0
MANMODE_NORMAL      = 1
MANMODE_DEAD        = 2
MANMODE_WAITING     = 3
MANMODE_WAITING2    = 4
MANMODE_WAITING_NT  = 5
MANMODE_WAITING_NT2 = 6
MANMODE_NEXTLEVEL   = 7
MANMODE_BONUS_START = 8
MANMODE_BONUS_RUN   = 9

    DEFINE_SUBROUTINE ManProcess ; in INITBANK

                lda #$FF
                sta specialTimeFlag             ; detects time overflow in bigbang (and diamond grab)


    ; ManMode tells the player what it is currently doing.  State machine.

                lda SWCHB
                and #3
                bne .skipReset          ; BOTH select/reset = restart

;                lsr SWCHB
;                bcs .skipReset

    IF F1F2NEXTCAVE=YES
                lda #MANMODE_NEXTLEVEL
                sta ManMode
    ELSE
                jmp Restart                     ; RESET = end game, jump to title screen
    ENDIF

.skipReset:

                ldy ManMode
                ;sok lda ManActionTimer,y
                ;sok beq .skipTimer
                ;sok jsr UpdateTimer
.skipTimer:
                ldy ManMode
                lda ManActionLO,y
                sta actionVector
                lda ManActionHI,y
                sta actionVector+1
                jmp (actionVector)

ManActionTimer
                .byte 0 ;<manStartup            ; 0             no timer
                .byte 1 ;<normalMan             ; 1             timer
                .byte 1 ;<deadMan               ; 2             timer
                .byte 1 ;<waitingMan            ; 3             timer
                .byte 1 ;<waitingManPress       ; 4             timer
                .byte 0 ;<waitingManNoTim       ; 5             no timer
                .byte 0 ;<waitingManPressNoTim  ; 6             no timer
                .byte 0 ;<nextLevelMan          ; 7             no timer
                .byte 2 ;<BonusCountdownStart   ; 8             fast timer
                .byte 2 ;<BonusCountdownRun     ; 9             fast timer
ManActionLO
                .byte <manStartup               ; 0             no timer
                .byte <normalMan                ; 1             timer
                .byte <deadMan                  ; 2             timer
                .byte <waitingMan               ; 3             timer
                .byte <waitingManPress          ; 4             timer
                .byte <waitingMan               ; 5             no timer
                .byte <waitingManPress          ; 6             no timer
                .byte <nextLevelMan             ; 7             no timer
                .byte <BonusCountdownStart      ; 8             fast timer
                .byte <BonusCountdownRun        ; 9             fast timer

ManActionHI
                .byte >manStartup               ; no timer
                .byte >normalMan                ; timer
                .byte >deadMan                  ; timer
                .byte >waitingMan               ; timer
                .byte >waitingManPress          ; timer
                .byte >waitingMan               ; no timer
                .byte >waitingManPress          ; no timer
                .byte >nextLevelMan             ; no timer
                .byte >BonusCountdownStart      ; fast timer
                .byte >BonusCountdownRun        ; fast timer

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE UpdateTimer

                ldx #3
                lda ManMode
                cmp #MANMODE_BONUS_RUN
                beq .setLoops

                ldx #NUM_LEVELS-1               ; intermissions run at full speed
                bit caveDisplay
                bmi .intermission2
                ldx level
.intermission2
                lda TimeFracTbl,x
                bit LookingAround
                bpl notSlowTime
                lda #0                           ; new behaviour: time does not count down when looking around
                ;lsr                             ; go half-speed time countdown when looking around
notSlowTime
                adc caveTimeFrac
                sta caveTimeFrac
                bcc .forceTimeDraw

; count down magic wall time in sync with cave time:
                ldx MagicAmoebaFlag
                inx                             ; $FF = dormant?
                beq .notActive
                dec MagicAmoebaFlag
.notActive
                ldx #1
.setLoops
                stx timerLoops
                bne .notScoring
.loopTimer
                lda level                       ; each second left adds 'level' to score
                clc
                adc #1
                jsr ScoreAdd
.notScoring
                sed
                sec
                lda caveTime
                sbc #1
                sta caveTime
                cld
                bcs .skipHi2a
                dec caveTimeHi
.skipHi2a
; check for running out of time sound:
                lda caveTimeHi
                bne .timeAbove9
                lda #$09
                sec
                sbc caveTime
                bcc .timeAbove9
; this assumes that SND_MASK_HI = %11110000
;  and the time entries are ordered 9 to 0!
                asl
                asl
                asl
                asl
                adc #SOUND_TIME_9
                sta tmpSound
                lda newSounds
                and #<(~SND_MASK_HI)
                ora tmpSound
                sta newSounds
.skipTimeSound:
                ldx caveTime
                bne .timeNotZero
                stx AUDV0                       ; stop bonus sound
                stx soundIdxLst
.contChannel1:
                ldx #MANMODE_NEXTLEVEL          ; time bonus
                lda ManMode
                cmp #MANMODE_BONUS_RUN
                beq .nextLevel
                ldx #MANMODE_WAITING_NT2        ; time over
                cmp #MANMODE_WAITING2           ; Man already dead?
                beq .nextLevel
                dex                             ; == MANMODE_WAITING_NT
.nextLevel
                stx ManMode                     ; -> man dies, but no explosion
.timeNotZero:
.forceTimeDraw
                lda #BANK_SCORING
                jmp DrawTimeFromROM             ; Z-flag == 0!

.timeAbove9
                dec timerLoops
                bne .loopTimer
                beq .forceTimeDraw

TimeFracTbl:
    .byte   31  ; level 1, NTSC/PAL
    .byte   27  ; level 2, NTSC/PAL
    .byte   24  ; level 3, NTSC/PAL
    .byte   23  ; level 4, NTSC/PAL
    .byte   22  ; level 5, NTSC/PAL
; calculate: level 5 throttle * level 5 time / level x throttle


    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE manStartup

                lda ManX
                sta POS_X_NEW ;NewX
                sta POS_X
                lda ManY
                sta POS_Y_NEW ;NewY
                sta POS_Y

                inc POS_VAR
                ldx POS_VAR                 ; animation index
                lda .RockfordStartup-1,x
                bmi CreateRockford
                sta POS_Type

; check for start of "crack" sound:
                cmp #CHARACTER_EXPLOSION3   ; first explosion frame?
                bne .skipCrack1
                START_SOUND SOUND_CRACK     ;  yes, start "crack" sound
.skipCrack1:
                lda #$FF
                sta ManDelayCount           ; anything, just non-0

                jmp PutBoardCharacterFromRAM    ;70 --> switches this bank out but who cares!

CreateRockford
                inc ManMode                 ; --> MANMODE_NORMAL
RTS_CF
                rts

.RockfordStartup
;    .byte CHARACTER_NOGO
;    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
    .byte CHARACTER_STEEL
    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
    .byte CHARACTER_NOGO
    .byte CHARACTER_STEEL
    ;.byte CHARACTER_NOGO
    .byte CHARACTER_EXPLOSION3
    ;.byte CHARACTER_EXPLOSION
    .byte CHARACTER_EXPLOSION2
    .byte CHARACTER_EXPLOSION1
    .byte CHARACTER_MANOCCUPIED
    .byte -1

    ;------------------------------------------------------------------------------

waitingMan      dec ManDelayCount

                lda #0
                sta LookingAround
                sta BGColour

    ; Wait for button to be RELEASED first!

                lda BufferedButton
                bpl noChange
                inc ManMode

    ; Man loses a life and re-starts level if lives available
    ; Special-case: Bonus levels go to next level.

                lda caveDisplay
                bmi intermission                ; don't lose a life on intermission screens
    IF NUM_LIVES != -1
                dec MenCurrent                  ; works for P1P2 format
    ; display lives after a live is lost
                lda scoringFlags                ;
                and #~DISPLAY_FLAGS
                ora #DISPLAY_LIVES
                sta scoringFlags                ;
    ENDIF
                jsr goGeneralScoringSetups      ; update the life display. Roundabout way of doing it.
intermission

                lda #120                        ; something long.  anything.
                sta scoringTimer                ; first time through we wait on the current display

waitingManPress

    ; Cycle the score display, player display, level display based on timing
    ; see "Scoring timer" reset stomp comment in bank_generic.

                lda scoringTimer
                cmp #10                         ; non-zero so we don't get stomped on by the scoring reset in
                bcs stillKicking
                lda #90                         ; something long.  anything.
                sta scoringTimer

                lda MenCurrent
                and #$0f
                cmp #$01
                ldx scoringFlags
                inx
                txa
    ; if game over for current player, display diamonds/time, score, player/lives/cave and high score
                and #$f3
                bcc gameOver
    ; else display diamonds/time and score only
                and #$f1
gameOver        sta scoringFlags                ;

                jsr goGeneralScoringSetups      ; update the score display.

stillKicking

                lda BufferedButton                   ; button pressed?
                bmi noChange

                STOP_CHANNEL 1              ; stop all long running sounds

    ; If it's a bonus level, even though we've died... we go to the next cave

                lda caveDisplay
                bpl nonextlevel
                ldx #MANMODE_NEXTLEVEL
                stx ManMode
                rts


nonextlevel     lda NextLevelTrigger
                ora #BIT_NEXTLIFE
                sta NextLevelTrigger

noChange        rts

    ;------------------------------------------------------------------------------
    ; Normal man state


normalMan

    ; Timer is still running, so we see if the player is to die for any reason

                bit demoMode
                bmi stayAlive
    ; SELECT pressed?
                lda SWCHB
                eor #$FF
                and #3
                bne Time0                       ; EITHER select or reset are pressed
;                lsr
;                lsr
;                bcc Time0                       ; suicide!
stayAlive

    ;------------------------------------------------------------------------------

                ldx ManY
                ldy ManX

                lda BoardLineStartLO,x
                sta Board_AddressR
                lda BoardLineStartHiR,x
                sta Board_AddressR+1

    IF MULTI_BANK_BOARD = YES
                lda BoardBank,x                 ;4
                sta RAM_Bank                    ;3
    ELSE
                lda #BANK_BOARD                 ;2
    ENDIF
                jsr GetBoardCharacter           ;6+20(A)

                lda CharToType,x
                cmp #TYPE_MAN
                beq PlayerAlive

    ; character he's on isn't a MAN character, so he dies...

Time0

                inc ManMode                   ; #1 -- player dead!


    ; the dead man creates an explosion...
    ; note, if we get a segtime problem, this code will re-execute OK

deadMan         lda ManX
                sta POS_X
                lda ManY
                sta POS_Y

                jsr BlankPlayerFrame

                jsr BigBang
                ror specialTimeFlag
                bpl timeTooShortToDie           ; wait until next time around

    ; and becomes a man waiting for resurrection...

                inc ManMode

timeTooShortToDie
                rts

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE BonusCountdownStart
                inc ManMode                                     ; waiting for countdown to complete

                START_SOUND SOUND_BONUS_POINTS                  ; one-off trigger of bonus countdown sound

                lda #AnimateSTAND-Manimate
                sta ManAnimation
                ;lda #>AnimateSTAND
                ;sta ManAnimation+1


                rts

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE BlankPlayerFrame

                lda #AnimateBLANK-Manimate
                sta ManAnimation
                ;lda #>AnimateBLANK
                ;sta ManAnimation+1
                lda #0
                sta ManDelayCount
                ;rts

    ; do NOT fall through!  Above removed just while there's a plain rts following...

    ;------------------------------------------------------------------------------
    DEFINE_SUBROUTINE BonusCountdownRun
                 rts

    ;------------------------------------------------------------------------------

;lookColour      .byte $b0,$02

    DEFINE_SUBROUTINE LookAround ; in INITBANK

                ;ldx Platform
                ;lda lookColour,x
                ;sta BGColour

    ; Use the joystick as a window-scroller to change the viewport

                lda BufferedJoystick
                lsr
                lsr
                lsr
                lsr
                tay

                lda JoyMoveX,y
                ;asl
                clc
                adc BoardScrollX
                cmp BoardEdge_Right
                bcs AbandonX
                sta BoardScrollX

AbandonX        lda JoyMoveY,y
                ;asl
                clc
                adc BoardScrollY
                cmp BoardEdge_Bottom
                bcs AbandonY
                sta BoardScrollY

AbandonY        rts




PlayerAlive

    ; Calling code uses 'POS_X_NEW' and 'POS_Y_NEW' as new player position, so these must be set
    ; before exiting via (for example) look-around option :)

                lda ManX
                sta POS_X_NEW
                lda ManY
                sta POS_Y_NEW


    ;------------------------------------------------------------------------------
    ; Look around is triggered by holding down the fire button for a while, without any other
    ; joystick directions chosen. The variable LookingAround has a negative value ($FF) when looking
    ; is active. Otherwise, it is counting down to the time where it will trigger.

LOOK_DELAY = 6

                ldx #LOOK_DELAY
                lda BufferedButton
                bmi noLook                      ; button?
                lda LookingAround
                bmi LookAround                  ; already looking
                lda BufferedJoystick
                cmp #$F0
                bcc noLook                      ; must have no directions chosen
                ldx LookingAround
                dex
noLook          stx LookingAround

    ;------------------------------------------------------------------------------

                ; control the scrolling via the joystick

                lda ManLastDirection
                and #DIRECTION_BITS
                tay

                lda BufferedJoystick                 ; joystick
                and BufferedJoystick+1

                ldx #0
.loopDirs       asl
                bcc .dirFound
                dey
                inx
                cpx #4
                bne .loopDirs
                clc
.dirFound
                lda POS_X_NEW ;NewX
                adc JoyDirX,x
                sta POS_X_NEW ;NewX
                lda POS_Y_NEW ;NewY
                clc
                adc JoyDirY,x
                sta POS_Y_NEW ;NewY

                tya
                beq noMovement                  ; animation OK

                txa
                eor ManLastDirection
                and #DIRECTION_BITS
                eor ManLastDirection
                sta ManLastDirection
                lda ManAnimTblLo,x
                sta ManAnimation
                ;lda ManAnimTblHi,x
                ;sta ManAnimation+1
                lda #0
                sta ManDelayCount
phase0          ;jsr MovePlayer
noMovement      ;ldx MAN_Player

DFS_rts         rts


ManAnimTblLo
    .byte   AnimateRIGHT-Manimate, AnimateLEFT-Manimate, AnimateUP-Manimate, AnimateUP-Manimate, AnimateSTOPPED-Manimate
;ManAnimTblHi
;    .byte   >AnimateRIGHT, >AnimateLEFT, >AnimateUP, >AnimateUP, >AnimateSTOPPED



JoyMoveX        .byte 0,0,0,0,0,1, 1,1,0,-1,-1,-1;,0, 0,0,0
JoyMoveY        .byte 0,0,0,0,0,1,-1,0,0, 1,-1;, 0,0,1,-1,0

JoyDirY
    .byte   0,0;,1,-1,0
JoyDirX
    .byte   1,-1,0,0,0


    ;------------------------------------------------------------------------------


    DEFINE_SUBROUTINE DrawFullScreen ; = 2568[-96]

    ; 83[-7] + 2484[-89] = 2567[-96]


                lda INTIM                       ; 4
                cmp #SEGTIME_BDF                ; 2
                bcc DFS_rts                     ; 2/3
                STRESS_TIME SEGTIME_BDF

                lda #>( DrawFlag + RAM_WRITE )  ; 2
                sta BDF_DrawFlagAddress+1       ; 3
                sta BDF_DrawFlagAddress2+1      ; 3

                tsx                             ; 2
                stx DHS_Stack                   ; 3

                inc ScreenDrawPhase             ; 5

                clc                             ; 2         required clear for DrawScreenRowPreparation
                ldx #SCREEN_LINES               ; 2
                txa                             ; 2 = 31

        ; fall through

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE DrawScreenRowPreparation ; = 52[-7]

                ;clc
                dex                             ; 2
                stx DHS_Line                    ; 3
                adc BoardScrollY                ; 3         the Y offset of screen into board
                tay                             ; 2 = 10

                ;clc
                lda BoardLineStartLO-1,y        ; 4         Y is one too big!
                adc BoardScrollX                ; 3         the X offset of screen into board
                sta BDF_BoardAddress            ; 3
                adc #SCREEN_WIDTH/2             ; 2
                sta BDF_BoardAddress2           ; 3

                lda BoardLineStartHiR-1,y       ; 4         a board line *WILL NOT CROSS* page boundary
                sta BDF_BoardAddress+1          ; 3
                sta BDF_BoardAddress2+1         ; 3 = 25

                lda DrawLineStartLO,x           ; 4
                sta BDF_DrawFlagAddress         ; 3
                adc #SCREEN_WIDTH/2             ; 2
                sta BDF_DrawFlagAddress2        ; 3 = 12

    IF MULTI_BANK_BOARD = YES
                lda BoardBank-1,y               ; 4
                sta BDF_BoardBank               ; 3
    ENDIF
                ldy #SCREEN_WIDTH/2-1           ; 2
                jmp CopyRow2                    ; 3 = 12[-7]

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE BigBang ;=1630[-85](B)
    ; requires a lot of complicated to calculate/test extra time if called from PROCESS_MAN!

    ; requires POS_X, POS_Y, POS_Type to be set
    ; returns C if time too short

                lda INTIM                       ;4
                cmp #SEGTIME_BIGBANG            ;2
                bcc AbortExplosion              ;2/3= 8         not enough processing time (carry important)

                STRESS_TIME SEGTIME_BIGBANG

                START_PRIO_SOUND SOUND_EXPLOSION;10= 10

                lda #CHARACTER_EXPLOSION        ;2
                ldx POS_Type                    ;3
                cpx #TYPE_FLUTTERBY             ;2
                bne noDiamExp                   ;2/3
                ora #$80                        ;2              butterfly generates diamond
noDiamExp       sta POS_VAR                     ;3 = 14         object type to become, identified by char

                lda #TYPE_EXPLOSION             ;2
                sta POS_Type                    ;3 =  5

                dec POS_X                       ;5
                dec POS_Y                       ;5
                jsr ExplodeADiamond             ;6+186(B)       @x-1,y-1
                inc POS_X                       ;5
                jsr ExplodeADiamondSameRow      ;6+161(B)       @x,  y-1
                inc POS_X                       ;5
                jsr ExplodeADiamondSameRow      ;6+161(B)       @x+1,y-1

                inc POS_Y                       ;5
                jsr ExplodeADiamond             ;6+186(B)       @x+1,y
                dec POS_X                       ;5
                jsr ExplodeADiamond0            ;6+118(B)       @x,  y
                dec POS_X                       ;5
                jsr ExplodeADiamondSameRow      ;6+161(B)       @x-1,y

                inc POS_Y                       ;5
                jsr ExplodeADiamond             ;6+186(B)       @x-1,y+1
                inc POS_X                       ;5
                jsr ExplodeADiamondSameRow      ;6+161(B)       @x,  y+1
                inc POS_X                       ;5
                jsr ExplodeADiamondSameRow      ;6+161(B)       @x+1,y+1

                sec                             ;2              flags to callee that creature processed OK
AbortExplosion
NotEnoughProcessTime
                rts                             ;6 =  8


ExplodeADiamond ;=186[-10](B)

    ; Explosions generate explode creatures.  This allows the explosion to progress over
    ; a series of frames. The explode creature subsequently dies and creates a diamond, or
    ; a blank, as appropriate.  Meanwhile, creatures cannot move into exploding squares.

    ; First check if the creature at this position may be exploded

                ldy POS_Y                       ;3
                lda BoardLineStartLO,y          ;4
                sta Board_AddressR              ;3
                sta Board_AddressW              ;3
                lda BoardLineStartHiR,y         ;4
                sta Board_AddressR+1            ;3              READ address
                ora #>RAM_WRITE                 ;2
                sta Board_AddressW+1            ;3 = 25         WRITE address

ExplodeADiamondSameRow ;=161[-10](B)

        IF MULTI_BANK_BOARD = YES
                ldy POS_Y                       ;3              we could save another 9 cycles here at the cost of 10 bytes
                lda BoardBank,y                 ;4              switch this on return
        ELSE
                lda #BANK_BOARD                 ;2
        ENDIF
                ldy POS_X                       ;3
                jsr GetBoardCharacter           ;6+20(A)        sets RAM bank, ROM bank, needs Board_AddressR

                lda GenericCharFlag,x           ;3
                and #GENERIC_MASK_EXPLODABLE    ;2
                beq AbortExplosion              ;2/3=43[-5]

    ; It can, so draw an explosion in the square and create an explosion object

ExplodeADiamond0 ;=118[-5](B)

    ; The following puts immediate explosion characters onscreen. This reduces the visual
    ; delay before the explosion creature(s) activate and draw themselves.

    ; Actually... consider a firefly/butterfly which is next to the player.  The firefly
    ; checks and finds the player there, so it decides to explode.  Gets to here. But the
    ; player moves away in the very same cycle (AFTER the firefly/butterfly). He's now one
    ; away and escapes the (next frame) explosion. By putting in the explosion characters
    ; immediately, we make sure that the player blows up too.

        IF MULTI_BANK_BOARD = YES
                ldy POS_Y                       ;3
                ldx BoardBank,y                 ;4              switch this on return
        ELSE
                ldx #BANK_BOARD                 ;2
        ENDIF
                ldy POS_X                       ;3
                lda #CHARACTER_EXPLOSION        ;2
                jsr PutBoardCharacter           ;6+21(A)=39[-5] write new post-explosion character, sets RAM bank, ROM bank, needs Board_AddressW


    ; Create the explosion object.  Note that POS_VAR tells it what sort of object it
    ; becomes, once it has finished its delay processing.

                jmp InsertObjectStack           ;3+76(B)        place on stack so it stays alive

    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE VectorProcess ;=19(A)

                ;sta ROM_Bank                    ;3              processors can assume bank is stored

                lda OSPointerHI,x               ;4
                sta POS_Vector+1                ;3
                lda OSPointerLO,x               ;4
                sta POS_Vector                  ;3

                jmp (POS_Vector)                ;5 = 19         vector to processor for particular object type
                                                ;               NOTE: Bank is either INITBANK or FIXED.


OBJTYPE    SET 0
    MAC DEFINE
TYPE_{1}    = OBJTYPE
OBJTYPE    .SET OBJTYPE + 1
    ENDM

        ; If adding/removing types, the following must also be updated...
        ;   InitialFace[...]                in DecodeCave.asm
        ;   BaseTypeCharacter[...]          in BANK_FIXED.asm
        ;   BaseTypeCharacterFalling[...]   in BANK_FIXED.asm
        ;   OSPointerLO[...]                in BANK_INITBANK.asm
        ;   OSPointerHI[...]                in BANK_INITBANK.asm
        ;   CharReplacement[...]            in BANK_ROM_SHADOW_DRAWBUFFERS.asm
        ;   CharToType[...]                 in BANK_FIXED.asm (may have deleted types)
        ;   CharToType2[...]                in DecodeCave.asm (may have deleted types)
        ;   Sortable[...]                   in BANK_FIXED.asm


                DEFINE MAN
                DEFINE BOULDER
                DEFINE AMOEBA
                DEFINE FLUTTERBY
                DEFINE FIREFLY
                DEFINE DIAMOND
                DEFINE MAGICWALL
                DEFINE EXITDOOR
                DEFINE SELECTOR
                DEFINE EXPLOSION
                DEFINE EXPLOSION1
                DEFINE EXPLOSION2
                DEFINE EXPLOSION3
                DEFINE BLANK
                DEFINE SOIL
                DEFINE STEELWALL
                DEFINE BRICKWALL

                DEFINE MAXIMUM
;    IF DEMO_VERSION = NO
;PROCESS_SELECTOR = 0
;    ENDIF


    DEFINE_SUBROUTINE OSPointerLO
                .byte <PROCESS_MAN
                .byte <PROCESS_BOULDER
                .byte 0 ;<PROCESS_AMOEBA
                .byte <PROCESS_FLUTTERBY
                .byte <PROCESS_FIREFLY
                .byte <PROCESS_DIAMOND
                .byte 0                         ; magic wall
                .byte 0                         ; exit door
                .byte 0 ;<PROCESS_SELECTOR         ; selection screen controller
                .byte <PROCESS_EXPLOSION
                .byte <PROCESS_EXPLOSION
                .byte <PROCESS_EXPLOSION
                .byte <PROCESS_EXPLOSION
;                .byte 0
;                .byte 0                         ; soil
;                .byte 0                         ; steel
;                .byte 0                         ; wall

    IF * - OSPointerLO < TYPE_MAXIMUM-4
        ECHO "ERROR: Missing entry in OSPointerLO table!"
        EXIT
    ENDIF


    DEFINE_SUBROUTINE OSPointerHI
                .byte >PROCESS_MAN
                .byte >PROCESS_BOULDER
                .byte 0 ;>PROCESS_AMOEBA
                .byte >PROCESS_FLUTTERBY
                .byte >PROCESS_FIREFLY
                .byte >PROCESS_DIAMOND
                .byte 0 ;>PROCESS_MAGICWALL
                .byte 0                         ; exit door
                .byte 0 ;>PROCESS_SELECTOR         ; selection screen controller
                .byte >PROCESS_EXPLOSION
                .byte >PROCESS_EXPLOSION
                .byte >PROCESS_EXPLOSION
                .byte >PROCESS_EXPLOSION
;                .byte 0
;                .byte 0 ;soil
;                .byte 0 ;steel
;                .byte 0 ;wall

    IF * - OSPointerHI < TYPE_MAXIMUM-4
        ECHO "ERROR: Missing entry in OSPointerHI table!"
        EXIT
    ENDIF

;       IF TIMER_DEBUG = NO
;    DEFINE_SUBROUTINE OSTimer
;                .byte SEGTIME_MAN
;                .byte SEGTIME_BOULDER1
;                .byte SEGTIME_AMOEBASQUARE
;                .byte SEGTIME_BUTTERFLY
;                .byte SEGTIME_FIREFLY
;                .byte SEGTIME_BOULDER1
;                .byte 0                ; MAGICWALL
;                .byte 0                 ; exit door
;                .byte 0                    ; selection screen controller (no timer)
;                .byte SEGTIME_EXPLOSION
;                .byte SEGTIME_EXPLOSION
;                .byte SEGTIME_EXPLOSION
;                .byte SEGTIME_EXPLOSION
;;                .byte 0
;;                .byte 0 ;soil
;;                .byte 0 ;steel
;;                .byte 0 ;wall
;
;    IF * - OSTimer < TYPE_MAXIMUM-4
;        ECHO "ERROR: Missing entry in OSTimer table!"
;        EXIT
;    ENDIF
;       ENDIF


    ;------------------------------------------------------------------------------

    DEFINE_SUBROUTINE MoveVecLO ; [character type]

                .byte <MOVE_BLANK
                .byte <MOVE_SOIL
                .byte <MOVE_BOULDER
                .byte <MOVE_GENERIC             ;amoeba
                .byte <MOVE_DIAMOND
                .byte <MOVE_DIAMOND
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_EXIT
                .byte <MOVE_EXIT

                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC
                .byte <MOVE_GENERIC             ; amoeba???

                .byte <MOVE_GENERIC             ; falling boulder
                .byte <MOVE_GENERIC             ; falling diamond

                .byte <MOVE_GENERIC             ; unkillable man

    IF * - MoveVecLO < CHARACTER_MAXIMUM
        ECHO "ERROR: Missing entry in MoveVecLO table!"
        EXIT
    ENDIF



    DEFINE_SUBROUTINE MoveVecHI ;[character type]

                .byte >MOVE_BLANK
                .byte >MOVE_SOIL
                .byte >MOVE_BOULDER
                .byte >MOVE_GENERIC             ;amoeba
                .byte >MOVE_DIAMOND
                .byte >MOVE_DIAMOND
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_EXIT
                .byte >MOVE_EXIT

                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC
                .byte >MOVE_GENERIC             ;amoeba

                .byte >MOVE_GENERIC             ; falling boulder
                .byte >MOVE_GENERIC             ; falling diamond

                .byte >MOVE_GENERIC             ; unkillable man

    IF * - MoveVecLO < CHARACTER_MAXIMUM
        ECHO "ERROR: Missing entry in MoveVecLO table!"
        EXIT
    ENDIF


    CHECK_BANK_SIZE "INITBANK"

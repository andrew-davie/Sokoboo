; Cave definitions

.DIR_UP             = 0
.DIR_RIGHT          = 2
.DIR_DOWN           = 4
.DIR_LEFT           = 6


    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE TRACKS

    .byte   $0A                                 ; Cave 10 J
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $25 ;BCD'd $19                                 ; Diamonds worth: 25 points
    .byte   $60 ;BCD'd $3C                                 ; Extra diamonds worth: 60 points
    .byte   $00, $00, $00, $00, $00             ; Randomiser seed values for difficulty levels 1-5
    IF TEST_BONUS_COUNTDOWN = YES
        .byte   $01, $01, $01, $01, $01
    ELSE
        .byte   $0C, $0C, $0C, $0C, $0C             ; Diamonds needed: 12, 12, 12, 12, 12 (for difficulty levels 1-5)
    ENDIF


    .byte   $96, $82, $78, $6E, $64             ; Cave time: 150, 130, 120, 110, 100 seconds


;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $26, $26
        .byte   $76, $c4
        .byte   $be, $7e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $26, $26
            .byte   $76, $c4
            .byte   $be, $7e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $26, $26
            .byte   $76, $c4
            .byte   $be, $7e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   $00, $00, $00, $00                  ; Random objects:
    .byte   $00, $00, $00, $00                  ;   first code unused (0%)
                                                ;   second code unused (0%)
                                                ;   third code unused (0%)
                                                ;   fourth code unused (0%)
    .byte   CHARACTER_MANOCCUPIED, $0D, $03               ; StoreChar zPRFd1 at (13, 3)

    IF TEST_BONUS_COUNTDOWN = YES
        .byte   CHARACTER_EXITDOOR, $19, 3                   ; StoreChar zPreOut at (39,22)
    ELSE
        .byte   CHARACTER_EXITDOOR, $27, $16                   ; StoreChar zPreOut at (39,22)
    ENDIF



    .byte   LINE+CHARACTER_DIAMOND, $05, $04, $11, $03 ; Line of zDiaS from ( 5, 4); length = 17; direction = down/right
    .byte   LINE+CHARACTER_DIAMOND, $15, $04, $11, $05 ; Line of zDiaS from (21, 4); length = 17; direction = down/left
    .byte   FILL+CHARACTER_BLANK, $05, $0B, $11, $03, CHARACTER_FIREFLY; FilledRect of zSpace from ( 5,11); length = 17; height = 3; fill = zFFly1
    .byte   RECT+CHARACTER_WALL, $01, $04, $15, $11    ; Rect of zBrick from ( 1, 4); length = 21; height = 17
    .byte   CHARACTER_BLANK, $0D, $04                  ; StoreChar zSpace at (13, 4)
    .byte   RECT+CHARACTER_WALL, $07, $06, $0D, $0D    ; Rect of zBrick from ( 7, 6); length = 13; height = 13
    .byte   CHARACTER_BLANK, $0D, $06                  ; StoreChar zSpace at (13, 6)
    .byte   RECT+CHARACTER_WALL, $09, $08, $09, $09    ; Rect of zBrick from ( 9, 8); length = 9; height = 9
    .byte   CHARACTER_BLANK, $0D, $08                  ; StoreChar zSpace at (13, 8)
    .byte   RECT+CHARACTER_WALL, $0B, $0A, $05, $05    ; Rect of zBrick from (11,10); length = 5; height = 5
    .byte   CHARACTER_BLANK, $0D, $0A                  ; StoreChar zSpace at (13,10)
    .byte   FILL+CHARACTER_WALL, $03, $06, $03, $0F, CHARACTER_FIREFLY; FilledRect of zBrick from ( 3, 6); length = 3; height = 15; fill = zFFly1
    .byte   CHARACTER_BLANK, $04, $06                  ; StoreChar zSpace at ( 4, 6)
    .byte   LINE+CHARACTER_DIAMOND, $04, $10, $04, $04 ; Line of zDiaS from ( 4,16); length = 4; direction = down

    END_CAVE TRACKS
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE CROWD

    .byte   $0B                                 ; Cave 11 K
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $50 ;BCD'd $32                                 ; Diamonds worth: 50 points
    .byte   $00                                 ; Extra diamonds worth: 0 points
    .byte   $00, $04, $66, $97, $64             ; Randomiser seed values for difficulty levels 1-5
    .byte   $06, $06, $06, $06, $06             ; Diamonds needed: 6, 6, 6, 6, 6 (for difficulty levels 1-5)
    .byte   $78, $78, $96, $96, $F0             ; Cave time: 120, 120, 150, 150, 240 seconds


;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $26, $48
        .byte   $04, $16
        .byte   $9e, $be
     ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $26, $48
            .byte   $04, $16
            .byte   $9e, $be
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $26, $48
            .byte   $04, $16
            .byte   $9e, $be
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------



    .byte   CHARACTER_BLANK                            ; Random objects:
    .byte   CHARACTER_BOX
    .byte   CHARACTER_FIREFLY
    .byte   CHARACTER_BLANK
    .byte   $64, $50, $02, $00                  ;   zSpace : 100/256 = 39%
                                                ;   zBouS  :  80/256 = 31%
                                                ;   zFFly1 :   2/256 =  0%
                                                ;   fourth code unused (0%)
    .byte   LINE+CHARACTER_WALL, $0A, $03, $09, $04    ; Line of zBrick from (10, 3); length = 9; direction = down
    .byte   LINE+CHARACTER_WALL, $14, $03, $09, $04    ; Line of zBrick from (20, 3); length = 9; direction = down
    .byte   LINE+CHARACTER_WALL, $1E, $03, $09, $04    ; Line of zBrick from (30, 3); length = 9; direction = down
    .byte   LINE+CHARACTER_WALL, $09, $16, $09, $00    ; Line of zBrick from ( 9,22); length = 9; direction = up
    .byte   LINE+CHARACTER_WALL, $0C, $0F, $11, $02    ; Line of zBrick from (12,15); length = 17; direction = right
    .byte   LINE+CHARACTER_WALL, $05, $0B, $09, $02    ; Line of zBrick from ( 5,11); length = 9; direction = right
    .byte   LINE+CHARACTER_WALL, $0F, $0B, $09, $02    ; Line of zBrick from (15,11); length = 9; direction = right
    .byte   LINE+CHARACTER_WALL, $19, $0B, $09, $02    ; Line of zBrick from (25,11); length = 9; direction = right
    .byte   LINE+CHARACTER_WALL, $1C, $13, $0B, $01    ; Line of zBrick from (28,19); length = 11; direction = up/right
    .byte   CHARACTER_DIAMOND, $04, $03                ; StoreChar zDiaS at ( 4, 3)
    .byte   CHARACTER_DIAMOND, $0E, $03                ; StoreChar zDiaS at (14, 3)
    .byte   CHARACTER_DIAMOND, $18, $03                ; StoreChar zDiaS at (24, 3)
    .byte   CHARACTER_DIAMOND, $22, $03                ; StoreChar zDiaS at (34, 3)
    .byte   CHARACTER_DIAMOND, $04, $16                ; StoreChar zDiaS at ( 4,22)
    .byte   CHARACTER_DIAMOND, $23, $15                ; StoreChar zDiaS at (35,21)
    .byte   CHARACTER_MANOCCUPIED, $14, $14               ; StoreChar zPRFd1 at (20,20)
    .byte   CHARACTER_EXITDOOR, $26, $11                   ; StoreChar zPreOut at (38,17)

    END_CAVE CROWD
    ENDIF
        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE WALLS

    .byte   $0C                                 ; Cave 12 L
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $20 ;BCD'd $14                                 ; Diamonds worth: 20 points
    .byte   $00                                 ; Extra diamonds worth: 0 points
    .byte   $00, $3C, $02, $3B, $66             ; Randomiser seed values for difficulty levels 1-5
    .byte   $13, $13, $0E, $10, $15             ; Diamonds needed: 19, 19, 14, 16, 21 (for difficulty levels 1-5)
    .byte   $B4, $AA, $A0, $A0, $A0             ; Cave time: 180, 170, 160, 160, 160 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
    .byte   $46, $66
    .byte   $06, $18
    .byte   $ae, $7e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $46, $66
            .byte   $06, $18
            .byte   $ae, $7e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $46, $66
            .byte   $06, $18
            .byte   $ae, $7e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   $00, CHARACTER_BOX, CHARACTER_DIAMOND, $00                  ; Random objects:
    .byte   $3C, $32, $09, $00                  ;   zSpace :  60/256 = 23%
                                                ;   zBouS  :  50/256 = 19%
                                                ;   zDiaS  :   9/256 =  3%
                                                ;   fourth code unused (0%)

    .byte   LINE+CHARACTER_WALL, $0A, $05, $12, $04    ; Line of zBrick from (10, 5); length = 18; direction = down
    .byte   LINE+CHARACTER_WALL, $0E, $05, $12, $04    ; Line of zBrick from (14, 5); length = 18; direction = down
    .byte   LINE+CHARACTER_WALL, $12, $05, $12, $04    ; Line of zBrick from (18, 5); length = 18; direction = down
    .byte   LINE+CHARACTER_WALL, $16, $05, $12, $04    ; Line of zBrick from (22, 5); length = 18; direction = down
    .byte   LINE+CHARACTER_WALL, $02, $06, $0B, $02    ; Line of zBrick from ( 2, 6); length = 11; direction = right
    .byte   LINE+CHARACTER_WALL, $02, $0A, $0B, $02    ; Line of zBrick from ( 2,10); length = 11; direction = right
    .byte   LINE+CHARACTER_WALL, $02, $0E, $0F, $02    ; Line of zBrick from ( 2,14); length = 15; direction = right
    .byte   LINE+CHARACTER_WALL, $02, $12, $0B, $02    ; Line of zBrick from ( 2,18); length = 11; direction = right
    .byte   FILL+CHARACTER_SOIL, $1E, $04, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (30, 4); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FIREFLY, $20, $05                ; StoreChar zFFly1 at (32, 5)
    .byte   FILL+CHARACTER_SOIL, $1E, $09, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (30, 9); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FIREFLY, $20, $0A                ; StoreChar zFFly1 at (32,10)
    .byte   FILL+CHARACTER_SOIL, $1E, $0E, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (30,14); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FIREFLY, $20, $0F                ; StoreChar zFFly1 at (32,15)
    .byte   CHARACTER_MANOCCUPIED, $03, $14               ; StoreChar zPRFd1 at ( 3,20)
    .byte   CHARACTER_EXITDOOR, $27, $16                   ; StoreChar zPreOut at (39,22)

    END_CAVE WALLS
    ENDIF

        ;------------------------------------------------------------------------------

    ;IFCONST CAVE_NAMED_APOCALYPSE
    START_CAVE APOCALYPSE

    .byte   $0D                                 ; Cave 13 M
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $8C                                 ; Magic wall/amoeba slow growth for: 140 seconds
    .byte   $05                                 ; Diamonds worth: 5 points
    .byte   $08                                 ; Extra diamonds worth: 8 points
    .byte   $00, $01, $02, $03, $04             ; Randomiser seed values for difficulty levels 1-5
    .byte   $32, $37, $3C, $46, $50            ; Diamonds needed: 50, 55, 60, 70, 80 (for difficulty levels 1-5)
 ;   .byte 30,35,40,45,50    ; modified goal due to fewer butterflies; TJ: reverted, now that we can have all 30

    .byte   $A0, $9B, $96, $91, $8C             ; Cave time: 160, 155, 150, 145, 140 seconds


;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $88, $c8
        .byte   $24, $24
        .byte   $cc, $7a
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $88, $c8
            .byte   $24, $24
            .byte   $cc, $7a
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $88, $c8
            .byte   $24, $24
            .byte   $cc, $7a
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------



    .byte   CHARACTER_BOX, $00, $00, $00                  ; Random objects:
    .byte   $28, $00, $00, $00                  ;   zBouS  :  40/256 = 15%
                                                ;   second code unused (0%)
                                                ;   third code unused (0%)
                                                ;   fourth code unused (0%)

    .byte   CHARACTER_MANOCCUPIED, $12, $03               ; StoreChar zPRFd1 at (18, 3)
    .byte   CHARACTER_EXITDOOR, $0A, $03                   ; StoreChar zPreOut at (10, 3)
    .byte   CHARACTER_AMOEBA, $14, $03                 ; StoreChar zAmoe at (20, 3)

;-----
; Modified version with fewer butterflies to allow apocalpyse to be playable for the demo
; Basically reduced the butterfly count significantly
   ;.byte   $70, $05, $13, $1E, $02            ; Line of zBFly1 from ( 5,19); length = 30; direction = right


    .byte   LINE+CHARACTER_WALL, $05, $12, $1E, $02    ; Line of zBrick from ( 5,18); length = 30; direction = right
    .byte   LINE+CHARACTER_FLUTTERBY, $05, $13, $1E, $02          ; Line of zBFly1 from ( 5,19); length = 30; direction = right
    .byte   LINE+CHARACTER_BOX, $05, $14, $1E, $02 ; Line of zBouS from ( 5,20); length = 30; direction = right
    .byte   RECT+CHARACTER_SOIL, $05, $15, $1E, $02    ; Rect of zDirt from ( 5,21); length = 30; height = 2

    END_CAVE APOCALYPSE
    ;ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE ZIGZAG

    .byte   $0E                                 ; Cave 14 N
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $10 ;BCD'd $0A                                 ; Diamonds worth: 10 points
    .byte   $20 ;BCD'd $14                                 ; Extra diamonds worth: 20 points
    .byte   $00, $00, $00, $00, $00             ; Randomiser seed values for difficulty levels 1-5
    .byte   $1E, $23, $28, $2A, $2D             ; Diamonds needed: 30, 35, 40, 42, 45 (for difficulty levels 1-5)
    .byte   $96, $91, $8C, $87, $82             ; Cave time: 150, 145, 140, 135, 130 seconds


;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $2A, $2A
        .byte   $66, $a4
        .byte   $ce, $5e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $2A, $2A
            .byte   $66, $a4
            .byte   $ce, $5e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $26, $46
            .byte   $04, $06
            .byte   $9e, $be
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   CHARACTER_BOX, $00, $00, $00                  ; Random objects:
    .byte   $00, $00, $00, $00                  ;   first code unused (0%)
                                                ;   second code unused (0%) ???
                                                ;   third code unused (0%) ???
                                                ;   fourth code unused (0%) ???

    .byte   FILL+CHARACTER_SOIL, $0A, $0A, $0D, $0D, CHARACTER_BLANK; FilledRect of zDirt from (10,10); length = 13; height = 13; fill = zSpace
    .byte   LINE+CHARACTER_FLUTTERBY, $0B, $0B, $0C, $03     ; Line of zBFly1 from (11,11); length = 12; direction = down/right
    .byte   RECT+CHARACTER_SOIL, $0C, $0A, $03, $0D    ; Rect of zDirt from (12,10); length = 3; height = 13
    .byte   RECT+CHARACTER_SOIL, $10, $0A, $03, $0D    ; Rect of zDirt from (16,10); length = 3; height = 13
    .byte   RECT+CHARACTER_SOIL, $14, $0A, $03, $0D    ; Rect of zDirt from (20,10); length = 3; height = 13
    .byte   LINE+CHARACTER_BOX, $16, $08, $0C, $02 ; Line of zBouS from (22, 8); length = 12; direction = right
    .byte   LINE+CHARACTER_FIREFLY, $16, $07, $0C, $02 ; Line of zFFly1 from (22, 7); length = 12; direction = right
    .byte   RECT+CHARACTER_SOIL, $17, $06, $03, $04    ; Rect of zDirt from (23, 6); length = 3; height = 4
    .byte   RECT+CHARACTER_SOIL, $1B, $06, $03, $04    ; Rect of zDirt from (27, 6); length = 3; height = 4
    .byte   RECT+CHARACTER_SOIL, $1F, $06, $03, $04    ; Rect of zDirt from (31, 6); length = 3; height = 4
    .byte   CHARACTER_MANOCCUPIED, $03, $03               ; StoreChar zPRFd1 at ( 3, 3)
    .byte   CHARACTER_EXITDOOR, $27, $14                   ; StoreChar zPreOut at (39,20)

;    .byte   LINE+CHARACTER_WALL, $01, $09, $1E, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right

    END_CAVE ZIGZAG
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE ENCHANTED_BOXES

    .byte   $10                                 ; Cave 16 P
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $10 ;BCD'd $0A                                 ; Diamonds worth: 10 points
    .byte   $20 ;BCD'd $14                                 ; Extra diamonds worth: 20 points
    .byte   $01, $78, $81, $7E, $7B             ; Randomiser seed values for difficulty levels 1-5
    .byte   $0C, $0F, $0F, $0F, $0C             ; Diamonds needed: 12, 15, 15, 15, 12 (for difficulty levels 1-5)
    .byte   $96, $96, $96, $96, $96             ; Cave time: 150, 150, 150, 150, 150 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
            .byte   $58, $68
            .byte   $24, $44
            .byte   $be, $9e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $58, $68
            .byte   $24, $44
            .byte   $be, $9e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $58, $68
            .byte   $24, $44
            .byte   $be, $9e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------

    .byte   CHARACTER_BOX, $00, $00, $00                  ; Random objects:
    .byte   $32, $00, $00, $00                  ;   zBouS  :  50/256 = 19%
                                                ;   second code unused (0%)
                                                ;   third code unused (0%)
                                                ;   fourth code unused (0%)
    .byte   CHARACTER_MANOCCUPIED, $01, $03               ; StoreChar zPRFd1 at ( 1, 3)
    .byte   CHARACTER_EXITDOOR, $27, $04                   ; StoreChar zPreOut at (39, 4)
    .byte   FILL+CHARACTER_SOIL, $08, $13, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from ( 8,19); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FIREFLY, $0A, $14                ; StoreChar zFFly1 at (10,20)
 IF SHOWDIAMONDP
     .byte   CHARACTER_DIAMOND, $08, $8                ; StoreChar zFFly1 at (10,20)
 ENDIF
    .byte   RECT+CHARACTER_WALL, $07, $0A, $06, $08    ; Rect of zBrick from ( 7,10); length = 6; height = 8
    .byte   LINE+CHARACTER_WALL0, $07, $0A, $06, $02   ; Line of zMagic from ( 7,10); length = 6; direction = right
    .byte   FILL+CHARACTER_SOIL, $10, $13, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (16,19); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FIREFLY, $12, $14                ; StoreChar zFFly1 at (18,20)
    .byte   RECT+CHARACTER_WALL, $0F, $0A, $06, $08    ; Rect of zBrick from (15,10); length = 6; height = 8
    .byte   LINE+CHARACTER_WALL0, $0F, $0A, $06, $02   ; Line of zMagic from (15,10); length = 6; direction = right
    .byte   FILL+CHARACTER_SOIL, $18, $13, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (24,19); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FIREFLY, $1A, $14                ; StoreChar zFFly1 at (26,20)
    .byte   FILL+CHARACTER_SOIL, $20, $13, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (32,19); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FIREFLY, $22, $14                ; StoreChar zFFly1 at (34,20)

    END_CAVE ENCHANTED_BOXES
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE INTERMISSION_1

    .byte   $11                                 ; Cave 17 I1
    CAVE_SIZE_INTERMISSION                      ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $30 ;BCD'd $1E                                 ; Diamonds worth: 30 points
    .byte   $00                                 ; Extra diamonds worth: 0 points
    .byte   $0A, $0B, $0C, $0D, $0E             ; Randomiser seed values for difficulty levels 1-5
    .byte   $06, $06, $06, $06, $06             ; Diamonds needed: 6, 6, 6, 6, 6 (for difficulty levels 1-5)
    .byte   $0A, $0A, $0A, $0A, $0A             ; Cave time: 10, 10, 10, 10, 10 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $28, $46
        .byte   $54, $a4
        .byte   $be, $5e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $28, $46
            .byte   $54, $a4
            .byte   $be, $7e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $28, $46
            .byte   $54, $a4
            .byte   $be, $7e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   $00, CHARACTER_DIAMOND, $00, $00                  ; Random objects:
    .byte   $FF, $09, $00, $00                  ;   zSpace : 255/256 = 99%
                                                ;   zDiaS  :   9/256 =  3%
                                                ;   third code unused (0%)
                                                ;   fourth code unused (0%)

;   superfluous due to limited cave size
;    .byte   FILL+CHARACTER_STEEL, $00, $02, $28, $16, CHARACTER_STEEL; FilledRect of zSteel from ( 0, 2); length = 40; height = 22; fill = zSteel
    .byte   FILL+CHARACTER_STEEL, $00, $02, $14, 9+3, CHARACTER_BLANK; FilledRect of zSteel from ( 0, 2); length = 20; height = 12; fill = zSpace
;    .byte   CHARACTER_FLUTTERBY2, $0A, $0C          ; StoreChar zBFly3 at (10,12)
;    .byte   CHARACTER_BOX, $0A, $05             ; StoreChar zBouS at (10, 4)
;    .byte   CHARACTER_SOIL, $0A, $6                 ; StoreChar zDirt at (10, 5)
;    .byte   CHARACTER_MANOCCUPIED, $03, $05         ; StoreChar zPRFd1 at ( 3, 5)
    .byte   CHARACTER_FLUTTERBY2, $05, $0C          ; StoreChar zBFly3 at (10,12)
    .byte   CHARACTER_BOX, $06, $07             ; StoreChar zBouS at (10, 4)
    .byte   CHARACTER_SOIL, $06, $8                 ; StoreChar zDirt at (10, 5)
    .byte   CHARACTER_MANOCCUPIED, $03, $b          ; StoreChar zPRFd1 at ( 3, 5)

    .byte   CHARACTER_EXITDOOR, $12, $0C            ; StoreChar zPreOut at (18,12)

    END_CAVE INTERMISSION_1
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE INTERMISSION_2

    .byte   $12                                 ; Cave 18
    CAVE_SIZE_INTERMISSION                      ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $10 ;BCD'd $0A                                 ; Diamonds worth: 10 points
    .byte   $00                                 ; Extra diamonds worth: 0 points
    .byte   $0A, $0B, $0C, $0D, $0E             ;      Randomiser seed values for difficulty levels 1-5
    .byte   $10, $10, $10, $10, $10             ;      Diamonds needed: 16, 16, 16, 16, 16 (for difficulty levels 1-5)
    .byte   $0F, $0F, $0F, $0F, $0F             ;      Cave time: 15, 15, 15, 15, 15 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $0a, $0a
        .byte   $76, $c4
        .byte   $2e, $2e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $0a, $0a
            .byte   $76, $c4
            .byte   $2e, $2e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $0a, $0a
            .byte   $76, $c4
            .byte   $2e, $2e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------

    .byte   $00, $00, $00, $00                  ; Random objects:
    .byte   $00, $00, $00, $00                  ;   first code unused (0%)
                                                ;   second code unused (0%)
                                                ;   third code unused (0%)
                                                ;   fourth code unused (0%)

;   superfluous due to limited cave size
;    .byte   FILL+CHARACTER_STEEL, $00, $02, $28, $16, CHARACTER_STEEL; FilledRect of zSteel from ( 0, 2); length = 40; height = 22; fill = zSteel
    .byte   FILL+CHARACTER_STEEL, $00, $02, $14, $0C, CHARACTER_SOIL; FilledRect of zSteel from ( 0, 2); length = 20; height = 12; fill = zDirt
    .byte   LINE+CHARACTER_BOX, $01, $03, $09, $03 ; Line of zBouS from ( 1, 3); length = 9; direction = down/right
    .byte   LINE+CHARACTER_FIREFLY, $02, $03, $08, $03 ; Line of zFFly1 from ( 2, 3); length = 8; direction = down/right
    .byte   LINE+CHARACTER_DIAMOND, $01, $05, $08, $03 ; Line of zDiaS from ( 1, 5); length = 8; direction = down/right
    .byte   LINE+CHARACTER_BOX, $01, $06, $07, $03 ; Line of zBouS from ( 1, 6); length = 7; direction = down/right
    .byte   LINE+CHARACTER_BOX, $12, $03, $09, $05 ; Line of zBouS from (18, 3); length = 9; direction = down/left
    .byte   LINE+CHARACTER_DIAMOND, $12, $05, $08, $05 ; Line of zDiaS from (18, 5); length = 8; direction = down/left
    .byte   LINE+CHARACTER_BOX, $12, $06, $07, $05 ; Line of zBouS from (18, 6); length = 7; direction = down/left
    .byte   CHARACTER_MANOCCUPIED, $01, $04               ; StoreChar zPRFd1 at ( 1, 4)
    .byte   CHARACTER_EXITDOOR, $12, $04                   ; StoreChar zPreOut at (18, 4)

    END_CAVE INTERMISSION_2
    ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE INTERMISSION_3

    .byte   $13                                 ; Cave 19
    CAVE_SIZE_INTERMISSION                      ; width, height
    .byte   $04                                 ; Magic wall/amoeba slow growth for: 4 seconds
    .byte   $10 ;BCD'd $0A                                 ; Diamonds worth: 10 points
    .byte   $00                                 ; Extra diamonds worth: 0 points
    .byte   $0A, $0B, $0C, $0D, $0E             ; Randomiser seed values for difficulty levels 1-5
    .byte   $0E, $0E, $0E, $0E, $0E             ; Diamonds needed: 14, 14, 14, 14, 14 (for difficulty levels 1-5)
    .byte   $14, $14, $14, $14, $14             ; Cave time: 20, 20, 20, 20, 20 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $16, $26
        .byte   $36, $44
        .byte   $8e, $9e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $16, $26
            .byte   $36, $44
            .byte   $8e, $9e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $16, $26
            .byte   $36, $44
            .byte   $8e, $9e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   $00, $00, $00, $00                  ; Random objects:
    .byte   $00, $00, $00, $00                  ;   first code unused (0%)
                                                ;   second code unused (0%)
                                                ;   third code unused (0%)
                                                ;   fourth code unused (0%)

;   superfluous due to limited cave size
;    .byte   FILL+CHARACTER_STEEL, $00, $02, $28, $16, CHARACTER_STEEL; FilledRect of zSteel from ( 0, 2); length = 40; height = 22; fill = zSteel
    .byte   FILL+CHARACTER_STEEL, $00, $02, $14, $0C, CHARACTER_BLANK; FilledRect of zSteel from ( 0, 2); length = 20; height = 12; fill = zSpace
    .byte   LINE+CHARACTER_DIAMOND, $01, $0C, $12, $02 ; Line of zDiaS from ( 1,12); length = 18; direction = right
    .byte   FILL+CHARACTER_FIREFLY, $0F, $08, $04, $04, CHARACTER_FIREFLY; FilledRect of zFFly1 from (15, 9); length = 4; height = 4; fill = zFFly1
;    .byte   FILL+CHARACTER_FIREFLY, $0f, $09, $04, $03, CHARACTER_FIREFLY; FilledRect of zFFly1 from (15, 9); length = 4; height = 4; fill = zFFly1
;    .byte   CHARACTER_MANOCCUPIED, $08, 3               ; StoreChar zPRFd1 at ( 8, 3)
    .byte   CHARACTER_MANOCCUPIED, 15, 6                ; StoreChar zPRFd1 at ( 8, 3)
    .byte   CHARACTER_EXITDOOR, $12, $07                ; StoreChar zPreOut at (18, 7)

; remainders of WAKA WAKA :(
;    .byte   $13                                 ; Cave WAKA_WAKA
;    CAVE_SIZE_ROOM                              ; width, height
;    .byte   $04                                 ; Magic wall/amoeba slow growth for: 4 seconds
;    .byte   $50                                 ; Diamonds worth: 50 points
;    .byte   $99                                 ; Extra diamonds worth: 0 points
;    .byte   $00, $00, $00, $00, $00             ; Randomiser seed values for difficulty levels 1-5
;    .byte   $05, $05, $05, $05, $05             ; Diamonds needed: 14, 14, 14, 14, 14 (for difficulty levels 1-5)
;    .byte   90, 75, 60, 50, 40                  ; Cave time: 20, 20, 20, 20, 20 seconds
;
;    .byte   $16, $26                            ; medium yellow     NTSC/PAL
;    .byte   $36, $44                            ; dark orange
;    .byte   $8e, $9e                            ; bright blue
;
;    .byte   0, 0, 0, 0                          ; Random objects, unused
;    .byte   0, 0, 0, 0                          ; random values, unused
;
;    .byte   FILL+CHARACTER_STEEL, 10,  2, 19, 22, CHARACTER_BLANK
;    .byte   CHARACTER_BLANK, 10, 10
;    .byte   CHARACTER_BLANK, 10, 12
;    .byte   CHARACTER_BLANK, 10, 14
;    .byte   CHARACTER_BLANK, 28, 10
;    .byte   CHARACTER_BLANK, 28, 12
;    .byte   CHARACTER_BLANK, 28, 14
;
;    .byte   RECT+CHARACTER_STEEL, 12,  4,  2,  2
;    .byte   RECT+CHARACTER_STEEL, 15,  4,  3,  2
;    .byte   LINE+CHARACTER_STEEL, 19,  3,  3, .DIR_DOWN
;    .byte   RECT+CHARACTER_STEEL, 21,  4,  3,  2
;    .byte   RECT+CHARACTER_STEEL, 25,  4,  2,  2
;
;    .byte   LINE+CHARACTER_STEEL, 12,  7,  2, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 15,  7,  5, .DIR_DOWN
;    .byte   LINE+CHARACTER_STEEL, 17,  7,  5, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 19,  7,  3, .DIR_DOWN
;    .byte   LINE+CHARACTER_STEEL, 23,  7,  5, .DIR_DOWN
;    .byte   LINE+CHARACTER_STEEL, 25,  7,  2, .DIR_RIGHT
;
;    .byte   LINE+CHARACTER_STEEL, 11,  9,  3, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 15,  9,  3, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 21,  9,  3, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 25,  9,  3, .DIR_RIGHT
;
;    .byte   CHARACTER_STEEL, 13, 10
;    .byte   CHARACTER_STEEL, 15, 10
;    .byte   CHARACTER_STEEL, 23, 10
;    .byte   CHARACTER_STEEL, 25, 10
;
;    .byte   LINE+CHARACTER_STEEL, 11, 11,  3, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 17, 11,  3, .DIR_DOWN
;    .byte   LINE+CHARACTER_STEEL, 21, 11,  3, .DIR_DOWN
;    .byte   LINE+CHARACTER_STEEL, 25, 11,  3, .DIR_RIGHT
;
;    .byte   CHARACTER_STEEL, 17, 11
;    .byte   CHARACTER_STEEL, 21, 11
;
;    .byte   LINE+CHARACTER_STEEL, 11, 12,  3, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 15, 12,  3, .DIR_DOWN
;    .byte   LINE+CHARACTER_STEEL, 17, 12,  5, .DIR_RIGHT
;    .byte   LINE+CHARACTER_STEEL, 23, 12,  3, .DIR_DOWN
;    .byte   LINE+CHARACTER_STEEL, 25, 12,  3, .DIR_RIGHT
;
;    .byte   CHARACTER_STEEL, 13, 14
;    .byte   CHARACTER_STEEL, 15, 14
;    .byte   CHARACTER_STEEL, 23, 14
;    .byte   CHARACTER_STEEL, 25, 14
;
; about half way done until here...
;
;    .byte   CHARACTER_MANOCCUPIED, 1, 12
;    .byte   CHARACTER_EXITDOOR, 38, 12

  ENDIF

    END_CAVE INTERMISSION_3
    ENDIF





    ;ECHO "MAX CAVE SIZE = ", MAX_CAVE_SIZE

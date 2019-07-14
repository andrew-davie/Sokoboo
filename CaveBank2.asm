; Cave definitions


    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

    ;IFCONST CAVE_NAMED_FUNNEL
    START_CAVE FUNNEL

    .byte   $0F                         ; Cave 15 O
    CAVE_SIZE_ROOM                      ; width, height
    .byte   $08                         ; Magic wall/amoeba slow growth for: 8 seconds
    .byte   $10 ;BCD'd $0A                         ; Diamonds worth: 10 points
    .byte   $20 ;BCD'd $14                         ; Extra diamonds worth: 20 points
    .byte   $01, $1D, $1E, $1F, $20     ; Randomiser seed values for difficulty levels 1-5
    .byte   $0F, $14, $14, $19, $1E     ; Diamonds needed: 15, 20, 20, 25, 30 (for difficulty levels 1-5)
    .byte   $78, $78, $78, $78, $8C     ; Cave time: 120, 120, 120, 120, 140 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $88, $c6
        .byte   $24, $44
        .byte   $ee, $5e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $88, $c6
            .byte   $24, $44
            .byte   $ee, $5e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $88, $c6
            .byte   $24, $44
            .byte   $ee, $5e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   $00, CHARACTER_BOULDER, CHARACTER_FIREFLY, $00          ; Random objects:
    .byte   $64, $50, $02, $00          ;   zSpace : 100/256 = 39%
                                        ;   zBouS  :  80/256 = 31%
                                        ;   zFFly1 :   2/256 =  0%
                                        ;   fourth code unused (0%)

    .byte   LINE+CHARACTER_WALL, $02, $04, $0A, $03     ; Line of zBrick from ( 2, 4); length = 10; direction = down/right
    .byte   LINE+CHARACTER_WALL, $0F, $0D, $0A, $01     ; Line of zBrick from (15,13); length = 10; direction = up/right
    .byte   LINE+CHARACTER_SOIL, $0C, $0E, $03, $02     ; Line of zDirt from (12,14); length = 3; direction = right
    .byte   LINE+CHARACTER_WALL0, $0C, $0F, $03, $02     ; Line of zMagic from (12,15); length = 3; direction = right
    .byte   CHARACTER_EXITDOOR, $14, $16               ; StoreChar zPreOut at (20,22)
    .byte   CHARACTER_MANOCCUPIED, $14, $03               ; StoreChar zPRFd1 at (20, 3)

    END_CAVE FUNNEL
    ;ENDIF

        ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO

    START_CAVE INTERMISSION_4

    .byte   $14                         ; Cave 20
    CAVE_SIZE_INTERMISSION              ; width, height
    .byte   $03                         ; Magic wall/amoeba slow growth for: 3 seconds
    .byte   $30 ;BCD'd $1E                         ; Diamonds worth: 30 points
    .byte   $00                         ; Extra diamonds worth: 0 points
    .byte   $00, $00, $00, $00, $00     ; Randomiser seed values for difficulty levels 1-5
    .byte   $06, $06, $06, $06, $06     ; Diamonds needed: 6, 6, 6, 6, 6 (for difficulty levels 1-5)
    .byte   $14, $14, $14, $14, $14     ; Cave time: 20, 20, 20, 20, 20 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $28, $48
        .byte   $a6, $b6
        .byte   $0e, $0e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $28, $48
            .byte   $a6, $b6
            .byte   $0e, $0e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $28, $48
            .byte   $a6, $b6
            .byte   $0e, $0e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------



; ENDIF

    .byte   $00, $00, $00, $00          ; Random objects:
    .byte   $00, $00, $00, $00          ;   first code unused (0%)
                                        ;   second code unused (0%)
                                        ;   third code unused (0%)
                                        ;   fourth code unused (0%)

;   superfluous due to limited cave size
;    .byte   FILL+CHARACTER_STEEL, $00, $02, $28, $16, CHARACTER_STEEL; FilledRect of zSteel from ( 0, 2); length = 40; height = 22; fill = zSteel
    .byte   FILL+CHARACTER_STEEL, $00, $02, $14, $0C, CHARACTER_SOIL ; FilledRect of zSteel from ( 0, 2); length = 20; height = 12; fill = zDirt
    .byte   RECT+CHARACTER_BOULDER, $0B, $03, $03, $02     ; Rect of zBouS from (11, 3); length = 3; height = 2
    .byte   FILL+CHARACTER_BLANK, $0B, $07, $03, $06, CHARACTER_BLANK; FilledRect of zSpace from (11, 7); length = 3; height = 6; fill = zSpace
    .byte   LINE+CHARACTER_WALL0, $0B, $06, $03, $02     ; Line of zMagic from (11, 6); length = 3; direction = right
    .byte   LINE+CHARACTER_WALL0, $0B, $0A, $03, $02     ; Line of zMagic from (11,10); length = 3; direction = right
    .byte   LINE+CHARACTER_BOULDER, $08, $07, $03, $03     ; Line of zBouS from ( 8, 7); length = 3; direction = down/right
    .byte   CHARACTER_MANOCCUPIED, $03, $03               ; StoreChar zPRFd1 at ( 3, 3)
    .byte   CHARACTER_EXITDOOR, $09, $0A               ; StoreChar zPreOut at ( 9,10)

    END_CAVE INTERMISSION_4

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE GUARDS

    .byte   $05                         ; Cave 05 E
    CAVE_SIZE_ROOM                      ; width, height
    .byte   $14                         ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $50 ;BCD'd $32                         ; Diamonds worth: 50 points
    .byte   $90 ;BCD'd $5A                         ; Extra diamonds worth: 90 points
    .byte   $00, $00, $00, $00, $00     ; Randomiser seed values for difficulty levels 1-5
    .byte   $04, $05, $06, $07, $08     ; Diamonds needed: 4, 5, 6, 7, 8 (for difficulty levels 1-5)
    .byte   $96, $78, $5A, $3C, $1E     ; Cave time: 150, 120, 90, 60, 30 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
    .byte   $48, $68                    ; NTSC/PAL
    .byte   $24, $46                    ; NTSC/PAL
    .byte   $ae, $be                    ; NTSC/PAL
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
;good
;        .byte   $e8, $38
;        .byte   $58, $86
;        .byte   $ca, $5a
        .byte   $26, $68
        .byte   $04, $24
        .byte   $9e, $0e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $48, $68
            .byte   $24, $46
            .byte   $ae, $9e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------

    .byte   $00, $00, $00, $00          ; Random objects:
    .byte   $00, $00, $00, $00          ;   first code unused (0%)
                                        ;   second code unused (0%)
                                        ;   third code unused (0%)
                                        ;   fourth code unused (0%)

    .byte   CHARACTER_MANOCCUPIED, $01, $03               ; StoreChar zPRFd1 at ( 1, 3)
    .byte   CHARACTER_EXITDOOR, $27, $16               ; StoreChar zPreOut at (39,22)
    .byte   FILL+CHARACTER_BLANK, $08, $0A, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from ( 8,10); length = 3; height = 3; fill = zSpace
    .byte   FILL+CHARACTER_BLANK, $10, $0A, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from (16,10); length = 3; height = 3; fill = zSpace
    .byte   FILL+CHARACTER_BLANK, $18, $0A, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from (24,10); length = 3; height = 3; fill = zSpace
    .byte   FILL+CHARACTER_BLANK, $20, $0A, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from (32,10); length = 3; height = 3; fill = zSpace
    .byte   CHARACTER_DIAMOND, $09, $0C               ; StoreChar zDiaS at ( 9,12)
    .byte   CHARACTER_FIREFLY, $0A, $0A               ; StoreChar zFFly1 at (10,10)
    .byte   CHARACTER_DIAMOND, $11, $0C               ; StoreChar zDiaS at (17,12)
    .byte   CHARACTER_FIREFLY, $12, $0A               ; StoreChar zFFly1 at (18,10)
    .byte   CHARACTER_DIAMOND, $19, $0C               ; StoreChar zDiaS at (25,12)
    .byte   CHARACTER_FIREFLY, $1A, $0A               ; StoreChar zFFly1 at (26,10)
    .byte   CHARACTER_DIAMOND, $21, $0C               ; StoreChar zDiaS at (33,12)
    .byte   CHARACTER_FIREFLY, $22, $0A               ; StoreChar zFFly1 at (34,10)
    .byte   FILL+CHARACTER_BLANK, $08, $10, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from ( 8,16); length = 3; height = 3; fill = zSpace
    .byte   FILL+CHARACTER_BLANK, $10, $10, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from (16,16); length = 3; height = 3; fill = zSpace
    .byte   FILL+CHARACTER_BLANK, $18, $10, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from (24,16); length = 3; height = 3; fill = zSpace
    .byte   FILL+CHARACTER_BLANK, $20, $10, $03, $03, CHARACTER_BLANK; FilledRect of zSpace from (32,16); length = 3; height = 3; fill = zSpace
    .byte   CHARACTER_DIAMOND, $09, $12               ; StoreChar zDiaS at ( 9,18)
    .byte   CHARACTER_FIREFLY, $0A, $10               ; StoreChar zFFly1 at (10,16)
    .byte   CHARACTER_DIAMOND, $11, $12               ; StoreChar zDiaS at (17,18)
    .byte   CHARACTER_FIREFLY, $12, $10               ; StoreChar zFFly1 at (18,16)
    .byte   CHARACTER_DIAMOND, $19, $12               ; StoreChar zDiaS at (25,18)
    .byte   CHARACTER_FIREFLY, $1A, $10               ; StoreChar zFFly1 at (26,16)
    .byte   CHARACTER_DIAMOND, $21, $12               ; StoreChar zDiaS at (33,18)
    .byte   CHARACTER_FIREFLY, $22, $10               ; StoreChar zFFly1 at (34,16)

;    .byte   LINE+CHARACTER_WALL, $09, $10, $1E, $02    ; Line of zBrick from ( 9,16); length = 30; direction = right

    END_CAVE GUARDS
    ENDIF

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE FIREFLY_DENS

    .byte   $06                         ; Cave 06 F
    CAVE_SIZE_ROOM                      ; width, height
    .byte   $14                         ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $40 ;BCD'd $28                         ; Diamonds worth: 40 points
    .byte   $60 ;BCD'd $3C                         ; Extra diamonds worth: 60 points
    .byte   $00, $14, $15, $16, $17     ; Randomiser seed values for difficulty levels 1-5
    .byte   $04, $06, $07, $08, $08     ; Diamonds needed: 4, 6, 7, 8, 8 (for difficulty levels 1-5)
    .byte   $96, $78, $64, $5A, $50     ; Cave time: 150, 120, 100, 90, 80 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $26, $48
        .byte   $78, $a4
        .byte   $de, $5e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $26, $48
            .byte   $78, $a4
            .byte   $de, $5e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $26, $48
            .byte   $78, $a4
            .byte   $de, $5e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------

    .byte   CHARACTER_BOULDER, $00, $00, $00          ; Random objects:
    .byte   $32, $00, $00, $00          ;   zBouS  :  50/256 = 19%
                                        ;   second code unused (0%)
                                        ;   third code unused (0%)
                                        ;   fourth code unused (0%)

    .byte   FILL+CHARACTER_WALL, $01, $03, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from ( 1, 3); length = 10; height = 4; fill = zSpace
    .byte   FILL+CHARACTER_WALL, $01, $06, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from ( 1, 6); length = 10; height = 4; fill = zSpace
    .byte   FILL+CHARACTER_WALL, $01, $09, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from ( 1, 9); length = 10; height = 4; fill = zSpace
    .byte   FILL+CHARACTER_WALL, $01, $0C, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from ( 1,12); length = 10; height = 4; fill = zSpace
    .byte   LINE+CHARACTER_SOIL, $0A, $03, $0D, $04     ; Line of zDirt from (10, 3); length = 13; direction = down
    .byte   CHARACTER_DIAMOND, $03, $05               ; StoreChar zDiaS at ( 3, 5)
    .byte   CHARACTER_FIREFLY, $04, $05               ; StoreChar zFFly1 at ( 4, 5)
    .byte   CHARACTER_DIAMOND, $03, $08               ; StoreChar zDiaS at ( 3, 8)
    .byte   CHARACTER_FIREFLY, $04, $08               ; StoreChar zFFly1 at ( 4, 8)
    .byte   CHARACTER_DIAMOND, $03, $0B               ; StoreChar zDiaS at ( 3,11)
    .byte   CHARACTER_FIREFLY, $04, $0B               ; StoreChar zFFly1 at ( 4,11)
    .byte   CHARACTER_DIAMOND, $03, $0E               ; StoreChar zDiaS at ( 3,14)
    .byte   CHARACTER_FIREFLY, $04, $0E               ; StoreChar zFFly1 at ( 4,14)
    .byte   FILL+CHARACTER_WALL, $1D, $03, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from (29, 3); length = 10; height = 4; fill = zSpace
    .byte   FILL+CHARACTER_WALL, $1D, $06, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from (29, 6); length = 10; height = 4; fill = zSpace
    .byte   FILL+CHARACTER_WALL, $1D, $09, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from (29, 9); length = 10; height = 4; fill = zSpace
    .byte   FILL+CHARACTER_WALL, $1D, $0C, $0A, $04, CHARACTER_BLANK; FilledRect of zBrick from (29,12); length = 10; height = 4; fill = zSpace
    .byte   LINE+CHARACTER_SOIL, $1D, $03, $0D, $04     ; Line of zDirt from (29, 3); length = 13; direction = down
    .byte   CHARACTER_DIAMOND, $24, $05               ; StoreChar zDiaS at (36, 5)
    .byte   CHARACTER_FIREFLY, $23, $05               ; StoreChar zFFly1 at (35, 5)
    .byte   CHARACTER_DIAMOND, $24, $08               ; StoreChar zDiaS at (36, 8)
    .byte   CHARACTER_FIREFLY, $23, $08               ; StoreChar zFFly1 at (35, 8)
    .byte   CHARACTER_DIAMOND, $24, $0B               ; StoreChar zDiaS at (36,11)
    .byte   CHARACTER_FIREFLY, $23, $0B               ; StoreChar zFFly1 at (35,11)
    .byte   CHARACTER_DIAMOND, $24, $0E               ; StoreChar zDiaS at (36,14)
    .byte   CHARACTER_FIREFLY, $23, $0E               ; StoreChar zFFly1 at (35,14)
    .byte   CHARACTER_MANOCCUPIED, $03, $14               ; StoreChar zPRFd1 at ( 3,20)
    .byte   CHARACTER_EXITDOOR, $26, $14               ; StoreChar zPreOut at (38,20)

    END_CAVE FIREFLY_DENS
    ENDIF

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE AMOEBA

    .byte   $07                         ; Cave 07 G
    CAVE_SIZE_ROOM                      ; width, height
    .byte   $4B                         ; Magic wall/amoeba slow growth for: 75 seconds
    .byte   $10 ;BCD'd $0A                         ; Diamonds worth: 10 points
    .byte   $20 ;BCD'd $14                         ; Extra diamonds worth: 20 points
    .byte   $02, $07, $08, $0A, $09     ; Randomiser seed values for difficulty levels 1-5
    .byte   $0F, $14, $19, $19, $19     ; Diamonds needed: 15, 20, 25, 25, 25 (for difficulty levels 1-5)
    .byte   $78, $78, $78, $78, $78     ; Cave time: 120, 120, 120, 120, 120 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
            .byte   $48, $68
            .byte   $04, $06
            .byte   $c8, $5a
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $48, $66
            .byte   $04, $04
            .byte   $c8, $58
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $4a, $68
            .byte   $26, $24
            .byte   $d8, $7a
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------
                                        ;

    .byte   CHARACTER_BLANK                    ; Random objects:
    .byte   CHARACTER_BOULDER
    .byte   CHARACTER_FIREFLY
    .byte   0                           ; unused
    .byte   $64, $28, $02, $00          ;   zSpace : 100/256 = 39%
                                        ;   zBouS  :  40/256 = 15%
                                        ;   zFFly1 :   2/256 =  0%
                                        ;   fourth code unused (0%)

    .byte   LINE+CHARACTER_WALL, $01, $07, $0C, $02     ; Line of zBrick from ( 1, 7); length = 12; direction = right
    .byte   LINE+CHARACTER_WALL, $1C, $05, $0B, $02     ; Line of zBrick from (28, 5); length = 11; direction = right
    .byte   LINE+CHARACTER_AMOEBA, $13, $15, $02, $02     ; Line of zAmoe from (19,21); length = 2; direction = right
    .byte   CHARACTER_DIAMOND, $04, $06               ; StoreChar zDiaS at ( 4, 6)
    .byte   CHARACTER_DIAMOND, $04, $0E               ; StoreChar zDiaS at ( 4,14)
    .byte   CHARACTER_DIAMOND, $04, $16               ; StoreChar zDiaS at ( 4,22)
    .byte   CHARACTER_DIAMOND, $22, $04               ; StoreChar zDiaS at (34, 4)
    .byte   CHARACTER_DIAMOND, $22, $0C               ; StoreChar zDiaS at (34,12)
    .byte   CHARACTER_DIAMOND, $22, $16               ; StoreChar zDiaS at (34,22)
    .byte   CHARACTER_MANOCCUPIED, $14, $06               ; StoreChar zPRFd1 at (20, 3)
    .byte   CHARACTER_EXITDOOR, $27, $07               ; StoreChar zPreOut at (39, 7)

    END_CAVE AMOEBA
    ENDIF

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE ENCHANTED_WALL

    .byte   $08                         ; Cave 08 H
    CAVE_SIZE_ROOM                      ; width, height
    .byte   $14                         ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $10 ;BCD'd $0A                         ; Diamonds worth: 10 points
    .byte   $20 ;BCD'd $14                         ; Extra diamonds worth: 20 points
    .byte   $01, $03, $04, $05, $06     ; Randomiser seed values for difficulty levels 1-5
    .byte   $0A, $0F, $14, $14, $14     ; Diamonds needed: 10, 15, 20, 20, 20 (for difficulty levels 1-5)
    .byte   $78, $6E, $64, $5A, $50     ; Cave time: 120, 110, 100, 90, 80 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $98, $d8
        .byte   $44, $66
        .byte   $de, $3e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $98, $d8
            .byte   $44, $66
            .byte   $de, $3e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $98, $d8
            .byte   $44, $66
            .byte   $de, $3e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------

    .byte   $00, CHARACTER_BOULDER, CHARACTER_FIREFLY, $00          ; Random objects:
    .byte   $5A, $32, $02, $00          ;   zSpace :  90/256 = 35%
                                        ;   zBouS  :  50/256 = 19%
                                        ;   zFFly1 :   2/256 =  0%
                                        ;   fourth code unused (0%)
    .byte   CHARACTER_DIAMOND, $04, $06               ; StoreChar zDiaS at ( 4, 6)
    .byte   CHARACTER_DIAMOND, $22, $04               ; StoreChar zDiaS at (34, 4)
    .byte   CHARACTER_DIAMOND, $22, $0C               ; StoreChar zDiaS at (34,12)
    .byte   CHARACTER_EXITDOOR, $00, $05               ; StoreChar zPreOut at ( 0, 5)
    .byte   CHARACTER_MANOCCUPIED, $14, $03               ; StoreChar zPRFd1 at (20, 3)
    .byte   LINE+CHARACTER_WALL, $01, $07, $0C, $02     ; Line of zBrick from ( 1, 7); length = 12; direction = right
    .byte   LINE+CHARACTER_WALL, $01, $0F, $0C, $02     ; Line of zBrick from ( 1,15); length = 12; direction = right
    .byte   LINE+CHARACTER_WALL, $1C, $05, $0B, $02     ; Line of zBrick from (28, 5); length = 11; direction = right
    .byte   LINE+CHARACTER_WALL, $1C, $0D, $0B, $02     ; Line of zBrick from (28,13); length = 11; direction = right
    .byte   LINE+CHARACTER_WALL0, $0E, $11, $08, $02     ; Line of zMagic from (14,17); length = 8; direction = right
    .byte   CHARACTER_DIAMOND, $0C, $10               ; StoreChar zDiaS at (12,16)
    .byte   CHARACTER_BLANK, $0E, $12               ; StoreChar zSpace at (14,18)
    .byte   CHARACTER_DIAMOND, $13, $12               ; StoreChar zDiaS at (19,18)
    .byte   LINE+CHARACTER_SOIL, $0E, $0F, $08, $02     ; Line of zDirt from (14,15); length = 8; direction = right

    END_CAVE ENCHANTED_WALL
    ENDIF

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE GREED

    .byte   $09                         ; Cave 09 I
    CAVE_SIZE_ROOM                      ; width, height
    .byte   $14                         ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $05                         ; Diamonds worth: 5 points
    .byte   $10 ;BCD'd $0A                         ; Extra diamonds worth: 10 points
    .byte   $64, $89, $8C, $FB, $33     ; Randomiser seed values for difficulty levels 1-5
    .byte   $4B, $4B, $50, $55, $5A     ; Diamonds needed: 75, 75, 80, 85, 90 (for difficulty levels 1-5)
    .byte   $96, $96, $82, $82, $78     ; Cave time: 150, 150, 130, 130, 120 seconds

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $d6, $34
        .byte   $88, $d8
        .byte   $2e, $2e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $d6, $34
            .byte   $88, $d8
            .byte   $2e, $2e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $d8, $78
            .byte   $94, $d4
            .byte   $3e, $4e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   CHARACTER_BOULDER, CHARACTER_DIAMOND, $00, $00          ; Random objects:
    .byte   $F0, $78, $00, $00          ;   zBouS  : 240/256 = 93-46%
                                        ;   zDiaS  : 120/256 = 46%
                                        ;   third code unused (0%)
                                        ;   fourth code unused (0%)

    .byte   FILL+CHARACTER_WALL, $05, $0A, $0D, $0D, CHARACTER_BLANK; FilledRect of zBrick from ( 5,10); length = 13; height = 13; fill = zSpace
    .byte   CHARACTER_SOIL, $0C, $0A                                ; StoreChar zDirt at (12,10)
    .byte   FILL+CHARACTER_WALL, $19, $0A, $0D, $0D, CHARACTER_BLANK; FilledRect of zBrick from (25,10); length = 13; height = 13; fill = zSpace
    .byte   CHARACTER_SOIL, $1F, $0A                                ; StoreChar zDirt at (31,10)
    .byte   LINE+CHARACTER_WALL, $11, $12, $09, $02                 ; Line of zBrick from (17,18); length = 9; direction = right
    .byte   LINE+CHARACTER_BLANK, $11, $13, $09, $02                ; Line of zSpace from (17,19); length = 9; direction = right
    .byte   CHARACTER_MANOCCUPIED, $07, $0C                         ; StoreChar zPRFd1 at ( 7,12)
    .byte   CHARACTER_EXITDOOR, $08, $0C                            ; StoreChar zPreOut at ( 8,12)

    END_CAVE GREED
    ENDIF

    ;ECHO "MAX CAVE SIZE = ", MAX_CAVE_SIZE
    ;ECHO "MAX_CAVE_NUMBER = ", MAX_CAVE_NUMBER



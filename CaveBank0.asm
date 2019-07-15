; Cave definitions
; Sample cave definitions.
; Any cave can be in any bank.  System auto-calculates required bank buffer size in RAM.
; have as many banks as you like.  Add new banks in notBoulderDash.asm.


    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

    IF 0 ;{
    ;IF DEMO_VERSION = NO && FINAL_VERSION = NO
    START_CAVE SELECTION_SCREEN


    .byte 0                             ; cave 0 -- selection screen
    CAVE_SIZE   10, SCREEN_LINES        ; width, height
    .byte   $14                         ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $10 ;BCD'd $0A                         ; Diamonds worth: 10 points
    .byte   $15 ;BCD'd $0F                         ; Extra diamonds worth: 15 points
    CAVE_RANDOM $0,0,0,0,0              ; Randomiser seed values for difficulty levels 1-5
    .byte   $0C, $0C, $0C, $0C, $0C     ; Diamonds needed: 12, 12, 12, 12, 12 (for difficulty levels 1-5)
    .byte   $FF,0,0,0,0                 ; cave time
    .byte   $a6, $96                    ; NTSC/PAL
    .byte   $36, $46                    ; NTSC/PAL
    .byte   $0e, $0e                    ; NTSC/PAL
    .byte   $00, $00, $00, $00          ; Random objects:
    .byte   $00, $00, $00, $00          ;   SPACE / BOULDERS/ DIAMONDS / unused


    ;.byte   FILL+CHARACTER_BOX, $01, $03, 38,6, $00
    STOCH   CHARACTER_MANOCCUPIED, $03, $04       ; StoreChar zPRFd1 at ( 3, 4)
    STOCH   CHARACTER_EXPLOSION3, 1,3          ; special selector creature (overload explosion character)
    END_CAVE SELECTION_SCREEN
    ENDIF ;}

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE INTRO

    .byte   $01                                 ; Cave 01 A
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $10 ;BCD'd $0A                                 ; Diamonds worth: 10 points
    .byte   $15 ;BCD'd $0F                                 ; Extra diamonds worth: 15 points
    CAVE_RANDOM $2A, $0B, $0C, $0D, $0E         ; Randomiser seed values for difficulty levels 1-5

        .byte   $0C, $0C, $0C, $0C, $0C             ; Diamonds needed: 12, 12, 12, 12, 12 (for difficulty levels 1-5)

    .byte   $96, $6E, $46, $28, $1E             ; Cave time

; z26 palette/z26 palette:
;    .byte   $a8, $96                            ; NTSC/PAL
;    .byte   $36, $46                            ; NTSC/PAL
;    .byte   $0e, $0e                            ; NTSC/PAL
; z26 palette/TJ's PAL TV palette:


;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $a8, $b6
        .byte   $36, $46
        .byte   $0e, $0e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
        .byte   $a8, $b6
        .byte   $36, $46
        .byte   $0e, $0e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $a8, $b6
            .byte   $36, $46
            .byte   $0e, $0e
        ENDIF

 ENDIF

;-------------------------------------------------------------------------------------

    .byte   CHARACTER_BLANK                            ; Random objects:
    .byte   CHARACTER_BOX
    .byte   CHARACTER_DIAMOND
    .byte   CHARACTER_BLANK
    .byte   $3C, $32, $09, $00                  ;   zSpace :  60/256 = 23-19-3%
                                                ;   zBouS  :  50/256 = 19-3%
                                                ;   zDiaS  :   9/256 =  3%
                                                ;   fourth code unused (0%)

BASEX = 5
BASEY = 9



#if 1

 .byte   LINE+CHARACTER_BLANK, BASEX+5, BASEY+1, 3, 2
 ;.byte   LINE+CHARACTER_BLANK, BASEX+5, BASEY+2, 3, 2
 ;.byte   LINE+CHARACTER_BLANK, BASEX+5, BASEY+3, 3, 2


  .byte   LINE+CHARACTER_STEEL, BASEX+4, BASEY+0, 5, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+4, BASEY+0, 4, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+2, BASEY+3, 3, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+2, BASEY+3, 3, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+0, BASEY+5, 3, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+0, BASEY+5, 4, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+0, BASEY+8, 5, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+4, BASEY+8, 3, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+4, BASEY+10, 7, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+10, BASEY+8, 3, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+10, BASEY+9, 9, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+12, BASEY+8, 2, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+6, BASEY+8, 3, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+18, BASEY+5, 5, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+13, BASEY+5, 6, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+9, BASEY+6, 5, 2
  .byte   LINE+CHARACTER_STEEL, BASEX+9, BASEY+3, 4, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+8, BASEY+0, 4, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+4, BASEY+5, 2, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+6, BASEY+5, 2, 4
  .byte   LINE+CHARACTER_STEEL, BASEX+7, BASEY+5, 2, 4

  STOCH   CHARACTER_MANOCCUPIED, BASEX+11, BASEY+8               ; StoreChar zPRFd1 at ( 3, 4)

  STOCH   CHARACTER_BOX, BASEX+5, BASEY+2
  STOCH   CHARACTER_BOX, BASEX+7, BASEY+3
  STOCH   CHARACTER_BOX, BASEX+5, BASEY+4
  STOCH   CHARACTER_BOX, BASEX+7, BASEY+4
  STOCH   CHARACTER_BOX, BASEX+2, BASEY+7
  STOCH   CHARACTER_BOX, BASEX+5, BASEY+7

  STOCH   CHARACTER_DIAMOND, BASEX+16, BASEY+6
  STOCH   CHARACTER_DIAMOND, BASEX+17, BASEY+6
  STOCH   CHARACTER_DIAMOND, BASEX+16, BASEY+7
  STOCH   CHARACTER_DIAMOND, BASEX+17, BASEY+7
  STOCH   CHARACTER_DIAMOND, BASEX+16, BASEY+8
  STOCH   CHARACTER_DIAMOND, BASEX+17, BASEY+8

#endif

#if 0
    .byte   LINE+CHARACTER_BLANK, BASEX+1, BASEY+1, 8, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right
    .byte   LINE+CHARACTER_BLANK, BASEX+1, BASEY+2, 8, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right
    .byte   LINE+CHARACTER_BLANK, BASEX+1, BASEY+3, 8, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right
    .byte   LINE+CHARACTER_BLANK, BASEX+1, BASEY+4, 8, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right
    .byte   LINE+CHARACTER_BLANK, BASEX+1, BASEY+5, 8, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right



    .byte   LINE+CHARACTER_STEEL, BASEX+$01, BASEY+0, 7, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right
    .byte   LINE+CHARACTER_STEEL, BASEX+$01, BASEY+1, 2, 4    ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+3, BASEY+2, 3, 2    ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+4, BASEY+4, 2, 4    ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+0, BASEY+2, 4, 4    ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+1, BASEY+5, 1, 4    ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+1, BASEY+6, 8, 2    ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+8, BASEY+4, 2, 4    ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+7, BASEY+1, 2,2     ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_STEEL, BASEX+9, BASEY+1, 4,4     ; Line of zBrick from ( 1, 9); length = 30; direction = down

    .byte   LINE+CHARACTER_DIAMOND, BASEX+2, BASEY+4, 2,2     ; Line of zBrick from ( 1, 9); length = 30; direction = down
    .byte   LINE+CHARACTER_DIAMOND, BASEX+2, BASEY+5, 2,2     ; Line of zBrick from ( 1, 9); length = 30; direction = down

    ;.byte   LINE+CHARACTER_WALL, $01, $09, $1E, $02    ; Line of zBrick from ( 1, 9); length = 30; direction = right
    ;.byte   LINE+CHARACTER_WALL, $09, $10, $1E, $02    ; Line of zBrick from ( 9,16); length = 30; direction = right
    STOCH   CHARACTER_MANOCCUPIED, BASEX+02, BASEY+3               ; StoreChar zPRFd1 at ( 3, 4)

    STOCH   CHARACTER_BOX, BASEX+2, BASEY+2               ; StoreChar zPRFd1 at ( 3, 4)
    STOCH   CHARACTER_BOX, BASEX+4, BASEY+3               ; StoreChar zPRFd1 at ( 3, 4)
    STOCH   CHARACTER_BOX, BASEX+7, BASEY+3               ; StoreChar zPRFd1 at ( 3, 4)
    STOCH   CHARACTER_BOX, BASEX+6, BASEY+4               ; StoreChar zPRFd1 at ( 3, 4)
#endif

  END_CAVE INTRO

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO

    START_CAVE ROOMS

    .byte   $02                                 ; Cave 02 B
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $20 ;BCD'd $14                                 ; Diamonds worth: 20 points
    .byte   $50 ;BCD'd $32                                 ; Extra diamonds worth: 50 points
    CAVE_RANDOM $03, $00, $01, $57, $58         ; Randomiser seed values for difficulty levels 1-5
    .byte   $0A, $0C, $09, $0D, $0A             ; Diamonds needed: 10, 12, 9, 13, 10 (for difficulty levels 1-5)
    .byte   $96, $6E, $46, $46, $46             ; Cave time: 150, 110, 70, 70, 70 seconds


;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $78, $a8
        .byte   $34, $44
        .byte   $ce, $7e
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $78, $a8
            .byte   $34, $44
            .byte   $ce, $7e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $78, $a8
            .byte   $34, $44
            .byte   $ce, $7e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   CHARACTER_BLANK                            ; Random objects:
    .byte   CHARACTER_BOX
    .byte   CHARACTER_DIAMOND
    .byte   CHARACTER_FIREFLY
    .byte   $3C, $32, $09, $02                  ;   zSpace :  60/256 = 23-19-3%
                                                ;   zBouS  :  50/256 = 19-3%
                                                ;   zDiaS  :   9/256 =  3%
                                                ;   zFFly1 :   2/256 =  0%
    .byte   LINE+CHARACTER_WALL, $01, $08, $26, $02    ; Line of zBrick from ( 1, 8); length = 38; direction = right
    .byte   LINE+CHARACTER_WALL, $01, $0F, $26, $02    ; Line of zBrick from ( 1,15); length = 38; direction = right
    .byte   LINE+CHARACTER_WALL, $08, $03, $14, $04    ; Line of zBrick from ( 8, 3); length = 20; direction = down
    .byte   LINE+CHARACTER_WALL, $10, $03, $14, $04    ; Line of zBrick from (16, 3); length = 20; direction = down
    .byte   LINE+CHARACTER_WALL, $18, $03, $14, $04    ; Line of zBrick from (24, 3); length = 20; direction = down
    .byte   LINE+CHARACTER_WALL, $20, $03, $14, $04    ; Line of zBrick from (32, 3); length = 20; direction = down
    .byte   LINE+CHARACTER_BLANK, $01, $05, $26, $02   ; Line of zSpace from ( 1, 5); length = 38; direction = right
    .byte   LINE+CHARACTER_BLANK, $01, $0B, $26, $02   ; Line of zSpace from ( 1,11); length = 38; direction = right
    .byte   LINE+CHARACTER_BLANK, $01, $12, $26, $02   ; Line of zSpace from ( 1,18); length = 38; direction = right
    .byte   LINE+CHARACTER_BLANK, $14, $03, $14, $04   ; Line of zSpace from (20, 3); length = 20; direction = down
    .byte   CHARACTER_MANOCCUPIED, $12, $15               ; StoreChar zPRFd1 at (18,21)
    .byte   CHARACTER_EXITDOOR, $12, $16                   ; StoreChar zPreOut at (18,22)
    END_CAVE ROOMS
;  ELSE
;    START_CAVE ROOMS
;
;    .byte   $02                                 ; Cave 02 B
;    CAVE_SIZE_ROOM                              ; width, height
;    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
;    .byte   $20 ;BCD'd $14                                 ; Diamonds worth: 20 points
;    .byte   $50 ;BCD'd $32                                 ; Extra diamonds worth: 50 points
;    CAVE_RANDOM $04, $00, $01, $57, $58         ; Randomiser seed values for difficulty levels 1-5
;    .byte   99, $0C, $09, $0D, $0A             ; Diamonds needed: 10, 12, 9, 13, 10 (for difficulty levels 1-5)
;    .byte   120, $6E, $46, $46, $46             ; Cave time: 150, 110, 70, 70, 70 seconds
;
;;; z26 palette/z26 palette
;;    .byte   $8a, $ca                            ; NTSC/PAL
;;    .byte   $46, $66                            ; NTSC/PAL
;;    .byte   $de, $3e                            ; NTSC/PAL
;; z26 palette/TJ's PAL TV palette
;    .byte   $78, $a8                            ; NTSC/PAL
;    .byte   $34, $44                            ; NTSC/PAL
;    .byte   $ce, $7e                            ; NTSC/PAL
;
;    .byte   CHARACTER_DIAMOND                            ; Random objects:
;    .byte   CHARACTER_FIREFLY
;    .byte   0
;    .byte   0
;    .byte   255, 50, $00, $00                  ;   zSpace :  60/256 = 23-19-3%
;                                                ;   zBouS  :  50/256 = 19-3%
;                                                ;   zDiaS  :   9/256 =  3%
;                                                ;   zFFly1 :   2/256 =  0%
;
;;    .byte   FILL+CHARACTER_DIAMOND, 1, 3, 28, 10, CHARACTER_DIAMOND; FilledRect of zDirt from ( 8,10); length = 4; height = 4; fill = zSpace
;    .byte   CHARACTER_MANOCCUPIED, 1, 3               ; StoreChar zPRFd1 at (18,21)
;    .byte   CHARACTER_EXITDOOR, 38, 22                   ; StoreChar zPreOut at (18,22)
;    END_CAVE ROOMS
;  ENDIF
    ENDIF

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE MAZE

    .byte   $03                                 ; Cave 03 C
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $00                                 ; Magic wall/amoeba slow growth for: 0 seconds
    .byte   $15 ;BCD'd $0F                                 ; Diamonds worth: 15 points
    .byte   $0 ;BCD'd $00                                 ; Extra diamonds worth: 0 points
    CAVE_RANDOM $00, $32, $36, $34, $37         ; Randomiser seed values for difficulty levels 1-5
    .byte   $18, $17, $18, $17, $15             ; Diamonds needed: 24, 23, 24, 23, 21 (for difficulty levels 1-5)
    .byte   $96, $64, $5A, $50, $46             ; Cave time: 150, 100, 90, 80, 70 seconds


;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
    .byte   $f6, $48                            ; NTSC/PAL
    .byte   $24, $24                            ; NTSC/PAL
    .byte   $9e, $be                            ; NTSC/PAL
    ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $c4, $52
            .byte   $26, $44
            .byte   $8e, $de
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $c4, $52
            .byte   $26, $44
            .byte   $8e, $de
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------

    .byte   CHARACTER_WALL                             ; Random objects:
    .byte   CHARACTER_BOX
    .byte   CHARACTER_DIAMOND
    .byte   CHARACTER_BLANK
    .byte   $64, $32, $09, $00                  ;   zBrick : 100/256 = 39%
                                                ;   zBouS  :  50/256 = 19%
                                                ;   zDiaS  :   9/256 =  3%
                                                ;   fourth code unused (0%)
    .byte   CHARACTER_MANOCCUPIED, $03, $04               ; StoreChar zPRFd1 at ( 3, 4)

    .byte   CHARACTER_EXITDOOR, $27, $14                   ; StoreChar zPreOut at (39,20)
    END_CAVE MAZE
    ENDIF

    ;------------------------------------------------------------------------------

    IF FINAL_VERSION = YES || DEMO_VERSION = NO
    START_CAVE BUTTERFLIES

    .byte   $04                                 ; Cave 04 D
    CAVE_SIZE_ROOM                              ; width, height
    .byte   $14                                 ; Magic wall/amoeba slow growth for: 20 seconds
    .byte   $05                                 ; Diamonds worth: 5 points
    .byte   $20 ;BCD'd $14                                 ; Extra diamonds worth: 20 points
    CAVE_RANDOM $00, $6E, $70, $73, $77         ; Randomiser seed values for difficulty levels 1-5
    .byte   $24, $24, $24, $24, $24             ; Diamonds needed: 36, 36, 36, 36, 36 (for difficulty levels 1-5)
    .byte   $78, $64, $50, $3C, $32             ; Cave time: 120, 100, 80, 60, 50 seconds

;; z26 palette/z26 palette:
;    .byte   $16, $26                            ; NTSC/PAL
;    .byte   $54, $84                            ; NTSC/PAL
;    .byte   $ae, $7e                            ; NTSC/PAL
; z26 palette/TJ's PAL TV palette:

;-------------------------------------------------------------------------------------
; PALETTE DEFINITIONS

    IF FINAL_VERSION || ![TJ_MODE|AD_MODE]
        .byte   $16, $26
        .byte   $54, $86
        .byte   $ae, $9e
     ELSE

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF AD_MODE
            .byte   $16, $26
            .byte   $54, $86
            .byte   $ae, $9e
        ENDIF

        ; COMMENT FOLLOWING OUT IF NOT WANTED!
        ; OPTIONAL block -- if it's not here, then the FINAL_VERSION is used
        IF TJ_MODE
            .byte   $16, $26
            .byte   $54, $86
            .byte   $ae, $9e
        ENDIF

    ENDIF

;-------------------------------------------------------------------------------------


    .byte   CHARACTER_BOX                          ; Random objects:
    .byte   CHARACTER_BLANK
    .byte   CHARACTER_BLANK
    .byte   CHARACTER_BLANK
    .byte   $14, $00, $00, $00                  ;   zBouS  :  20/256 =  7%

    .byte   CHARACTER_MANOCCUPIED, $01, $03               ; StoreChar zPRFd1 at ( 1, 3)
    .byte   CHARACTER_EXITDOOR, $26, $16                   ; StoreChar zPreOut at (38,22)
    .byte   FILL+CHARACTER_SOIL, $08, $0A, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from ( 8,10); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FLUTTERBY, $0A, $0B                    ; StoreChar zBFly1 at (10,11)
    .byte   FILL+CHARACTER_SOIL, $10, $0A, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (16,10); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FLUTTERBY, $12, $0B                    ; StoreChar zBFly1 at (18,11)
    .byte   FILL+CHARACTER_SOIL, $18, $0A, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (24,10); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FLUTTERBY, $1A, $0B                    ; StoreChar zBFly1 at (26,11)
    .byte   FILL+CHARACTER_SOIL, $20, $0A, $04, $04, CHARACTER_BLANK; FilledRect of zDirt from (32,10); length = 4; height = 4; fill = zSpace
    .byte   CHARACTER_FLUTTERBY, $22, $0B                    ; StoreChar zBFly1 at (34,11)
    END_CAVE BUTTERFLIES
    ENDIF

   ; ECHO "MAX CAVE SIZE = ", MAX_CAVE_SIZE

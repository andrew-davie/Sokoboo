; Sound TODOs:
; ? (un)cover cave (not done yet)
; + initial crack sound
; + diamond pickup
; o diamond starts falling (double start bug)
; + diamond lands
; o BOX stars falling (double start bug)
; + BOX lands
; + BOX is pushed
; + Rockford moves through soil
; + Rockford moves through blank
; + Rockfords digs into soil
; + magic wall
; + amoeba
; + door opens (background flash fixed)
; + running out of time
; + bonus points
; x extra live (no sound, Cosmic Ark effect instead, fix colors)

; - BD doku seems wrong, there are sound priorities
;   -> rework sound system, prioritisize sounds!



LOW_BONUS_SOUND = 1             ; 1 = the bonus points sound goes deeper
SND_MASK_LO     = %1111
SND_MASK_HI     = %11110000

;-----------------------------------------------------------

    MAC START_SOUND ; = 15
    SUBROUTINE
        lda     newSounds           ; 3
      IF {1} < 16
        and     #SND_MASK_LO        ; 2
        cmp     #SOUND_MOVE_SOIL+1  ; 2     overwrite low priority move sounds
        bcs     .skipNew            ; 2/3
      ELSE
        and     #SND_MASK_HI        ; 2
        cmp     #(SOUND_MOVE_SOIL+1)<<4  ; 2     overwrite low priority move sounds
        bcs     .skipNew            ; 2/3
;        bne     .skipNew            ; 2/3
      ENDIF
        eor     newSounds           ; 3
        ora     #{1}                ; 2
        sta     newSounds           ; 3
.skipNew
    SUBROUTINE
    ENDM


;-----------------------------------------------------------

    MAC START_PRIO_SOUND ; = 10
        lda     newSounds           ; 3
      IF {1} < 16
        and     #<(~SND_MASK_LO)    ; 2
      ELSE
        and     #<(~SND_MASK_HI)    ; 2
      ENDIF
        ora     #{1}                ; 2
        sta     newSounds           ; 3
    ENDM

;-----------------------------------------------------------

    MAC STOP_CHANNEL ; {0 or 1}
; only any sound in the channel
        lda #0
        sta soundIdxLst+{1}
        sta AUDV0+{1}
    ENDM

;-----------------------------------------------------------

    MAC STOP_SOUND ; {0 or 1, sound offset}
; only stops a given sound the channel
        lda     #{2}
        eor     soundIdxLst+{1}
        bne     .skipStop
        sta     soundIdxLst+{1}
        sta     AUDV0+{1}
.skipStop
    ENDM

;-----------------------------------------------------------
    DEFINE_SUBROUTINE StartSound
;-----------------------------------------------------------
; worst case timings:
; SOIL, DIRT = 82
; channel0   = 69
; channel1   = 68
; channel1   = 80+(1..2*9) (random frequency)
;-----------------------------------------------------------
; a = sound idx
; 1. assign all sounds (except move) to their channels:

                ldx     #1                      ; 2
                cmp     #SOUND_GROUP_HI         ; 2
                bcc     .checkChannel0          ; 2/3
; channel 1 group sounds get prioritized:
                cmp     soundIdxLst+1           ; 2
                beq     .skipSound              ; 2/3       avoid restarting the same sound
                bcs     .startChannel           ; 2/3=12
                bcc     .skipSound              ; 3

.checkChannel0:                                 ; 7
                dex                             ; 2 =  9

                cmp     #SOUND_GROUP_LO         ; 2
                bcc     .soundFree              ; 2/3
                cmp     soundIdxLst             ; 3         prio >= current sound?
                bcs     .startChannel           ; 2/3        yes, overwrite
                ldy     soundIdxLst             ; 3
                cpy     #OFSS_EXPLOSION         ; 2         current explosion?
                bcs     .skipSound              ; 2/3        yes, keep
                bcc     .startChannel           ; 2/3        no, overwrite

; 2. move sound, check for a free channel (1 preferred):
.soundFree:
                inx                             ; 2
                ldy     soundIdxLst+1           ; 3         channel 1 free?
                beq     .startChannel           ; 2/3        yes, use it
                dex                             ; 2
                ldy     soundIdxLst             ; 3         channel 0 free?
                bne     .skipSound              ; 2/3=14     no, skip sound

; 3. create new sound:
.startChannel:                                  ;13/14/21/27 (ch1, ch0, dirt/soil)
                sta     soundIdxLst,x           ; 4
                tay                             ; 2 =  6

RestartSound:
; x = sound channel 0/1
; y = sound index
                lda     #0                      ; 2
                sta     decayTimeLst,x          ; 4
                sta     AUDV0,x                 ; 4
                lda     SoundTbl+OFS_RND_FREQ,y ; 4
                beq     .fixedFreq              ; 2/3=16

; increase base frequency by random value:
                lda rnd ;NEXT_RANDOM            ; 3
                and     #%1110                  ; 2 =  5    up to 8 different variations
.reTry:
                lsr                             ; 2
                cmp     SoundTbl+OFS_RND_FREQ,y ; 4
                bcs     .reTry                  ; 2/3= 8
.fixedFreq:
                clc                             ; 2
                adc     SoundTbl+OFS_FREQ,y     ; 4
                sta     AUDF0,x                 ; 4
                lda     SoundTbl+OFS_DIST,y     ; 4
                sta     AUDC0,x                 ; 4
                lda     SoundTbl+OFS_DECAY,y    ; 4
                sta     decayIdxLst,x           ; 4 = 26

.skipSound:
                rts                             ; 6 =  6

;-----------------------------------------------------------

;ManActionSounds
;                .byte 1 ;<manStartup            ; 0             sounds
;                .byte 1 ;<normalMan             ; 1
;                .byte 1 ;<deadMan               ; 2
;                .byte 1 ;<waitingMan            ; 3
;                .byte 1 ;<waitingManPress       ; 4
;                .byte 1 ;<waitingManNoTim       ; 5
;                .byte 1 ;<waitingManPressNoTim  ; 6
;                .byte 0 ;<nextLevelMan          ; 7
;                .byte 1 ;<BonusCountdownStart   ; 8
;                .byte 1 ;<BonusCountdownRun     ; 9


;-----------------------------------------------------------
    DEFINE_SUBROUTINE PlaySounds
;-----------------------------------------------------------

                ldy     ManMode             ; 3         new sounds allowed?
                cpy     #MANMODE_NEXTLEVEL  ; 2
                beq     .skipHi             ; 2/3

                lda     newSounds           ; 3
                and     #SND_MASK_LO        ; 2
                beq     .skipLo             ; 2/3       no new low sound was triggered
                asl                         ; 2
                asl                         ; 2
                jsr     StartSound          ; 6
.skipLo:
                lda     newSounds           ; 3
                and     #SND_MASK_HI        ; 2
                beq     .skipHi             ; 2/3       no new high sound was triggered
                lsr                         ; 2
                lsr                         ; 2
                adc     #<(SoundTblHi-SoundTbl-4)
                jsr     StartSound          ; 6
.skipHi:
                lda     #0                  ; 2         prepare for new triggers
                sta     newSounds           ; 3

    ; fall through

; The issue here is that this code writes to channels which are not in use.

                NEXT_RANDOM                     ; this makes sure rnd is updated each frame, also used for other things!

.freqVibrato    = tmpVar                        ; @Andrew: replace with whatever is available
; called once/frame
                ldx     #1
.loopSound:

                lda     soundIdxLst,x
                beq     .nextSound              ; don't write to inactive channels! IMPORTANT SO MUSIC CAN CO-EXIST

                cmp     #OFSS_BONUS_POINTS
                beq     .bonusPointsSound       ;

                lda     decayTimeLst,x
                bne     .contNote
; start next note:
                ldy     decayIdxLst,x
                lda     DecayTbl,y
                sta     AUDV0,x
                bne     .contSound
; current sound is over, now check what to do next:
                ldy     soundIdxLst,x
                cpy     #OFSS_BONUS_POINTS
                beq     .bonusPointsSound       ;
                lda     SoundTbl+OFS_DIST,y     ;   loop sound?
                bpl     .endSound               ;
                jsr     RestartSound
                bne     .loopSound

; special handling for score countdown sound:
.bonusPointsSound:
                lda     soundBonusPts
                tay
                and     #$03
                eor     #$03
                sta     .freqVibrato
                tya
                lsr
                lsr
                lsr
                sec                             ; frequency divider:
                sbc     .freqVibrato            ; 1,2,3,4, 1,2,3,4, 2,3,4,5...
                sta     AUDF0                   ; ...28,29,30,31, 28,29,30,31
                lda     #VOL_SOUND_BONUS
                sta     AUDV0
;                cpy     #MAX_SOUND_BONUS-1
;                bcc     .skipReset
                tya
                bne     .skipReset
  IF LOW_BONUS_SOUND
                ldy     #DIST_DIV31
                sty     AUDC0
                ldy     #$38-1
  ELSE
                ldy     #MIN_SOUND_BONUS-1
  ENDIF
                sty     soundBonusPts           ; = decayIdxLst !
.skipReset:
;                lda     #1<<4                   ; -> decayTimeLst,x = 1

; continue with normal sounds:
.contSound:
                lsr
                lsr
                lsr
                lsr
                sta     decayTimeLst,x
                inc     decayIdxLst,x
.contNote:
                dec     decayTimeLst,x
.nextSound:
                dex
                bpl     .loopSound
                rts
.endSound:
                lda     #0                      ; THIS FIXES THE SOUNDS NOT 'STOPPING' -- A was NOT 0 as commented below :)
                sta     soundIdxLst,x           ; a = 0!
                beq     .nextSound


;-----------------------------------------------------------
; S O U N D - D A T A
;-----------------------------------------------------------

DIST_NOISE      = $08
DIST_DIV2       = $04 ; 15720..491 Hz
DIST_DIV6       = $0c ;  5240..164 Hz
DIST_DIV31      = $06 ;  1014.. 32 Hz
;DIST_DIV93      = $0e ; unused

LOOP_SOUND      = $80

OFS_DIST        = 0
OFS_FREQ        = 1
OFS_RND_FREQ    = 2
OFS_DECAY       = 3

MIN_SOUND_BONUS = $20   ;$08
MAX_SOUND_BONUS = $100  ;$e8
VOL_SOUND_BONUS = $07

;Note: The ADSR values documented at www.elmerproductions.com/sp/peterb
;  are sometimes not matching what I hear when playing the original
;  Also be base volume is not documented, therefore I assume 15 here. If the
;  result is too loud the decays have to be adjusted.
DecayTbl:
    .byte   $00
DecayMove:          ; 24/12ms = 1/1
    .byte   $12, $14, $00
DecayExplosion:     ; 8/2400ms = 1/144
    .byte   $15                     ;  1
; Vol: 10, Len: 144
    .byte   $5a                     ;  5
    .byte   $59                     ;  5
    .byte   $48                     ;  4
    .byte   $57                     ;  5
    .byte   $56                     ;  5
    .byte   $55                     ;  5
    .byte   $84                     ;  8
    .byte   $b3                     ; 11
    .byte   $f2, $62                ; 21
    .byte   $f1;, $f1, $f1, $f1, $f1 ; 75   shortened!
    .byte   $00
DecayDiamondPickup: ; 2/6ms??  != 1/30
DecayBOX:
; Vol: 10, Len: 30
    .byte   $1a                     ;  1
    .byte   $19                     ;  1
    .byte   $18                     ;  1
    .byte   $17                     ;  1
    .byte   $16                     ;  1
    .byte   $15                     ;  1
    .byte   $24                     ;  2
    .byte   $23                     ;  2
    .byte   $42                     ;  4
    .byte   $f1, $11                ; 16
    .byte   $00
DecayDiamondFalling:; 2/6+6ms??  != 1/30
    .byte   $13                     ;  1
; Vol: 7, Len: 30
    .byte   $17                     ;  1
    .byte   $26                     ;  2
    .byte   $15                     ;  1
    .byte   $24                     ;  2
    .byte   $23                     ;  2
    .byte   $42                     ;  4
    .byte   $f1, $31                ; 18
    .byte   $00
DecayAmoeba:        ; 24/??ms
;    .byte   $12, $13, $12, $00
    .byte   $11, $12, $13, $00
DecayMagic:         ;  2/12ms = 0/1
    .byte   $13, $00
DecayCrack:         ; 24/750ms = 2/45
    .byte   $15                     ;  1
; Vol: 10, Len: 45
    .byte   $1a                     ;  1
    .byte   $29                     ;  2
    .byte   $28                     ;  2
    .byte   $17                     ;  1
    .byte   $26                     ;  2
    .byte   $15                     ;  1
    .byte   $34                     ;  3
    .byte   $33                     ;  3
    .byte   $62                     ;  6
    .byte   $f1, $91                ; 24
    .byte   $00
;DecayUncover:       ; 2/168/??ms = 0/10
;    .byte   $1a                     ;  1
;    .byte   $19                     ;  1
;    .byte   $18                     ;  1
;    .byte   $17                     ;  1
;    .byte   $16                     ;  1
;    .byte   $15                     ;  1
;    .byte   $24                     ;  2
;    .byte   $23                     ;  2
;    .byte   $42                     ;  4
;    .byte   $f1, $11                ; 16
;    .byte   $00
DecayTime:          ; 2/1500ms = 1/90
    .byte   $15                     ;  1
; Vol: 10, Len: 90
    .byte   $3a                     ;  3
    .byte   $39                     ;  3
    .byte   $38                     ;  3
    .byte   $37                     ;  3
    .byte   $36                     ;  3
    .byte   $35                     ;  3
    .byte   $54                     ;  5
    .byte   $73                     ;  7
    .byte   $d2                     ; 13
    .byte   $f1, $f1, $f1, $21      ; 47
    .byte   $00

    ALIGN 256

;Note: The exact NOISE base frequency is not working. Therefore I assume a base
; frequency of 2620 HZ (31440/6) after comparing the sounds with the original.
SoundTbl:
    .byte   0
    .byte   0, 0
    .byte   0
OFSS_MOVE_BLANK        = . - SoundTbl
    .byte   DIST_NOISE
    .byte   2, 0    ; ~873 Hz (vs. 827)
    .byte   DecayMove-DecayTbl
OFSS_MOVE_SOIL         = . - SoundTbl
    .byte   DIST_NOISE
    .byte   0, 0    ; ~2620 Hz (vs. 2576)
    .byte   DecayMove-DecayTbl


;Sounds of group LO belong to channel 0. If a new sound is requested, this
; overwrites existing sounds:
SOUND_GROUP_LO  = . - SoundTbl

OFSS_BOX           = . - SoundTbl
    .byte   DIST_NOISE
    .byte   17, 0   ; ~146 Hz (vs. 143)
    .byte   DecayBOX-DecayTbl
OFSS_DIAMOND_PICKUP    = . - SoundTbl
    .byte   DIST_DIV6
    .byte   16, 0   ; 308 Hz
    .byte   DecayDiamondPickup-DecayTbl
OFSS_DIAMOND_FALLING   = . - SoundTbl
    .byte   DIST_DIV2
    .byte   3, 5    ; 1965..3930 Hz
    .byte   DecayDiamondFalling-DecayTbl
OFSS_EXPLOSION         = . - SoundTbl
    .byte   DIST_NOISE
    .byte   7, 0    ; ~328 Hz (vs. 315)
    .byte   DecayExplosion-DecayTbl
OFSS_BONUS_POINTS      = . - SoundTbl
; at the end of each level, the time is counted down 30s/frame,
; during that period, this sound it played
; it last for up to
; Note: the last 10s (= 20 frames) the timer sound is played
    .byte   DIST_DIV6
    .byte   0, 0    ; unused (vs. 3246..164)
    .byte   MIN_SOUND_BONUS     ; here the inital frequency divider is set!


;Sounds of group HI belong to channel 1. If a new sound is requested, this
; only overwrites existing sounds if it has higher priority (index).
SOUND_GROUP_HI  = . - SoundTbl

SoundTblHi
OFFS_HI                = . - SoundTbl

OFSS_MOVE_BLANK_HI     = . - SoundTbl
    .byte   DIST_NOISE
    .byte   2, 0    ; ~873 Hz (vs. 827)
    .byte   DecayMove-DecayTbl
OFSS_MOVE_SOIL_HI      = . - SoundTbl
    .byte   DIST_NOISE
    .byte   0, 0    ; ~2620 Hz (vs. 2576)
    .byte   DecayMove-DecayTbl
OFSS_AMOEBA            = . - SoundTbl
    .byte   DIST_DIV31|LOOP_SOUND
    .byte   4, 5    ; 101..203 Hz
    .byte   DecayAmoeba-DecayTbl
OFSS_MAGIC_WALL        = . - SoundTbl
    .byte   DIST_DIV2|LOOP_SOUND
    .byte   5, 3    ; 1965..2620 Hz
    .byte   DecayMagic-DecayTbl
OFSS_CRACK             = . - SoundTbl
    .byte   DIST_NOISE
    .byte   3, 0    ; ~655 Hz (vs. 737)
    .byte   DecayCrack-DecayTbl
;OFSS_UNCOVER           = . - SoundTbl
;    .byte   DIST_DIV2|LOOP_SOUND
;    .byte   4, 6    ; 1572..3930 Hz (vs. 1561..3543)
;    .byte   DecayUncover-DecayTbl
OFSS_TIME_9            = . - SoundTbl
    .byte   DIST_DIV6
    .byte   11, 0    ; 437 Hz (vs. 468)
    .byte   DecayTime-DecayTbl
OFSS_TIME_8            = . - SoundTbl
    .byte   DIST_DIV6
    .byte   10, 0    ; 476 Hz (vs. 484)
    .byte   DecayTime-DecayTbl
OFSS_TIME_7            = . - SoundTbl
    .byte   DIST_DIV2
    .byte   31, 0    ; 491 Hz (vs. 500)
    .byte   DecayTime-DecayTbl
OFSS_TIME_6            = . - SoundTbl
    .byte   DIST_DIV2
    .byte   30, 0    ; 507 Hz (vs. 515)
    .byte   DecayTime-DecayTbl
OFSS_TIME_5            = . - SoundTbl
    .byte   DIST_DIV2
    .byte   29, 0    ; 524 Hz (vs. 531)
    .byte   DecayTime-DecayTbl
OFSS_TIME_4            = . - SoundTbl
    .byte   DIST_DIV2
    .byte   28, 0    ; 542 Hz (vs. 546)
    .byte   DecayTime-DecayTbl
OFSS_TIME_3            = . - SoundTbl
    .byte   DIST_DIV2
    .byte   27, 0    ; 561 Hz (vs. 562)
    .byte   DecayTime-DecayTbl
OFSS_TIME_2            = . - SoundTbl
    .byte   DIST_DIV2
    .byte   26, 0    ; 582 Hz (vs. 578)
    .byte   DecayTime-DecayTbl
OFSS_TIME_1           = . - SoundTbl
    .byte   DIST_DIV2
    .byte   25, 0    ; 605 Hz (vs. 593)
    .byte   DecayTime-DecayTbl
OFSS_TIME_0            = . - SoundTbl
    .byte   DIST_DIV2
    .byte   24, 0    ; 629 Hz (vs. 609)
    .byte   DecayTime-DecayTbl


; special low priority:
SOUND_MOVE_BLANK        = OFSS_MOVE_BLANK / 4
SOUND_MOVE_SOIL         = OFSS_MOVE_SOIL / 4
; group lo:
SOUND_BOX           = OFSS_BOX / 4
SOUND_EXPLOSION         = OFSS_EXPLOSION / 4
SOUND_DIAMOND_PICKUP    = OFSS_DIAMOND_PICKUP / 4
SOUND_DIAMOND_FALLING   = OFSS_DIAMOND_FALLING / 4
SOUND_BONUS_POINTS      = OFSS_BONUS_POINTS / 4
; group hi:

SOUND_AMOEBA            = (OFSS_AMOEBA  - OFFS_HI) * 4 + $10
SOUND_MAGIC_WALL        = (OFSS_MAGIC_WALL  - OFFS_HI) * 4 + $10
SOUND_CRACK             = (OFSS_CRACK  - OFFS_HI) * 4 + $10
SOUND_TIME_9            = (OFSS_TIME_9  - OFFS_HI) * 4 + $10
SOUND_TIME_8            = (OFSS_TIME_8  - OFFS_HI) * 4 + $10
SOUND_TIME_7            = (OFSS_TIME_7  - OFFS_HI) * 4 + $10
SOUND_TIME_6            = (OFSS_TIME_6  - OFFS_HI) * 4 + $10
SOUND_TIME_5            = (OFSS_TIME_5  - OFFS_HI) * 4 + $10
SOUND_TIME_4            = (OFSS_TIME_4  - OFFS_HI) * 4 + $10
SOUND_TIME_3            = (OFSS_TIME_3  - OFFS_HI) * 4 + $10
SOUND_TIME_2            = (OFSS_TIME_2  - OFFS_HI) * 4 + $10
SOUND_TIME_1            = (OFSS_TIME_1  - OFFS_HI) * 4 + $10
SOUND_TIME_0            = (OFSS_TIME_0  - OFFS_HI) * 4 + $10
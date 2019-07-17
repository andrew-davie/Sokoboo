    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

    NEWBANK TITLE_LOGO_BANK
;
;===============================================================================
; code starts here
;===============================================================================

FREE SET 0

SwitchToNewFrameTitleBank SUBROUTINE
    lda     #BANK_TitleScreen       ; 2
    sta     SET_BANK                ; 3
    jmp     ContTitle               ; 3 = 8

; unused, but required!
    ds      4, 0
; coming from SwitchToDrawLogoBank

    ; fall through

;--------------------------------------------------------------------------
; 6-sprite routine; 32 lines of sprites for "First Star Software" logo.
    DEFINE_SUBROUTINE DrawLogo

    ;--------------------------------------------------------------------------
    ; Object X,Y positioning
    ; Timing is absolutely critical here!

                                    ;           @29

    lda     #$a3                    ; 2
    sta     HMP1                    ; 3 =  5    @38

;    lda     #%00011                 ; 2
    sta     NUSIZ0                  ; 3
    sta     NUSIZ1                  ; 3
    sta     VDELP0                  ; 3 = 11    @49

    sta     RESP0                   ; 3         @52
    sta     RESP1                   ; 3 =  6    @55

    sta     VDELP1                  ; 3
    lda     #TWHITE                 ; 2
    sta     COLUP1                  ; 3
    ldy     #LKERNEL_H/2-1          ; 2
    sty     loopCntFSS              ; 3 = 13    @68

    lda     audV0LstBtm,y           ; 4
    and     #VOL_MASK               ; 2
;---------------------------------------
    sta     HMOVE                   ; 3
    jmp     .enterFSSLoop           ; 3 = 12    @04

;    ALIGN_FREE 256

    ;--------------------------------------------------------------------------
    ; Code is exquisitely timed so that each line takes
    ; *EXACTLY* 76 cycles.  Code cannot cross page-boundaries, as the branch
    ; would then take an extra cycle, and bugger the display.

LoopFSS                             ;           @13
    dey                             ; 2
    sty     loopCntFSS              ; 3 =  5    @18

    lda     FSSlogoB0,y             ; 4
    sta     GRP0                    ; 3
    lda     FSSlogoB1,y             ; 4
    sta     GRP1                    ; 3
    lda     FSSlogoB2,y             ; 4
    sta     GRP0                    ; 3 = 21    @39

    lda     FSSlogoB5,y             ; 4
    sta     tmpGfx                  ; 3
    lax     FSSlogoB4,y             ; 4
    lda     FSSlogoB3,y             ; 4 = 15
    ldy     tmpGfx                  ; 3
    sta     GRP1                    ; 3
    stx     GRP0                    ; 3
    sty     GRP1                    ; 3
    sta     GRP0                    ; 3 = 15    @69

    ldy     loopCntFSS              ; 3
    SLEEP   2                       ; 2 =  5    @74
;---------------------------------------
    lda     audV0LstBtm,y           ; 4
    and     #VOL_MASK               ; 2
.enterFSSLoop                       ;           @04
    UPDATE_MUSIC_SET_VOL 0          ; 3         @07!    <-- AUDV0
    UPDATE_MUSIC_DATA_LO 1          ; 9 = 18    @16

    lda     FSSlogoA0,y             ; 4
    sta.w   GRP0                    ; 4
    lda     FSSlogoA1,y             ; 4
    sta     GRP1                    ; 3
    lda     FSSlogoA2,y             ; 4
    sta     GRP0                    ; 3 = 22    @38

    lda     FSSlogoA5,y             ; 4
    sta     tmpGfx                  ; 3
    lax     FSSlogoA4,y             ; 4
    lda     FSSlogoA3,y             ; 4 = 15
    ldy     tmpGfx                  ; 3
    sta     GRP1                    ; 3
    stx     GRP0                    ; 3
    sty     GRP1                    ; 3
    sta     GRP0                    ; 3 = 15    @68

    UPDATE_MUSIC_DATA_HI 1          ; 8         @76
;---------------------------------------
    UPDATE_MUSIC_VOL 1              ; 7         @07!    <-- AUDV1

    ldy     loopCntFSS              ; 3
    bne     LoopFSS                 ; 2/3= 5/6
    CHECKPAGE LoopFSS
    sty     GRP0                    ; 3
    dey
    sty     VBLANK                  ; 3         @20     Y = $ff, end of screen - enter blanking
; note: GRP1 is cleared later!

; here we return from the other bank:
    DEFINE_SUBROUTINE ContTitle                           ;           @17/18
; copy last precalculated channel 0 value for on-the-fly calculations:
    lda     audvTmpLo               ; 3
    sta     audv0Lo                 ; 3
    lda     audV0LstBtm             ; 3                 should be always even...
    lsr                             ; 2                 ...so no carry set here
    sta     audv0Hi                 ; 3 = 14    @32

; new BD music
    lda     #NOTE_OFF_LEN-1         ; 2                 run music for 7 frames, then turn off
    cmp     noteLen                 ; 3
    bmi     .skipChangeNote         ; 2/3= 7/8          C == 0 if taken!
    lda     noteLen                 ; 3                 update frame counter
    bmi     .nextNote               ; 2/3

StopNote                            ;           @46     debug label
; calculate offset of precalculated values:
    ldy     #(SCANLINES_NTSC-196)/2-1;2
    lda     Platform                ; 3
    beq     .stopNoteNTSC           ; 2/3
    ldy     #(SCANLINES_PAL-196)/2-1; 2
.stopNoteNTSC
    ldx     noteIdx                 ; 3
    lda     MusicData,x             ; 4
;a*y -> a:y, CF = 0
.acc    = audvOfsLo
.aux    = audvOfsHi
;    dey                             ; 2
    sty     .aux                    ; 3
    sta     .acc                    ; 3
    sta     WSYNC
;---------------------------------------
    lda     #0                      ; 2
    lsr     .acc                    ; 5
    ldy     #8                      ; 2
    bcc     .noAdd                  ; 2/3=17.5
.add
    adc     .aux                    ; 3
.noAdd
    ror                             ; 2
    ror     .acc                    ; 5
    dey                             ; 2
    bcs     .add                    ; 2/3
    bne     .noAdd                  ; 2/3=14.5
; max total: 17+120-1 = 136
;    sta     WSYNC                   ;               no music, so no need to update waveforms here
;    and     #$0f                    ;               mask upper 4 bits to avoid overflow
    sta     audvOfsHi               ;               audvOfsLo is in .acc
    sty     note0                   ;               Y == 0, turns off music
    sty     note1
    bcc     .exitUpdateNote         ;               or .exitStopNote, but then audV0LstBtm cannot be assumed always even

;-------------------------------------------------------------------------------
.nextNote                           ;
    sta     WSYNC                   ;               no music, so no need to update waveforms here

    lda     inputBuffer
    and     SWCHA
    ldy     noteIdx
    bne     .contTitle
_CountDown                          ;               label defined for debugging only
    ldx     demoDelay               ;               get collected input over the last 256 notes (initially 0!)
    cmp     #$f0                    ;               any input?
    beq     .noInput
    ldx     #DEMO_DELAY+1           ;               yes, reset delay
    lda     #$f0
.noInput
    clc
    dex
  IF DEMO_VERSION = NO
    stx     demoDelay               ;               no input for DEMO_DELAY frames?
  ELSE
    ldx     #1
  ENDIF
    bne     .contTitle
    stx     sCave                   ;               yes, switch to demo mode
    stx     sLevel
    lda     #$80
    sta     sJoysticks              ;               -> jtoggle = demoMode
    jmp     ExitTitle

.contTitle
    sta     inputBuffer

;        lda     #0
;        sta     audv0Lo
;        sta     audv0Hi
;        sta     audv1Lo
;        sta     audv1Hi
    sta     WSYNC
;---------------------------------------
    ldx     #NOTE_LEN_NTSC-1
  IF NOTE_LEN_NTSC > NOTE_LEN_PAL
    lda     Platform
    beq     .ntscLen
    dex                             ;                   == NOTE_LEN_PAL-1
.ntscLen:
  ENDIF
    stx     noteLen                 ;                   reset frame counter

    ldy     noteIdx
    lda     MusicData,y             ;                   grab and store next channel 0 note
    sta     note0
    iny                             ;                   next channel
    lda     MusicData,y             ;                   grab and store next channel 1 note
    sta     note1
    iny
    sty     noteIdx                 ;                   get ready for next note
    sta     WSYNC                   ;                   still no music yet, don't update waveforms
;---------------------------------------
    bcc     .exitUpdateNote

;-------------------------------------------------------------------------------
TEST2
.skipChangeNote                     ;           @40/41  still playing current notes
    jsr     UpdateMusicWSync0L      ;39
    jsr     UpdateMusicWSync1L      ;39
    jsr     UpdateMusicWSync0L      ;39

.exitUpdateNote
    CHECK_CLC
    lda     audv0Lo                 ; 3
    adc     audvOfsLo               ; 3
    sta     audvTmpLo               ; 3
    lda     audv0Hi                 ; 3
;    and     #$0f                    ; 2             mask upper 4 bits to avoid overflow here and later
    adc     audvOfsHi               ; 3              ...now this can't overflow!
    asl                             ; 2
    clc

.exitStopNote
  IF L276
    ldy     #(36-PC_BTM/2)/2        ; 2
  ELSE
    ldy     #(28-PC_BTM/2)/2        ; 2
  ENDIF
    ldx     Platform                ; 3
    beq     .overScanNTSC           ; 2/3
    ldy     #(42-PC_BTM/2)/2        ; 2 =  9
.overScanNTSC
    sty     tmpY

; here we precalculate the first 48 values:
    tay                             ; 2
    ldx     #PC_BTM-1               ; 2
.loopOverScan
;---------------------------------------
    UPDATE_MUSIC_WSYNC 1            ;27         @07     maintain sound while precalcuating
; 1st calculation:
    CHECK_CLC
    lda     audvTmpLo               ; 3
    adc     note0                   ; 3 =  6
    bcc     .skipHi1                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi1
    sty     audV0Lst+PC_TOP,x       ; 4
    dex                             ; 2 = 14
; 2nd calculation:
    CHECK_CLC
    adc     note0                   ; 3
    sta     audvTmpLo               ; 3 =  6
    bcc     .skipHi2                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi2
    sty     audV0Lst+PC_TOP,x       ; 4
    dex                             ; 2 = 14
; total: 63                                     @47 max
;---------------------------------------
    UPDATE_MUSIC_WSYNC 0            ;27         @07     maintain sound while precalcuating
; 3rd calculation:
    CHECK_CLC
    lda     audvTmpLo               ; 3
    adc     note0                   ; 3 =  6
    bcc     .skipHi3                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi3
    sty     audV0Lst+PC_TOP,x       ; 4
    dex                             ; 2 = 14
; 4th calculation:
    CHECK_CLC
    adc     note0                   ; 3
    sta     audvTmpLo               ; 3 =  6
    bcc     .skipHi4                ; 2/3
    iny                             ; 2
    iny                             ; 2
    clc                             ; 2
.skipHi4
    sty     audV0Lst+PC_TOP,x       ; 4
    dex                             ; 2 = 14
    bpl     .loopOverScan           ; 2/3

    ldy     tmpY                    ; 3
.waitOverScan
;---------------------------------------
;    jsr     UpdateMusicWSync1L      ;39
    UPDATE_MUSIC_WSYNC 1            ;27         @07     maintain sound while precalcuating

    lda     btnReleased             ; 3
    beq     .notReleased            ; 2/3
    bit     INPT4                   ; 4         button pressed?
    bmi     .exitButton             ; 2/3

; switch to next mode:
    dec     btnReleased             ; 5
    dec     titleMode               ; 5
    bpl     .exitButton             ; 2/3
     ;--------------------------------------------------------------------------
; title screen done
; clear the RAM (between Platform and last zeropage variables) to avoid wrongly initialized variables
ExitTitle                           ;           debug label  only
    lda     #0
    ldx     #DSL-endTitleClear-1
.loopClear
    sta     endTitleClear+1,x
    dex
    bpl     .loopClear
    jmp     ExitTitleScreen

.notReleased
    bit     INPT4                   ; 4         button released?
    bpl     .exitButton             ; 2/3
    inc     btnReleased             ; 5
.exitButton                         ;   = 24    @31 max

; free: 20
; prepare evaluating joystick up and down:
    ldx     selRow                  ; 3
    lda     SWCHA                   ; 4
    eor     #$ff                    ; 2
    asl                             ; 2
    asl                             ; 2
    pha                             ; 3
    clc                             ; 2 = 18
;---------------------------------------
;    jsr     UpdateMusicWSync0L      ;39         @13
    UPDATE_MUSIC_WSYNC 0            ;27         @07

    pla                             ; 4

    dey                             ; 2
    bne     .waitOverScan           ; 2/3= 8/9

    sty     GRP1                    ; 3 =  3    @18

    asl                             ; 2
    bcc     .notDown                ; 2/3
    inx                             ; 2
    lda     sPlayers                ; 3
    beq     .onePlayer              ; 2/3
    cpx     #NUM_SEL                ; 2
    bcc     .setJoyY                ; 2/3
    clc                             ; 2
    bcc     .skipJoyY               ; 3

.onePlayer                          ;12
    cpx     #NUM_SEL-1              ; 2
    bcc     .setJoyY                ; 2/3
    clc                             ; 2
    bcc     .skipJoyY               ; 3 = 21

.notDown                            ; 5
    bpl     .skipJoyY               ; 2/3
    dex                             ; 2
  IF DEMO_VERSION = NO
    bmi     .skipJoyY               ; 2/3
  ELSE
    beq     .skipJoyY               ; 2/3
  ENDIF
.setJoyY
    lda     noteLen                 ; 3
    bne     .skipJoyY               ; 2/3
    stx     selRow                  ; 3 =  8
.skipJoyY                           ;
; free: 5
;    jmp     NewFrameTitle           ; 3 = 29 max
    jmp     SwitchToNewFrameTitleBank;11 = 37 max

 ;-----------------------------------------------------------

UpdateMusicWSync0L
; maintain first channel
    UPDATE_MUSIC_WSYNC 0            ;27
    rts                             ; 6 = 33

UpdateMusicWSync1L
; maintain second channel
    UPDATE_MUSIC_WSYNC 1            ;27
    rts                             ; 6 = 33

;-----------------------------------------------------------
    OPTIONAL_PAGEBREAK "FSSlogo", (31*6)
;    ALIGN_FREE 256

FSSlogo
FSSlogoA0
FSSlogoA1
FSSlogoA2
FSSlogoA3
FSSlogoA4
FSSlogoA5
FSSlogoB0
FSSlogoB1
FSSlogoB2
FSSlogoB3
FSSlogoB4
FSSlogoB5
  ds 16,0
    CHECKPAGE FSSlogo

    ALIGN_FREE 256

; Music data for two channels
; exactly 256 bytes, must start at page start!
MusicData:
    .byte   45 ,  23
    .byte   57 ,  34
    .byte   68 ,  45
    .byte   91 ,  54
    .byte   51 ,  20
    .byte   61 ,  38
    .byte   68 ,  40
    .byte   102,  61
    .byte   72 ,  18
    .byte   81 ,  18
    .byte   91 ,  36
    .byte   108,  18
    .byte   81 ,  40
    .byte   153,  121
    .byte   86 ,  43
    .byte   136,  108
    .byte   45 ,  23
    .byte   91 ,  23
    .byte   34 ,  23
    .byte   51 ,  23
    .byte   40 ,  20
    .byte   102,  20
    .byte   51 ,  20
    .byte   40 ,  20
    .byte   45 ,  23
    .byte   91 ,  23
    .byte   34 ,  23
    .byte   51 ,  23
    .byte   72 ,  36
    .byte   182,  36
    .byte   91 ,  36
    .byte   72 ,  36
    .byte   81 ,  20
    .byte   81 ,  20
    .byte   30 ,  20
    .byte   45 ,  20
    .byte   64 ,  32
    .byte   162,  32
    .byte   81 ,  32
    .byte   64 ,  32
    .byte   34 ,  17
    .byte   86 ,  68
    .byte   38 ,  17
    .byte   91 ,  68
    .byte   61 ,  15
    .byte   61 ,  15
    .byte   121,  23
    .byte   61 ,  23
    .byte   91 ,  23
    .byte   91 ,  23
    .byte   91 ,  23
    .byte   91 ,  23
    .byte   91 ,  45
    .byte   91 ,  45
    .byte   91 ,  23
    .byte   91 ,  23
    .byte   91 ,  20
    .byte   91 ,  20
    .byte   91 ,  20
    .byte   91 ,  20
    .byte   91 ,  40
    .byte   91 ,  40
    .byte   91 ,  20
    .byte   91 ,  20
    .byte   91 ,  23
    .byte   115,  91
    .byte   91 ,  23
    .byte   121,  91
    .byte   91 ,  45
    .byte   115,  91
    .byte   91 ,  23
    .byte   121,  91
    .byte   91 ,  20
    .byte   115,  91
    .byte   91 ,  20
    .byte   121,  91
    .byte   81 ,  40
    .byte   102,  81
    .byte   81 ,  20
    .byte   108,  81
    .byte   91 ,  23
    .byte   182,  23
    .byte   91 ,  23
    .byte   162,  136
    .byte   91 ,  45
    .byte   153,  45
    .byte   91 ,  23
    .byte   136,  108
    .byte   81 ,  20
    .byte   162,  20
    .byte   81 ,  20
    .byte   162,  20
    .byte   81 ,  40
    .byte   121,  40
    .byte   81 ,  20
    .byte   162,  20
    .byte   91 ,  23
    .byte   115,  91
    .byte   91 ,  23
    .byte   121,  91
    .byte   91 ,  45
    .byte   115,  91
    .byte   91 ,  23
    .byte   121,  91
    .byte   91 ,  20
    .byte   115,  91
    .byte   91 ,  20
    .byte   121,  91
    .byte   81 ,  40
    .byte   102,  81
    .byte   81 ,  20
    .byte   108,  81
    .byte   115,  91
    .byte   91 ,  68
    .byte   68 ,  57
    .byte   57 ,  45
    .byte   102,  81
    .byte   81 ,  61
    .byte   61 ,  51
    .byte   40 ,  20
    .byte   136,  115
    .byte   115,  91
    .byte   91 ,  68
    .byte   68 ,  57
    .byte   102,  61
    .byte   81 ,  51
    .byte   61 ,  40
    .byte   40 ,  20


FREE SET FREE + BANK_START + ROM_BANK_SIZE/2 - .

    ECHO "Free bytes in TITLE_LOGO_BANK:", FREE

    CHECK_HALF_BANK_SIZE "TITLE_LOGO_BANK"

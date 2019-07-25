; segtime optimization (averages):
;   lost time = segtime/2 * 64
;   num-segments = (vblank + overscan time) (NTSC 276=62+51=113) / 2 / segtime
;   overhead: num-segments * 8 (assuming minimal INTIM check only)
;
; segtime = 2:
;   lost time = 64
;   num-segments = 28
;   overhead = 224!
; segtime = 3:
;   lost time = 96
;   num-segments = 18
;   overhead = 144!
; segtime = 4:              <--!!!
;   lost time = 128!
;   num-segments = 28
;   overhead = 112
; segtime = 5:
;   lost time = 160!
;   num-segments = 11
;   overhead = 88
; segtime = 6:
;   lost time = 192!
;   num-segments = 9
;   overhead = 72
; segtime = 7:
;   lost time = 224!
;   num-segments = 8
;   overhead = 64
; segtime = 10:
;   lost time = 320!
;   num-segments = 5
;   overhead = 40
; segtime = 20:
;   lost time = 640!
;   num-segments = 2
;   overhead = 16
; segtime = 40:
;   lost time = 1280!
;   num-segments = 1
;   overhead = 8

; optimal INTIM segtime is 4 + 1 = 5,
; below wasted time increases rapidly, above only moderately
; if the overhead becomes larger, optimal segtimes will increase too
; also the lost time will become smaller, if smaller segments can be used instead,
;  so larger segtimes are not that bad then


 MAC SEGTIME
{1} SET {2}
TEST_{1} = 0
 ENDM

 MAC XSEGTIME
{1} SET {2}-1
TEST_{1} = 1
 ENDM

;@TJ -- SIMPLY PUT AN X IN FRONT OF THE LINE(S) YOU WANT TO TEST
; eg: XSEGTIME SEGTIME_BOX1,5
; No other action required.  All code enables/disables automatically.

; 2012/02/11 -- experimental reduction in times (but not stress tested)
; due to separation of timeslice overhead to separate check

    SEGTIME SEGTIME_SCD_DIRECT,8                ; TODO: 392@12/2/2012
    SEGTIME SEGTIME_SCD_QUICK,9                 ; TODO: 414@12/2/2012
    SEGTIME SEGTIME_SCD_SLOW,12                  ; TODO: cycles: ~635 @12/2/2012.
    SEGTIME SEGTIME_SCD_PF0,5                   ; TODO: cycle counted ~126 @12/2/2012
    SEGTIME SEGTIME_SCD_MIN,SEGTIME_SCD_PF0     ; * MINIMUM TIME OF THE ABOVE + 1

 IF MULTI_BANK_BOARD = YES
    SEGTIME SEGTIME_BDF,42                      ; * 5/8/11 stress tested DHS->DS
 ELSE
    SEGTIME SEGTIME_BDF,41                      ; * 7/8/11
 ENDIF

    SEGTIME SEGTIME_BDS,5                       ; *AD 11/8/11
    SEGTIME SEGTIME_DSL,5                       ; * 9/8/11 unrolled once



    SEGTIME MINIMUM_SORT_TIME,3                ;     157(A)->2.45


    ;following will lock-up system if used as 'XSEGTIME'.
    SEGTIME MINIMUM_SEGTIME,4                 ; processing slice minimum requirement

    SEGTIME MINIMUM_SEGTIMEBLANK,16 ;17             ; * 7/8/11      993(A)->15.5

    ; MINIMUM_SEGTIME
    ; MINIMUM_SEGTIMEBLANK
    ; SEGTIME_BDF
    ; SEGTIME_BDS
    ; SEGTIME_DSL
    ; SEGTIME_SWITCHOBJECTS

    SEGTIME SEGTIME_MINIMUM_TIMESLICE,MINIMUM_SEGTIME+1      ; MINIMUM of the TIMESLICE segments listed above

        ; Note: we add 1 to the minimum because there's a bit of overhead at the start of the timeslice code which vectors
        ; to the appropriate timeslice.  That timeslice then checks the segtime again -- and in the case of the minimum we
        ; will already have used 55 cycles of the available timeslice to get to the segtime check. Given that there are only
        ; 9 spare cycles in the 'unit' left, it's probably more efficient to abort earlier and save those 55 cycles for other
        ; uses ...


; The following timings have been physicaly timed via code/debugger... the comment shows the worst observed time.
; Generally the allocated segtime should be a bit bigger than the worst observed, to cater for the minor code
; outside the creature itself which might otherwise cause screen time over-run.

; The following are NOT object-related and timing is a bit of manual guesswork/calculation
; Comment may indicate at what value a glitch was DEFINITELY seen. These timings may not be optimal.

    SEGTIME SEGTIME_MAN,24 ;<< using this as XSEGTIME stops player working ...?!
    SEGTIME SEGTIME_CIRCLE, 10        ; drawing circle creature
    SEGTIME SEGTIME_CIRCLE_HELPER, 10        ; drawing circle creature's helper

; TJ: I should only prevent processes with an extra check (e.g. get diamond)

; push BOX is slowest (besides get diamond which has an extra timer check)
; if we add another check for it, SEGTIME_MAN reduces by ~5

    SEGTIME SEGTIME_BOX1,5                  ; ~182 cycles if falling on man + sort overhead!
    SEGTIME SEGTIME_BOX3,8                  ; SEGTIME_BOX4 causes freezes if stressed
    SEGTIME SEGTIME_BOX4,7                  ;(*) not 100% sure, maybe one more
    SEGTIME SEGTIME_MAGIC,SEGTIME_BOX4 + 2  ; tied together (diamond falling through magic wall)

; the following values have been tested with the STRESS_TIME macro:
 IF MULTI_BANK_BOARD = YES
    SEGTIME SEGTIME_BIGBANG,34                  ; TODO* 5/8/11, 1732(B)+218(butterfly)->1940->30.3
 ELSE
    SEGTIME SEGTIME_BIGBANG,31                  ; * 7/8/11
 ENDIF
    SEGTIME SEGTIME_EXPLOSION,7                 ; * 5/8/11
    SEGTIME SEGTIME_GET_DIAMOND,17              ; * 14/8/11, required if UpdateScore loops (e.g. 9990->10000)
    SEGTIME SEGTIME_BUTTERFLY,10                ; * 7/8/11, 525(B)->8.20

    SEGTIME SEGTIME_SWITCHOBJECTS,3             ; 16/8/11 by calculation. 72 cycles -->  ceil(72/64)+1 --> 3 Object stack switchover

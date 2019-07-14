;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TIA (Stella) write-only registers
;
Vsync		equ	$00
Vblank		equ	$01
Wsync		equ	$02
Colup0		equ	$06
Colubk		equ	$09
Ctrlpf		equ	$0A
Resm0		equ	$12
Enam0		equ	$1D
Hmm0		equ	$22
Hmove		equ	$2A
Hmclr		equ	$2B
;
; RAM definitions
; Note: The system RAM maps in at 0080-00FF and also at 0180-01FF. It is
; used for variables and the system stack. The programmer must make sure
; the stack never grows so deep as to overwrite the variables.
;
RamStart	equ	$0080
RamEnd		equ	$00FF
StackBottom	equ	$00FF
StackTop	equ	$0080
;
; 6532 (RIOT) registers
;
Swcha		equ	$0280
Swacnt		equ	$0281
Swchb		equ	$0282
Swbcnt		equ	$0283
Intim		equ	$0284
Tim64t		equ	$0296
;
; ROM definitions
;
RomStart        equ     $F000
RomEnd          equ     $FFFF
IntVectors      equ     $FFFA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Ram definitions
;
                ORG     $80
tablePTR        DS      1
colour          DS      1
counter         DS      1
colourcounter   DS      1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Data Area
;
                ORG     $F800
table:          DB      4,5,6,7,8,9,10,11,12,11,10,9,8,7,6,5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Program initialisation
;

Cart_Init:
		SEI				; Disable interrupts.:
		CLD				; Clear "decimal" mode.

		LDX	#$FF
		TXS				; Clear the stack

Common_Init:
		LDX	#$28		; Clear the TIA registers ($04-$2C)
		LDA	#$00
TIAClear:
		STA	$04,X
		DEX
                BPL     TIAClear        ; loop exits with X=$FF
	
		LDX	#$FF
RAMClear:
		STA	$00,X		; Clear the RAM ($FF-$80)
		DEX
                BMI     RAMClear        ; loop exits with X=$7F
	
		LDX	#$FF
		TXS				; Reset the stack
 
IOClear:
		STA	Swbcnt		; console I/O always set to INPUT
		STA	Swacnt		; set controller I/O to INPUT

StarsInit:      LDA     #$03
                STA     colour
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Main program loop
;
Start:
                LDA     #$02
		STA	Wsync		; Wait for horizontal sync
		STA	Vblank		; Turn on Vblank
                STA	Vsync		; Turn on Vsync
		STA	Wsync		; Leave Vsync on for 3 lines
		STA	Wsync
		STA	Wsync
                LDA     #$00
		STA	Vsync		; Turn Vsync off

                LDA     #43             ; Vblank for 37 lines
		STA	Tim64t		; 43*64intvls=2752=8256colclks=36.2lines

                LDA     #$00            ;black
                STA     ColuBK
                LDA     #$0e            ;white
                STA     ColuP0
                LDA     #$02            ;turn missile0 on
                STA     ENAM0
                LDX     tablePTR        ;reposition missile0 every couple of
                                        ;frames for starpattern movement
                LDY     counter
                INY
                CPY     #10
                BNE     @1
                LDY     #0
                INX
                CPX     #16
                BNE     @1
                LDX     #$00
@1:             STX     tablePTR       
                STY     counter
                LDA     table,X
                TAY
                STA     Wsync
@2:             DEY
                BPL     @2
                STA     ResM0
                LDA     #$70            ;this value is important for the effect
                STA     HMM0

                STA     Wsync
                STA     HMOVE
                JSR     Trick           ;waste 18 cycles and load move value
                STA     HMM0            ;this is the tricky part

                LDX     colourcounter   ;change colours for spakling stars
                INX
                STX     colourcounter
                CPX     #3
                BNE     VblankLoop
                LDA     colour
                CLC
                ADC     #$10
                STA     colour

VblankLoop:
		LDA	Intim
                BNE     VblankLoop      ; wait for vblank timer
		STA	Wsync		; finish waiting for the current line
                STA     Vblank          ; turn off Vblank

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Screen:         LDA     colour
                LDY     #192
@1:             STA     Wsync           ;change the colour every line for
                                        ;sparkling stars - otherwise do what
                                        ;you want here
                CLC
                ADC     #$03
                EOR     #$A0
                STA     ColuP0
                DEY
                BNE     @1
                LDA     #$02
                STA     Vblank          ;turn on Vblank
                LDX     #30
@END:           STA     Wsync
                DEX
                BNE     @END
                JMP     Start


Trick:          NOP                     ;the tricky subroutine
                NOP
                LDA     #$60
                RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Set up the 6502 interrupt vector table
;
		ORG	IntVectors
NMI             dw      Cart_Init
Reset           dw      Cart_Init
IRQ             dw      Cart_Init
        
		END

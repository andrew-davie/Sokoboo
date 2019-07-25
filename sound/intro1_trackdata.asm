; TIATracker music player
; Copyright 2016 Andre "Kylearan" Wichmann
; Website: https://bitbucket.org/kylearan/tiatracker
; Email: andre.wichmann@gmx.de
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;   http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

; Song author: 
; Song name: 

; @com.wudsn.ide.asm.hardware=ATARI2600

; =====================================================================
; TIATracker melodic and percussion instruments, patterns and sequencer
; data.
; =====================================================================
tt_TrackDataStart:

; =====================================================================
; Melodic instrument definitions (up to 7). tt_envelope_index_c0/1 hold
; the index values into these tables for the current instruments played
; in channel 0 and 1.
; 
; Each instrument is defined by:
; - tt_InsCtrlTable: the AUDC value
; - tt_InsADIndexes: the index of the start of the ADSR envelope as
;       defined in tt_InsFreqVolTable
; - tt_InsSustainIndexes: the index of the start of the Sustain phase
;       of the envelope
; - tt_InsReleaseIndexes: the index of the start of the Release phase
; - tt_InsFreqVolTable: The AUDF frequency and AUDV volume values of
;       the envelope
; =====================================================================

; Instrument master CTRL values
tt_InsCtrlTable:
        dc.b $07, $04, $0c, $04, $0c


; Instrument Attack/Decay start indexes into ADSR tables.
tt_InsADIndexes:
        dc.b $00, $0e, $0e, $1e, $1e


; Instrument Sustain start indexes into ADSR tables
tt_InsSustainIndexes:
        dc.b $08, $19, $19, $2b, $2b


; Instrument Release start indexes into ADSR tables
; Caution: Values are stored with an implicit -1 modifier! To get the
; real index, add 1.
tt_InsReleaseIndexes:
        dc.b $09, $1b, $1b, $2c, $2c


; AUDVx and AUDFx ADSR envelope values.
; Each byte encodes the frequency and volume:
; - Bits 7..4: Freqency modifier for the current note ([-8..7]),
;       8 means no change. Bit 7 is the sign bit.
; - Bits 3..0: Volume
; Between sustain and release is one byte that is not used and
; can be any value.
; The end of the release phase is encoded by a 0.
tt_InsFreqVolTable:
; 0: Pizzicato bassb
        dc.b $8a, $8a, $89, $88, $86, $85, $85, $84
        dc.b $83, $00, $83, $83, $83, $00
; 1+2: Square2
        dc.b $8c, $8c, $8b, $89, $87, $85, $84, $83
        dc.b $82, $82, $81, $81, $81, $00, $81, $00
; 3+4: Square
        dc.b $85, $85, $85, $85, $84, $83, $83, $82
        dc.b $82, $82, $81, $81, $81, $81, $00, $80
        dc.b $00



; =====================================================================
; Percussion instrument definitions (up to 15)
;
; Each percussion instrument is defined by:
; - tt_PercIndexes: The index of the first percussion frame as defined
;       in tt_PercFreqTable and tt_PercCtrlVolTable
; - tt_PercFreqTable: The AUDF frequency value
; - tt_PercCtrlVolTable: The AUDV volume and AUDC values
; =====================================================================

; Indexes into percussion definitions signifying the first frame for
; each percussion in tt_PercFreqTable.
; Caution: Values are stored with an implicit +1 modifier! To get the
; real index, subtract 1.
tt_PercIndexes:
        dc.b $01, $0a, $0c


; The AUDF frequency values for the percussion instruments.
; If the second to last value is negative (>=128), it means it's an
; "overlay" percussion, i.e. the player fetches the next instrument note
; immediately and starts it in the sustain phase next frame. (Needs
; TT_USE_OVERLAY)
tt_PercFreqTable:
; 0: Kick
        dc.b $00, $01, $02, $03, $04, $05, $06, $87
        dc.b $00
; 1: HH
        dc.b $80, $00
; 2: Snare
        dc.b $01, $03, $06, $0e, $13, $11, $15, $14
        dc.b $17, $1b, $00


; The AUDCx and AUDVx volume values for the percussion instruments.
; - Bits 7..4: AUDC value
; - Bits 3..0: AUDV value
; 0 means end of percussion data.
tt_PercCtrlVolTable:
; 0: Kick
        dc.b $ee, $ed, $ed, $eb, $e9, $e8, $e8, $e6
        dc.b $00
; 1: HH
        dc.b $87, $00
; 2: Snare
        dc.b $8b, $8a, $8a, $8a, $8a, $8a, $89, $88
        dc.b $87, $86, $00


        
; =====================================================================
; Track definition
; The track is defined by:
; - tt_PatternX (X=0, 1, ...): Pattern definitions
; - tt_PatternPtrLo/Hi: Pointers to the tt_PatternX tables, serving
;       as index values
; - tt_SequenceTable: The order in which the patterns should be played,
;       i.e. indexes into tt_PatternPtrLo/Hi. Contains the sequences
;       for all channels and sub-tracks. The variables
;       tt_cur_pat_index_c0/1 hold an index into tt_SequenceTable for
;       each channel.
;
; So tt_SequenceTable holds indexes into tt_PatternPtrLo/Hi, which
; in turn point to pattern definitions (tt_PatternX) in which the notes
; to play are specified.
; =====================================================================

; ---------------------------------------------------------------------
; Pattern definitions, one table per pattern. tt_cur_note_index_c0/1
; hold the index values into these tables for the current pattern
; played in channel 0 and 1.
;
; A pattern is a sequence of notes (one byte per note) ending with a 0.
; A note can be either:
; - Pause: Put melodic instrument into release. Must only follow a
;       melodic instrument.
; - Hold: Continue to play last note (or silence). Default "empty" note.
; - Slide (needs TT_USE_SLIDE): Adjust frequency of last melodic note
;       by -7..+7 and keep playing it
; - Play new note with melodic instrument
; - Play new note with percussion instrument
; - End of pattern
;
; A note is defined by:
; - Bits 7..5: 1-7 means play melodic instrument 1-7 with a new note
;       and frequency in bits 4..0. If bits 7..5 are 0, bits 4..0 are
;       defined as:
;       - 0: End of pattern
;       - [1..15]: Slide -7..+7 (needs TT_USE_SLIDE)
;       - 8: Hold
;       - 16: Pause
;       - [17..31]: Play percussion instrument 1..15
;
; The tracker must ensure that a pause only follows a melodic
; instrument or a hold/slide.
; ---------------------------------------------------------------------
TT_FREQ_MASK    = %00011111
TT_INS_HOLD     = 8
TT_INS_PAUSE    = 16
TT_FIRST_PERC   = 17

; Intro left
tt_pattern0:
        dc.b $11, $08, $3e, $08, $12, $3e, $3e, $08
        dc.b $13, $08, $3e, $08, $12, $3e, $3e, $08
        dc.b $11, $08, $3e, $08, $12, $3e, $12, $3e
        dc.b $13, $08, $3e, $08, $12, $3e, $13, $08
        dc.b $00

; Intro2 L
tt_pattern1:
        dc.b $11, $08, $34, $08, $12, $34, $34, $08
        dc.b $13, $08, $34, $08, $12, $34, $34, $08
        dc.b $11, $08, $34, $08, $12, $34, $12, $34
        dc.b $13, $08, $34, $08, $12, $34, $13, $08
        dc.b $00

; Intro2-fill L
tt_pattern2:
        dc.b $11, $08, $34, $08, $12, $34, $34, $08
        dc.b $13, $08, $34, $08, $12, $34, $34, $08
        dc.b $11, $08, $34, $08, $12, $34, $12, $34
        dc.b $13, $08, $34, $08, $12, $34, $13, $08
        dc.b $00

; Intro right
tt_pattern3:
        dc.b $6f, $08, $73, $08, $6e, $08, $73, $08
        dc.b $6f, $08, $73, $08, $73, $08, $73, $08
        dc.b $6f, $08, $73, $08, $6e, $08, $b3, $08
        dc.b $6f, $08, $73, $08, $b3, $08, $73, $08
        dc.b $00

; Intro2 R
tt_pattern4:
        dc.b $71, $08, $73, $08, $74, $08, $71, $08
        dc.b $6f, $08, $73, $08, $b3, $08, $73, $08
        dc.b $b3, $08, $73, $08, $b3, $08, $73, $08
        dc.b $71, $08, $73, $08, $74, $08, $71, $08
        dc.b $00




; Individual pattern speeds (needs TT_GLOBAL_SPEED = 0).
; Each byte encodes the speed of one pattern in the order
; of the tt_PatternPtr tables below.
; If TT_USE_FUNKTEMPO is 1, then the low nibble encodes
; the even speed and the high nibble the odd speed.
    IF TT_GLOBAL_SPEED = 0
tt_PatternSpeeds:
%%PATTERNSPEEDS%%
    ENDIF


; ---------------------------------------------------------------------
; Pattern pointers look-up table.
; ---------------------------------------------------------------------
tt_PatternPtrLo:
        dc.b <tt_pattern0, <tt_pattern1, <tt_pattern2, <tt_pattern3
        dc.b <tt_pattern4
tt_PatternPtrHi:
        dc.b >tt_pattern0, >tt_pattern1, >tt_pattern2, >tt_pattern3
        dc.b >tt_pattern4        


; ---------------------------------------------------------------------
; Pattern sequence table. Each byte is an index into the
; tt_PatternPtrLo/Hi tables where the pointers to the pattern
; definitions can be found. When a pattern has been played completely,
; the next byte from this table is used to get the address of the next
; pattern to play. tt_cur_pat_index_c0/1 hold the current index values
; into this table for channels 0 and 1.
; If TT_USE_GOTO is used, a value >=128 denotes a goto to the pattern
; number encoded in bits 6..0 (i.e. value AND %01111111).
; ---------------------------------------------------------------------
tt_SequenceTable:
        ; ---------- Channel 0 ----------
        dc.b $00, $00, $01, $02, $80

        
        ; ---------- Channel 1 ----------
        dc.b $03, $04, $03, $04, $85


        echo "Track size: ", *-tt_TrackDataStart

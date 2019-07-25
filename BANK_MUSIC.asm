    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

    ; 2K reserved for music.

                NEWBANK BANK_MUSIC1

                ;build datestamp

    .byte   "July 25 2019"

    ds  80, " "
    .byte   "This Atari 2600 "
    .byte   "version of Sokob"
    .byte   "an was programmed by And"
    .byte   "rew Davie using "
    .byte   "a character engi"
    .byte   "ne developed by "
    .byte   "he and Thomas Je"
    .byte   "ntzsch. This bin"
    .byte   "ary is...   Copy"
    .byte   "right Andrew Dav"
    .byte   "ie (C)2019 "

    ;--------------------------------------------------------------------------

    include "sounds.asm"    ; code and data for the various sounds:

                CHECK_BANK_SIZE "BANK_MUSIC1"

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

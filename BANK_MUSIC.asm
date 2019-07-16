    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------

    ; 2K reserved for music.

                NEWBANK BANK_MUSIC1

                ;build datestamp

  IF DEMO_VERSION = NO
    .byte   "Feb 29 2012"
  ELSE
    .byte   "Jan 18 2014"
  ENDIF

  IF EMBED_COPYRIGHT = YES
    ds  80, " "
    .byte   "This Atari 2600 "
    .byte   "version of Bould"
    .byte   "er Dash(R) was p"
    .byte   "rogrammed by And"
    .byte   "rew Davie and Th"
    .byte   "omas Jentzsch be"
    .byte   "tween 2003 and 2"
    .byte   "012. BOX Das"
    .byte   "h(R) is a regist"
    .byte   "ered trademark o"
    .byte   "f First Star Sof"
    .byte   "tware, Inc. Copy"
    .byte   "right (C)1984-20"
    .byte   "12 First Star So"
    .byte   "ftware, Inc. All"
    .byte   " rights reserved"
    .byte   ". The supporting"
    .byte   " software, inclu"
    .byte   "ding the graphic"
    .byte   "s engine, optmis"
    .byte   "ation algorithms"
    .byte   ", and other code"
    .byte   " and logic not p"
    .byte   "ertaining to the"
    .byte   " BOX Dash(R)"
    .byte   " implementation,"
    .byte   " are Copyright ("
    .byte   "C)2012 Andrew Da"
    .byte   "vie and Thomas J"
    .byte   "entzsch."
   IF DEMO_VERSION = NO
    .byte   " This bi"
    .byte   "nary is not free"
    .byte   " and may not be "
    .byte   "sold, or redistr"
    .byte   "ibuted in any mo"
    .byte   "dified form. "
   ELSE
    .byte   " This 2nd demo version Copyright (C)2014."
   ENDIF
    ds  80, "  "
  ENDIF

    ;--------------------------------------------------------------------------

    include "sounds.asm"    ; code and data for the various sounds:

                CHECK_BANK_SIZE "BANK_MUSIC1"

    ;------------------------------------------------------------------------------
    ;##############################################################################
    ;------------------------------------------------------------------------------



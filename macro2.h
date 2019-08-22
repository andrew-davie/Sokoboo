; macros

    MAC NTSC_TO_PAL ; {col} {intensity}
    IF {1} = 0
    .byte {1}+{2}
    ENDIF
    IF {1} = $10
    .byte $22+{2}
    ENDIF
    IF {1} = $20
    .byte $42+{2}
    ENDIF
    IF {1} = $30
    .byte $42+{2}
    ENDIF
    IF {1} = $40
    .byte $62+{2}
    ENDIF
    IF {1} = $50
    .byte $82+{2}
    ENDIF
    IF {1} = $60
    .byte $C2+{2}
    ENDIF
    IF {1} = $70
    .byte $D2+{2}
    ENDIF
    IF {1} = $80
    .byte $B2+{2}
    ENDIF
    IF {1} = $90
    .byte $92+{2}
    ENDIF
    IF {1} = $A0
    .byte $72+{2}
    ENDIF
    IF {1} = $B0
    .byte $52+{2}
    ENDIF
    IF {1} = $C0
    .byte $32+{2}
    ENDIF
    IF {1} = $D0
    .byte $32+{2}
    ENDIF
    IF {1} = $E0
    .byte $22+{2}
    ENDIF
    IF {1} = $F0
    .byte $42+{2}
    ENDIF
    ENDM

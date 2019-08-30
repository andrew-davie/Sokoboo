; macros

    MAC NTSC_TO_PAL ; {col} {intensity}
    IF {1} = 0
    .byte {1}+{2}
    ENDIF
    IF {1} = $10
    .byte $20+{2}
    ENDIF
    IF {1} = $20
    .byte $40+{2}
    ENDIF
    IF {1} = $30
    .byte $40+{2}
    ENDIF
    IF {1} = $40
    .byte $60+{2}
    ENDIF
    IF {1} = $50
    .byte $80+{2}
    ENDIF
    IF {1} = $60
    .byte $C0+{2}
    ENDIF
    IF {1} = $70
    .byte $D0+{2}
    ENDIF
    IF {1} = $80
    .byte $B0+{2}
    ENDIF
    IF {1} = $90
    .byte $90+{2}
    ENDIF
    IF {1} = $A0
    .byte $70+{2}
    ENDIF
    IF {1} = $B0
    .byte $50+{2}
    ENDIF
    IF {1} = $C0
    .byte $30+{2}
    ENDIF
    IF {1} = $D0
    .byte $30+{2}
    ENDIF
    IF {1} = $E0
    .byte $20+{2}
    ENDIF
    IF {1} = $F0
    .byte $40+{2}
    ENDIF
    ENDM

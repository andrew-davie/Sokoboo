
;Begin {Circle}
;x := r;
;y := 0;
;d := 1 - r;
;Repeat
;Circle_Points(x,y);
;y := y + 1;
;if d < 0 Then
;    d := d + 2*y + 1
;Else Begin
;    x := x - 1;
;    d := d + 2*(y-x) + 1
;    End
;Until x < y
;End; {Circle}


  DEFINE_SUBROUTINE PlotChar

  ; a = x pos
  ; y = y pos

            cmp BoardLimit_Width
            bcs off1x
            cpy BoardLimit_Height
            bcs off1x

            pha
            lda #BANK_GetBoardAddressW          ;
            sta SET_BANK                        ;
            jsr GetBoardAddressW                ;11+24[-2](A)

            stx SET_BANK_RAM                    ;3

            pla
            tay
            lda circ_char                        ;3
            sta (Board_AddressW),y              ;6
off1x            rts

;x            Plot(x,y);
;x            Plot(y,x);
;x           Plot(y,-x);
;x           Plot(x,-y);
;x           Plot(-x,-y);
;x           Plot(-y,-x);
;x            Plot(-y,x);
;x            Plot(-x,y)

  DEFINE_SUBROUTINE PlotCirclePoints

    ; +x+y
      clc
      lda circ_y
      lsr
      adc ManY          ; "origin"
      tay
      clc
      lda circ_x
      lsr
      adc ManX
      cmp BoardLimit_Height
      bcs off1x
      jsr PlotChar

      ;+y+x
      clc
      lda circ_x
      lsr
      adc ManY          ; "origin"
      tay
      clc
      lda circ_y
      lsr
      adc ManX
      jsr PlotChar

        ; y,-x
      sec
      lda ManY
      asl
      sbc circ_x
      lsr
      tay
      clc
      lda circ_y
      lsr
      adc ManX          ; "origin"
      jsr PlotChar

      ; x,-y
      lda ManY
      asl
      sec
      sbc circ_y         ; "origin"
      lsr
      tay
      lda circ_x
      lsr
      clc
      adc ManX
      jsr PlotChar

      ; -x,-y
      lda ManY
      asl
      sec
      sbc circ_y          ; "origin"
      lsr
      tay
      lda ManX
      asl
      sec
      sbc circ_x
      lsr
      jsr PlotChar

      ; -y,-x
      lda ManY
      asl
      sec
      sbc circ_x          ; "origin"
      lsr
      tay
      lda ManX
      asl
      sec
      sbc circ_y
      lsr
      jsr PlotChar

      ; -y,x
      lda circ_x
      lsr
      clc
      adc ManY          ; "origin"
      tay
      lda ManX
      asl
      sec
      sbc circ_y
      lsr
      jsr PlotChar

      ; -x,y
      lda circ_y
      lsr
      cld
      adc ManY          ; "origin"
      tay
      lda ManX
      asl
      sec
      sbc circ_x
      lsr
      jsr PlotChar


                  rts                                 ;6



  DEFINE_SUBROUTINE DrawCircle
  ; a = radius
;                  sty circ_char
;                  sta circ_x
;                  eor #255
;                  clc
;                  adc #1
;                  sta circ_scratch     ; "d" --> "1-r" in unit terms

;                  lda #0
;                  sta circ_y

CircleRepeat



                  jsr PlotCirclePoints
                  inc circ_y
                  lda circ_scratch
                  bpl positiveD

                  lda circ_y
                  asl
                  sec         ; "+1"
                  adc circ_scratch
                  jmp CCont

positiveD         dec circ_x

                  sec
                  lda circ_y
                  sbc circ_x
                  asl
                  sec             ; "+1"
                  adc circ_scratch

CCont             sta circ_scratch

                  lda circ_x
                  cmp circ_y
                  bcs CircleRepeat ; circleDie

circleDie          rts

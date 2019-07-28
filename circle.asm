;    Sokoboo - a Sokoban implementation
;    using a generic tile-based display engine for the Atari 2600
;    Sokoban (倉庫番)™ is © Falcon Co., Ltd.
;
;    Code related to this Sokoban™ implementation was developed by Andrew Davie.
;
;    Code related to the generic tile-based display engine was developed by
;    Andrew Davie and Thomas Jentzsch during 2003-2011 and is
;    Copyright(C)2003-2019 Thomas Jentzsch and Andrew Davie - contacts details:
;    Andrew Davie (andrew@taswegian.com), Thomas Jentzsch (tjentzsch@yahoo.de).
;
;    Code related to music and sound effects uses the TIATracker music player
;    Copyright 2016 Andre "Kylearan" Wichmann - see source code in the "sound"
;    directory for Apache licensing details.
;
;    Some level data incorporated in this program were created by Lee J Haywood.
;    See the copyright notices in the License directory for a list of level
;    contributors.
;
;    Except where otherwise indicated, this software is released under the
;    following licensing arrangement...
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;    see https://www.gnu.org/licenses/gpl-3.0.en.html

;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.

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

tilepal: .incbin "../resources/our.pal" ; include and label our palette

  .bank 2   ; switch to bank 2
  .org $0000  ; start at $0000
  .incbin "../resources/our.bkg"  ; empty background first
  .incbin "../resources/sheet01.chr"  ; our sprite pic data
  ; note these MUST be in that order.

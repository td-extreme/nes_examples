  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"

hello_world  .db _H, _E, _L, _L, _O, _SPACE, _W, _O, _R, _L, _D, END_STRING

TEXT_X          EQU     $FB
TEXT_Y          EQU     $FA

Start:
  setup_ppu
  load_palette tilepal

  ldx #80
  ldy #70
  stx TEXT_X
  sty TEXT_Y

infin:

  wait_blank
  print_string hello_world, TEXT_X, TEXT_Y
  print_string hello_world, TEXT_Y, TEXT_X
  
  jmp infin 

tilepal: .incbin "../resources/our.pal" ; include and label our palette

  .bank 2   ; switch to bank 2
  .org $0000  ; start at $0000
  .incbin "../resources/our.bkg"  ; empty background first
  .incbin "../resources/sheet01.chr"  ; our sprite pic data
  ; note these MUST be in that order.

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

  .include "../lib/basic_resources.asm"

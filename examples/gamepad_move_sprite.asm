  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/gamepad.asm"

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

  jsr update_gamepad

  if_gamepad_1_held UP_BUTTON, end_up
  ldy TEXT_Y
  dey
  sty TEXT_Y
end_up:

  if_gamepad_1_held DOWN_BUTTON, end_down
  ldy TEXT_Y
  iny
  sty TEXT_Y
end_down:

  if_gamepad_1_held LEFT_BUTTON, end_left
  ldx TEXT_X
  dex
  stx TEXT_X
end_left:

  if_gamepad_1_held RIGHT_BUTTON, end_right
  ldx TEXT_X
  inx
  stx TEXT_X
end_right:

  jmp infin

  .include "../lib/basic_resources.asm"

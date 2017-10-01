  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/boolean.asm"
  .include "../lib/collision_detection.asm"
  .include "../test_lib/assertion_macros.asm"

TEXT_X          EQU     $FB
TEXT_Y          EQU     $FA

BOX_X           EQU     $F9
BOX_Y           EQU     $F8
BOX_W           EQU     $F7
BOX_H           EQU     $F6

Start:
  setup_ppu
  load_palette tilepal

  ldx #80
  ldy #70
  stx TEXT_X
  sty TEXT_Y

  ldx #5
  ldy #5
  stx BOX_X
  sty BOX_Y

  ldx #10
  ldy #10
  stx BOX_W
  sty BOX_H


  wait_blank

  ldx #10
  ldy #10
  is_point_in_box BOX_X, BOX_Y, BOX_W, BOX_H

  cmp #TRUE
  assert_true_a


infin:
  jmp infin

  .include "../lib/basic_resources.asm"

  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/collision_detection.asm"

str_true .db _T, _R, _U, _E, END_STRING
str_false .db _F, _A, _L, _S, _E, END_STRING

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
  beq is_true
  jmp is_false

is_true:
  print_string str_true, TEXT_X, TEXT_Y
  jmp end_if
is_false:
  print_string str_false, TEXT_X, TEXT_Y
end_if:

infin:
  jmp infin

tilepal: .incbin "../resources/our.pal" ; include and label our palette

  .bank 2   ; switch to bank 2
  .org $0000  ; start at $0000
  .incbin "../resources/our.bkg"  ; empty background first
  .incbin "../resources/sheet01.chr"  ; our sprite pic data
  ; note these MUST be in that order.

  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/boolean.asm"
  .include "../lib/cursor.asm"
  .include "../test_lib/assertion_macros.asm"
  .include "../lib/sprite.asm"

ONE     EQU %00000001
TWO     EQU %00000010
THREE   EQU %00000011
FOUR    EQU %00000100

TEST_VAR_1  EQU  $EE

Start:
  setup_ppu
  load_palette tilepal

infin:
  wait_blank

; test assert_true_accumulator passes
;  lda #TRUE
;  assert_accumulator_true

; setup
  sprite_new test_sprite, $EE, 10, 11, 12

; test sprite_x_get
  set_cursor #20, #10
  sprite_x_get test_sprite
  assert_accumulator_equals #10

; test sprite_y_get
  set_cursor #20, #20
  sprite_y_get test_sprite
  assert_accumulator_equals #11

; test sprite_x_add
  set_cursor #20, #30
  sprite_x_add test_sprite, #3
  sprite_x_get test_sprite
  assert_accumulator_equals #13

; test sprite_x_sub
  set_cursor #20, #40
  sprite_x_sub test_sprite, #1
  sprite_x_get test_sprite
  assert_accumulator_equals #12

; test sprite_y_add
  set_cursor #20, #50
  sprite_y_add test_sprite, #4
  sprite_y_get test_sprite
  assert_accumulator_equals #15

; test sprite_y_sub
  set_cursor #20, #60
  sprite_y_sub test_sprite, #5
  sprite_y_get test_sprite
  assert_accumulator_equals #10

; test sprite_x_set
  set_cursor #20, #70
  sprite_x_set test_sprite, #20
  sprite_x_get test_sprite
  assert_accumulator_equals #20

; test sprite_y_set
  set_cursor  #20, #80
  sprite_y_set test_sprite, #22
  sprite_y_get test_sprite
  assert_accumulator_equals #22

  jmp infin

  .include "../lib/basic_resources.asm"

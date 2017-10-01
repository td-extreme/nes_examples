  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/boolean.asm"
  .include "../lib/cursor.asm"

  .include "../test_lib/assertion_macros.asm"

Start:
  setup_ppu
  load_palette tilepal

  ;test cursor forward
  set_cursor #10, #10
  cursor_forward
  assert_address_value_equals CURSOR_X, #20

  ;test cursor back
  set_cursor #30, #20
  cursor_backward
  assert_address_value_equals CURSOR_X, #20

  ;accumlator is perserved when calling cursor forward
  set_cursor #10, #40
  lda #01
  cursor_forward
  assert_accumulator_equals #01

  ;accumlator is perserved when calling cursor backward
  set_cursor #30, #50
  lda #01
  cursor_backward
  assert_accumulator_equals #01

  ;test cursor down
  set_cursor #20, #60
  cursor_down
  assert_address_value_equals CURSOR_Y, #70

  ;test cursor down
  set_cursor #20, #90
  cursor_up
  assert_address_value_equals CURSOR_Y, #80

  ;test cursor down
  set_cursor #20, #60
  cursor_down
  assert_address_value_equals CURSOR_Y, #70

  ;accumlator is perserved when calling cursor up
  set_cursor #20, #110
  lda #01
  cursor_up
  assert_accumulator_equals #01

  ;accumlator is perserved when calling cursor down
  set_cursor #20, #100
  lda #01
  cursor_down
  assert_accumulator_equals #01

infin:
  jmp infin

  .include "../lib/basic_resources.asm"


  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/boolean.asm"
  .include "../lib/cursor.asm"
  .include "../test_lib/assertion_macros.asm"

ONE     EQU %00000001
TWO     EQU %00000010
THREE   EQU %00000100

TEST_VAR_1  EQU  $EE

Start:
  setup_ppu
  load_palette tilepal

infin:
  wait_blank

; test true passes
  set_cursor  #80, #70
  lda #TRUE
  assert_true_a

; test false fails
  set_cursor #80, #80
  lda #FALSE
  assert_true_a

; test true passes
  set_cursor  #80, #70
  lda #TRUE
  assert_a_true

; test false fails
  set_cursor #80, #80
  lda #FALSE
  assert_a_true

; test assert_address_value_equals passes
  set_cursor #80, #90
  ldx #ONE
  stx TEST_VAR_1
  assert_address_value_equals TEST_VAR_1, #ONE

; test assert_address_value_equals fails
  set_cursor #80, #100
  ldx #ONE
  stx TEST_VAR_1
  assert_address_value_equals TEST_VAR_1, #TWO

; test assert_accumulator_equals passes
  set_cursor #80, #110
  lda #01
  assert_accumulator_equals #01

; test assert_accumulator_equals fails
  set_cursor #80, #120
  lda #01
  assert_accumulator_equals #02

; test assert_a_equals passes
  set_cursor #80, #130
  lda #01
  assert_a_equals #01

; test assert_a_equals fails
  set_cursor #80, #140
  lda #01
  assert_a_equals #02

; test assert_x_equals passes
  set_cursor #80, #150
  ldx #01
  assert_x_equals #01

; test assert_x_equals fails
  set_cursor #80, #160
  ldx #01
  assert_x_equals #02

; test assert_y_equals passes
  set_cursor #80, #170
  ldy #01
  assert_y_equals #01

; test assert_y_equals fails
  set_cursor #80, #180
  ldy #01
  assert_y_equals #02

  jmp infin

  .include "../lib/basic_resources.asm"


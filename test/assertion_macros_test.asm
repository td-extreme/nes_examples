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

; test true passes
  set_cursor  #80, #70
  lda #TRUE
  assert_true_a

; test false fails
  set_cursor #80, #80
  lda #FALSE
  assert_true_a

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

infin:
  jmp infin

  .include "../lib/basic_resources.asm"


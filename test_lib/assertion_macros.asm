str_passed .db _P, _A, _S, _S, _E, _D, END_STRING
str_failed .db _F, _A, _I, _L, _E, _D, END_STRING


print_result .macro
  beq test_passed\@
  jmp test_failed\@

test_passed\@:
  print_string str_passed, CURSOR_X, CURSOR_Y
  jmp end_if\@
test_failed\@:
  print_string str_failed, CURSOR_X, CURSOR_Y
end_if\@:
  .endm

assert_accumulator_true .macro
  cmp #TRUE
  print_result

  .endm

assert_a_true .macro
  cmp #TRUE
  print_result

  .endm

assert_address_value_equals .macro
  lda \1
  cmp \2
  print_result

  .endm

assert_accumulator_equals .macro
  cmp \1
  print_result

  .endm

assert_a_equals .macro
  cmp \1
  print_result

  .endm

assert_x_equals .macro
  txa
  cmp \1
  print_result

  .endm

assert_y_equals .macro
  tya
  cmp \1
  print_result

  .endm

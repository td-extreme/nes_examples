str_passed .db _P, _A, _S, _S, _E, _D, END_STRING
str_failed .db _F, _A, _I, _L, _E, _D, END_STRING


print_result .macro
  beq is_true\@
  jmp is_false\@

is_true\@:
  print_string str_passed, CURSOR_X, CURSOR_Y
  jmp end_if\@
is_false\@:
  print_string str_failed, CURSOR_X, CURSOR_Y
end_if\@:
  .endm

assert_true_a .macro
  cmp #TRUE
  print_result

  .endm

assert_address_value_equals .macro
  lda \1
  cmp \2
  print_result


  .endm

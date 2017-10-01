CURSOR_X          EQU     $FE
CURSOR_Y          EQU     $FF

set_cursor .macro
  lda \1
  sta CURSOR_X
  lda \2
  sta CURSOR_Y

  .endm

cursor_forward .macro
  clc
  pha
  lda CURSOR_X
  adc #10
  sta CURSOR_X
  pla

  .endm

cursor_backward .macro
  sec
  pha
  lda CURSOR_X
  sbc #10
  sta CURSOR_X
  pla

  .endm

cursor_down .macro
  clc
  pha
  lda CURSOR_Y
  adc #10
  sta CURSOR_Y
  pla

  .endm

cursor_up .macro
  sec
  pha
  lda CURSOR_Y
  sbc #10
  sta CURSOR_Y
  pla

  .endm

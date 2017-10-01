CURSOR_X          EQU     $FE
CURSOR_Y          EQU     $FF

set_cursor .macro
  lda \1
  sta CURSOR_X
  lda \2
  sta CURSOR_Y

  .endm

cursor_forward .macro
  pha
  lda CURSOR_X
  adc #08
  sta CURSOR_X
  pla

  .endm

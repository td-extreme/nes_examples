_A = 10
_B = 11
_C = 12
_D = 13
_E = 14
_F = 15
_G = 16
_H = 17
_I = 18
_J = 19
_K = 20
_L = 21
_M = 22
_N = 23
_O = 24
_P = 25
_Q = 26
_R = 27
_S = 28
_T = 29
_U = 30
_V = 31
_W = 32
_X = 33
_Y = 34
_Z = 35
_SPACE = 36
_COMMA = 40
_EXPLANATION = 41
_SINGLE_QUOTE = 42
_AMPERSAND = 43
_PERIOD = 44
_DOUBLE_QUOTE = 45
_QUESTION_MARK = 46
_DASH = 47
END_STRING = 255

print_char .macro
  lda \3
  sta $2004
  lda \1
  sta $2004
  lda #$00
  sta $2004
  lda \2
  sta $2004
  .endm

print_string .macro
  ldx \2
  ldy #00
string_loop\@:
  lda \3
  sta $2004
  lda \1, y
  sta $2004
  lda #$00
  sta $2004
  txa
  sta $2004
  adc #08
  tax
  iny
  lda \1, y
  cmp #255
  bne string_loop\@
  .endm

        .rsset $
S_X     .rs 1
S_Y     .rs 1
S_INDEX .rs 1

; /1 sprite-name
; /2 memmory_address
; /3 sprite.x
; /4 sprite.y
; /5 sptite.sheet_index
sprite_new .macro
\1 EQU \2

  ldy #S_X
  lda #\3
  sta \1, Y

  ldy #S_Y
  lda #\4
  sta \1, Y

  ldy #S_INDEX
  lda #\5
  sta \1, Y

  .endm

; \1 sprite-name
sprite_print .macro
  ldy #S_Y
  lda \1, Y
  sta $2004

  ldy #S_INDEX
  lda \1, Y
  sta $2004

  lda $00
  sta $2004

  ldy #S_X
  lda \1, Y
  sta $2004

  .endm

; \1 sprite-name
; \2 value
sprite_x_set .macro
  ldy #S_X
  lda \2
  sta \1, Y
  .endm

sprite_y_set .macro
  ldy #S_Y
  lda \2
  sta \1, Y
  .endm

; \1 sprite-name
sprite_x_get .macro
  ldy #S_X
  lda \1, Y
  .endm

sprite_y_get .macro
  ldy #S_Y
  lda \1, Y
  .endm

; \1 sprite-name
; \2 value
sprite_x_add .macro
  clc
  ldy #S_X
  lda \1, Y
  adc \2
  sta \1, Y
  .endm

; \1 sprite-name
; \2 value
sprite_x_sub .macro
  sec
  ldy #S_X
  lda \1, Y
  sbc \2
  sta \1, Y
  .endm

; \1 sprite-name
; \2 value
sprite_y_add .macro
  clc
  ldy #S_Y
  lda \1, Y
  adc \2
  sta \1, Y
  .endm

; \1 sprite-name
; \2 value
sprite_y_sub .macro
  sec
  ldy #S_Y
  lda \1, Y
  sbc \2
  sta \1, Y
  .endm

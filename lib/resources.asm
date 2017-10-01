begin_resources .macro
  .bank 2   ; switch to bank 2
  .org $0000  ; start at $0000
  .endm

include_background .macro
  .incbin \1
  .endm

include_sprite_sheet .macro
  .incbin \1
  .endm

include_pallete .macro
\2: .incbin \1
  .endm


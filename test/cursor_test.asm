  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/boolean.asm"
  .include "../test_lib/assertion_macros.asm"
  .include "../lib/cursor.asm"

Start:
  setup_ppu
  load_palette tilepal

infin:
  jmp infin

  .include "../lib/basic_resources.asm"


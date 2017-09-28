  .inesprg 1   ; 1 bank of code
  .ineschr 1   ; 1 bank of spr/bkg data
  .inesmir 1   ; something always 1
  .inesmap 0   ; we use mapper 0

  .bank 1      ; following goes in bank 1
  .org $FFFA   ; start at $FFFA
  .dw 0        ; dw stands for Define Word and we give 0 as address for NMI routine
  .dw Start    ; give address of start of our code for execution on reset of NES.
  .dw 0        ; give 0 for address of VBlank interrupt handler, we tell PPU not to
               ; make an interrupt for VBlank.

  .bank 0             ; bank 0 - our place for code.
  .org $8000          ; code starts at $8000



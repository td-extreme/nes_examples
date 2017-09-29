setup_ppu .macro
  lda #%00001000 ; do the setup of PPU
  sta $2000
  lda #%00011110
  sta $2001

  lda #$3F    ; have $2006 tell
  sta $2006   ; $2007 to start
  lda #$00    ; at $3F00 (palette).
  sta $2006

  .endm

load_palette .macro
  ldx #00 
loadpal\@:        ; this is a freaky loop
  lda \1, x  ; that gives 32 numbers
  sta $2007       ; to $2007, ending when
  inx             ; X is 32, meaning we
  cpx #32         ; are done.
  bne loadpal\@   ; if X isn’t =32, goto “loadpal:” line.
  .endm

wait_blank .macro
waitblank\@:      ; this is the wait for VBlank code from above
  lda $2002       ; load A with value at location $2002
  bpl waitblank\@ ; if bit 7 is not set (not VBlank) keep checking
  .endm

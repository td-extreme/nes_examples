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

  .include "print_strings.asm"
  .include "collision_detection.asm"

hello_world  .db _H, _E, _L, _L, _O, _SPACE, _W, _O, _R, _L, _D, END_STRING
title .db _P, _O, _N, _G, END_STRING

str_true .db _T, _R, _U, _E, END_STRING
str_false .db _F, _A, _L, _S, _E, END_STRING


TEXT_X          EQU     $FB
TEXT_Y          EQU     $FA

   

Start: lda #%00001000 ; do the setup of PPU
  sta $2000
  lda #%00011110
  sta $2001

  lda #$3F    ; have $2006 tell
  sta $2006   ; $2007 to start
  lda #$00    ; at $3F00 (palette).
  sta $2006

  ldx #80
  ldy #70
  stx TEXT_X
  sty TEXT_Y


infin:

  ldx #00    ; clear X

loadpal:          ; this is a freaky loop
  lda tilepal, x  ; that gives 32 numbers
  sta $2007       ; to $2007, ending when
  inx             ; X is 32, meaning we
  cpx #32         ; are done.
  bne loadpal     ; if X isn’t =32, goto “loadpal:” line.


waitblank:        ; this is the wait for VBlank code from above
  lda $2002       ; load A with value at location $2002
  bpl waitblank   ; if bit 7 is not set (not VBlank) keep checking

  lda #$00   ; these lines tell $2003
  sta $2003  ; to tell
  lda #$00   ; $2004 to start
  sta $2003  ; at $0000.

  lda TRUE
  sbc TRUE
  beq is_true
  jmp is_false

is_true:
  print_string str_true, TEXT_X, TEXT_Y
  jmp end_if
is_false:
  print_string str_false, TEXT_X, TEXT_Y

end_if:

reset:

  jmp infin

tilepal: .incbin "our.pal" ; include and label our palette

  .bank 2   ; switch to bank 2
  .org $0000  ; start at $0000
  .incbin "our.bkg"  ; empty background first
  .incbin "sheet01.chr"  ; our sprite pic data
  ; note these MUST be in that order.

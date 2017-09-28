  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"

hello_world  .db _H, _E, _L, _L, _O, _SPACE, _W, _O, _R, _L, _D, END_STRING

TEXT_X          EQU     $FB
TEXT_Y          EQU     $FA


Start:
  lda #%00001000 ; do the setup of PPU
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


loadpal:          ; this is a freaky loop
  lda tilepal, x  ; that gives 32 numbers
  sta $2007       ; to $2007, ending when
  inx             ; X is 32, meaning we
  cpx #32         ; are done.
  bne loadpal     ; if X isn’t =32, goto “loadpal:” line.


infin:

waitblank:        ; this is the wait for VBlank code from above
  lda $2002       ; load A with value at location $2002
  bpl waitblank   ; if bit 7 is not set (not VBlank) keep checking

;  lda #$00   ; these lines tell $2003
;  sta $2003  ; to tell
;  lda #$00   ; $2004 to start
;  sta $2003  ; at $0000.


  print_string hello_world, TEXT_X, TEXT_Y
  print_string hello_world, TEXT_Y, TEXT_X
  
  
  jmp infin 

tilepal: .incbin "../resources/our.pal" ; include and label our palette

  .bank 2   ; switch to bank 2
  .org $0000  ; start at $0000
  .incbin "../resources/our.bkg"  ; empty background first
  .incbin "../resources/sheet01.chr"  ; our sprite pic data
  ; note these MUST be in that order.

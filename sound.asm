    ;;---CODE START---;;
  .inesprg 1
  .inesmap 0
  .inesmir 1
  .ineschr 0  ; note that we have no CHR-ROM bank in this code

  .bank 1
  .org $FFFA
  .dw 0 ; no VBlank routine
  .dw Start
  .dw 0 ; we'll get to this at a later time

  .bank 0
  .org $8000 ; note that I just copy/pasted code from the register sections Start:

Start:
  lda #$FF   ; typical
  sta $4000  ; write

  lda #%11011011  ; % means binary number, remember the '#' for immediate values.
  sta $4001  ; immediate means "not an address, just a number".

  lda #$A5
  sta $4002

  lda #$AB
  sta $4003

  lda #%00000001
  sta $4015
infinite: jmp infinite

;;--- END OF CODE FILE ---;;

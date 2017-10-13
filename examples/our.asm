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

  .include "../lib/boolean.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/collision_detection.asm"

hello_world  .db _H, _E, _L, _L, _O, _SPACE, _W, _O, _R, _L, _D, END_STRING
title .db _P, _O, _N, _G, END_STRING


RIGHT_BUTTON    EQU %00000001
LEFT_BUTTON     EQU %00000010
DOWN_BUTTON     EQU %00000100
UP_BUTTON       EQU %00001000
START_BUTTON    EQU %00010000
SELECT_BUTTON   EQU %00100000
B_BUTTON        EQU %01000000
A_BUTTON        EQU %10000000

JOY_STAT        EQU     $FC     ; byte containing status of joypad
OLD_STAT        EQU     $FD     ; joypad status from previous refresh

TEXT_X          EQU     $FB
TEXT_Y          EQU     $FA

PADDLE_1_X      EQU     $F0
PADDLE_1_Y      EQU     $EF
PADDLE_1_WIDTH  EQU     $E0
PADDLE_1_HEIGHT EQU     $E1

BALL_X          EQU     $E2
BALL_Y          EQU     $E3
BALL_WIDTH      EQU     $E4
BALL_HEIGHT     EQU     $E5

BALL_DIRECTION_X    EQU     $E6
BALL_DIRECTION_Y    EQU     $E7

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

  ldy #80
  ldx #16
  stx PADDLE_1_X
  sty PADDLE_1_Y

  ldx #08
  stx PADDLE_1_WIDTH
  ldx #32
  stx PADDLE_1_HEIGHT

  ldx #125
  stx BALL_X
  stx BALL_Y

  ldx #08
  stx BALL_WIDTH
  stx BALL_HEIGHT

  ldx #$01
  stx BALL_DIRECTION_X
  stx BALL_DIRECTION_Y

infin:

  lda JOY_STAT
  sta OLD_STAT
  jsr read_joypad

  lda #UP_BUTTON
  and JOY_STAT
  beq up_not_pressed
  and OLD_STAT
  beq up_not_pressed
  ldx PADDLE_1_Y
  dex
  dex
  stx PADDLE_1_Y
up_not_pressed:

  lda #DOWN_BUTTON
  and JOY_STAT
  beq down_not_pressed
  and OLD_STAT
  beq down_not_pressed
  ldx PADDLE_1_Y
  inx
  inx
  stx PADDLE_1_Y
down_not_pressed:

  lda #LEFT_BUTTON
  and JOY_STAT
  beq left_not_pressed
  and OLD_STAT
  beq left_not_pressed
  ldx TEXT_X
  dex
  stx TEXT_X
left_not_pressed:

  lda #RIGHT_BUTTON
  and JOY_STAT
  beq right_not_pressed
  and OLD_STAT
  beq right_not_pressed
  ldx TEXT_X
  inx
  stx TEXT_X
right_not_pressed:

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


  print_string hello_world, TEXT_X, TEXT_Y

  print_char #24, BALL_X, BALL_Y

; collision_detection

  ldx BALL_X
  lda BALL_DIRECTION_X
  cmp #$01
  bne x_left
x_right:
  inx
  stx BALL_X
  jmp check_x_paddle_one

x_left:
  dex
  stx BALL_X

check_x_paddle_one:

;  collision_detection BALL_X, BALL_Y, BALL_WIDTH, BALL_HEIGHT, PADDLE_1_X, PADDLE_1_Y, PADDLE_1_WIDTH, PADDLE_1_HEIGHT

  ldx BALL_X
  ldy BALL_Y

  is_point_in_box PADDLE_1_X, PADDLE_1_Y, PADDLE_1_WIDTH, PADDLE_1_HEIGHT

  sbc FALSE

  bne finish_x
  lda #$01
  cmp BALL_DIRECTION_X
  beq swap_ball_dir_x_1
  lda #$00
  sta BALL_DIRECTION_X
  jmp finish_x

swap_ball_dir_x_1:

  lda #$01
  sta BALL_DIRECTION_X

finish_x:


; collision_detection

  ldy PADDLE_1_Y
  ldx #00
paddle_loop:
  sty $2004
  tya
  adc #10
  tay
  lda #38
  sta $2004
  lda #$00
  sta $2004
  lda PADDLE_1_X
  sta $2004
  inx
  cpx #03
  bne paddle_loop

reset:

  jmp infin

advance_space:
  lda TEXT_X
  adc #08
  sta TEXT_X
  rts


read_joypad:
  ldy     #$01
  sty     $4016   ; reset strobe
  dey
  sty     $4016   ; clear strobe
  sty     JOY_STAT ; JOY_STAT = 0 (clear all button bits)
  ldy     #$08    ; do all 8 buttons
  read_button:
  lda     $4016   ; load button status
  and     #$01    ; only keep lowest bit
  lsr     a       ; transfer to carry flag
  rol     JOY_STAT
  dey
  bne     read_button
  rts

tilepal: .incbin "../resources/our.pal" ; include and label our palette

  .bank 2   ; switch to bank 2
  .org $0000  ; start at $0000
  .incbin "../resources/our.bkg"  ; empty background first
  .incbin "../resources/sheet01.chr"  ; our sprite pic data
  ; note these MUST be in that order.

RIGHT_BUTTON    EQU %00000001
LEFT_BUTTON     EQU %00000010
DOWN_BUTTON     EQU %00000100
UP_BUTTON       EQU %00001000
START_BUTTON    EQU %00010000
SELECT_BUTTON   EQU %00100000
B_BUTTON        EQU %01000000
A_BUTTON        EQU %10000000

GAMEPAD_1_STAT        EQU     $FC     ; byte containing status of joypad
OLD_GAMEPAD_1_STAT    EQU     $FD     ; joypad status from previous refresh

if_gamepad_1_pressed .macro
  lda #\1
  and GAMEPAD_1_STAT
  beq \2
  and OLD_GAMEPAD_1_STAT
  bne \2
  .endm

if_gamepad_1_held .macro
  lda #\1
  and GAMEPAD_1_STAT
  beq \2
  .endm

update_gamepad:
  lda GAMEPAD_1_STAT
  sta OLD_GAMEPAD_1_STAT
  jsr read_joypad
  rts

read_joypad:
  ldy     #$01
  sty     $4016   ; reset strobe
  dey
  sty     $4016   ; clear strobe
  sty     GAMEPAD_1_STAT ; JOY_STAT = 0 (clear all button bits)
  ldy     #$08    ; do all 8 buttons
  read_button:
  lda     $4016   ; load button status
  and     #$01    ; only keep lowest bit
  lsr     a       ; transfer to carry flag
  rol     GAMEPAD_1_STAT
  dey
  bne     read_button
  rts

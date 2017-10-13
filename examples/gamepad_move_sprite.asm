  .include "../lib/basic_setup.asm"
  .include "../lib/print_strings.asm"
  .include "../lib/ppu.asm"
  .include "../lib/gamepad.asm"
  .include "../lib/sprite.asm"

MOVE_DISTANCE = 1
Start:

  sprite_new mySprite, $EE, 10, 10, _A

  setup_ppu
  load_palette tilepal

GameLoop:

  wait_blank
  sprite_print mySprite

  jsr update_gamepad

  if_gamepad_1_button_held UP_BUTTON, PressedUp
  if_gamepad_1_button_held DOWN_BUTTON, PressedDown
  if_gamepad_1_button_held LEFT_BUTTON, PressedLeft
  if_gamepad_1_button_held RIGHT_BUTTON, PressedRight

  if_gamepad_1_button_press A_BUTTON, PressedA
  if_gamepad_1_button_press B_BUTTON, PressedB
  if_gamepad_1_button_press START_BUTTON, PressedStart
  if_gamepad_1_button_press SELECT_BUTTON, PressedSelect

  jmp GameLoop

PressedUp:
  sprite_y_sub mySprite, #MOVE_DISTANCE
  rts

PressedDown:
  sprite_y_add mySprite, #MOVE_DISTANCE
  rts

PressedLeft:
  sprite_x_sub mySprite, #MOVE_DISTANCE
  rts

PressedRight:
  sprite_x_add mySprite, #MOVE_DISTANCE
  rts

PressedA:
  ; incrment the sprite sheet index by 1
  ldx #S_INDEX
  inc mySprite, X
  rts

PressedB:
  ; decrement the sprite sheet index by 1
  ldx #S_INDEX
  dec mySprite, X
  rts

PressedSelect:
  ; Set the sprite sheet index to sprite of the letter A
  ldy #S_INDEX
  lda #_A
  sta mySprite, Y
  rts

PressedStart:

  rts

  .include "../lib/basic_resources.asm"

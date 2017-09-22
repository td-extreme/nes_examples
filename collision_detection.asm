COLLISION_ABOVE = %00000001
COLLISION_BELOW = %00000010
COLLISION_LEFT  = %00000100
COLLISION_RIGHT = %00001000

TRUE = %00000001
FALSE = %00000000

; macro takes memmory addresses of
;  - object 1 x,y and height and width
;  - object 2 x,y and height and width
; Checks to see if object 1 collides with object 2
; Places results on top of the stack
;

collision_detection .macro
  ; \1 address of object_1_x
  ; \2 address of object_1_y
  ; \3 address of object_1_width
  ; \4 address of object_1_height
  ; \5 address of object_2_x
  ; \6 address of object_2_y
  ; \7 address of object_2_width
  ; \8 address of object_2_height

  ; check if top left corner obj1 is inside obj2
  ldx \1  ; put obj1.x into reg_x
  ldy \2  ; put obj1.y into reg_y
  is_point_in_box \5, \6, \7, \8
  sdc TRUE
  beq collision_detection_return_true
  
  ; check if top right corner obj1 is inside obj2
  lda \1 
  adc \3
  tax     ; put obj1.x + obj1.width into reg_x
  ldy \2  ; put obj1.y into reg_y
  is_point_in_box \5, \6, \7, \8
  sdc TRUE
  beq collision_detection_return_true

  ; check if bottom left corner obj1 is inside obj2
  ldx \1  ; put obj1.x into reg_x
  lda \2
  adc \4
  tay  ; put obj1.y into reg_y
  is_point_in_box \5, \6, \7, \8
  sdc TRUE
  beq collision_detection_return_true

  ; check if bottom right corner obj1 is inside obj2
  lda \1 
  adc \3
  tax     ; put obj1.x + obj1.width into reg_x
  lda \2
  adc \4
  tay  ; put obj1.y into reg_y
  is_point_in_box \5, \6, \7, \8
  sdc TRUE
  beq collision_detection_return_true
  
  lda FALSE
  jmp collision_detection_exit
  

collision_detection_return_true:
  lda TRUE

collision_detection_exit:
  .endm

is_point_in_box .macro
  ; reg_x point.x
  ; reg_y point.y
  ; \1 box.x
  ; \2 box.y
  ; \3 box.width
  ; \4 box.height
  
  ; check if point.x is between box.x and box.x + box.width

  txa 
  cmp \1  ; exit if point.x < box.x
  bcc is_point_in_box_return_false   
  txa
  adc \3
  cmp \1  ; exit if point.x > box.x + box.width
  bcs is_point_in_box_return_false
  
  tya
  cmp \2  ; exit if point.y < box.y
  bcc is_point_in_box_return_false   
  tya
  adc \4
  cmp \1  ; exit if poin.y > box.y + box.height    
  bcs is_point_in_box_return_false
  
  lda TRUE

is_point_in_box_return_false:
  lda FALSE

is_point_in_box_exit:
 
  .endm

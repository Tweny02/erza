'''
Godot4.4
v0.1.02.20250523
	# demo阶段
		- bgm loop
	# Export
		- 导出游戏
		- 换个bg
		- 进入demo阶段


'''


extends CharacterBody2D

# =====================CONST==========================
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# ======================VAR=============================
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# get input direction： -1,0,1
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():	
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")	
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED 
		
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()

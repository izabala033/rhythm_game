extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	
	# WASD / Arrow keys
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	# normalize so diagonal movement isn't faster
	input_vector = input_vector.normalized()
	
	# move player
	velocity = input_vector * speed
	move_and_slide()

	# optional: keep player inside viewport bounds
	var screen_rect = Rect2(Vector2.ZERO, get_viewport_rect().size)
	position.x = clamp(position.x, screen_rect.position.x, screen_rect.size.x)
	position.y = clamp(position.y, screen_rect.position.y, screen_rect.size.y)

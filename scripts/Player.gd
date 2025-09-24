extends CharacterBody2D

@export var speed: float = 300.0
@export var beat_scale_amount: float = 1.2  # how big the pulse gets
@export var beat_pulse_time: float = 0.1   # time to reach max scale

func _ready() -> void:
	add_to_group("BeatReactors")

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
	
func on_beat(beat_count: int):
	# create a tween for a pulse effect
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(beat_scale_amount, beat_scale_amount), beat_pulse_time)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1, 1), beat_pulse_time * 2)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

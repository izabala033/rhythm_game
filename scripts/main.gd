extends Node2D
@onready var shader_mat: ShaderMaterial = $ColorRect.material
@onready var beat_controller = $BeatController

func _ready():
	# pass the viewport size to shader
	shader_mat.set_shader_parameter("viewport_size", get_viewport().size)
	shader_mat.set_shader_parameter("beat_strength", 0.0)

	beat_controller.beat.connect(_on_beat)

func _on_beat():
	# pulse the shader on beat
	var tween = get_tree().create_tween()
	tween.tween_property(shader_mat, "shader_parameter/beat_strength", 1.0, 0.05).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(shader_mat, "shader_parameter/beat_strength", 0.0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

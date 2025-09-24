extends Node2D

@onready var shader_mat: ShaderMaterial = $ColorRect.material

func _ready():
	# pass the viewport size to shader
	shader_mat.set_shader_parameter("viewport_size", get_viewport().size)
	shader_mat.set_shader_parameter("beat_strength", 0.0)

	# join the group so BeatController will call on_beat()
	add_to_group("BeatReactors")

func on_beat(beat_count: int):
	# pulse every beat
	var tween = get_tree().create_tween()
	tween.tween_property(shader_mat, "shader_parameter/beat_strength", 1.0, 0.05) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(shader_mat, "shader_parameter/beat_strength", 0.0, 0.2) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# extra effect every 4th beat
	if beat_count % 4 == 0:
		print("Bar complete!")

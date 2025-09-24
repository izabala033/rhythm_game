extends Node

signal beat

@export var audio_path: String = "res://assets/summer_days.mp3"
var _player: AudioStreamPlayer
var _beat_interval: float
var _next_beat_time: float = 0.0

func _ready():
	_player = AudioStreamPlayer.new()
	add_child(_player)
	_player.stream = load(audio_path)
	_player.play()
	
	var bpm = _player.stream.get_bpm()

	_beat_interval = 60.0 / bpm
	_next_beat_time = _beat_interval

func _process(delta):
	if not _player.playing:
		return

	var current_time = _player.get_playback_position()
	while current_time >= _next_beat_time:
		emit_signal("beat")
		_next_beat_time += _beat_interval

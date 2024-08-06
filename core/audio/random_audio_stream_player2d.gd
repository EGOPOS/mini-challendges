@tool
class_name RandomAudioStreamPlayer2D extends AudioStreamPlayer2D

@export var clamp_pitch_from: float
@export var clamp_pitch_to: float

@export var clamp_db_from: float
@export var clamp_db_to: float

@export var random_playing: bool = false:
	set(value):
		if not is_node_ready(): await ready
		random_playing = value
		if random_playing:
			random_play()
		await finished
		random_playing = false

var counter: int = 0

func random_play(from: float = 0.0):
	pitch_scale = randf_range(clamp_pitch_from, clamp_pitch_to)
	volume_db = randf_range(clamp_db_from, clamp_db_to)#clamp(noise.get_noise_1d(clamp_pitch_from + noise.get_noise_1d(counter)), clamp_pitch_from, clamp_pitch_to)
	counter += 1
	super.play(from)

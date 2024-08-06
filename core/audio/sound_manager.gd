extends Node

# USER METHODS

func play(stream: AudioStream, bus: String = "Master") -> AudioStreamPlayer:
	return _play(_get_stream_player(bus), stream, bus)

func play2d(stream: AudioStream, bus: String = "Master") -> AudioStreamPlayer3D:
	return _play(_get_stream_player2d(bus), stream, bus)

func play3d(stream: AudioStream, bus: String = "Master") -> AudioStreamPlayer3D:
	return _play(_get_stream_player3d(bus), stream, bus)

func set_looped(player):
	player.finished.disconnect(player.queue_free)
	player.finished.connect(player.play)
	return player

func set_random(player, pitch_from: float, pitch_to: float, db_from: float, db_to: float):
	player.set_script(preload("res://core/audio/random_audio_stream_player2d.gd"))
	player.db_from = db_from
	player.db_to = db_to
	player.pitch_from = pitch_from
	player.pitch_to = pitch_to
	return player

# OTHER
#region
func _get_stream_player(bus: String = "Master"):
	var player = AudioStreamPlayer.new()
	player.bus = bus
	player.finished.connect(player.queue_free)
	add_child(player)
	return player

func _get_stream_player2d(bus: String = "Master"):
	var player = AudioStreamPlayer3D.new()
	player.bus = bus
	player.finished.connect(player.queue_free)
	add_child(player)
	return player

func _get_stream_player3d(bus: String = "Master"):
	var player = AudioStreamPlayer3D.new()
	player.bus = bus
	player.finished.connect(player.queue_free)
	add_child(player)
	return player

func _play(player, stream: AudioStream, bus: String = "Master"):
	player.stream = stream
	player.play()
	return player
#endregion


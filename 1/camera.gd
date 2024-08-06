extends Camera2D

@export var player: CharacterBody2D


func _process(delta: float) -> void:
	if not player: return
	
	
	position = position.lerp(player.position, delta * 16)

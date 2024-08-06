extends Node2D

@onready var area: Area2D = $Area2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_sprite: Sprite2D = $Pivot/Sprite2D

var character: CharacterBody2D = null
var character_entered_transform: Transform2D

func _ready() -> void:
	area.body_entered.connect(on_player_entered)
	timer.timeout.connect(func():
		if not character: return
		
		character.state_machine.transition_to("Fall")
		
		character.scale = Vector2.ONE
		character.rotation = 0
		character = null
		
		
		animation_player.play("pop")
		await animation_player.animation_finished
		hide_at_time()
	)
	
	animation_player.play("idle")


func on_player_entered(player):
	character = player
	character.state_machine.transition_to("Bubbled")
	animation_player.play("spinning")
	
	timer.start()
	
	await get_tree().physics_frame
	area.monitoring = false


func _process(delta: float) -> void:
	if character:
		character.global_transform = character_sprite.global_transform


func hide_at_time():
	get_tree().create_tween().tween_property(self, "modulate:a", 0.0, 0.5)
	
	await get_tree().create_timer(10.0).timeout
	
	get_tree().create_tween().tween_property(self, "modulate:a", 1.0, 0.5)
	area.monitoring = true
	animation_player.play("idle")

extends Node2D

@onready var area: Area2D = $Area2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: GPUParticles2D = $CPUParticles2D
@onready var particles_3: GPUParticles2D = $CPUParticles2D3
@onready var particles_2: GPUParticles2D = $CPUParticles2D2


func _ready() -> void:
	area.body_entered.connect(on_player_entered)

	animated_sprite.play("mine" + str(randi_range(0, 3)))


func on_player_entered(player):
	player.state_machine.transition_to("Jump")
	player.velocity.y -= 500
	particles.emitting = true
	particles_2.emitting = true
	particles_3.emitting = true
	
	await get_tree().physics_frame
	area.monitoring = false
	
	await get_tree().create_timer(.9).timeout
	
	animated_sprite.modulate.a = 0
	
	
	await get_tree().create_timer(5.0).timeout
	
	get_tree().create_tween().tween_property(animated_sprite, "modulate:a", 1.0, 0.5)
	
	await get_tree().physics_frame
	area.monitoring = true

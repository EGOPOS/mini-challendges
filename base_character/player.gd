extends CharacterBody2D

@export var direction_component: Node
@onready var state_machine: StateMachine = $StateMachine

@export_category("Move")
@export var speed: float = 30.0
@export var sprint_multiplier: float = 1.5
@export var acceleration: float = 5.0
@export var friction: float = 8.0

@export_category("Jump")
@export var default_jumps_count: int = 1
@export var air_multiplier: float = 0.6
@export var jump_release_multiplier: float = 0.4

@export var jump_height : float = 200
@export var jump_time_to_peak : float = 0.7
@export var jump_time_to_descent : float = 0.5

@export var coyote_time: float = 0.25

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export_enum("Male", "Female") var gender = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var jump_buffer: int = 1


func apply_acceleration(delta: float, direction: Vector2, multiplier: float = 1.0):
	velocity = velocity.lerp(Vector2(direction.x*speed, velocity.y), acceleration * delta * multiplier)

func apply_friction(delta: float, multiplier: float = 1.0):
	velocity = velocity.lerp(Vector2(0, velocity.y), friction * delta * multiplier)

func apply_jump_gravity(delta: float):
	velocity.y += jump_gravity*delta

func apply_fall_gravity(delta: float):
	velocity.y += fall_gravity*delta

func can_jump():
	return jump_buffer > 0

func reset_jump_buffer():
	jump_buffer = default_jumps_count

func update_flip():
	if round(velocity.x):
		animated_sprite.flip_h = velocity.x < 0

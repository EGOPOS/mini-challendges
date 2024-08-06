extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	object.animated_sprite.play("jump")
	object.velocity.y = object.jump_velocity
	object.jump_buffer -= 1

func update(delta: float):
	var direction = object.direction_component.get_direction()
	object.apply_acceleration(delta, direction * object.air_multiplier)
	object.apply_jump_gravity(delta)
	object.move_and_slide()
	
	object.update_flip()
	
	if Input.is_action_just_pressed("movement_jump") and object.can_jump():
		try_transition("Jump")
	
	if Input.is_action_just_released("movement_jump") or not Input.is_action_pressed("movement_jump"):
		object.velocity.y *= object.jump_release_multiplier
		try_transition("Fall")
	
	if object.velocity.y > 0:
		try_transition("Fall")

func exit():
	pass

func try_transition(state: String):
	state_machine.transition_to(state)

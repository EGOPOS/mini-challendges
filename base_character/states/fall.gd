extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	
	if object.animated_sprite.animation == "jump" and object.animated_sprite.is_playing():
		await object.animated_sprite.animation_finished
	object.animated_sprite.play("fall")

func update(delta: float):
	var direction = object.direction_component.get_direction()
	object.apply_acceleration(delta, direction, object.air_multiplier)
	object.apply_fall_gravity(delta)
	object.move_and_slide()
	
	object.update_flip()
	
	if get_left_time() > object.coyote_time:
		OneCall.callable(func(): object.jump_buffer -= 1)
	
	if Input.is_action_just_pressed("movement_jump") and object.can_jump():
		try_transition("Jump")
	
	if object.is_on_floor():
		if InputBuffer.is_action_in_buffer("movement_jump"):
			try_transition("Jump")
		else:
			try_transition("Idle")

func exit():
	pass

func try_transition(state: String):
	state_machine.transition_to(state)

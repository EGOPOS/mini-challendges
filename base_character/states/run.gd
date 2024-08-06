extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	object.animated_sprite.play("run")

func update(delta: float):
	var direction = object.direction_component.get_direction()
	object.apply_acceleration(delta, direction * object.sprint_multiplier)
	object.move_and_slide()
	
	object.update_flip()
	
	if direction == Vector2.ZERO:
		try_transition("Idle")
	
	if Input.is_action_just_pressed("movement_jump"):
		try_transition("Jump")
	
	if not object.is_on_floor():
		try_transition("Fall")
	
	if Input.is_action_just_released("movement_sprint"):
		try_transition("Walk")

func exit():
	pass

func try_transition(state: String):
	state_machine.transition_to(state)

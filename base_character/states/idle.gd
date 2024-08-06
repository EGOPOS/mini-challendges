extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	object.animated_sprite.play("idle")
	object.reset_jump_buffer()

func update(delta: float):
	object.apply_friction(delta)
	object.move_and_slide()
	
	var direction = object.direction_component.get_direction()
	if direction != Vector2.ZERO:
		try_transition("Walk")
	
	if InputBuffer.is_action_in_buffer("movement_jump"):
		try_transition("Jump")
	
	if not object.is_on_floor():
		try_transition("Fall")

func exit():
	pass

func try_transition(state: String):
	state_machine.transition_to(state)

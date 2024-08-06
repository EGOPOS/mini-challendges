extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	object.animated_sprite.play("fall")

func update(delta: float):
	object.apply_friction(delta)
	object.move_and_slide()

func exit():
	pass

func try_transition(state: String):
	state_machine.transition_to(state)

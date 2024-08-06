class_name State extends Node

var state_machine: StateMachine
var object: Object
var enter_time: int = 0

func enter(object: Object, state_machine: StateMachine):
	self.state_machine = state_machine
	self.object = object
	enter_time = get_time()

func update(delta: float):
	pass

func physics_update(delta: float):
	pass

func exit():
	pass

func try_transition(state: String):
	pass

func get_left_time():
	return (Time.get_ticks_msec()-enter_time)/1000.0

# Ну вдруг как-то переиначить нужно будет
func get_time():
	return Time.get_ticks_msec()

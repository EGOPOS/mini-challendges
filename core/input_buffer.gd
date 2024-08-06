extends Node

var actions = {
	"movement_jump": 0.15,
}

var _input_buffer: Array[String]

func _input(event):
	if event.is_action_type():
		for action in actions.keys():
			if event.is_action(action):
				_input_buffer.append(action)
				get_tree().create_timer(actions[action]).timeout.connect( Callable(func(action: String):
					_input_buffer.remove_at(_input_buffer.rfind(action))
				).bind(action) )

func is_action_in_buffer(action: String):
	if _input_buffer.find(action) != -1:
		return true
	return false

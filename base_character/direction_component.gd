extends Node

func get_direction():
	return Vector2(Input.get_axis("movement_left", "movement_right"), 0)

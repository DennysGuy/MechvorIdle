class_name DroneMove extends State

var speed : int = 150
var dir : Vector2

func enter() -> void:
	if parent.navigation_coordinates:
		dir = parent.navigation_coordinates.position - parent.position

func exit() -> void:
	parent.navigation_coordinates = null

func process_physics(delta: float) -> State:
	return null

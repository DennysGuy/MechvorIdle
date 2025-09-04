class_name DroneMove extends State

@export var idle_state : State

var speed : int = 20
var dir : Vector2

func enter() -> void:
	parent.animation_player.play("move")
	parent.progress_bar.hide()
	if parent.navigation_coordinates:
		dir = parent.navigation_coordinates - parent.global_position

func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	
	parent.velocity = dir.normalized() * speed
	parent.move_and_slide()
	var threshold := 1.0
	if  parent.position.distance_to(parent.navigation_coordinates) < threshold:
		return idle_state
	
	return null

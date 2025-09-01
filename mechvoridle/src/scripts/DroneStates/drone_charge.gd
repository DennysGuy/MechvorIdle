class_name DroneCharge extends State 

@export var idle_state : State

func enter() -> void:
	parent.animation_player.play("idle")
	parent.progress_bar.show()
	parent.rotation = 0
func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	if is_instance_valid(parent.tracked_hostile):
		parent.look_at(parent.tracked_hostile)
	else:
		return idle_state
	return null

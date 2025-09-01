class_name TurretIdle extends State
@export var charge_state : State
func enter() -> void:
	parent.animation_player.play("idle")
	parent.progress_bar.hide()

func exit() -> void:
	pass


func process_physics(delta: float) -> State:
	if is_instance_valid(parent.tracked_hostile):
		return charge_state
		
	return null

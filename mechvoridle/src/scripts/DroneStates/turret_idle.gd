class_name TurretIdle extends State
@export var charge_state : State
func enter() -> void:
	parent.animation_player.play("idle")
	parent.progress_bar.hide()
	#parent.sprite_2d.rotation = 0
	print("Hey I'm in Idle State")
func exit() -> void:
	pass


func process_physics(delta: float) -> State:
	if parent.tracked_hostile:
		return charge_state
		
	return null

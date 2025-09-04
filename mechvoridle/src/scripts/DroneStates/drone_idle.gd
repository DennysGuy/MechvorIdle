class_name DroneIdle extends State

@onready var state_machine :StateMachine = $".."


func enter() -> void:
	parent.animation_player.play("idle")
	parent.progress_bar.show()

func process_physics(delta : float) -> State:
	if not GameManager.can_fight_boss:
		parent.progress_bar.value += GameManager.drone_mining_speed
		
		if parent.progress_bar.value >= parent.progress_bar.max_value:
			parent.obtain_resources()
			parent.progress_bar.value = 0

	else:
		parent.progress_bar.value = 0
	
	return null

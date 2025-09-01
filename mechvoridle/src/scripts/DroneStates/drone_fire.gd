class_name DroneFire extends State


func enter() -> void:
	
	parent.animation_player.play("fire_laser")
	parent.progress_bar.hide()

func exit() -> void:
	pass


func process_physics(delta: float) -> State:
	#we'll handle moving to charge state in the parent
	return null

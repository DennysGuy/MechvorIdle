class_name HealerIdle extends State

@export var heal : State

func enter() -> void:
	parent.animation_player.play("Idle")
	parent.timer.wait_time = 2.0
	parent.timer.start()
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0.0:
		return heal
	
	return null

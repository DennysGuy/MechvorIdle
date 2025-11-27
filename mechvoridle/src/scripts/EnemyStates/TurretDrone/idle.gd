class_name TurretBotIdle extends State

@export var shoot : State

func enter() -> void:

	parent.animation_player.play("idle")
	parent.timer.wait_time = randf_range(0.5,1.3)
	parent.timer.start()

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		return shoot
	return null
		

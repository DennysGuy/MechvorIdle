class_name EnemyShoot extends State

@export var idle: State


func enter() -> void:
	parent.is_attacking = true
	if !GameManager.in_overdrive_mode:
		parent.animation_player.speed_scale = 1.3
	else:
		parent.animation_player.speed_scale = TimeManager.slow_time_factor
		
	parent.animation_player.play(animation_name)
	
	if !GameManager.in_overdrive_mode:
		parent.timer.wait_time = 2.0
	else:
		parent.timer.wait_time = 3.5
		
	parent.timer.start()

func exit() -> void:
	parent.is_attacking = false
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		return idle
	return null
		

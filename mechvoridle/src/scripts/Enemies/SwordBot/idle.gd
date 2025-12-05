class_name SwordBotIdle extends State

@export var pursue : State

func enter() -> void:
	if parent.is_blocking:
		parent.animation_player.play('Block')
	else:
		parent.animation_player.play("Idle")
		
	if GridManager.player and not parent.is_slave:
		if !GameManager.in_overdrive_mode:
			parent.timer.wait_time = 0.5
		else:
			parent.timer.wait_time = 1.0
			
		parent.timer.start()
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.timer.time_left <= 0 and GridManager.player and !parent.is_slave:
		return pursue
	
	return null
		

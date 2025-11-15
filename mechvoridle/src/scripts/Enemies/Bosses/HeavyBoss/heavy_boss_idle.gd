class_name HeavyBossIdle extends State

@export var random_move : State
@export var taunt : State

func enter() -> void:
	parent.animation_player.play("Idle")
	if parent.change_phase:
		parent.idle_time = 2.0
	else:
		match parent.current_phase:
			parent.PHASES.ATTACK_PHASE1:
				parent.idle_time = 0.5
	
	parent.timer.wait_time = parent.idle_time
	parent.timer.start()
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.change_phase:
		return taunt
	
	if parent.current_phase == parent.PHASES.ATTACK_PHASE1:
		return random_move
	
	return null
		

class_name HeavyBossIdle extends State

@export var random_move : State
@export var rocket_shots : State
@export var taunt : State
@export var shield_summon : State
@export var death : State
func enter() -> void:

	parent.animation_player.play("Idle")
	if parent.change_phase:
		parent.idle_time = 2.0
	else:
		match parent.current_phase:
			parent.PHASES.ATTACK_PHASE1:
				parent.idle_time = 1.0
	
	parent.timer.wait_time = parent.idle_time
	parent.timer.start()
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.is_dead:
		return death
	
	if parent.change_phase:
		return taunt
	
	if parent.current_phase == parent.PHASES.ATTACK_PHASE1:
		return random_move
	elif parent.current_phase == parent.PHASES.ATTACK_PHASE2:
		return rocket_shots
	elif parent.current_phase == parent.PHASES.ATTACK_PHASE3:
		return shield_summon
		
	return null
		

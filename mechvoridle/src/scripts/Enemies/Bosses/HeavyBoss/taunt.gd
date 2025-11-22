class_name BossTaunt extends State

@export var idle : State
var taunt_finished : bool = false
func enter() -> void:
	parent.can_hurt = true
	#parent.animation_player.play("Idle")
	#taunt_finished = false
	#await get_tree().create_timer(2.0).timeout
	#taunt_finished = true
	parent.animation_player.play("Taunt")
	parent.timer.wait_time = 3.0

	parent.timer.start()
	
func exit() -> void:
	parent.change_phase = false

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.timer.time_left <= 0:
		if parent.current_phase != parent.PHASES.ATTACK_PHASE3:
			parent.phase_timer.wait_time = randi_range(8,15)
			parent.phase_timer.start()
		return idle
	
	return null
		

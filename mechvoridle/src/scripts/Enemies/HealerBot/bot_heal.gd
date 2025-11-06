class_name EnemyHeal extends State

@export var idle : State

func enter() -> void:
	var pulse : HealPulse = preload("uid://dmyiefkprcywd").instantiate()
	pulse.global_position = parent.pulse_point.global_position
	parent.get_parent().add_child(pulse)
	
	var pulse_2 : HealPulse = preload("uid://dmyiefkprcywd").instantiate()
	pulse_2.global_position = parent.pulse_point2.global_position
	parent.get_parent().add_child(pulse_2)
	SignalBus.heal_enemy.emit()
	parent.timer.wait_time = 0.3
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		return idle

	return null

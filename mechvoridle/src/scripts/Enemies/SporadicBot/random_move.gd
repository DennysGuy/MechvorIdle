class_name RandomMove extends State

@export var idle : State
@export var zap : State
@export var timer_wait : float = 0.3
var time_to_shoot : int = 0
var interval : int = 2
func enter() -> void:
	SignalBus.move_enemy.emit(parent, parent.random_direction_list.pick_random(),parent.row_limit,parent.col_limit)
	time_to_shoot += 1
	parent.timer.wait_time = timer_wait
	parent.timer.start()

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		
		if time_to_shoot == interval:
			time_to_shoot = 0
			return zap
			
		return idle
	
	return null

class_name RandomMove extends State

@export var idle : State
@export var attack : State
@export var timer_wait : float = 0.3
var time_to_shoot : int = 0
@export var interval_min_val : int = 2
@export var interval_max_val : int = 4
var interval : int = 0
func enter() -> void:
	SfxManager.play_sfx(SfxManager.get_enemy_movement_whoosh())
	interval = randi_range(interval_min_val, interval_max_val)
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
		
		if time_to_shoot >= interval:

			time_to_shoot = 0
			return attack
			
		return idle
	
	return null

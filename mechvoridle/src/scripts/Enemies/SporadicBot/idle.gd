class_name SporadicIdle extends State


@export var random_move : State
@export var die : State
var timer : Timer
func enter() -> void:
	
	
	parent.animation_player.play("idle")
	var random_time : float = randf_range(0.5,1.0)
	parent.timer.wait_time = random_time
	parent.timer.start()

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.is_dead:
		parent.state_machine.change_state(die)
		
	if parent.timer.time_left <= 0:
		return random_move
	
	return null

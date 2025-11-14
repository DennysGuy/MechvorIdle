class_name BossDropIn extends State

@export var taunt : State 


func enter() -> void:
	parent.misc_animation_player.play("Intro")
	parent.timer.wait_time = 0.2
	parent.timer.start()
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		return taunt
	
	return null
		

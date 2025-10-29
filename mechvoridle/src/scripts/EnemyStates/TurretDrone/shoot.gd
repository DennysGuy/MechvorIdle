class_name EnemyShoot extends State

@export var idle: State


func enter() -> void:
	parent.animation_player.play(animation_name)
	await get_tree().create_timer(0.6667).timeout
	parent.state_machine.change_state(idle)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
		

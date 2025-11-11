class_name Zap extends State

@export var idle : State

func enter() -> void:

	parent.animation_player.speed_scale = 1.5
	parent.animation_player.play("shoot")
	await get_tree().create_timer(2.0).timeout
	parent.state_machine.change_state(idle)
func exit() -> void:
	parent.animation_player.speed_scale = 1.0

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

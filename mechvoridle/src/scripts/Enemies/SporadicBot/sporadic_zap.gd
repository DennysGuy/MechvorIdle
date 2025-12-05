class_name Zap extends State

@export var idle : State

func enter() -> void:
	parent.is_attacking = true
	if !GameManager.in_overdrive_mode:
		parent.animation_player.speed_scale = 2.5
		
	parent.animation_player.play("shoot")
	var wait_time : float = 0.7
	if GameManager.in_overdrive_mode:
		wait_time = 2.0
		
	await get_tree().create_timer(wait_time).timeout
	parent.state_machine.change_state(idle)
func exit() -> void:
	parent.is_attacking = false
	parent.animation_player.speed_scale = 1.0

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

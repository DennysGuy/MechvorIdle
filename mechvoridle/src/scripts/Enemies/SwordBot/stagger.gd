class_name SwordBotStagger extends State

@export var idle : State
func enter() -> void:
	parent.in_stagger_state = true
	parent.animation_player.play("Stagger")
	parent.timer.wait_time = 3.0
	parent.timer.start()

func exit() -> void:
	SignalBus.move_actor_to_tile.emit(parent, parent.destined_tile)
	parent.in_stagger_state = false
	parent.tile_to_attack = null
	parent.destined_tile = null

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		return idle
	return null
		

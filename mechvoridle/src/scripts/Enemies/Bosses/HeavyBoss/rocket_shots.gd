class_name RocketShots extends State


@export var taunt : State
var number_of_shots : int 

func enter() -> void:
	var pos_choices : Array[int] = [0,2]
	var destined_tile : Tile = GridManager.get_tile(parent.tiles,Vector2(0,pos_choices.pick_random()))
	SignalBus.move_actor_to_tile.emit(parent, destined_tile)
	parent.animation_player.play("RocketIdle")
	parent.timer.wait_time = 2.0
	await get_tree().create_timer(1.0).timeout
	parent.timer.start()

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.timer.time_left <= 0:
		print("FIRE ROCKETS!")
		if parent.change_phase:
			return taunt
		else:
			parent.timer.start()

	return null
		

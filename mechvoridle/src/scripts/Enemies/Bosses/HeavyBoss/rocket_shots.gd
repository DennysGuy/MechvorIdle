class_name RocketShots extends State


@export var taunt : State
var number_of_shots : int 


func enter() -> void:
	var pos_choices : Array[int] = [0,2]
	var destined_tile : Tile = GridManager.get_tile(parent.tiles,Vector2(0,pos_choices.pick_random()))
	SignalBus.move_actor_to_tile.emit(parent, destined_tile)
	parent.animation_player.play("RocketIdle")
	await get_tree().create_timer(0.5).timeout
	parent.rocket_launch_timer.start()

func exit() -> void:
	parent.rocket_launch_timer.stop()


func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.change_phase:
		return taunt


	return null
		

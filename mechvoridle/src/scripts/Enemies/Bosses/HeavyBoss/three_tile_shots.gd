class_name ThreeTileShots extends State

'''
How this functions:
	
	- the boss will navigate to one of the side tiles during beginning of process
	- the boss will fire, move to next tile ; repeat process until they get to the final tile
	- then they will return to idle state and repeat process

'''
@export var idle : State
var initial_tile : Tile

func enter() -> void:

	var tile_choices := [0,2]
	initial_tile = GridManager.get_tile(parent.tiles, Vector2(0,0))
	SignalBus.move_actor_to_tile.emit(parent, initial_tile)

	var new_coordinates : Vector2 = Vector2.ZERO

	new_coordinates = Vector2(0,2)

	
	parent.destined_tile = GridManager.get_tile(parent.tiles, new_coordinates)

	var i : float = parent.current_tile.coordinates.y
			
	while i <= new_coordinates.y:
		parent.animation_player.play("CanonArmFire")
		await get_tree().create_timer(0.6).timeout
		i += 1.0
		var new_tile : Tile = GridManager.get_tile(parent.tiles, Vector2(new_coordinates.x, i))
		SignalBus.move_actor_to_tile.emit(parent, new_tile)
		
	parent.state_machine.change_state(idle)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
		

func direction(init_y_value : int, destined_y_value : int) -> float:
	if init_y_value < destined_y_value:
		return 1
	else:
		return -1

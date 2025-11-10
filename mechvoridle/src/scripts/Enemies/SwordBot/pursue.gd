class_name SwordBotPursue extends State

'''
when we exit idle, we will access the player's current tile and use the "y" value
as a means to navigate sword bot to the location.

We will move sword bot tile by tile until their reaches the destined column.

Once sword bot has reached the tile we'll go into prepare state - which just plays the prepare
animation player.

When animation ends, we'll go to the attack state which will be dashing to the appropriate tile (if not at row 3)
issuing the attack and retreating back.
'''
@export var idle : State
@export var prepare : State



func enter() -> void:
	if GridManager.player:
		var new_coordinates : Vector2 = Vector2(parent.current_tile.coordinates.x, GridManager.player.current_tile.coordinates.y)
		parent.destined_tile = GridManager.get_tile(parent.tiles, new_coordinates)
		parent.tile_to_attack = GridManager.player.current_tile
		var i : float = parent.current_tile.coordinates.y
		
		while parent.current_tile.coordinates != new_coordinates:
			i += 1.0 * multiplier(parent.current_tile.coordinates.y, new_coordinates.y)
			var new_tile : Tile = GridManager.get_tile(parent.tiles, Vector2(new_coordinates.x, i))
			SignalBus.move_actor_to_tile.emit(parent, new_tile)
			await get_tree().create_timer(0.5).timeout
			
		parent.state_machine.change_state(prepare) #for now
	else:
		parent.state_machine.change_state(idle)
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
		
func multiplier(init_y_value : int, destined_y_value : int) -> float:
	if init_y_value < destined_y_value:
		return 1
	else:
		return -1

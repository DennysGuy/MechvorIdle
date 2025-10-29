extends Node

const MAX_ROWS = 5
const MAX_COLUMNS = 3

var player : GridPlayer
var enemies : Array[GridEnemy]

var targeted_tiles : Array[Tile] = []

func _ready() -> void:
	pass
	
func init_grid(tiles : Node) -> void:
	var x_pos : int = 0
	for row in range(MAX_ROWS):
		var new_position : Vector3 = Vector3.ZERO
		var y_pos : int = 0
		
		if row != 0: 
			x_pos += 3
		else: 
			x_pos = 0
		
		new_position.x = x_pos
		
		for col in range(MAX_COLUMNS):
			var new_tile : Tile = preload("uid://jgfdd71l3y54").instantiate()
			new_tile.coordinates = Vector2(row,col)
			if col != 0: 
				y_pos += 3
			else: 
				y_pos = 0
			
			if row == 4:
				new_tile.set_owner_as_player()
			else:
				new_tile.set_owner_as_enemy()
		
			#new_tile.set_owner_as_player()
			new_tile.position = Vector3(y_pos, 0, x_pos)
			tiles.add_child(new_tile)

	print(tiles.get_children().size())

func get_tile(tiles : Node, coordinates : Vector2) -> Tile:
	
	if coordinates.x < 0 or coordinates.x > MAX_ROWS-1:
		return null
	
	if coordinates.y < 0 or coordinates.y > MAX_COLUMNS-1:
		return null
	
	if tiles.get_children().is_empty():
		return null
	
	for tile in tiles.get_children():
		if tile is Tile and tile.coordinates == coordinates:
			return tile
			
	return null

func spawn_player(tiles : Node) -> void:
	var grid_player : GridPlayer = preload("uid://lam3j4dmw2xs").instantiate()
	var starting_tile : Tile = get_tile(tiles, Vector2(4,1))
	grid_player.global_position = starting_tile.marker_3d.global_position
	player = grid_player
	starting_tile.occupant = player
	player.current_tile = starting_tile
	player.tiles = tiles
	add_child(grid_player)

func spawn_test_enemy(tiles : Node) -> void:
	var spor_enemy : GridEnemy = preload("uid://b7cur5tqfwumt").instantiate()
	var starting_tile : Tile = get_tile(tiles, Vector2(1,1))
	spor_enemy.global_position = starting_tile.marker_3d.global_position
	spor_enemy.current_tile = starting_tile
	spor_enemy.tiles = tiles
	starting_tile.occupant = spor_enemy
	
	var turret_enemy1 : GridEnemy = preload("uid://bdavl4sbcomxk").instantiate()
	var starting_tile_turret_1 : Tile = get_tile(tiles, Vector2(0,0))
	turret_enemy1.global_position = starting_tile_turret_1.marker_3d.global_position
	turret_enemy1.current_tile = starting_tile_turret_1
	turret_enemy1.tiles = tiles
	starting_tile_turret_1.occupant = turret_enemy1
	
	var turret_enemy2 : GridEnemy = preload("uid://bdavl4sbcomxk").instantiate()
	var starting_tile_turret_2 : Tile = get_tile(tiles, Vector2(0,2))
	turret_enemy2.global_position = starting_tile_turret_2.marker_3d.global_position
	turret_enemy2.current_tile = starting_tile_turret_2
	turret_enemy2.tiles = tiles
	starting_tile_turret_2.occupant = turret_enemy2
		
	
	enemies.append(spor_enemy)
	enemies.append(turret_enemy1)
	enemies.append(turret_enemy2)
	
	add_child(spor_enemy)
	add_child(turret_enemy1)
	add_child(turret_enemy2)
	
func tile_available(grid_actor : GridActor, adjacent_tile : Tile, row_limit : int = -1, col_limit : int = -1) -> bool:
	if not adjacent_tile:
		print("no tile here, chum")
		print(adjacent_tile)
		return false
	
	if row_limit > -1 and adjacent_tile.coordinates.x >= row_limit:
		print("out of row limit")
		return false
	
	if col_limit > -1 and adjacent_tile.coordinates.y >= col_limit:
		print("out of col limit")
		return false
	
	if adjacent_tile.occupant:
		print("tile occupied")
		print(adjacent_tile)
		return false
	
	if grid_actor is GridPlayer and adjacent_tile.current_owner == adjacent_tile.OWNER.ENEMY:
		print(adjacent_tile)
		print("tile has incorrect owner")
		return false
	
	if grid_actor is GridEnemy and adjacent_tile.current_owner == adjacent_tile.OWNER.PLAYER:
		print(adjacent_tile)
		print("tile has incorrect owner")
		return false
	
	return true


func clear_targeted_tiles() -> void:
	for tile in targeted_tiles:
		tile.clear_targeted_overlay()
	
	targeted_tiles.clear()

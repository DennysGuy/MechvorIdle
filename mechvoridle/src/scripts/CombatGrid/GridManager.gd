extends Node

const MAX_ROWS : int = 5
const MAX_COLUMNS : int = 3
const MAX_WAVES : int = 10
var current_wave : int = -1

var player : GridPlayer
var enemies : Array[GridEnemy] = []

var targeted_tiles : Array[Tile] = []

const SPORADIC_ENEMY = preload("uid://b7cur5tqfwumt")
const TURRET_ENEMY = preload("uid://bdavl4sbcomxk")
const HEALER_BOT = preload("uid://dcrmt7013v31a")
const SWORD_BOT = preload("uid://df0aqkd6tb8o0")


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

#func spawn_test_enemy(tiles : Node) -> void:
	#
	#var spor_enemy = preload("uid://b7cur5tqfwumt")
	#spawn_enemy(spor_enemy,Vector2(1,1), tiles)
#
	#var turret_enemy1 = preload("uid://dcrmt7013v31a")
	#spawn_enemy(turret_enemy1,Vector2(0,0), tiles)
	#
	#var healer_bot = preload("uid://bdavl4sbcomxk")
	#spawn_enemy(healer_bot,Vector2(0,2), tiles)


func check_wave_status() -> void:
	if enemies.is_empty() and !GameManager.timed_out:
		SignalBus.spawn_next_wave.emit()

	
func tile_available(grid_actor : GridActor, adjacent_tile : Tile, row_limit : int = -1, col_limit : int = -1, is_dash_attack : bool = false) -> bool:
	if not adjacent_tile:
		#print("no tile here, chum")
		#print(adjacent_tile)
		return false
	
	if row_limit > -1 and adjacent_tile.coordinates.x >= row_limit:
		#print("out of row limit")
		return false
	
	if col_limit > -1 and adjacent_tile.coordinates.y >= col_limit:
		#print("out of col limit")
		return false
	
	if adjacent_tile.occupant:
		#print("tile occupied")
		#print(adjacent_tile)
		return false
	
	if grid_actor is GridPlayer and adjacent_tile.current_owner == adjacent_tile.OWNER.ENEMY and not is_dash_attack:
		#print(adjacent_tile)
		#print("tile has incorrect owner")
		return false
	
	if grid_actor is GridEnemy and adjacent_tile.current_owner == adjacent_tile.OWNER.PLAYER:
		#print(adjacent_tile)
		#print("tile has incorrect owner")
		return false
	
	return true


func clear_targeted_tiles() -> void:
	for tile in targeted_tiles:
		tile.clear_targeted_overlay()
	
	targeted_tiles.clear()


func set_mech_as_light() -> void:
	GameManager.owned_mech_components["Head"] = preload("uid://b7cbnbqyrpcv1")
	GameManager.owned_mech_components["Torso"] = preload("uid://d2s3tleah2tvp")
	GameManager.owned_mech_components["Arms"] = preload("uid://cjuugvmjr36lj")
	GameManager.owned_mech_components["Legs"] = preload("uid://cpmb51aj71fpr")
	

func set_mech_as_heavy() -> void:
	GameManager.owned_mech_components["Head"] = preload("uid://cmbchudcdtn2r")
	GameManager.owned_mech_components["Torso"] = preload("uid://bjr7icnj7rnhl")
	GameManager.owned_mech_components["Arms"] = preload("uid://4vf13bdn8i41")
	GameManager.owned_mech_components["Legs"] = preload("uid://kkoht6ubl33m")
	
func set_mech_as_standard_heavy() -> void:
	GameManager.owned_mech_components["Head"] = preload("uid://cmbchudcdtn2r")
	GameManager.owned_mech_components["Torso"] = preload("uid://lr8shvddq7me")
	GameManager.owned_mech_components["Arms"] = preload("uid://4vf13bdn8i41")
	GameManager.owned_mech_components["Legs"] = preload("uid://k1p5grxnndv3")

func set_mech_as_standard_light() -> void:
	GameManager.owned_mech_components["Head"] = preload("uid://b7cbnbqyrpcv1")
	GameManager.owned_mech_components["Torso"] = preload("uid://lr8shvddq7me")
	GameManager.owned_mech_components["Arms"] = preload("uid://cjuugvmjr36lj")
	GameManager.owned_mech_components["Legs"] = preload("uid://k1p5grxnndv3")





var waves = [
	[
		{
			"enemy" : TURRET_ENEMY.duplicate(true),
			"coordinates": Vector2(1,1),
			"is_slave": false
		},
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(0,2),
			"is_slave": false
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(0,0),
			"is_slave": false
		}
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(0,0),
			"is_slave": false
		},
		{
			"enemy": TURRET_ENEMY.duplicate(true),
			"coordinates": Vector2(0,2),
			"is_slave": false
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(0,1),
			"is_slave": false
		}
		
	],
	[
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(1,2),
			"is_slave": false
		},
		{
			"enemy": HEALER_BOT.duplicate(true),
			"coordinates": Vector2(0,0),
			"is_slave": false
		}
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(0,0),
			"is_slave": false
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(1,1),
			"is_slave": false
		},
		{
			"enemy": HEALER_BOT.duplicate(true),
			"coordinates": Vector2(0,2),
			"is_slave": false
		}
	],
	[
		{
			"enemy": SWORD_BOT.duplicate(true), 
			"coordinates": Vector2(2,1),
			"is_slave": false
		},
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(0,1),
			"is_slave": false
		},
		{
			"enemy": SWORD_BOT.duplicate(true), 
			"coordinates": Vector2(2,1),
			"is_slave": false
		},
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(0,2),
			"is_slave": false
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(1,1),
			"is_slave": false
		},
		{
			"enemy": SWORD_BOT.duplicate(true), 
			"coordinates": Vector2(2,0),
			"is_slave": false
		},
		
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(0,0),
			"is_slave": false
		},
		{
			"enemy": HEALER_BOT.duplicate(true), 
			"coordinates": Vector2(0,2),
			"is_slave": false
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(1,0),
			"is_slave": false
		},
		{
			"enemy": SWORD_BOT.duplicate(true), 
			"coordinates": Vector2(2,2),
			"is_slave": false
		},
		
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(0,0),
			"is_slave": false
		},
		{
			"enemy": HEALER_BOT.duplicate(true), 
			"coordinates": Vector2(0,2),
			"is_slave": false
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(1,0),
			"is_slave": false
		},
		{
			"enemy": SWORD_BOT.duplicate(true), 
			"coordinates": Vector2(3,0),
			"is_slave": false
		},
		{
			"enemy": SWORD_BOT.duplicate(true), 
			"coordinates": Vector2(2,0),
			"is_slave": true
		},
	]
	
	
]



func reset_combat() -> void:
	current_wave = -1;
	player.health = player.max_health

extends Node

const MAX_ROWS : int = 6
const MAX_COLUMNS : int = 4
const MAX_WAVES : int = 15
const MAX_LEVEL : int = 3
const PLAYER_ROW : int = 5
var current_wave : int = -1

var player : GridPlayer
var enemies : Array[GridEnemy] = []
var boss_waves_to_beat : int = 0
var targeted_tiles : Array[Tile] = []
var locked_on_enemies : Array[GridActor] = []
var wave_level : int = 1 #used for wave level and challenge level --increments after challenge level ends
var total_waves_completed : int = 0
const SPORADIC_ENEMY = preload("uid://b7cur5tqfwumt")
const TURRET_ENEMY = preload("uid://bdavl4sbcomxk")
const HEALER_BOT = preload("uid://dcrmt7013v31a")
const SWORD_BOT = preload("uid://df0aqkd6tb8o0")
const CHALLENGE_CHEST = preload("uid://mutb6sqjaftb")

const HEAVY_BOSS = preload("uid://dolkqjjmpal6f")

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
			
			if row == PLAYER_ROW:
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
	var starting_tile : Tile = get_tile(tiles, Vector2(5,1))
	grid_player.global_position = starting_tile.marker_3d.global_position
	player = grid_player
	starting_tile.occupant = player
	player.current_tile = starting_tile
	player.tiles = tiles
	add_child(grid_player)

var boss_spawn : Array = [
		{
			"enemy": HEAVY_BOSS.duplicate(true), 
			"coordinates": Vector2(0,1),
			"is_slave": false,
			"is_boss": true,
			"level" : 1
		}
	]

func check_wave_status() -> void:
	if enemies.is_empty() and !GameManager.timed_out and !GameManager.in_boss_fight:
		SignalBus.spawn_next_wave.emit()
	if enemies.is_empty() and GameManager.in_boss_fight:
		GridManager.boss_waves_to_beat -= 1
		if boss_waves_to_beat > 0:
			SignalBus.spawn_mini_wave.emit()
	
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
		return false
	
	if grid_actor is GridPlayer and adjacent_tile.current_owner == adjacent_tile.OWNER.ENEMY and not is_dash_attack:
		return false
	
	if grid_actor is GridEnemy and adjacent_tile.current_owner == adjacent_tile.OWNER.PLAYER:
		return false
	
	return true

func add_enemy_to_locked_on_list(enemy : GridActor) -> void:
	var list_has_enemy : bool = locked_on_enemies.has(enemy)
	
	if !list_has_enemy:
		enemy.lock_on_cross_hair.show()
		locked_on_enemies.append(enemy)
		
	print("THIS IS LOCKED ON LIST AFTER ADD: %s" % [locked_on_enemies])

## TODO Will need to call this when the enemy dies too
func remove_enemy_from_locked_on_list(enemy : GridActor) -> void:
	if enemy:
		enemy.lock_on_cross_hair.hide()
		locked_on_enemies.erase(enemy)
		
	print("THIS IS LOCKED ON LIST AFTER ERASE: %s" % [locked_on_enemies])

func remove_all_enemies_from_locked_on_list() -> void:
	for enemy in locked_on_enemies:
		if is_instance_valid(enemy):
			remove_enemy_from_locked_on_list(enemy)
		
	if !locked_on_enemies.is_empty():
		locked_on_enemies.clear()
	
	print("THIS IS LOCKED ON LIST AFTER ERASE ALL: %s" % [locked_on_enemies])

func clear_targeted_tiles() -> void:
	for tile in targeted_tiles:
		if is_instance_valid(tile):
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

func set_mech_as_standard() -> void:
	pass

var level_configurations : Dictionary = {
	1 : {
		"waves": [
			##WAVE 1
			[
				{
					"enemy": CHALLENGE_CHEST.duplicate(true),
					"coordinates": Vector2(0,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
			],
			##WAVE 2
			[
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
			],
			##WAVE 3
			[
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(1,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
			],
			##WAVE 4
			[
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,0),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(2,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
			],
			##WAVE 5
			[
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(2,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(2,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(0,0),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(0,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
			]
		]
	},
	2 : {
		"waves": [
			##WAVE 1
			[
				{
					"enemy": HEALER_BOT.duplicate(true),
					"coordinates": Vector2(0,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				}
			],
			##WAVE 2
			[
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(1,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(1,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(0,0),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(0,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
			],
			##WAVE 3
			[
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(0,0),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(2,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
			],
			##WAVE 4
			[
				{
					"enemy": HEALER_BOT.duplicate(true),
					"coordinates": Vector2(0,0),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(0,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(1,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
			],
			##WAVE 5
			[
				{
					"enemy": HEALER_BOT.duplicate(true),
					"coordinates": Vector2(0,0),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": HEALER_BOT.duplicate(true),
					"coordinates": Vector2(0,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(2,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
			]
		]
	},
	3 : {
		"waves" : [
			##WAVE 1
			[
				{
					"enemy": SWORD_BOT.duplicate(true),
					"coordinates": Vector2(2,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				}
			],
			##WAVE 2
			[
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(0,0),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				}
			],
			##WAVE 3
			[
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(0,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(2,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				}
			],
			##WAVE 4
			[
				{
					"enemy": HEALER_BOT.duplicate(true),
					"coordinates": Vector2(0,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				},
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(0,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SWORD_BOT.duplicate(true),
					"coordinates": Vector2(2,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 1
				},
			],
			##WAVE 5
			[
				{
					"enemy": HEALER_BOT.duplicate(true),
					"coordinates": Vector2(0,1),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				},
				{
					"enemy": TURRET_ENEMY.duplicate(true),
					"coordinates": Vector2(0,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 3
				},
				{
					"enemy": SPORADIC_ENEMY.duplicate(true),
					"coordinates": Vector2(1,3),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SWORD_BOT.duplicate(true),
					"coordinates": Vector2(3,2),
					"is_slave": false,
					"is_boss": false,
					"level" : 2
				},
				{
					"enemy": SWORD_BOT.duplicate(true),
					"coordinates": Vector2(2,2),
					"is_slave": true,
					"is_boss": false,
					"level" : 1
				},
			],			
		],
	},

}

var boss_mini_waves = [
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(1,0),
			"is_slave": false,
			"is_boss": false,
			"level": 1
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(1,2),
			"is_slave": false,
			"is_boss": false,
			"level": 1
		}
	],
	[
		{
			"enemy": SPORADIC_ENEMY.duplicate(true), 
			"coordinates": Vector2(2,3),
			"is_slave": false,
			"is_boss": false,
			"level": 2,
		},
		{
			"enemy": SPORADIC_ENEMY.duplicate(true),
			"coordinates": Vector2(1,2),
			"is_slave": false,
			"is_boss": false,
			"level": 1
		}
	],
	[
		{
			"enemy": SPORADIC_ENEMY.duplicate(true), 
			"coordinates": Vector2(2,2),
			"is_slave": false,
			"is_boss": false,
			"level":2
		},
		{
			"enemy": SWORD_BOT.duplicate(true),
			"coordinates": Vector2(2,0),
			"is_slave": false,
			"is_boss": false,
			"level": 1
		}
	],
	[
		{
			"enemy": TURRET_ENEMY.duplicate(true), 
			"coordinates": Vector2(2,0),
			"is_slave": false,
			"is_boss": false,
			"level": 1
		},
		{
			"enemy": TURRET_ENEMY.duplicate(true),
			"coordinates": Vector2(2,2),
			"is_slave": false,
			"is_boss": false,
			"level": 1
		}
	]
]

func reset_combat() -> void:
	current_wave = -1;
	total_waves_completed = 0
	player.health = player.max_health
	wave_level = 1

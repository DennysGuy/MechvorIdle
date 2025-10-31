class_name CombatGrid extends Node3D


@onready var tiles: Node = $Tiles
var player : GridPlayer
@onready var health_amount_label: Label = $CanvasLayer/HealthAmountLabel
@onready var player_health_bar: ProgressBar = $CanvasLayer/PlayerHealthBar



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridManager.init_grid(tiles)
	GridManager.spawn_player(tiles)
	GridManager.spawn_test_enemy(tiles)
	SignalBus.move_player.connect(move_player)
	SignalBus.move_enemy.connect(move_actor)
	player_health_bar.max_value = GridManager.player.health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GridManager.player:
		health_amount_label.text = "%s/%s" % [GridManager.player.health, GridManager.player.max_health]
		player_health_bar.value = GridManager.player.health


func move_player(direction : Vector2) -> void:
	move_actor(GridManager.player, direction)
	
	
func move_actor(grid_actor : GridActor, direction : Vector2, row_limit : int = -1, col_limit : int = -1) -> void:
	var new_coords : Vector2 = grid_actor.current_tile.coordinates + direction
	var adjacent_tile : Tile = GridManager.get_tile(tiles, new_coords)
	
	if not GridManager.tile_available(grid_actor, adjacent_tile, row_limit, col_limit):
		return

	translate_actor(grid_actor, adjacent_tile)
	
	
func translate_actor(actor : GridActor, adjacent_tile : Tile) -> void:
	var prev_tile = actor.current_tile
	var next_tile = adjacent_tile
	prev_tile.occupant = null
	actor.current_tile = adjacent_tile
	next_tile.occupant = actor
	actor.global_position = adjacent_tile.marker_3d.global_position

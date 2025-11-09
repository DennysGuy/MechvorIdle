class_name CombatGrid extends Node3D


@onready var tiles: Node = $Tiles
var player : GridPlayer
@onready var health_amount_label: Label = $CanvasLayer/HealthAmountLabel
@onready var player_health_bar: ProgressBar = $CanvasLayer/PlayerHealthBar
@onready var player_shield_stamina: ProgressBar = $CanvasLayer/PlayerShieldStamina

@onready var wave_tracker: Label = $CanvasLayer/WaveTracker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridManager.init_grid(tiles)
	GridManager.spawn_player(tiles)
	#GridManager.spawn_test_enemy(tiles)
	spawn_next_wave()
	SignalBus.move_player.connect(move_player)
	SignalBus.move_actor_to_tile.connect(translate_actor)
	SignalBus.move_enemy.connect(move_actor)
	SignalBus.spawn_next_wave.connect(spawn_next_wave)
	player_health_bar.max_value = GridManager.player.health
	player_shield_stamina.max_value = GameManager.shield_amount
	player_shield_stamina.value = player_shield_stamina.max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GridManager.player:
		health_amount_label.text = "%s/%s" % [GridManager.player.health, GridManager.player.max_health]
		player_health_bar.value = GridManager.player.health
		player_shield_stamina.value = GameManager.current_shield_amount


func move_player(direction : Vector2, is_dash_attack : bool) -> void:
	move_actor(GridManager.player, direction, -1, -1, is_dash_attack)
	
	
func move_actor(grid_actor : GridActor, direction : Vector2, row_limit : int = -1, col_limit : int = -1, is_dash_attack : bool = false) -> void:
	var new_coords : Vector2 = grid_actor.current_tile.coordinates + direction
	var adjacent_tile : Tile = GridManager.get_tile(tiles, new_coords)
	
	if not GridManager.tile_available(grid_actor, adjacent_tile, row_limit, col_limit, is_dash_attack):
		return
   
	translate_actor(grid_actor, adjacent_tile)
	
#returns previous tile for convenience	
func translate_actor(actor : GridActor, adjacent_tile : Tile) -> Tile:
	var prev_tile = actor.current_tile
	var next_tile = adjacent_tile
	prev_tile.occupant = null
	actor.current_tile = adjacent_tile
	next_tile.occupant = actor
	actor.global_position = adjacent_tile.marker_3d.global_position
	return prev_tile


func spawn_enemy(enemy : PackedScene, tile_coords : Vector2) -> void:
	var enemy_to_spawn : GridEnemy = enemy.instantiate()
	var init_tile : Tile = GridManager.get_tile(tiles, tile_coords)

	enemy_to_spawn.global_position = init_tile.marker_3d.global_position
	enemy_to_spawn.current_tile = init_tile
	enemy_to_spawn.tiles = tiles
	init_tile.occupant = enemy_to_spawn

	GridManager.enemies.append(enemy_to_spawn)
	print(GridManager.enemies)
	add_child(enemy_to_spawn)

@onready var count_down_timer: CountDownTimer = $CanvasLayer/CountDownTimer

func spawn_next_wave(on_time_out : bool = false) -> void:
	await get_tree().process_frame
	if GridManager.current_wave == GridManager.waves.size()-1:
		return
		
	GridManager.current_wave += 1
	wave_tracker.text = "Wave %s/10" % [GridManager.current_wave+1]
	if GridManager.current_wave > 0:
		if on_time_out:
			count_down_timer.add_time(30)
		else:
			count_down_timer.add_time(12)
		
	
	var selected_wave = GridManager.waves[GridManager.current_wave]
	for enemy in selected_wave:
		spawn_enemy(enemy["enemy"], enemy["coordinates"])
		await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_timer(0.5).timeout
	
	SignalBus.enable_enemy_movement.emit()
	
	count_down_timer.start_timer()

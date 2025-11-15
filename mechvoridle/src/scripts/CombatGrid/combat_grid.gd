class_name CombatGrid extends Node3D


@onready var tiles: Node = $Tiles
var player : GridPlayer
@onready var health_amount_label: Label = $CanvasLayer/HealthAmountLabel
@onready var player_health_bar: TextureProgressBar = $CanvasLayer/PlayerHealthBar
@onready var player_shield_stamina: TextureProgressBar = $CanvasLayer/PlayerShieldStamina

@onready var wave_tracker: Label = $CanvasLayer/WaveTracker

@onready var camera: Camera3D = $Camera

var player_tile_coordinates : Array[Vector2] = [Vector2(4,0), Vector2(4,1), Vector2(4,2)]
@onready var supply_crate_timer: Timer = $SupplyCrateTimer

@onready var damage_multiplier_label: RichTextLabel = $CanvasLayer/DamageMultiplierLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridManager.init_grid(tiles)
	GridManager.spawn_player(tiles)
	damage_multiplier_label.hide()
	#GridManager.spawn_test_enemy(tiles)
	spawn_next_wave()
	SignalBus.move_player.connect(move_player)
	SignalBus.move_actor_to_tile.connect(translate_actor)
	SignalBus.move_enemy.connect(move_actor)
	SignalBus.spawn_next_wave.connect(spawn_next_wave)
	SignalBus.update_player_health_bar.connect(update_health_bar)
	SignalBus.update_shield_amount.connect(update_shield_amount)
	SignalBus.refil_shield_gauge.connect(fill_shield_guage)
	
	SignalBus.show_damage_multiplier_label.connect(show_damage_multipler)
	SignalBus.hide_damage_mulitplier_label.connect(hide_damage_multiplier)
	
	player_health_bar.max_value = GridManager.player.health
	player_shield_stamina.max_value = GameManager.shield_amount
	player_shield_stamina.value = player_shield_stamina.max_value
	player_health_bar.max_value = GridManager.player.max_health
	player_health_bar.value = GridManager.player.health
	health_amount_label.text = "%s/%s" % [GridManager.player.health, GridManager.player.max_health]
	supply_crate_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


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
	var prev_tile : Tile = actor.current_tile
	var next_tile : Tile = adjacent_tile
	if prev_tile:
		if prev_tile.occupant == actor:
			prev_tile.occupant = null
		
	if adjacent_tile:
		actor.current_tile = adjacent_tile
	if next_tile and next_tile.occupant == null:
		next_tile.occupant = actor
	if adjacent_tile:
		actor.global_position = adjacent_tile.marker_3d.global_position
	
	#check for crate if player
	if actor == GridManager.player and next_tile.upgrade_crate:
		if next_tile.upgrade_crate is HealthCrate:
			increase_player_health(next_tile.upgrade_crate.health_amount)
			next_tile.upgrade_crate.queue_free()
			next_tile.upgrade_crate = null
	
	return prev_tile


func spawn_enemy(enemy : PackedScene, tile_coords : Vector2, is_slave : bool) -> void:
	var enemy_to_spawn : GridActor = enemy.instantiate()
	var init_tile : Tile = GridManager.get_tile(tiles, tile_coords)
	
	if enemy_to_spawn is SwordBot:
		enemy_to_spawn.is_slave = is_slave
	
	enemy_to_spawn.global_position = init_tile.marker_3d.global_position
	enemy_to_spawn.current_tile = init_tile
	enemy_to_spawn.tiles = tiles
	init_tile.occupant = enemy_to_spawn

	GridManager.enemies.append(enemy_to_spawn)
	print(GridManager.enemies)
	add_child(enemy_to_spawn)

@onready var count_down_timer: CountDownTimer = $CanvasLayer/CountDownTimer

func spawn_next_wave() -> void:
	await get_tree().process_frame
	if GridManager.current_wave == GridManager.waves.size()-1:
		return
		
	GridManager.current_wave += 1
	wave_tracker.text = "Wave %s/10" % [GridManager.current_wave+1]
	if GridManager.current_wave > 0:
		if GameManager.timed_out:
			count_down_timer.add_time(35)
			GameManager.timed_out = false
		else:
			count_down_timer.add_time(15)
		
	
	var selected_wave = GridManager.waves[GridManager.current_wave]
	for enemy in selected_wave:
		spawn_enemy(enemy["enemy"], enemy["coordinates"], enemy["is_slave"])
		await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_timer(0.5).timeout
	
	SignalBus.enable_enemy_movement.emit()
	
	count_down_timer.start_timer()

func update_shield_amount() -> void:
	player_shield_stamina.value = GameManager.current_shield_amount

func fill_shield_guage() -> void:
	var speed := 45.0  # amount per second
	
	while GameManager.current_shield_amount < GameManager.shield_amount and GridManager.player.regen_started:
		var delta := get_process_delta_time()
		GameManager.current_shield_amount = min(
			GameManager.current_shield_amount + speed * delta,
			GameManager.shield_amount
		)
		
		update_shield_amount()
		await get_tree().process_frame 
		
		GridManager.player.start_shield_cool_down = false
		
		if not GridManager.player.can_use_shield and GameManager.current_shield_amount >= GameManager.shield_amount:
			GridManager.player.can_use_shield = true

func update_health_bar() -> void:

	health_amount_label.text = "%s/%s" % [GridManager.player.health, GridManager.player.max_health]
	var tween := create_tween()
	tween.tween_property(
		player_health_bar,
		"value",
		GridManager.player.health,
		0.35  # duration
	)

func increase_player_health(value : int) -> void:
	GridManager.player.health += value
	if GridManager.player.health > GridManager.player.max_health:
		GridManager.player.health = GridManager.player.max_health
		
	create_damage_label(value,GridManager.player.damage_label_marker, 2)
	update_health_bar()

func _on_supply_crate_timer_timeout() -> void:
	var random_num : int = randi_range(0,100)
	print("THE NUMBER GENERATED: " + str(random_num))
	if random_num <= 25 and GridManager.player.health < GridManager.player.max_health:
		var tile : Tile = GridManager.get_tile(tiles, player_tile_coordinates.pick_random())
		var health_crate : HealthCrate = preload("uid://dm63oush42xtx").instantiate()
		health_crate.health_amount = randi_range(50,75)
		tile.upgrade_crate = health_crate
		health_crate.global_position = tile.global_position
		add_child(health_crate)
		
	supply_crate_timer.start()
		

func create_damage_label(amount : int, marker : Marker3D, type : int = 0, ) -> void:
	var damage_label : GridDamageLabel = preload("uid://w3nvxv0mdub").instantiate()
	
	match type:
		0:
			damage_label.label.text = "-%s" % [amount]
			damage_label.set_as_damage()
		1:
			damage_label.label.text = "inv."
			damage_label.set_as_invincible()
		2:
			damage_label.label.text = "+%s" % [amount]
			damage_label.set_as_heal()
	
	damage_label.global_position = marker.global_position
	add_child(damage_label)

func show_damage_multipler(value : float) -> void:
	damage_multiplier_label.show()
	damage_multiplier_label.text = "[font_size=16]dmgx[/font_size][font_size=32]%s[/font_size]" % [value]

func hide_damage_multiplier() -> void:
	damage_multiplier_label.hide()

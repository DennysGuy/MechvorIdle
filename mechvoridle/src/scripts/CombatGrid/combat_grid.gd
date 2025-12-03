class_name CombatGrid extends Node3D


@onready var tiles: Node = $Tiles
var player : GridPlayer
@onready var health_amount_label: Label = $CanvasLayer/HealthAmountLabel
@onready var player_health_bar: TextureProgressBar = $CanvasLayer/PlayerHealthBar
@onready var player_shield_stamina: TextureProgressBar = $CanvasLayer/PlayerShieldStamina

@onready var wave_tracker: Label = $CanvasLayer/WaveTracker

@onready var camera: Camera3D = $Camera

var player_tile_coordinates : Array[Vector2] = [Vector2(5,0), Vector2(5,1), Vector2(5,2),Vector2(5,3)]
@onready var supply_crate_timer: Timer = $SupplyCrateTimer

@onready var damage_multiplier_label: RichTextLabel = $CanvasLayer/DamageMultiplierLabel

@onready var cutscene_player: AnimationPlayer = $CutscenePlayer

@onready var timer: Timer = $Timer
@onready var transition_player: AnimationPlayer = $TransitionPlayer

@onready var music_player: AudioStreamPlayer = $MusicPlayer

@onready var next_damage_label: Label = $CanvasLayer/NextDamageLabel

@onready var momentum_meter: TextureProgressBar = $CanvasLayer/MomentumMeter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridManager.init_grid(tiles)
	GridManager.spawn_player(tiles)
	damage_multiplier_label.hide()
	#GridManager.spawn_test_enemy(tiles)
	#spawn_next_wave()
	SignalBus.move_player.connect(move_player)
	SignalBus.move_actor_to_tile.connect(translate_actor)
	SignalBus.move_enemy.connect(move_actor)
	
	SignalBus.spawn_next_wave.connect(spawn_next_wave)
	SignalBus.update_player_health_bar.connect(update_health_bar)
	SignalBus.update_shield_amount.connect(update_shield_amount)
	SignalBus.refil_shield_gauge.connect(fill_shield_guage)
	
	SignalBus.send_actor_to_tile.connect(send_actor_to_tile)
	SignalBus.show_damage_multiplier_label.connect(show_damage_multipler)
	SignalBus.hide_damage_mulitplier_label.connect(hide_damage_multiplier)
	SignalBus.spawn_enemies.connect(spawn_enemies)
	
	SignalBus.transition_win_screen.connect(play_fade_out)
	SignalBus.transition_lose_screen.connect(play_fade_to_lose)
	
	SignalBus.spawn_mini_wave.connect(spawn_mini_wave)
	SignalBus.spawn_health_crate.connect(spawn_health_crate)
	SignalBus.update_next_multiplier.connect(update_next_label)
	
	SignalBus.update_momentum_meter_amount.connect(update_momentum_meter_amount)
	
	player_health_bar.max_value = GridManager.player.health
	player_shield_stamina.max_value = GameManager.shield_amount
	player_shield_stamina.value = player_shield_stamina.max_value
	player_health_bar.max_value = GridManager.player.max_health
	player_health_bar.value = GridManager.player.health
	health_amount_label.text = "%s/%s" % [GridManager.player.health, GridManager.player.max_health]
	#supply_crate_timer.start()
	cutscene_player.play("IntroCutScene")
	transition_player.play("FadeIn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(GameManager.next_multiplier)
	pass

func update_next_label() -> void:
	next_damage_label.text = "Next DMG: %s" % [GameManager.next_multiplier]

func move_player(direction : Vector2, is_dash_attack : bool) -> void:
	move_actor(GridManager.player, direction, -1, -1, is_dash_attack)
	player_check_if_lock_on_valid()
	
func move_actor(grid_actor : GridActor, direction : Vector2, row_limit : int = -1, col_limit : int = -1, is_dash_attack : bool = false) -> void:
	var new_coords : Vector2 = grid_actor.current_tile.coordinates + direction
	var adjacent_tile : Tile = GridManager.get_tile(tiles, new_coords)
	
	if not GridManager.tile_available(grid_actor, adjacent_tile, row_limit, col_limit, is_dash_attack):
		return
   
	translate_actor(grid_actor, adjacent_tile)

func send_actor_to_tile(grid_actor : GridActor, tile_coordinates : Vector2, row_limit : int, col_limit : int):
	var tile_to_send : Tile = GridManager.get_tile(tiles, tile_coordinates)
	
	if not GridManager.tile_available(grid_actor, tile_to_send, row_limit, col_limit):
		return
		
	translate_actor(grid_actor, tile_to_send)

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
		if not actor is GridPlayer:
			check_if_lock_on_valid(actor)
		var tween : Tween = get_tree().create_tween()
		tween.tween_property(actor,"global_position", adjacent_tile.marker_3d.global_position, 0.15)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		#actor.global_position = adjacent_tile.marker_3d.global_position
	
	#check for crate if player
	if actor == GridManager.player and next_tile.upgrade_crate:
		if next_tile.upgrade_crate is HealthCrate:
			increase_player_health(next_tile.upgrade_crate.health_amount)
			next_tile.upgrade_crate.queue_free()
			next_tile.upgrade_crate = null
	
	return prev_tile

func check_if_lock_on_valid(enemy : GridActor) -> void:
	var distance_diff : float = abs(GridManager.player.current_tile.coordinates.y - enemy.current_tile.coordinates.y)
	var current_weapon_scanning : MechWeapon = GridManager.player.current_weapon_scanning
	if current_weapon_scanning and current_weapon_scanning.attack_pattern.lock_on_distance.y <= distance_diff:
		GridManager.remove_enemy_from_locked_on_list(enemy)

func player_check_if_lock_on_valid() -> void:
	var locked_on_enemies : Array[GridActor] = GridManager.locked_on_enemies
	
	if locked_on_enemies.is_empty():
		return
	
	for enemy in locked_on_enemies:
		var distance_diff : float = abs(GridManager.player.current_tile.coordinates.y - enemy.current_tile.coordinates.y)
		print("THIS IS DISTANCE DIFF FROM PLAYER TO ENEMY: %s" % [distance_diff])
		var current_weapon_scanning : MechWeapon = GridManager.player.current_weapon_scanning
		if current_weapon_scanning and current_weapon_scanning.attack_pattern.lock_on_distance.y <= distance_diff:
			GridManager.remove_enemy_from_locked_on_list(enemy)

func spawn_enemy(enemy : PackedScene, tile_coords : Vector2, is_slave : bool = false, is_boss : bool = false) -> void:
	var enemy_to_spawn : GridActor = enemy.instantiate()
	var init_tile : Tile = GridManager.get_tile(tiles, tile_coords)
	print("this is init tiles occupant: %s" % [init_tile.occupant])
	if enemy_to_spawn is SwordBot:
		enemy_to_spawn.is_slave = is_slave
	
	if is_boss:
		GameManager.in_boss_fight = true
	
	if GameManager.in_boss_fight and enemy_to_spawn is GridEnemy:
		enemy_to_spawn.drop_chance = 70
	
	enemy_to_spawn.global_position = init_tile.marker_3d.global_position
	enemy_to_spawn.current_tile = init_tile
	enemy_to_spawn.tiles = tiles
	init_tile.occupant = enemy_to_spawn

	GridManager.enemies.append(enemy_to_spawn)

	add_child(enemy_to_spawn)

@onready var count_down_timer: CountDownTimer = $CanvasLayer/CountDownTimer

func spawn_next_wave() -> void:
	await get_tree().process_frame
	if GridManager.current_wave == GridManager.MAX_WAVES-1:
		GameManager.in_boss_fight = true
		#play_count_down()
		cutscene_player.play("CountDownBoss")
		count_down_timer.stop_timer()
		count_down_timer.count_down = false
		return
		
	GridManager.current_wave += 1
	wave_tracker.text = "Wave %s/10" % [GridManager.current_wave+1]
	if GridManager.current_wave > 0:
		if GameManager.timed_out:
			count_down_timer.add_time(45)
			GameManager.timed_out = false
		else:
			var gained_time : int = 0
			if GridManager.current_wave <= 5:
				gained_time = 15
			elif GridManager.current_wave > 5 and GridManager.current_wave <= 7:
				gained_time = 18 
			else:
				gained_time = 20
				
			count_down_timer.add_time(gained_time)
			if GridManager.player.health < GridManager.player.max_health:
				GridManager.player.health = min( GridManager.player.health + GridManager.player.max_health * (gained_time * 0.01), GridManager.player.max_health) 
				update_health_bar()
	
	var selected_wave = GridManager.waves[GridManager.current_wave]
	spawn_enemies(selected_wave)
	
	count_down_timer.start_timer()


func spawn_mini_wave() -> void:
	await get_tree().process_frame
	var selected_wave : Array = GridManager.boss_mini_waves.pick_random()
	spawn_enemies(selected_wave)

func spawn_enemies(selected_wave : Array) -> void:
	for enemy in selected_wave:
		spawn_enemy(enemy["enemy"], enemy["coordinates"], enemy["is_slave"], enemy["is_boss"])
		await get_tree().create_timer(0.5).timeout
		
	await get_tree().create_timer(0.5).timeout
	
	SignalBus.enable_enemy_movement.emit()

func update_shield_amount() -> void:
	player_shield_stamina.value = GameManager.current_shield_amount

func fill_shield_guage() -> void:
	
	if not is_instance_valid(GridManager.player):
		return
		
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

func update_momentum_meter_amount(value : int) -> void:
	if GameManager.momentum_meter_amount >= GameManager.MAX_MOMENTUM_METER_AMOUNT:
		return
		
	GameManager.momentum_meter_amount += value
	SignalBus.update_momentum_count.emit()
	
	var tween := create_tween()
	tween.tween_property(
		momentum_meter,
		"value",
		GameManager.momentum_meter_amount,
		0.3
	)

func spawn_boss() -> void:
	spawn_enemies(GridManager.boss_spawn)

func increase_player_health(value : int) -> void:
	GridManager.player.health += value
	if GridManager.player.health > GridManager.player.max_health:
		GridManager.player.health = GridManager.player.max_health
		
	create_damage_label(value,GridManager.player.damage_label_marker, 2)
	update_health_bar()

func _on_supply_crate_timer_timeout() -> void:
	if not GridManager.player:
		return
		
	var random_num : int = randi_range(0,100)
	
	if random_num <= 25 and GridManager.player.health < GridManager.player.max_health:
		
		var tile : Tile = GridManager.get_tile(tiles, player_tile_coordinates.pick_random())
		var health_crate : HealthCrate = preload("uid://dm63oush42xtx").instantiate()
		
		health_crate.health_amount = randi_range(50,75)
		tile.upgrade_crate = health_crate
		health_crate.global_position = tile.global_position
		
		add_child(health_crate)
		
	supply_crate_timer.start()
		

func spawn_health_crate(drop_chance : int) -> void:
	var random_num : int = randi_range(0,100)
	
	if random_num <= drop_chance and GridManager.player.health < GridManager.player.max_health-50:
		
		var tile : Tile = GridManager.get_tile(tiles, player_tile_coordinates.pick_random())
		var health_crate : HealthCrate = preload("uid://dm63oush42xtx").instantiate()
		
		health_crate.health_amount = randi_range(50,75)
		tile.upgrade_crate = health_crate
		health_crate.global_position = tile.global_position
		
		add_child(health_crate)

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

func play_camera_swoop_to_position() -> void:
	cutscene_player.play("CameraSwoopToPosition")

func start_wave_combat() -> void:
	GridManager.player.can_move = true
	if !GameManager.in_boss_fight:
		spawn_next_wave()
	else:
		GameManager.fight_on = true
		start_count_up_timer()
		SignalBus.change_boss_phase.emit() #otherwise boss should be on the screen and we just enable movement
	
func commence_boss_fight() -> void:
	GameManager.fight_on = true

func play_count_down() -> void:
	cutscene_player.play("CountDown")

func play_fade_out() -> void:
	transition_player.play("FadeToWin")

func play_fade_to_lose() -> void:
	transition_player.play("FadeToLose")

func go_to_win_screen() -> void:
	get_tree().change_scene_to_file("res://src/scenes/WinPanel.tscn")

func go_to_lose_screen() -> void:
	get_tree().change_scene_to_file("res://src/scenes/LosePanel.tscn")

func _on_timer_timeout() -> void:
	play_count_down()

func start_count_up_timer() -> void:
	count_down_timer.count_down = false
	count_down_timer.start_timer()

func play_ready() -> void:
	SfxManager.play_sfx(SfxManager.READY)

func play_fight() -> void:
	SfxManager.play_sfx(SfxManager.FIGHT)

func play_three() -> void:
	SfxManager.play_sfx(SfxManager.VOX_ANNOUNCER_COUNT_DOWN__THREE_01)

func play_two() -> void:
	SfxManager.play_sfx(SfxManager.VOX_ANNOUNCER_COUNT_DOWN__TWO_01)

func play_one() -> void:
	SfxManager.play_sfx(SfxManager.VOX_ANNOUNCER_COUNT_DOWN__ONE_01)

func fade_out_music() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(music_player, "volume_db", -80, 4.0)
	await tween.finished

func play_alert() -> void:
	SfxManager.play_sfx(SfxManager.SHIP_ALARM_1)

func play_boss_theme() -> void:
	music_player.volume_db = 0
	music_player.stream = preload("uid://tum8nsa067ks")
	music_player.play()

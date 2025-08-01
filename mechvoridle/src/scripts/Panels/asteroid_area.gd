class_name AsteroidArea extends Node2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var asteroid_area_2d : Area2D = $AsteroidArea2D

@onready var mining_asteroid: TextureRect = $MiningAsteroid

@onready var asteroid_spawn_timer: Timer = $AsteroidSpawnTimer
var asteroid_spawn_timer_length : float = 10.0
@onready var asteroid_spawn_points: Node = $AsteroidSpawnPoints
@onready var platinum_drone_list: Node = $PlatinumDroneList

@onready var drone_list : Node = $DroneList
@onready var ufo_in_position : Marker2D = $UFOInPosition
@onready var ufo_out_position : Marker2D = $UFOOutPosition
@onready var ufo_spawn_timer : Timer = $UFOSpawnTimer
@onready var ufo_list : Node = $UFOList

@onready var click_asteroid_sfx : AudioStreamPlayer = $ClickAsteroidSfx


var start_ufo_spawn : bool = false

var mining_asteroid_sfx_list : Array[AudioStream] = [SfxManager.MIN_CLICK_ASTEROID_01, SfxManager.MIN_CLICK_ASTEROID_02, SfxManager.MIN_CLICK_ASTEROID_03, SfxManager.MIN_CLICK_ASTEROID_04, SfxManager.MIN_CLICK_ASTEROID_05, SfxManager.MIN_CLICK_ASTEROID_06, SfxManager.MIN_CLICK_ASTEROID_07, SfxManager.MIN_CLICK_ASTEROID_08]

var _offset : int = 50
func _ready() -> void:
	
	SignalBus.add_drone.connect(add_drone_to_scene)
	SignalBus.add_platinum_drone.connect(add_platinum_drone_to_scene)
	SignalBus.check_to_start_ufo_spawn.connect(toggle_ufo_spawn)
	animation_player.play("hover")
	asteroid_spawn_timer.wait_time = asteroid_spawn_timer_length
	asteroid_spawn_timer.start()
	

func _process(delta : float) -> void:
	mining_asteroid.rotation += 0.0005
	if start_ufo_spawn:
		ufo_spawn_timer.wait_time = randi_range(10,25)
		ufo_spawn_timer.start()
		start_ufo_spawn = false


func _on_texture_rect_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			play_mining_sfx()
			var mining_laser_damage : int = GameManager.mining_laser_damage
			var true_damage : int
			var can_crit : bool = is_crit_damage()
			if can_crit:
				true_damage = GameManager.mining_laser_damage * 2
				GameManager.raw_ferrite_count +=  true_damage
			else:
				true_damage = GameManager.mining_laser_damage
				GameManager.raw_ferrite_count += true_damage
			
			var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
			resource_acquired_label.output = "+"+str(true_damage)+ " Ferrite"
			resource_acquired_label.global_position = get_viewport().get_mouse_position()
			get_parent().add_child(resource_acquired_label)
			SignalBus.update_ferrite_count.emit()
			
			if platinum_gained():
				var value : int = randi_range(GameManager.platinum_gain_min,GameManager.platinum_gain_max)
				var crit_value = value * 2
				var platinum_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
				if can_crit:
					GameManager.platinum_count += crit_value
					platinum_acquired_label.output = "+"+str(crit_value)+ " Platinum"
				else:
					GameManager.platinum_count += value
					platinum_acquired_label.output = "+"+str(value)+ " Platinum"
				
				platinum_acquired_label.global_position = get_viewport().get_mouse_position()
				await get_tree().create_timer(0.2).timeout
				get_parent().add_child(platinum_acquired_label)
				SignalBus.update_platinum_count.emit()


func is_crit_damage() -> bool:
	if GameManager.mining_laser_crit_chance == 0:
		return false
	
	var rng := RandomNumberGenerator.new()
	
	rng.randomize()
	
	return rng.randf() < GameManager.mining_laser_crit_chance

func platinum_gained() -> bool:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return rng.randf() < GameManager.platinum_gain_chance


func add_drone_to_scene() -> void:
	var area_collision_shape : CollisionShape2D = asteroid_area_2d.get_child(0)
	var drone : MiningDrone = preload("res://src/scenes/MiningDrone.tscn").instantiate()
	var random_x_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.x+_offset, area_collision_shape.shape.get_rect().size.x-_offset)
	var random_y_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.y+_offset, area_collision_shape.shape.get_rect().size.y-_offset)
	drone.global_position = area_collision_shape.global_position + Vector2(random_x_pos, random_y_pos)
	drone.name = "Drone_%s" % str(Time.get_ticks_msec())
	drone_list.add_child(drone)
	print(drone.name)


func add_platinum_drone_to_scene() -> void:
	var area_collision_shape : CollisionShape2D = asteroid_area_2d.get_child(0)
	var platinum_drone : PlatinumMiningDrone = preload("res://src/scenes/PlatinumMiningDrone.tscn").instantiate()
	var random_x_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.x+_offset, area_collision_shape.shape.get_rect().size.x-_offset)
	var random_y_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.y+_offset, area_collision_shape.shape.get_rect().size.y-_offset)
	platinum_drone.global_position = area_collision_shape.global_position + Vector2(random_x_pos, random_y_pos)
	drone_list.add_child(platinum_drone)
	


func _on_asteroid_spawn_timer_timeout() -> void:
	var random_spawn_time : int = randi_range(asteroid_spawn_timer_length-5, asteroid_spawn_timer_length+5)
	asteroid_spawn_timer.wait_time = random_spawn_time
	spawn_asteroid()


func spawn_asteroid() -> void:
	var selected_spawn_point : Marker2D = asteroid_spawn_points.get_children().pick_random()
	var asteroid_1 : Asteroid = preload("res://src/scenes/MiningScene/Asteroid1.tscn").instantiate()
	var asteroid_2 : Asteroid = preload("res://src/scenes/MiningScene/Asteroid2.tscn").instantiate()
	var asteroid_3 : Asteroid = preload("res://src/scenes/MiningScene/Asteroid3.tscn").instantiate()
	var asteroid_list : Array[Asteroid] = [asteroid_1, asteroid_2, asteroid_3]
	var asteroid : Asteroid = asteroid_list.pick_random()
	asteroid.position = selected_spawn_point.position
	asteroid.mining_asteroid = asteroid_area_2d
	add_child(asteroid)

func spawn_ufo() -> void:
	if ufo_list.get_children().size() <= 0:
		var ufo : UFO = preload("res://src/scenes/MiningScene/UFO.tscn").instantiate()
		ufo.mining_asteroid_area = asteroid_area_2d
		ufo.global_position = ufo_in_position.global_position
		ufo.out_location = ufo_out_position
		ufo.drones_list = drone_list
		ufo.ufo_spawn_timer = ufo_spawn_timer
		ufo_list.add_child(ufo)
		SignalBus.sound_ship_alarm.emit()
	

func _on_ufo_spawn_timer_timeout():
		spawn_ufo()

func toggle_ufo_spawn() -> void:
	var total_drone_count : int = DroneManager.get_total_drone_count()
	if  total_drone_count >= GameManager.DRONES_TO_ACTIVATE_UFO:
		start_ufo_spawn = true
		print("hey we going")
	else:
		start_ufo_spawn = false
		ufo_spawn_timer.stop()
		if ufo_spawn_timer.is_stopped():
			print("WE STOPPED!")

func play_mining_sfx():
	click_asteroid_sfx.stream = mining_asteroid_sfx_list.pick_random()
	click_asteroid_sfx.play()

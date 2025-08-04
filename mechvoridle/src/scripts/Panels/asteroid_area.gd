class_name AsteroidArea extends Node2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var asteroid_area_2d : Area2D = $AsteroidArea2D


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
var mining_timer : SceneTreeTimer
var mouse_in_asteroid_range : bool = false

var _offset : int = 50
func _ready() -> void:
	
	SignalBus.add_drone.connect(add_drone_to_scene)
	SignalBus.add_platinum_drone.connect(add_platinum_drone_to_scene)
	SignalBus.check_to_start_ufo_spawn.connect(toggle_ufo_spawn)
	animation_player.play("hover")
	asteroid_spawn_timer.wait_time = asteroid_spawn_timer_length
	asteroid_spawn_timer.start()
	asteroid_area_2d.input_pickable = true

func _process(delta : float) -> void:
	
	
	if start_ufo_spawn:
		ufo_spawn_timer.wait_time = randi_range(25,30)
		ufo_spawn_timer.start()
		start_ufo_spawn = false

	if Input.is_action_just_pressed("mine_asteroid") and not mining_timer and is_inside_mining_area():
		mining_timer = get_tree().create_timer(0.4)
		await mining_timer.timeout
		spawn_mining_progress_bar()
		mining_timer = null
	


func spawn_mining_progress_bar():
	var mining_progress_bar : MiningLaserProgressBar = preload("res://src/scenes/MiningScene/MiningLaserProgressBar.tscn").instantiate()
	add_child(mining_progress_bar)

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
	else:
		start_ufo_spawn = false
		ufo_spawn_timer.stop()

func _on_asteroid_area_2d_mouse_entered():
	mouse_in_asteroid_range = true
	print(mouse_in_asteroid_range)


func _on_asteroid_area_2d_mouse_exited():
	mouse_in_asteroid_range = false
	print(mouse_in_asteroid_range)


func is_inside_mining_area() -> bool:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	var asteroid_area_collision : CollisionShape2D = asteroid_area_2d.get_child(0)
	var rect_shape := asteroid_area_collision.shape as RectangleShape2D

	# Calculate the global rect of the shape
	var top_left : Vector2 = asteroid_area_2d.global_position + asteroid_area_collision.position - rect_shape.extents
	var size : Vector2 = rect_shape.extents * 2.0
	var rect := Rect2(top_left, size)

	return rect.has_point(mouse_pos)

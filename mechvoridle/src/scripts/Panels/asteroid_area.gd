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
@onready var turret_drone_list: Node = $TurretDroneList

@onready var click_asteroid_sfx : AudioStreamPlayer = $ClickAsteroidSfx

@export_group("Drone Stats")
@export var local_drone_manager : LocalDroneManager

var start_ufo_spawn : bool = false
var mining_timer : SceneTreeTimer
var mouse_in_asteroid_range : bool = false

#asteroid stat modifiers
@export_group("Asteroid Name")
@export var asteroid_name : String
@export var audio_bus_name : String

@export_group("Asteroid Modifiers")
@export var cost : int
@export var drone_slots : int
@export var drone_damage_modifier : int
@export var drone_speed_modifier : float
@export var hazard_spawn_time_modifier : int

var _offset : int = 50
func _ready() -> void:
	local_drone_manager.max_owned_drones = drone_slots
	SignalBus.add_drone.connect(add_drone_to_scene)
	SignalBus.add_platinum_drone.connect(add_platinum_drone_to_scene)
	SignalBus.check_to_start_ufo_spawn.connect(toggle_ufo_spawn)
	SignalBus.stop_ufo_spawn.connect(stop_ufo_spawn)
	animation_player.play("hover")
	asteroid_spawn_timer.wait_time = asteroid_spawn_timer_length
	asteroid_spawn_timer.start()
	asteroid_area_2d.input_pickable = true

@warning_ignore("unused_parameter")
func _physics_process(delta : float) -> void:
	if not GameManager.can_fight_boss:
		if start_ufo_spawn:
			ufo_spawn_timer.wait_time = randi_range(45,60)
			ufo_spawn_timer.start()
			start_ufo_spawn = false

		if Input.is_action_just_pressed("set_drone_destination") and not mouse_in_asteroid_range and not is_inside_mining_area():
			remove_all_children_in_marker_group()
			SignalBus.deselect_drone.emit()
			GameManager.drone_selected = false
			
		if Input.is_action_just_pressed("set_drone_destination") and GameManager.drone_selected and is_inside_mining_area():		
			remove_all_children_in_marker_group()
	
				
		if Input.is_action_just_pressed("mine_asteroid") and not mining_timer and is_inside_mining_area():
				
				mining_timer = get_tree().create_timer(0.4)
				await mining_timer.timeout
				mining_timer = null
		
func remove_all_children_in_marker_group() -> void:
	for child in get_tree().get_nodes_in_group("DestinationMarkers"):
		child.queue_free()
	

func add_drone_to_scene(asteroid_scene : AsteroidArea) -> void:
	if asteroid_scene == self:
		var area_collision_shape : CollisionShape2D = asteroid_area_2d.get_child(0)
		var drone : MiningDrone = preload("res://src/scenes/MiningDrone.tscn").instantiate()
		var random_x_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.x+_offset, area_collision_shape.shape.get_rect().size.x-_offset)
		var random_y_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.y+_offset, area_collision_shape.shape.get_rect().size.y-_offset)
		
		drone.global_position = area_collision_shape.global_position + Vector2(random_x_pos, random_y_pos)
		drone.name = "Drone_%s" % str(Time.get_ticks_msec())
		drone.damage_modifier = drone_damage_modifier
		drone.speed_modifier = drone_speed_modifier
		drone.audio_bus_name = audio_bus_name
		
		local_drone_manager.register_mining_drone(drone)
		drone_list.add_child(drone)
		print(drone.name)

func add_platinum_drone_to_scene(asteroid_scene : AsteroidArea) -> void:
	if asteroid_scene == self:
		var area_collision_shape : CollisionShape2D = asteroid_area_2d.get_child(0)
		var platinum_drone : PlatinumMiningDrone = preload("res://src/scenes/PlatinumMiningDrone.tscn").instantiate()
		var random_x_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.x+_offset, area_collision_shape.shape.get_rect().size.x-_offset)
		var random_y_pos : float = randf_range(-area_collision_shape.shape.get_rect().size.y+_offset, area_collision_shape.shape.get_rect().size.y-_offset)
		
		platinum_drone.global_position = area_collision_shape.global_position + Vector2(random_x_pos, random_y_pos)
		platinum_drone.damage_modifier = drone_damage_modifier
		platinum_drone.speed_modifier = drone_speed_modifier
		platinum_drone.audio_bus_name = audio_bus_name
		
		local_drone_manager.register_platinum_drone(platinum_drone)
		platinum_drone_list.add_child(platinum_drone)

func _on_asteroid_spawn_timer_timeout() -> void:
	var random_spawn_time : int = randi_range(hazard_spawn_time_modifier-5, hazard_spawn_time_modifier+5)
	asteroid_spawn_timer.wait_time = random_spawn_time

func toggle_ufo_spawn() -> void:
	if GameManager.can_fight_boss:
		ufo_spawn_timer.stop()
		return
		
	var total_drone_count : int = DroneManager.get_total_drone_count()
	if  total_drone_count >= GameManager.DRONES_TO_ACTIVATE_UFO:
		start_ufo_spawn = true
	else:
		start_ufo_spawn = false
		ufo_spawn_timer.stop()

func _on_asteroid_area_2d_mouse_entered():
	mouse_in_asteroid_range = true


func _on_asteroid_area_2d_mouse_exited():
	mouse_in_asteroid_range = false


func is_inside_mining_area() -> bool:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	var asteroid_area_collision : CollisionShape2D = asteroid_area_2d.get_child(0)
	var rect_shape := asteroid_area_collision.shape as RectangleShape2D

	# Calculate the global rect of the shape
	var top_left : Vector2 = asteroid_area_2d.global_position + asteroid_area_collision.position - rect_shape.extents
	var size : Vector2 = rect_shape.extents * 2.0
	var rect := Rect2(top_left, size)

	return rect.has_point(mouse_pos)

func stop_ufo_spawn() -> void:
	start_ufo_spawn = false
	ufo_spawn_timer.stop()


func _on_return_button_button_up():
	GameManager.selected_location = GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_FIELD_MAP
	print(GameManager.selected_location)
	SignalBus.change_maps.emit()

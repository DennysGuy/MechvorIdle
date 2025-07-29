class_name UFO extends CharacterBody2D

var max_health: int = 15
var health : int

var speed : int = 100
var dir : Vector2
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hover_out_timer : Timer = $HoverOutTimer
@onready var laser_release_timer : Timer = $LaserReleaseTimer
@onready var health_bar : ProgressBar = $HealthBar

var mining_asteroid_area : Area2D
var out_location : Marker2D
var laser_timer_started : bool = false
var hover_time_started : bool = false
@export var drones_list : Node
@export var ufo_spawn_timer : Timer
enum states {HOVER_IN, SHOOT, HOVER_OUT, REMOVE, DEAD}
signal deliver_resources 
var current_state : int
var can_shoot : bool = false
func _ready() -> void:
	max_health = randi_range(8,15)
	health = max_health
	current_state = states.HOVER_IN
	dir = mining_asteroid_area.global_position - global_position
	hover_out_timer.wait_time = randi_range(8,12)
	health_bar.max_value = max_health
	health_bar.value = health
	health_bar.hide()


func _physics_process(delta : float) -> void:
	match(current_state):
		states.HOVER_IN:
			can_shoot = false
			if not laser_timer_started:
				laser_release_timer.start()
				laser_timer_started = true
			
			if global_position >= mining_asteroid_area.global_position:
				current_state = states.SHOOT
			else:
				velocity = dir.normalized() * speed
				move_and_slide()
				
		states.SHOOT:
			can_shoot = true
			velocity = Vector2.ZERO
			if not hover_time_started:
				hover_out_timer.start()
				hover_time_started = true
				
			if not animation_player.is_playing():
				animation_player.play("hover")
			
		states.HOVER_OUT:
			can_shoot = false
			dir = out_location.global_position - global_position
			if global_position <= out_location.global_position:
				velocity = dir.normalized() * speed
				move_and_slide()
			else:
				current_state = states.REMOVE
				
		states.DEAD:
			destroy_ufo()
		
		states.REMOVE:
			print("sheeee")
			SignalBus.check_to_start_ufo_spawn.emit()
			SignalBus.silence_ship_alarm.emit()
			queue_free()
func destroy_ufo() -> void:
	deliver_resources.emit()
	SignalBus.check_to_start_ufo_spawn.emit()
	SignalBus.silence_ship_alarm.emit()
	queue_free()
	#called in dead sate

func damage_ufo() -> void:
	animation_player.play("ufo_hit_flash")
	health -= 1
	health_bar.value = health
	
	if health <= 0:
		current_state = states.DEAD

func _on_hover_out_timer_timeout() -> void:
	current_state = states.HOVER_OUT


func _on_laser_release_timer_timeout() -> void:

	if !can_shoot:
		return
	
	laser_release_timer.wait_time = randi_range(1,3)
	var laser : UFOLaser = preload("res://src/scenes/MiningScene/UFOLaser.tscn").instantiate()
	var target = choose_random_target()
	if target:
		laser.target = target
		laser.position = position
		get_parent().add_child(laser)

func choose_random_target():
	return drones_list.get_children().pick_random()

func _on_ufo_click_control_gui_input(event) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		health_bar.show()
		damage_ufo()

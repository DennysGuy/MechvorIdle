class_name UFO extends CharacterBody2D

var max_health: int = 15
var health : int

var speed : int = 100
var dir : Vector2
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hover_out_timer : Timer = $HoverOutTimer
@onready var laser_release_timer : Timer = $LaserReleaseTimer
@onready var health_bar : ProgressBar = $HealthBar
@onready var hit_ufo_sfx_player : AudioStreamPlayer = $HitUFOSfxPlayer
@onready var ufo_hit_sfx_list : Array[AudioStream] = [SfxManager.MIN_UNIT_UFO_DAMAGE_01, SfxManager.MIN_UNIT_UFO_DAMAGE_02, SfxManager.MIN_UNIT_UFO_DAMAGE_03, SfxManager.MIN_UNIT_UFO_DAMAGE_04, SfxManager.MIN_UNIT_UFO_DAMAGE_05]
@onready var ufo_hover_sfx_player : AudioStreamPlayer2D = $UfoHoverSfxPlayer

var mining_asteroid_area : Area2D
var out_location : Marker2D
var laser_timer_started : bool = false
var hover_time_started : bool = false
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var drones_list : Node
@export var ufo_spawn_timer : Timer

enum states {HOVER_IN, SHOOT, HOVER_OUT, REMOVE, DEAD, NON_STATE}
signal deliver_resources 

var current_state : int
var can_shoot : bool = false
var destroy_ufo_start : bool = false
var can_be_hit : bool = true

func _ready() -> void:
	animated_sprite_2d.play("default")
	max_health = randi_range(8,15)
	health = max_health
	current_state = states.HOVER_IN
	dir = mining_asteroid_area.global_position - global_position
	hover_out_timer.wait_time = randi_range(8,12)
	health_bar.max_value = max_health
	health_bar.value = health
	health_bar.hide()

func _process(delta : float) -> void:
	if destroy_ufo_start:
		destroy_ufo()
		destroy_ufo_start = false

func _physics_process(delta : float) -> void:
	match(current_state):
		
		states.HOVER_IN:
			
			if !ufo_hover_sfx_player.playing:
				ufo_hover_sfx_player.stream = SfxManager.MIN_UNIT_UFO_HOVER_01
				ufo_hover_sfx_player.play()
				
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
			health_bar.hide()
			laser_release_timer.stop()
			can_shoot = false
			can_be_hit = false
			destroy_ufo_start = true
			current_state = states.NON_STATE
		states.NON_STATE:
			pass
		
		states.REMOVE:
			SignalBus.check_to_start_ufo_spawn.emit()
			SignalBus.play_ufo_escaped.emit()
			queue_free()
func destroy_ufo() -> void:
	deliver_resources.emit()
	SignalBus.check_to_start_ufo_spawn.emit()
	SignalBus.silence_ship_alarm.emit()
	if !GameManager.ufo_destroyed:
		SignalBus.show_task_completed_indicator.emit(GameManager.CHECK_LIST_INDICATOR_TOGGLES.UFO_DESTROYED)
	animated_sprite_2d.hide()
	var explosion : Explosion = preload("res://src/scenes/Explosion.tscn").instantiate()
	explosion.size_set = 5
	add_child(explosion)
	if not explosion.animated_sprite_2d.is_playing():
		queue_free()
	#called in dead sate

func damage_ufo() -> void:
	play_ufo_damage_sfx()
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
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and can_be_hit:
		health_bar.show()
		damage_ufo()

func play_ufo_damage_sfx() -> void:
	hit_ufo_sfx_player.stream = ufo_hit_sfx_list.pick_random()
	hit_ufo_sfx_player.play()

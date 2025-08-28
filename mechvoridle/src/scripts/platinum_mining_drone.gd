class_name PlatinumMiningDrone extends Node2D

@onready var progress_bar : ProgressBar = $ProgressBar
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var health : int = 15
var max_health : int = 15

var mining_sfx : Array[AudioStream] = [SfxManager.MIN_CLICK_ASTEROID_01,SfxManager.MIN_CLICK_ASTEROID_02,SfxManager.MIN_CLICK_ASTEROID_03]

func _ready() -> void:
	SignalBus.deselect_drone.connect(hide_outline)
	animation_player.play("idle")
	hide_outline()
	DroneManager.register_platinum_drone(self)

func _process(delta) -> void:
	set_outline_color()

func _physics_process(delta : float) -> void:
	if not GameManager.can_fight_boss:
		progress_bar.value += GameManager.drone_mining_speed
	
		if progress_bar.value >= progress_bar.max_value:
			obtain_resources()
			progress_bar.value = 0
	else:
		progress_bar.value = 0

func _exit_tree():
	DroneManager.unregister_platinum_drone(self)

@onready var sprite_2d: Sprite2D = $Sprite2D

func erase() -> void:
	sprite_2d.hide()
	progress_bar.hide()
	var explosion : Explosion = preload("res://src/scenes/Explosion.tscn").instantiate()
	explosion.size_set = 4
	SignalBus.issue_drone_down_alert.emit()
	add_child(explosion)

func obtain_resources() -> void:
	play_mining_sfx()
	var drone_damage : int = GameManager.platinum_drone_damage

	GameManager.platinum_count += drone_damage
	
	if !GameManager.plat_drone_purchased:
		SignalBus.add_to_submission_counter.emit(drone_damage, GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED)
		
	if !GameManager.upgrade_mining_drone_damage:
		SignalBus.add_to_submission_counter.emit(drone_damage, GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_MINING_DRONE_DAMAGE)
		
	if !GameManager.purchase_1_more_drone:
		SignalBus.add_to_submission_counter.emit(drone_damage, GameManager.CHECK_LIST_INDICATOR_TOGGLES.PURCHASE_1_MORE_DRONE)
			
	if !GameManager.recon_scout_purchased:
		SignalBus.add_to_submission_counter.emit(drone_damage, GameManager.CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED)
		
	if !GameManager.upgrade_platinum_drone_speed:
		SignalBus.add_to_submission_counter.emit(drone_damage, GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PLATINUM_DRONE_SPEED)
	
	
	
	var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	resource_acquired_label.output = "+"+str(drone_damage)
	resource_acquired_label.set_resource_as_platinum()
	resource_acquired_label.global_position = global_position
	get_parent().add_child(resource_acquired_label)
	SignalBus.update_platinum_count.emit()


func platinum_gained() -> bool:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return rng.randf() < GameManager.platinum_gain_chance


func _on_hurt_box_area_entered(area: Area2D) -> void:

	var area_parent  = area.get_parent()
	
	if area.get_parent() is Asteroid or area.get_parent() is UFOLaser:
		health -= area_parent.damage
		if health <= 0:
			kill_mining_drone()
	
		area_parent.queue_free() #we'll change to animation explode sequence
		
func kill_mining_drone():
	erase()

func play_mining_sfx() -> void:
	audio_stream_player_2d.stream = mining_sfx.pick_random()
	audio_stream_player_2d.play()


func _on_drone_data_shower_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			show_outline()
			SignalBus.show_drone_details.emit(self)

func show_outline() -> void:
	sprite_2d.material.set("shader_parameter/alpha_threshold", 0.0)

func hide_outline() -> void:
	sprite_2d.material.set("shader_parameter/alpha_threshold", 1.0)

func set_outline_color() -> void:
	if	health >= round(max_health *0.8):
		sprite_2d.material.set("shader_parameter/outline_color", Color.GREEN)
	elif health < round(max_health * 0.8) and health > round(max_health * 0.5):
		sprite_2d.material.set("shader_parameter/outline_color", Color.YELLOW)
	else:
		sprite_2d.material.set("shader_parameter/outline_color", Color.RED)

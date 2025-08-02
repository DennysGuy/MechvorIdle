class_name PlatinumMiningDrone extends Node2D

@onready var progress_bar : ProgressBar = $ProgressBar
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var health : int = 15

var mining_sfx : Array[AudioStream] = [SfxManager.MIN_CLICK_ASTEROID_01,SfxManager.MIN_CLICK_ASTEROID_02,SfxManager.MIN_CLICK_ASTEROID_03]

func _ready() -> void:
	animation_player.play("idle")
	DroneManager.register_platinum_drone(self)

func _process(delta : float) -> void:
	progress_bar.value += GameManager.drone_mining_speed
	
	if progress_bar.value >= progress_bar.max_value:
		obtain_resources()
		progress_bar.value = 0


func _exit_tree():
	DroneManager.unregister_platinum_drone(self)

@onready var sprite_2d: Sprite2D = $Sprite2D

func erase() -> void:
	sprite_2d.hide()
	progress_bar.hide()
	var explosion : Explosion = preload("res://src/scenes/Explosion.tscn").instantiate()
	explosion.size_set = 4
	add_child(explosion)


func obtain_resources() -> void:
	play_mining_sfx()
	var drone_damage : int = GameManager.platinum_drone_damage

	GameManager.platinum_count += drone_damage
			
	var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	resource_acquired_label.output = "+"+str(drone_damage)
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

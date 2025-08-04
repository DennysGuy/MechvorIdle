class_name MiningDrone extends Node2D

@onready var progress_bar : ProgressBar = $ProgressBar
@onready var sfx_player : AudioStreamPlayer2D = $SfxPlayer
@onready var sprite_2d = $Sprite2D
@onready var hurt_box = $HurtBox

var mining_sfx_list : Array[AudioStream] = [SfxManager.MIN_CLICK_ASTEROID_04, SfxManager.MIN_CLICK_ASTEROID_05, SfxManager.MIN_CLICK_ASTEROID_06, SfxManager.MIN_CLICK_ASTEROID_07]
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var health : int = 12

func _ready() -> void:
	animation_player.play("idle")
	DroneManager.register_mining_drone(self)

func _process(delta : float) -> void:
	progress_bar.value += GameManager.drone_mining_speed

	
	if progress_bar.value >= progress_bar.max_value:
		obtain_resources()
		progress_bar.value = 0
	
func _exit_tree():
	DroneManager.unregister_mining_drone(self)
	
func erase() -> void:
	progress_bar.hide()
	sprite_2d.hide()
	hurt_box.get_child(0).disabled = true
	var explosion : Explosion = preload("res://src/scenes/Explosion.tscn").instantiate()
	explosion.size_set = 3
	add_child(explosion)
	


func obtain_resources() -> void:
	var drone_damage : int = GameManager.drone_damage
	play_mining_sfx()
	GameManager.raw_ferrite_count += drone_damage
			
	var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	resource_acquired_label.output = "+"+str(drone_damage)
	resource_acquired_label.set_resource_as_ferrite()
	resource_acquired_label.global_position = global_position
	get_parent().add_child(resource_acquired_label)
	SignalBus.update_ferrite_count.emit()
			
	if platinum_gained():
		var value : int = randi_range(GameManager.platinum_gain_min,GameManager.platinum_gain_max)
		var crit_value = value * 2
		var platinum_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()

		GameManager.platinum_count += value
		platinum_acquired_label.output = "+"+str(value)
		platinum_acquired_label.set_resource_as_platinum()
		platinum_acquired_label.global_position = global_position
		await get_tree().create_timer(0.2).timeout
		get_parent().add_child(platinum_acquired_label)
		SignalBus.update_platinum_count.emit()


func platinum_gained() -> bool:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return rng.randf() < GameManager.platinum_gain_chance


func _on_hurt_box_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	
	if area.get_parent() is Asteroid or area.get_parent() is UFOLaser:
		health -= area_parent.damage
		if health <= 0:
			kill_mining_drone()
		
		if area.get_parent() is Asteroid:
			var asteroid : Asteroid = area.get_parent()
			asteroid.spawn_explosion_and_destroy()
		else:
			area_parent.queue_free() #we'll change to animation explode sequence
		
func kill_mining_drone():
	erase()

func play_mining_sfx() -> void:
	sfx_player.stream = mining_sfx_list.pick_random()
	sfx_player.play()

class_name PlatinumMiningDrone extends Node2D

@onready var progress_bar : ProgressBar = $ProgressBar

var health : int = 15

func _ready() -> void:
	pass

func _process(delta : float) -> void:
	progress_bar.value += GameManager.drone_mining_speed
	
	if progress_bar.value >= progress_bar.max_value:
		obtain_resources()
		progress_bar.value = 0
	
	if health <= 0:
		erase() #replace with animation

func erase() -> void:
	queue_free()


func obtain_resources() -> void:
	var drone_damage : int = GameManager.platinum_drone_damage

	GameManager.platinum_count += drone_damage
			
	var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	resource_acquired_label.output = "+"+str(drone_damage)+ " Platinum"
	resource_acquired_label.global_position = global_position
	get_parent().add_child(resource_acquired_label)
	SignalBus.update_platinum_count.emit()


func platinum_gained() -> bool:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return rng.randf() < GameManager.platinum_gain_chance

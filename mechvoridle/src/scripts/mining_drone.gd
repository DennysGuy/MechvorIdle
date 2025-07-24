class_name MiningDrone extends Node2D

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
	var drone_damage : int = GameManager.drone_damage

	GameManager.raw_ferrite_count += drone_damage
			
	var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	resource_acquired_label.output = "+"+str(drone_damage)+ " Ferrite"
	resource_acquired_label.global_position = global_position
	get_parent().add_child(resource_acquired_label)
	SignalBus.update_ferrite_count.emit()
			
	if platinum_gained():
		var value : int = randi_range(GameManager.platinum_gain_min,GameManager.platinum_gain_max)
		var crit_value = value * 2
		var platinum_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()

		GameManager.platinum_count += value
		platinum_acquired_label.output = "+"+str(value)+ " Platinum"
				
		platinum_acquired_label.global_position = global_position
		await get_tree().create_timer(0.2).timeout
		get_parent().add_child(platinum_acquired_label)
		SignalBus.update_platinum_count.emit()


func platinum_gained() -> bool:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return rng.randf() < GameManager.platinum_gain_chance

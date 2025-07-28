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


func _on_hurt_box_area_entered(area: Area2D) -> void:
	pass
	var area_parent : Asteroid = area.get_parent()
	
	if area.get_parent() is Asteroid:
		health -= area_parent.damage
		if health <= 0:
			kill_mining_drone()
	
	area_parent.queue_free() #we'll change to animation explode sequence
		
func kill_mining_drone():
	GameManager.platinum_drone_count -= 1
	GameManager.platinum_drone_cost = GameManager.platinum_drone_base_cost * pow(2, GameManager.platinum_drone_count)
	SignalBus.update_platinum_drone_count.emit()
	SignalBus.update_platinum_drone_cost.emit()
	#play animation
	queue_free()

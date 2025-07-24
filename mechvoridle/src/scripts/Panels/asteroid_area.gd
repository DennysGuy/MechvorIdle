class_name AsteroidArea extends Node2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var asteroid_area_2d : Area2D = $AsteroidArea2D

func _ready() -> void:
	SignalBus.add_drone.connect(add_drone_to_scene)
	animation_player.play("hover")

func _process(delta : float) -> void:
	pass


func _on_texture_rect_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mining_laser_damage : int = GameManager.mining_laser_damage
			var true_damage : int
			var can_crit : bool = is_crit_damage()
			if can_crit:
				true_damage = GameManager.mining_laser_damage * 2
				GameManager.raw_ferrite_count +=  true_damage
			else:
				true_damage = GameManager.mining_laser_damage
				GameManager.raw_ferrite_count += true_damage
			
			var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
			resource_acquired_label.output = "+"+str(true_damage)+ " Ferrite"
			resource_acquired_label.global_position = get_viewport().get_mouse_position()
			get_parent().add_child(resource_acquired_label)
			SignalBus.update_ferrite_count.emit()
			
			if platinum_gained():
				var value : int = randi_range(GameManager.platinum_gain_min,GameManager.platinum_gain_max)
				var crit_value = value * 2
				var platinum_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
				if can_crit:
					GameManager.platinum_count += crit_value
					platinum_acquired_label.output = "+"+str(crit_value)+ " Platinum"
				else:
					GameManager.platinum_count += value
					platinum_acquired_label.output = "+"+str(value)+ " Platinum"
				
				platinum_acquired_label.global_position = get_viewport().get_mouse_position()
				await get_tree().create_timer(0.2).timeout
				get_parent().add_child(platinum_acquired_label)
				SignalBus.update_platinum_count.emit()


func is_crit_damage() -> bool:
	if GameManager.mining_laser_crit_chance == 0:
		return false
	
	var rng := RandomNumberGenerator.new()
	
	rng.randomize()
	
	return rng.randf() < GameManager.mining_laser_crit_chance

func platinum_gained() -> bool:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return rng.randf() < GameManager.platinum_gain_chance


func add_drone_to_scene() -> void:
	var area_collision_shape : CollisionShape2D = asteroid_area_2d.get_child(0)
	var drone : MiningDrone = preload("res://src/scenes/MiningDrone.tscn").instantiate()
	var random_x_pos : float = randf_range(0, area_collision_shape.shape.get_rect().size.x)
	var random_y_pos : float = randf_range(0, area_collision_shape.shape.get_rect().size.y)
	drone.global_position = asteroid_area_2d.global_position + Vector2(random_x_pos, random_y_pos)
	add_child(drone)

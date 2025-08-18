class_name MiningLaserProgressBar extends ProgressBar


var mining_speed : float
@onready var click_asteroid_sfx : AudioStreamPlayer = $click_asteroid_sfx
var mining_asteroid_sfx_list : Array[AudioStream] = [SfxManager.MIN_CLICK_ASTEROID_01, SfxManager.MIN_CLICK_ASTEROID_02, SfxManager.MIN_CLICK_ASTEROID_03, SfxManager.MIN_CLICK_ASTEROID_04, SfxManager.MIN_CLICK_ASTEROID_05, SfxManager.MIN_CLICK_ASTEROID_06, SfxManager.MIN_CLICK_ASTEROID_07, SfxManager.MIN_CLICK_ASTEROID_08]
func _ready() -> void:
	max_value = 100
	value = 0
	mining_speed = GameManager.mining_laser_speed
	SignalBus.update_mining_laser_speed.connect(update_mining_laser_speed)

func _process(delta : float) -> void:
	position = get_global_mouse_position()+Vector2(30,-5)


func _physics_process(delta) -> void:
	if Input.is_action_pressed("mine_asteroid"):
		value += mining_speed
		
		if value >= max_value:
			obtain_resources()
			value = 0
				
	else:
		queue_free()

func obtain_resources() -> void:
	play_mining_sfx()
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
	resource_acquired_label.output = "+"+str(true_damage)
	resource_acquired_label.set_resource_as_ferrite()
	
	resource_acquired_label.global_position = get_viewport().get_mouse_position()  + Vector2(50,-8)
	get_parent().add_child(resource_acquired_label)
	SignalBus.update_ferrite_count.emit()
	
	if platinum_gained():
		
		var value : int = randi_range(GameManager.platinum_gain_min,GameManager.platinum_gain_max)
		var crit_value = value * 2
		var platinum_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
		platinum_acquired_label.set_resource_as_platinum()
		
		if can_crit:
			GameManager.platinum_count += crit_value
			if !GameManager.mine_100_platinum:
					SignalBus.add_to_mission_counter.emit(crit_value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.HUNDRED_PLATINUM_GAIN)
				
			if !GameManager.plat_drone_purchased:
				SignalBus.add_to_submission_counter.emit(crit_value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED)
			
			if !GameManager.upgrade_mining_drone_damage:
				SignalBus.add_to_submission_counter.emit(crit_value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_MINING_DRONE_DAMAGE)
			
			if !GameManager.purchase_1_more_drone:
				SignalBus.add_to_submission_counter.emit(crit_value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.PURCHASE_1_MORE_DRONE)
				
			if !GameManager.recon_scout_purchased:
				SignalBus.add_to_submission_counter.emit(crit_value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED)
			
			if !GameManager.upgrade_platinum_drone_speed:
				SignalBus.add_to_submission_counter.emit(crit_value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PLATINUM_DRONE_SPEED)
				
				platinum_acquired_label.output = "+"+str(crit_value)
		else:
			GameManager.platinum_count += value
		
			if !GameManager.mine_100_platinum:
					SignalBus.add_to_mission_counter.emit(value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.HUNDRED_PLATINUM_GAIN)
				
			if !GameManager.plat_drone_purchased:
				SignalBus.add_to_submission_counter.emit(value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED)
			
			if !GameManager.upgrade_mining_drone_damage:
				SignalBus.add_to_submission_counter.emit(value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_MINING_DRONE_DAMAGE)
			
			if !GameManager.purchase_1_more_drone:
				SignalBus.add_to_submission_counter.emit(value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.PURCHASE_1_MORE_DRONE)
				
			if !GameManager.recon_scout_purchased:
				SignalBus.add_to_submission_counter.emit(value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED)
			
			if !GameManager.upgrade_platinum_drone_speed:
				SignalBus.add_to_submission_counter.emit(value, GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PLATINUM_DRONE_SPEED)
			
		platinum_acquired_label.output = "+"+str(value)
		
		platinum_acquired_label.global_position = get_viewport().get_mouse_position() + Vector2(60,-5)
		await get_tree().create_timer(0.2).timeout
		get_parent().add_child(platinum_acquired_label)
		play_mining_sfx()
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


func play_mining_sfx():
	click_asteroid_sfx.stream = mining_asteroid_sfx_list.pick_random()
	click_asteroid_sfx.play()


func update_mining_laser_speed() -> void:
	mining_speed = GameManager.mining_laser_speed

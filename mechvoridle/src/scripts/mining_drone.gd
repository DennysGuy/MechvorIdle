class_name MiningDrone extends CharacterBody2D

@onready var progress_bar : ProgressBar = $ProgressBar
@onready var sfx_player : AudioStreamPlayer2D = $SfxPlayer
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var hurt_box = $HurtBox
@onready var audio_stream_player = $AudioStreamPlayer
@onready var state_machine : StateMachine = $StateMachine
@onready var move : State = $StateMachine/Move
@onready var health_regen_timer : Timer = $HealthRegenTimer

var mining_sfx_list : Array[AudioStream] = [SfxManager.MIN_CLICK_ASTEROID_04, SfxManager.MIN_CLICK_ASTEROID_05, SfxManager.MIN_CLICK_ASTEROID_06, SfxManager.MIN_CLICK_ASTEROID_07]
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var health : int = 12
var max_health : int = 12
var navigation_coordinates : Vector2

func _ready() -> void:
	SignalBus.deselect_drone.connect(hide_outline)
	SignalBus.move_drone.connect(change_to_move_state)
	SignalBus.update_health_regen_time.connect(decrease_health_regen_time)
	SignalBus.update_max_health.connect(increase_max_health)
	
	DroneManager.register_mining_drone(self)
	health_regen_timer.wait_time = GameManager.drone_health_regen_time
	health_regen_timer.start()
	hide_outline()
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	set_outline_color()
	state_machine.process_frame(delta)
	
func _exit_tree():
	DroneManager.unregister_mining_drone(self)
	
func erase() -> void:
	progress_bar.hide()
	sprite_2d.hide()
	hurt_box.get_child(0).disabled = true
	var explosion : Explosion = preload("res://src/scenes/Explosion.tscn").instantiate()
	explosion.size_set = 3
	SignalBus.issue_drone_down_alert.emit()
	
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


func _on_drone_data_shower_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if GameManager.drone_selected and GameManager.drone_selected == self:
				return
			show_outline()
			GameManager.drone_selected = self
			SignalBus.show_drone_details.emit(self)
		   

func hide_outline() -> void:
	sprite_2d.material.set("shader_parameter/alpha_threshold", 1.0)

func show_outline() -> void:
	sprite_2d.material.set("shader_parameter/alpha_threshold", 0.0)

func set_outline_color() -> void:
	if	health >= round(max_health *0.8):
		sprite_2d.material.set("shader_parameter/outline_color", Color.GREEN)
	elif health < round(max_health * 0.8) and health > round(max_health * 0.5):
		sprite_2d.material.set("shader_parameter/outline_color", Color.YELLOW)
	else:
		sprite_2d.material.set("shader_parameter/outline_color", Color.RED)

func change_to_move_state(selected_drone, destination : Vector2):
	if self == selected_drone:
		navigation_coordinates = destination
		state_machine.change_state(move)

func increase_max_health() -> void:
	max_health += GameManager.drone_max_health

func decrease_health_regen_time() -> void:
	health_regen_timer.wait_time = GameManager.drone_health_regen_amount

func _on_health_regen_timer_timeout():
	if health < max_health:
		var new_health_amount : int = health + GameManager.drone_health_regen_amount
		health = min(new_health_amount, max_health)

class_name PlatinumMiningDrone extends CharacterBody2D

@onready var progress_bar : ProgressBar = $ProgressBar
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var state_machine : StateMachine = $StateMachine
@onready var move : State = $StateMachine/Move

var navigation_coordinates : Vector2
var health : int = 15
var max_health : int = 15
@onready var health_regen_timer : Timer = $HealthRegenTimer

var mining_sfx : Array[AudioStream] = [SfxManager.MIN_CLICK_ASTEROID_01,SfxManager.MIN_CLICK_ASTEROID_02,SfxManager.MIN_CLICK_ASTEROID_03]

func _ready() -> void:
	SignalBus.move_drone.connect(change_to_move_state)
	SignalBus.deselect_drone.connect(hide_outline)
	SignalBus.update_health_regen_time.connect(decrease_health_regen_time)
	SignalBus.update_max_health.connect(increase_max_health)
	SignalBus.heal_drone.connect(heal_drone)
	
	health_regen_timer.wait_time = GameManager.drone_health_regen_time
	health_regen_timer.start()
	animation_player.play("idle")
	hide_outline()
	DroneManager.register_platinum_drone(self)
	state_machine.init(self)

func _process(delta) -> void:
	set_outline_color()
	state_machine.process_frame(delta)
	
	
func _physics_process(delta : float) -> void:
	state_machine.process_physics(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


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
	var area_parent = area.get_parent()
	
	if area.get_parent() is Asteroid or area.get_parent() is UFOLaser:
		health -= area_parent.damage
		SignalBus.update_drone_health_label.emit(self)
		if health <= 0:
			kill_mining_drone()
		
		if area.get_parent() is Asteroid:
			var asteroid : Asteroid = area.get_parent()
			asteroid.spawn_explosion_and_destroy()
		else:
			area_parent.queue_free() #we'll change to animation explode sequence
		
func kill_mining_drone():
	SignalBus.clear_drone_details.emit(self)
	erase()

func play_mining_sfx() -> void:
	audio_stream_player_2d.stream = mining_sfx.pick_random()
	audio_stream_player_2d.play()


func _on_drone_data_shower_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if GameManager.drone_selected and GameManager.drone_selected == self:
				return
			show_outline()
			GameManager.drone_selected = self
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

func change_to_move_state(selected_drone, destination : Vector2):
	if self == selected_drone:
		navigation_coordinates = destination
		state_machine.change_state(move)


func increase_max_health() -> void:
	max_health += GameManager.drone_max_health

func decrease_health_regen_time() -> void:
	health_regen_timer.wait_time = GameManager.drone_health_regen_amount

func heal_drone(selected_drone) -> void:
	if selected_drone == self:
		health = max_health
		SignalBus.update_drone_details_while_selected.emit(self)

func _on_health_regen_timer_timeout():
	if health < max_health:
		var new_health_amount : int = health + GameManager.drone_health_regen_amount
		health = min(new_health_amount, max_health)

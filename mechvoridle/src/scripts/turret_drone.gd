class_name TurretDrone extends CharacterBody2D

@onready var collision_shape_2d = $AnamolieDetector/CollisionShape2D.shape

var radius :float = 100.0
var aoe_radius_color : Color = Color(0,1,0,0.2)
var show_aoe_radius : bool = false
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var state_machine : StateMachine = $StateMachine
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hurt_box : Area2D = $HurtBox
@onready var progress_bar : ProgressBar = $ProgressBar
@onready var health_regen_timer : Timer = $HealthRegenTimer

var health : int = 18
var max_health : int = 18
var navigation_coordinates : Vector2

@onready var anamolie_detector : Area2D = $AnamolieDetector

var tracked_hostile : Node 

var damage : int
var speed : int

func _ready() -> void:
	set_range_area_scale()
	set_turret_damage()
	set_turret_speed() 
	radius = roundf(collision_shape_2d.radius * GameManager.turret_drone_range_scaler)
	SignalBus.deselect_drone.connect(deselect_drone)
	SignalBus.move_drone.connect(change_to_move_state)
	SignalBus.clear_tracked_hostile.connect(clear_tracked_hostile)
	
	SignalBus.update_health_regen_time.connect(decrease_health_regen_time)
	SignalBus.update_max_health.connect(increase_max_health)
	SignalBus.heal_drone.connect(heal_drone)
	DroneManager.register_turret_drone(self)
	health_regen_timer.wait_time = GameManager.drone_health_regen_time
	health_regen_timer.start()
	SignalBus.update_turret_drone_speed.connect(set_turret_speed)
	SignalBus.update_turret_drone_range.connect(set_range_area_scale)
	SignalBus.update_turret_drone_damage.connect(set_turret_damage)
	hide_outline()
	state_machine.init(self)
	
func _process(delta: float) -> void:
	
	queue_redraw()
	set_outline_color()
	state_machine.process_frame(delta)

	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _exit_tree():
	DroneManager.unregister_turret_drone(self)

func erase() -> void:
	progress_bar.hide()
	sprite_2d.hide()
	hurt_box.get_child(0).disabled = true
	var explosion : Explosion = preload("res://src/scenes/Explosion.tscn").instantiate()
	explosion.size_set = 3
	SignalBus.issue_drone_down_alert.emit()
	
	add_child(explosion)

func _draw() -> void:
	if show_aoe_radius:
		draw_circle(Vector2.ZERO, radius, aoe_radius_color)

func show_radius(value : bool) -> void:
	show_aoe_radius = value
	
func deselect_drone() -> void:
	hide_outline()
	show_radius(false)
	
@onready var move : State = $StateMachine/Move

func change_to_move_state(selected_drone, destination : Vector2) -> void:
	if self == selected_drone:
		navigation_coordinates = destination
		state_machine.change_state(move)

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

func _on_control_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if GameManager.drone_selected and GameManager.drone_selected == self:
				return
				
			show_radius(true)
			show_outline()
			GameManager.drone_selected = self
			SignalBus.show_drone_details.emit(self)

func kill_mining_drone():
	SignalBus.clear_drone_details.emit(self)
	erase()

func _on_hurt_box_area_entered(area):
	var area_parent = area.get_parent()
	
	if area.get_parent() is Asteroid or area.get_parent() is UFOLaser:
		health -= area_parent.damage
		SignalBus.update_drone_health_label.emit(self)
		if health <= 0:
			kill_mining_drone()
			tracked_hostile = null
	
		if area.get_parent() is Asteroid:
			var asteroid : Asteroid = area.get_parent()
			asteroid.spawn_explosion_and_destroy()
			SignalBus.clear_tracked_hostile.emit(area_parent)
			tracked_hostile = null
		else:
			area_parent.queue_free() #we'll change to animation explode sequence


func _on_anamolie_detector_area_entered(area : Area2D):
	var parent = area.get_parent()
	
	if parent is not TurretDrone:
		tracked_hostile = parent

func set_range_area_scale() -> void:
	radius = roundf(collision_shape_2d.radius * GameManager.turret_drone_range_scaler)
	collision_shape_2d.radius = radius
	
func set_turret_damage() -> void:
	damage = GameManager.turret_drone_damage

func set_turret_speed() -> void:
	speed = GameManager.turret_drone_speed

func _on_anamolie_detector_area_exited(area : Area2D):
	var parent = area.get_parent()
	
	if parent and parent == tracked_hostile:
		tracked_hostile = null

func clear_tracked_hostile(hostile) -> void:
	if tracked_hostile and tracked_hostile == hostile:
		tracked_hostile = null

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

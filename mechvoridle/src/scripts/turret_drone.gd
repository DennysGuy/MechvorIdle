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

var health : int = 12
var max_health : int = 12
var navigation_coordinates : Vector2

@onready var anamolie_detector : Area2D = $AnamolieDetector


var tracked_hostile : Node 
var tracked_hostile_queue : Array = []


func _ready() -> void:
	radius = collision_shape_2d.radius
	SignalBus.deselect_drone.connect(deselect_drone)
	SignalBus.move_drone.connect(change_to_move_state)
	DroneManager.register_turret_drone(self)
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
	

func change_to_move_state() -> void:
	pass

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
			show_radius(true)

func kill_mining_drone():
	erase()

func _on_hurt_box_area_entered(area):
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

func add_hostile_to_queue(hostile : Node) -> void:
	#adds the newly seen hostile to the queue to be moved later
	tracked_hostile_queue.append(hostile)

func move_next_in_queue() -> void:
	tracked_hostile = tracked_hostile_queue[0]
	#remove hostile from queue
	tracked_hostile_queue.erase(0)

func remove_from_queue(hostile : Node) -> void:
	#if the hostile leaves the area, we'll also need to remove from queue
	var index = tracked_hostile_queue.find(hostile)
	if index != -1:
		tracked_hostile_queue.erase(index)

func _on_anamolie_detector_area_entered(area : Area2D):
	var parent = area.get_parent()
	
	if not tracked_hostile:
		tracked_hostile = parent
	else:
		add_hostile_to_queue(parent)

func _on_anamolie_detector_area_exited(area : Area2D):
	var parent = area.get_parent()
	
	if parent:
		if parent == tracked_hostile:
			tracked_hostile = null
		else:
			remove_from_queue(parent)

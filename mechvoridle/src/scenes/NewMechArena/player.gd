extends CharacterBody3D

@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $mech/AnimationPlayer
@onready var animation_player_right_arm : AnimationPlayer = $mech/Node/UpperBody/RangedArmAnime/AnimationPlayer


@onready var upper_body: Node3D = $mech/Node/UpperBody
@onready var lower_body: Node3D = $mech/Node/LowerBody
@onready var node: Node3D = $mech/Node

@onready var muzzle: Marker3D = $mech/Node/UpperBody/RangedArmAnime/Node/RangedArm/Shoulder2/Bicep/ForeArm3/Hand2/Rifle1/Muzzle

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var camera: Camera3D = $Camera3D


var plain_y := 0.0


func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CA)
	state_machine.init(self)

func _process(delta) -> void:
	
	if Input.is_action_pressed("mine_asteroid"):
		animation_player_right_arm.play("FireRifle")
	
	var mouse_pos = get_viewport().get_mouse_position()

	# Cast ray from camera through mouse
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)

	# Intersect with Y = 0 plane (the ground)
	var plane_y = 0.0
	if abs(ray_dir.y) > 0.001: # avoid divide by zero
		var t = (plane_y - ray_origin.y) / ray_dir.y
		if t > 0:
			var target_pos = ray_origin + ray_dir * t

			# Rotate character toward the mouse
			var direction = target_pos - global_transform.origin
			direction.y = 0
			direction = direction.normalized()

			var target_rotation = atan2(direction.x, direction.z)
			upper_body.rotation.y = target_rotation + PI
	
	state_machine.process_frame(delta)
	
	
func _physics_process(delta : float) -> void:
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	state_machine.process_physics(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func get_yaw_difference() -> float:
	var angle_diff = wrapf(upper_body.rotation.y - lower_body.rotation.y, -PI, PI)
	return angle_diff
	
@onready var rifle_1: Node3D = $mech/Node/UpperBody/RangedArmAnime/Node/RangedArm/Shoulder2/Bicep/ForeArm3/Hand2/Rifle1


func fire_bullet() -> void:
	# Load and instantiate bullet
	var plasma_bullet : PlasmaBullet = preload("uid://b712bpq5ut01h").instantiate()
	
	# Position and rotate the bullet at the muzzle
	plasma_bullet.global_transform.origin = muzzle.global_transform.origin
	
	var rot_y = rifle_1.rotation.y
	var forward = Vector3(-sin(rot_y),0,-cos(rot_y))
	forward = forward.normalized()
	
	# Set direction along the muzzle's forward (-Z)
	plasma_bullet.direction = forward
	
	# Add the bullet to the scene
	get_tree().current_scene.add_child(plasma_bullet)

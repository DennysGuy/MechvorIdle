class_name Player extends CharacterBody3D

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
var threshold = PI * 2.0 / 4.0  # 120 degrees

var plain_y := 0.0


func _ready() -> void:
	var debug_arrow = MeshInstance3D.new()
	debug_arrow.mesh = ImmediateMesh.new()
	debug_arrow.transform = Transform3D(Basis(), Vector3(0, 0, -2)) # forward
	add_child(debug_arrow)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CA)
	state_machine.init(self)

func _process(delta) -> void:
	
	var upper_body_angle = atan2(upper_body.global_transform.basis.z.x, upper_body.global_transform.basis.z.z)
	var lower_body_angle = atan2(lower_body.global_transform.basis.z.x, lower_body.global_transform.basis.z.z)
	var diff = round(wrapf(upper_body_angle - lower_body_angle, -PI, PI))
	print("angle diff with up and low: " +str(diff))
	
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


func get_yaw(obj: Node3D) -> float:
	var forward = obj.global_transform.basis.z
	return atan2(forward.x, forward.z)  # radians, -PI..PI
	
@onready var rifle_1: Node3D = $mech/Node/UpperBody/RangedArmAnime/Node/RangedArm/Shoulder2/Bicep/ForeArm3/Hand2/Rifle1


func fire_bullet() -> void:
	var plasma_bullet : PlasmaBullet = preload("uid://b712bpq5ut01h").instantiate()
	
	# Copy full transform from muzzle
	plasma_bullet.global_transform = muzzle.global_transform
	
	# Use muzzle forward as bullet direction
	plasma_bullet.direction = -muzzle.global_transform.basis.z
	
	# Add to scene root
	get_tree().current_scene.add_child(plasma_bullet)

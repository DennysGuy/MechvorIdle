class_name PlayerDash extends State

@export var idle_state: State
@export var rotation_speed = 6.0
@export var dash_speed = 25.0   # use a realistic dash speed
@export var snap_threshold = deg_to_rad(180)
@export var snap_speed = 8.0

@onready var dash_timer: Timer = $"../../DashTimer"
@onready var node: Node3D = $"../../mech/Node"

var dash_direction: Vector3 = Vector3.ZERO

func enter() -> void:
	parent.animation_player.play("Dash")
	#parent.can_aim = false

	# Calculate dash direction
	dash_direction = parent.prev_dir.normalized()
	if dash_direction == Vector3.ZERO:
		#print("ASDLAKJSHFKJASHF")
		# If no input, dash forward relative to facing
		dash_direction = -parent.global_transform.basis.z.normalized()
	else:
		# Transform local input into world direction
		dash_direction = (parent.global_transform.basis * dash_direction).normalized()
	
	# Apply dash once
	parent.velocity = dash_direction * dash_speed
	
	# Rotate mech towards dash direction
	var target = Transform3D().looking_at(dash_direction, Vector3.UP).basis
	#parent.lower_body.basis = target
	parent.upper_body.basis = target
	
	dash_timer.start()


func exit() -> void:
	#parent.can_aim = true
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	# While dashing, maintain constant dash velocity (don’t reapply every frame)
	if dash_timer.time_left > 0:
		parent.velocity.x = dash_direction.x * dash_speed
		parent.velocity.z = dash_direction.z * dash_speed
		return null
	
	# End dash → smooth slowdown + transition
	parent.velocity.x = move_toward(parent.velocity.x, 0, dash_speed * 2)
	parent.velocity.z = move_toward(parent.velocity.z, 0, dash_speed * 2)
	if parent.velocity.length() < 0.1:
		return idle_state
	
	return null

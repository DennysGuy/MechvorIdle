class_name PlayerRun extends State


@export var idle_state: State

@export var rotation_speed = 6.0
@export var movement_speed = 4.0

@onready var node: Node3D = $"../../Mech/Node"


func enter() -> void:
	parent.animation_player.play("Run")

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	
	return null

func process_physics(_delta: float) -> State:

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()

	if direction != Vector3.ZERO:
		# Set velocity in the direction of movement
		parent.velocity.x = direction.x * movement_speed
		parent.velocity.z = direction.z * movement_speed

		# Rotate mech smoothly toward movement direction
		var target = Transform3D().looking_at(direction, Vector3.UP).basis
		node.basis = node.basis.slerp(target, rotation_speed * _delta)

	else:
		# No input, stop movement
		parent.velocity.x = move_toward(parent.velocity.x, 0, movement_speed)
		parent.velocity.z = move_toward(parent.velocity.z, 0, movement_speed)
		return idle_state

	# Apply movement
	parent.move_and_slide()
	
	return null

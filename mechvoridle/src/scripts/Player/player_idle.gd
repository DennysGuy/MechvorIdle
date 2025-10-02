class_name PlayerIdle extends State


@export var move_state: State
@onready var dialogue_starter_detector := $"../../Character/DialogueStarterDetector"

@onready var anim_tree := $"../../AnimationTree"
@onready var camera := $"../../CameraPivot/Camera3D"
@onready var camera_pivot := $"../../CameraPivot"
@onready var dialogue_point := $"../../DialoguePoint"
@onready var invalid_press_sfx := $"../../DeniedSFX"
var dialogue_start := "this_is_a_node_title"
var can_move : bool = true
var entity_to_rotate: Node3D = null
var start_rotation = false



func enter() -> void:
	parent.animation_player.play("Idle")
	parent.velocity.x = 0
	parent.velocity.z = 0


func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	var key_pressed: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if key_pressed != Vector2.ZERO:
		return move_state

	return null

func process_physics(_delta: float) -> State:
	
	var torso_yaw = parent.get_yaw(parent.upper_body)
	var legs_yaw = parent.get_yaw(parent.lower_body)
	
	var diff = wrapf(legs_yaw-torso_yaw, -PI, PI)

	if abs(diff) > parent.threshold:
		parent.lower_body.rotation.y = torso_yaw
	
	parent.move_and_slide()
	return null

func rotate_entity_smoothly(entity: Node3D, delta: float) -> void:
	# Calculate the direction vector from the entity to the player
	var direction_to_player = (parent.global_transform.origin - entity.global_transform.origin).normalized()
	# Calculate the target rotation basis for the entity to face the player
	var target_rotation = Basis.looking_at(direction_to_player, Vector3.UP)
	# Smoothly interpolate the entity's current basis towards the target rotation
	entity.transform.basis = entity.transform.basis.slerp(target_rotation, 8 * delta)

	

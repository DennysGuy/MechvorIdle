class_name ChallengeTarget extends GridEnemy

@onready var target_2: MeshInstance3D = $Target/Target3/Target2

var round_lost : bool = false

var order_index : int
var spawn_coordinates : Vector2
const CHALLENGE_TARGET_1_TEXTURE = preload("uid://dflbc21klh6bs")
const CHALLENGE_TARGET_2_TEXTURE = preload("uid://vllo5vxuf1xr")
const CHALLENGE_TARGET_3_TEXTURE = preload("uid://be4ihr5xuehhn")
const CHALLENGE_TARGET_4_TEXTURE = preload("uid://bk4rncy3hexea")

func _ready() -> void:
	ChallengeWaveManager.reveal_target_order.connect(reveal_number)
	ChallengeWaveManager.clear_targets.connect(remove_target)
	can_hurt = false
	match order_index:
		0:
			target_2.material_override = CHALLENGE_TARGET_1_TEXTURE
		1:
			target_2.material_override = CHALLENGE_TARGET_2_TEXTURE
		2:
			target_2.material_override = CHALLENGE_TARGET_3_TEXTURE
		3:
			target_2.material_override = CHALLENGE_TARGET_4_TEXTURE
			
	animation_player.play("SpawnIn")
	#await get_tree().create_timer(0.5)
	#animation_player.play("Hover")

func play_hover() -> void:
	animation_player.play("Hover")

func reveal_number() -> void:
	animation_player.play("RevealNumber")

func can_hurt_target() -> void:
	can_hurt = true

func _exit_tree() -> void:
	if !round_lost:
		ChallengeWaveManager.check_order(order_index)
	#await get_tree().process_frame

func remove_target() -> void:
	round_lost = true
	queue_free()

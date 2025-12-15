class_name ChallengeTarget extends GridEnemy

@onready var target_2: MeshInstance3D = $Target/Target3/Target2


var order_index : int

const CHALLENGE_TARGET_1_TEXTURE = preload("uid://dflbc21klh6bs")
const CHALLENGE_TARGET_2_TEXTURE = preload("uid://vllo5vxuf1xr")
const CHALLENGE_TARGET_3_TEXTURE = preload("uid://be4ihr5xuehhn")
const CHALLENGE_TARGET_4_TEXTURE = preload("uid://bk4rncy3hexea")

func _ready() -> void:
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
	await get_tree().create_timer(0.5)
	animation_player.play("Hover")

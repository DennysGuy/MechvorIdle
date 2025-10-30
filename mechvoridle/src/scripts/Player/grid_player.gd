class_name GridPlayer extends GridActor

@onready var animation_player: AnimationPlayer = $blockbench_export/AnimationPlayer
@onready var vlucan_1: Marker3D = $Vlucan1
@onready var vlucan_2: Marker3D = $Vlucan2

@onready var mech_part_names : Array[String] = ["Head", "Torso", "Legs", "Arms"]

@onready var melee_head: Node3D = $blockbench_export/UpperBody/Head/MeleeHead2
@onready var ranged_head: Node3D = $blockbench_export/UpperBody/Head/RangedHead2

@onready var light_torso: Node3D = $blockbench_export/UpperBody/Torso/LightTorso2
@onready var heavy_torso: Node3D = $blockbench_export/UpperBody/Torso/HeavyTorso2
@onready var standard_torso: Node3D = $blockbench_export/UpperBody/Torso/StandardTorso2

@onready var melee_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/MeleeHand2
@onready var ranged_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/RangedHand2

@onready var melee_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/MeleeForeArm2
@onready var ranged_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/RangedForeArm2

@onready var melee_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/MeleeBicep
@onready var ranged_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/RangedBicep2

@onready var melee_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/MeleeShoulder
@onready var ranged_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/RangedShoulder2

@onready var melee_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/MeleeHand23
@onready var ranged_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/RangedHand23

@onready var melee_forearm_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/MeleeBackGuard22
@onready var ranged_forearm_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/RangedBackGuard22

@onready var melee_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/MeleeBicep22
@onready var ranged_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/RangedBicep23

@onready var melee_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/MeleeShoulder22
@onready var ranged_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/RangedShoulder23

@onready var light_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/LightKneeBrace2
@onready var standard_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/StandardKneeBrace2
@onready var heavy_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/HeavyKneeBrace2

@onready var light_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/LightFood2
@onready var standard_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/StandardFoot2
@onready var heavy_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/HeavyFoot2

@onready var light_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/LightLowerLegGuard2
@onready var heavy_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/HeavyLowerLegGuard2
@onready var standard_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/StandardLowerLegGuard2

@onready var light_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/LightUpperLeg
@onready var standard_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/StandardUpperLeg
@onready var heavy_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/HeavyUpperLeg

@onready var light_knee_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/LightKneeBrace23
@onready var standard_knee_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/StandardKneeBrace23
@onready var heavy_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/HeavyBrace22

@onready var light_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/LightFoot22
@onready var standard_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/StandardFoot23
@onready var heavy_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/HeavyFoot23

@onready var light_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/LightCalf22
@onready var standard_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/StandardCalf22
@onready var heavy_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/HeavyCalf22

@onready var light_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/LightUpperLeg2
@onready var standard_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/StandardUpperLeg2
@onready var heavy_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/HeavyUpperLeg2

@onready var light_lower_leg_guard_2: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/LightLowerLegGuard2
@onready var heavy_lower_leg_guard_2: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/HeavyLowerLegGuard2
@onready var standard_lower_leg_guard_2: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/StandardLowerLegGuard2


@onready var mech_components : Dictionary = {
	"Head": {
		#melee head
		0: [melee_head],
		#ranged head
		1: [ranged_head]
	},
	"Torso": {
		#light torso
		0: [light_torso],
		#standard torso
		1: [standard_torso],
		#heavy torso
		2: [heavy_torso]
	},
	"Arms": {
		#melee arms
		0: [melee_hand, 
			melee_fore_arm, 
			melee_bicep, 
			melee_shoulder, 
			melee_hand_2, 
			melee_forearm_2, 
			melee_shoulder_2, 
			melee_bicep_2
		],
		#ranged arms
		1: [ranged_hand,
			ranged_fore_arm,
			ranged_bicep, 
			ranged_shoulder, 
			ranged_shoulder_2,
			ranged_hand_2,
			ranged_forearm_2,
			ranged_bicep_2
		]
	},
	"Legs": {
		#melee legs
		0 : [
			light_knee_brace,
			light_foot,
			light_lower_leg_guard,
			light_upper_leg,
			light_upper_leg_2,
			light_knee_brace_2,
			light_lower_leg_guard_2,
			light_foot_2,
			light_calf_2,
		],
		#standard legs
		1: [
			standard_knee_brace,
			standard_foot,
			standard_lower_leg_guard,
			standard_upper_leg,
			standard_knee_brace_2,
			standard_lower_leg_guard_2,
			standard_foot_2,
			standard_calf_2,
			standard_upper_leg_2
		],
		#heavy legs
		2: [
			heavy_knee_brace,
			heavy_foot,
			heavy_lower_leg_guard,
			heavy_upper_leg,
			heavy_brace_2,
			heavy_foot_2,
			heavy_lower_leg_guard_2,
			heavy_calf_2,
			heavy_upper_leg_2
		]
		
	}
}

var mech_vulcan : MechWeapon = preload("uid://kcrfevws33d7")
var can_shoot : bool = true
var firing : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridManager.set_mech_as_standard_light()
	enable_mech_parts()
	animation_player.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left") and can_move:
		SignalBus.move_player.emit(Vector2.UP)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
		GridManager.clear_targeted_tiles()
		
	if Input.is_action_pressed("move_right") and can_move:
		SignalBus.move_player.emit(Vector2.DOWN)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
		GridManager.clear_targeted_tiles()
	
	if Input.is_action_pressed("move_up") and can_move:
		SignalBus.move_player.emit(Vector2.LEFT)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
	
	if Input.is_action_pressed("move_down") and can_move:
		SignalBus.move_player.emit(Vector2.RIGHT)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true

	if Input.is_action_pressed("fire_vulcans") and not firing:
		firing = true
		add_vulcan_flares()
		mech_vulcan.attack_enemy(GridManager.player,tiles)
		await get_tree().create_timer(0.1).timeout
		for flare in get_tree().get_nodes_in_group("VulcanFlares"):
			flare.queue_free()
		await get_tree().create_timer(0.1).timeout
		firing = false
		
	if Input.is_action_just_released("fire_vulcans") and firing:
		for flare in get_tree().get_nodes_in_group("VulcanFlares"):
			flare.queue_free()
			
		GridManager.clear_targeted_tiles()
	
	
func enable_mech_parts() -> void:
	for part in mech_components:
		var selected_part_index : int = GameManager.owned_mech_components[part].index
		var visuals : Array = mech_components[part][selected_part_index]
		for visual in visuals:
			visual.show()

func add_vulcan_flares() -> void:
	var muzzle_flare_1 = preload("uid://6wqyu6m4rjr5").instantiate()
	var muzzle_flare_2 = preload("uid://6wqyu6m4rjr5").instantiate()
	
	muzzle_flare_1.position = vlucan_1.position
	muzzle_flare_2.position = vlucan_2.position
	
	add_child(muzzle_flare_1)
	add_child(muzzle_flare_2)

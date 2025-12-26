extends Node3D

@onready var melee_head: Node3D = $blockbench_export/UpperBody/Head/MeleeHead
@onready var ranged_head: Node3D = $blockbench_export/UpperBody/Head/RangedHead
@onready var standard_head: Node3D = $blockbench_export/UpperBody/Head/StandardHead


@onready var light_torso: Node3D = $blockbench_export/UpperBody/Torso/LightTorso
@onready var heavy_torso: Node3D = $blockbench_export/UpperBody/Torso/HeavyTorso
@onready var standard_torso: Node3D = $blockbench_export/UpperBody/Torso/StandardTorso

@onready var melee_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/MeleeHand
@onready var ranged_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/RangedHand
@onready var standard_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/StandardHand

@onready var melee_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/MeleeForeArm
@onready var ranged_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/RangedForeArm
@onready var standard_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/StandardForeArm


@onready var melee_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/MeleeBicep
@onready var ranged_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/RangedBicep
@onready var standard_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/StandardBicep


@onready var melee_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/MeleeShoulder
@onready var ranged_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/RangedShoulder
@onready var standard_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/StandardShoulder


@onready var melee_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/MeleeHand2
@onready var ranged_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/RangedHand2
@onready var standard_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/StandardHand2

@onready var melee_back_guard_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/MeleeBackGuard2
@onready var ranged_back_guard_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/RangedBackGuard2
@onready var standard_fore_arm_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/StandardForeArm2

@onready var melee_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/MeleeBicep2
@onready var ranged_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/RangedBicep2
@onready var standard_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/StandardBicep2

@onready var melee_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/MeleeShoulder2
@onready var ranged_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/RangedShoulder2
@onready var standard_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/StandardShoulder2

@onready var light_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/LightKneeBrace
@onready var standard_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/StandardKneeBrace
@onready var heavy_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/HeavyKneeBrace

@onready var light_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/LightFoot
@onready var standard_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/StandardFoot
@onready var heavy_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/HeavyFoot

@onready var light_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/LightLowerLegGuard
@onready var heavy_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/HeavyLowerLegGuard
@onready var standard_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/StandardLowerLegGuard

@onready var light_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/LightUpperLeg
@onready var standard_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/StandardUpperLeg
@onready var heavy_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/HeavyUpperLeg

@onready var light_knee_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/LightKneeBrace2
@onready var standard_knee_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/StandardKneeBrace2
@onready var heavy_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/HeavyBrace2

@onready var light_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/LightFoot2
@onready var standard_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/StandardFoot2
@onready var heavy_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/HeavyFoot2

@onready var light_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/LightCalf2
@onready var standard_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/StandardCalf2
@onready var heavy_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/HeavyCalf2

@onready var light_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/LightUpperLeg2
@onready var standard_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/StandardUpperLeg2
@onready var heavy_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/HeavyUpperLeg2

### WEAPONS ###

@onready var thy_kingdom_come_left_side: Node3D = $blockbench_export/UpperBody/Torso/ThyKingdomComeLeftSide
@onready var thy_kingdom_come_right_side: Node3D = $blockbench_export/UpperBody/Torso/ThyKingdomComeRightSide

@onready var soulder_rocket_left: Node3D = $blockbench_export/UpperBody/Torso/SoulderRocketLeft
@onready var soulder_rocket_right: Node3D = $blockbench_export/UpperBody/Torso/SoulderRocketRight

@onready var arm_rocket_launcher: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/ArmRocketLauncher
@onready var arm_rocket_launcher_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/ArmRocketLauncher2

@onready var katanna: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/Katanna
@onready var katanna_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/Katanna2

@onready var heat_sword: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/HeatSword
@onready var heat_sword_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/HeatSword2

@onready var spear: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/Spear
@onready var spear_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/Spear2

@onready var sub_machine_gun: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/SubMachineGun
@onready var sub_machine_gun_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/SubMachineGun2

@onready var rifle: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/Rifle
@onready var rifle_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/Rifle2

@onready var sniper_rifle: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/SniperRifle
@onready var sniper_rifle_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/SniperRifle2

@onready var blockbench_export: Node3D = $blockbench_export

@onready var mech_components : Dictionary = {
	"Head": {
		#melee head
		0: [melee_head],
		#standard head
		1: [standard_head],
		#ranged head
		2: [ranged_head]
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
			melee_back_guard_2, 
			melee_shoulder_2, 
			melee_bicep_2
		],
		#ranged arms
		1: [standard_hand,
			standard_fore_arm,
			standard_bicep, 
			standard_shoulder, 
			standard_shoulder_2,
			standard_hand_2,
			standard_fore_arm_2,
			standard_bicep_2
		],
		2: [ranged_hand,
			ranged_fore_arm,
			ranged_bicep, 
			ranged_shoulder, 
			ranged_shoulder_2,
			ranged_hand_2,
			ranged_back_guard_2,
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
			heavy_calf_2,
			heavy_upper_leg_2
		]	
	}
}

@onready var mech_weapons : Dictionary = {
	"LeftWeapon": {
		"Sword": [
			katanna_2,
			#sword_2
			heat_sword_2,
			#sword_3
			spear_2,	
		],
		"Rifle": [
			#rifle_1
			rifle_2,
			#rifle_2,
			sub_machine_gun_2,
			#rifle_3
			sniper_rifle_2,
		],
		"Rocket Launcher": [
			#rocket_1
			soulder_rocket_left,
			#rocket_2
			arm_rocket_launcher_2,
			#rocket_3
			thy_kingdom_come_left_side
		]
	},
	"RightWeapon": {
		"Sword": [
			#sword_1
			katanna,
			#sword_2
			heat_sword,
			#sword_3
			spear
		],
		"Rifle": [
			#rifle_1
			rifle,
			#rifle_2
			sub_machine_gun,
			#rifle_3
			sniper_rifle,	
		],
		"Rocket Launcher" : [
			#launcher_1
			soulder_rocket_right,
			#launcher_2
			arm_rocket_launcher,
			#launcher_3
			thy_kingdom_come_right_side
		]
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#GridManager.set_mech_as_standard()
	MenuController.set_selected_part.connect(display_selected_parts)
	display_selected_parts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	blockbench_export.rotation.y += 0.005


func _get_all_modular_nodes() -> Array[Node3D]:
	return [
		# HEADS
		melee_head, ranged_head, standard_head,

		# TORSOS
		light_torso, heavy_torso, standard_torso,

		# ARM 1
		melee_hand, ranged_hand, standard_hand,
		melee_fore_arm, ranged_fore_arm, standard_fore_arm,
		melee_bicep, ranged_bicep, standard_bicep,
		melee_shoulder, ranged_shoulder, standard_shoulder,

		# ARM 2
		melee_hand_2, ranged_hand_2, standard_hand_2,
		melee_back_guard_2, ranged_back_guard_2, standard_fore_arm_2,
		melee_bicep_2, ranged_bicep_2, standard_bicep_2,
		melee_shoulder_2, ranged_shoulder_2, standard_shoulder_2,

		# LEG 1
		light_knee_brace, standard_knee_brace, heavy_knee_brace,
		light_foot, standard_foot, heavy_foot,
		light_lower_leg_guard, standard_lower_leg_guard, heavy_lower_leg_guard,
		light_upper_leg, standard_upper_leg, heavy_upper_leg,

		# LEG 2
		light_knee_brace_2, standard_knee_brace_2, heavy_brace_2,
		light_foot_2, standard_foot_2, heavy_foot_2,
		light_calf_2, standard_calf_2, heavy_calf_2,
		light_upper_leg_2, standard_upper_leg_2, heavy_upper_leg_2,

		# WEAPONS
		thy_kingdom_come_left_side, thy_kingdom_come_right_side,
		soulder_rocket_left, soulder_rocket_right,
		arm_rocket_launcher, arm_rocket_launcher_2,
		katanna, katanna_2,
		heat_sword, heat_sword_2,
		spear, spear_2,
		sub_machine_gun, sub_machine_gun_2,
		rifle, rifle_2,
		sniper_rifle, sniper_rifle_2
	]


func hide_all_parts() -> void:
	for part in _get_all_modular_nodes():
		if is_instance_valid(part):
			part.hide()


func display_selected_parts() -> void:
	hide_all_parts()
	enable_mech_parts()
	enable_mech_weapons()


func enable_mech_parts() -> void:
	for part in mech_components:
		var selected_part_index : int = GameManager.owned_mech_components[part].index
		var visuals : Array = mech_components[part][selected_part_index]
		for visual in visuals:
			visual.show()

func enable_mech_weapons() -> void:
	var left_weapon : MechWeapon = GameManager.get_left_weapon()
	var right_weapon : MechWeapon = GameManager.get_right_weapon()
	
	var equipped_left_weapon = mech_weapons["LeftWeapon"][left_weapon.get_weapon_class()][left_weapon.shop_index]
	var equipped_right_weapon = mech_weapons["RightWeapon"][right_weapon.get_weapon_class()][right_weapon.shop_index]
	
	equipped_left_weapon.show()
	equipped_right_weapon.show()

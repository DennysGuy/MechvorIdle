class_name PlayerPreview extends Node3D

@onready var mech_preview : Node3D= $MechPreview

@onready var heavy_torso: Node3D = $MechPreview/HeavyTorso
@onready var heavy_arms: Node3D = $MechPreview/HeavyArms
@onready var ranged_head: Node3D = $MechPreview/RangedHead
@onready var heavy_legs: Node3D = $MechPreview/HeavyLegs
@onready var light_torso: Node3D = $MechPreview/LightTorso
@onready var light_legs: Node3D = $MechPreview/LightLegs
@onready var melee_arms: Node3D = $MechPreview/MeleeArms
@onready var melee_head: Node3D = $MechPreview/MeleeHead
@onready var plasma_sword_left_hand: Node3D = $MechPreview/PlasmaSwordLeftHand
@onready var plasma_sword_right_hand: Node3D = $MechPreview/PlasmaSwordRightHand
@onready var sword_left_hand: Node3D = $MechPreview/SwordLeftHand
@onready var sword_right_hand: Node3D = $MechPreview/SwordRightHand
@onready var standard_rifle_left_side: Node3D = $MechPreview/StandardRifleLeftSide
@onready var standard_rifle_right_side: Node3D = $MechPreview/StandardRifleRightSide
@onready var plasma_rifle_left_side: Node3D = $MechPreview/PlasmaRifleLeftSide
@onready var plasma_rifle_rightside: Node3D = $MechPreview/PlasmaRifleRightside
@onready var plasma_rocket_launcher_left_side: Node3D = $MechPreview/PlasmaRocketLauncherLeftSide
@onready var plasma_rocket_launcher_rite_side: Node3D = $MechPreview/PlasmaRocketLauncherRiteSide
@onready var rocket_launcher_right_side: Node3D = $MechPreview/RocketLauncherRightSide
@onready var rocket_launcher_left_side: Node3D = $MechPreview/RocketLauncherLeftSide
@onready var standard_torso: Node3D = $MechPreview/StandardTorso
@onready var standard_legs: Node3D = $MechPreview/StandardLegs

@onready var standard_arms: Node3D = $MechPreview/StandardArms
@onready var standard_head: Node3D = $MechPreview/StandardHead

@onready var spear_left_hand: Node3D = $MechPreview/SpearLeftHand
@onready var spear_right_hand: Node3D = $MechPreview/SpearRightHand
@onready var sub_machine_gun_left_hand: Node3D = $MechPreview/SubMachineGunLeftHand
@onready var sub_machine_gun_right_hand: Node3D = $MechPreview/SubMachineGunRightHand
@onready var sniper_rifle_left_hand: Node3D = $MechPreview/SniperRifleLeftHand
@onready var sniper_rifle_right_hand: Node3D = $MechPreview/SniperRifleRightHand
@onready var thy_kingdom_come_left_side: Node3D = $MechPreview/ThyKingdomComeLeftSide
@onready var thy_kingdom_come_right_side: Node3D = $MechPreview/ThyKingdomComeRightSide
@onready var arm_rocket_left_arm: Node3D = $MechPreview/ArmRocketLeftArm
@onready var arm_rocket_right_arm: Node3D = $MechPreview/ArmRocketRightArm

@onready var heat_sabre_left_hand: Node3D = $MechPreview/HeatSabreLeftHand
@onready var heat_sabre_right_hand: Node3D = $MechPreview/HeatSabreRightHand


@onready var parts_dictionary : Dictionary = {
	"Torso": {
		"LIGHT" : light_torso,
		"REGULAR": standard_torso, 
		"HEAVY": heavy_torso
	},
	"Arms": {
		"HEAVY": heavy_arms, 
		"LIGHT": melee_arms, 
		"REGULAR": standard_arms,
	},
	"Legs": {
		"LIGHT": light_legs, 
		"REGULAR": standard_legs, 
		"HEAVY": heavy_legs 
	},
	"Head": {
		"HEAVY": ranged_head, 
		"LIGHT": melee_head, 
		"REGULAR": standard_head
	},
	"Rifle": {
		0: {
			"Left" : plasma_rifle_left_side, 
			"Right": plasma_rifle_rightside
		},
		1: {
			"Left": sub_machine_gun_left_hand, 
			"Right": sub_machine_gun_right_hand
		},
		2: {
			"Left": sniper_rifle_left_hand, 
			"Right": sniper_rifle_right_hand			
		}
		
	},
	"Sword": {
		0: {
			"Left": sword_left_hand, 
			"Right": sword_right_hand
		},
		1: {
			"Left": heat_sabre_left_hand, 
			"Right": heat_sabre_right_hand
		},
		2: {
			"Left": spear_left_hand,
			"Right": spear_right_hand
		}
	},
	"Rocket Launcher" : {
		0: {
			"Left": rocket_launcher_left_side, 
			"Right": rocket_launcher_right_side
		},
		1: {
			"Left" : arm_rocket_left_arm, 
			"Right" : arm_rocket_right_arm
		},
		2: {
			"Left": thy_kingdom_come_left_side,
			"Right": thy_kingdom_come_right_side
		}
	}
}

func _ready() -> void:
	SignalBus.show_part.connect(show_part)
	SignalBus.show_weapon.connect(show_weapon)

func _process(delta) -> void:
	pass

func _physics_process(delta) -> void:
	mech_preview.rotation.y += 0.01


func show_part(body_part : String, category : String) -> void:
	var mech_component = parts_dictionary[body_part][category]
	if mech_component:
		mech_component.show()

func show_weapon(weapon : String, shop_index : int, hand :String) -> void:
	var selected_weapon = parts_dictionary[weapon][shop_index][hand]
	if selected_weapon:
		selected_weapon.show()

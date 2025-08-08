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


@onready var parts_dictionary : Dictionary = {
	"Torso": {
		"LIGHT" : light_torso,
		"REGULAR": standard_torso, 
		"HEAVY": heavy_torso
	},
	"Arms": {
		"Ranged": heavy_arms, 
		"Melee": melee_arms
	},
	"Legs": {
		"LIGHT": light_legs, 
		"REGULAR": standard_legs, 
		"HEAVY": heavy_legs 
	},
	"Head": {
		"Ranged": ranged_head, 
		"Melee": melee_head
	},
	"Rifle": {
		"Standard": {
			"Left" : standard_rifle_left_side, 
			"Right": standard_rifle_right_side
		},
		"Plasma" : {
			"Left": plasma_rifle_left_side, 
			"Right": plasma_rifle_rightside
		}
		
	},
	"Sword": {
		"Standard": {
			"Left": sword_left_hand, 
			"Right": sword_right_hand
		},
		"Plasma": {
			"Left": plasma_sword_left_hand, 
			"Right": plasma_sword_right_hand
		}
	},
	"Rocket Launcher" : {
		"Standard": {
			"Left": rocket_launcher_left_side, 
			"Right": rocket_launcher_right_side
		},
		"Plasma" : {
			"Left" : plasma_rocket_launcher_left_side, 
			"Right" : plasma_rocket_launcher_rite_side
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
	mech_component.show()

func show_weapon(weapon : String, category : String, hand :String) -> void:
	var selected_weapon = parts_dictionary[weapon][category][hand]
	selected_weapon.show()

class_name PartPreviewer extends Node3D

@onready var mech_preview: Node3D = $MechPreview

@onready var heavy_torso: Node3D = $MechPreview/HeavyTorso
@onready var standard_torso: Node3D = $MechPreview/StandardTorso
@onready var light_torso: Node3D = $MechPreview/LightTorso

@onready var light_arms: Node3D = $MechPreview/MeleeArms
@onready var standard_arms: Node3D = $MechPreview/StandardArms
@onready var heavy_arms: Node3D = $MechPreview/RangedArms

@onready var heavy_legs: Node3D = $MechPreview/HeavyLegs
@onready var standard_legs: Node3D = $MechPreview/StandardLegs
@onready var light_legs: Node3D = $MechPreview/LightLegs

@onready var light_head: Node3D = $MechPreview/MeleeHead
@onready var standard_head: Node3D = $MechPreview/StandardHead
@onready var heavy_head: Node3D = $MechPreview/RangedHead


@onready var plasma_rifle: Node3D = $MechPreview/PlasmaRifle
@onready var sniper_rifle: Node3D = $MechPreview/SniperRifle
@onready var sub_machine_gun: Node3D = $MechPreview/SubMachineGun

@onready var standard_sword: Node3D = $MechPreview/StandardSword
@onready var spear: Node3D = $MechPreview/Spear
@onready var heat_sabre: Node3D = $MechPreview/HeatSabre

@onready var standard_rocket_launcher: Node3D = $MechPreview/StandardRocketLauncher
@onready var thy_kingdom_come: Node3D = $MechPreview/ThyKingdomCome
@onready var arm_rocket: Node3D = $MechPreview/ArmRocket

var previously_viewed : Node3D

@onready var mech_parts: Dictionary = {
		"Torso": {
			"HEAVY": heavy_torso,
			"REGULAR": standard_torso, 
			"LIGHT": light_torso
		},
		"Arms": {
			"LIGHT": light_arms, 
			"REGULAR": standard_arms,
			"HEAVY": heavy_arms
		},
		"Legs": {
			"HEAVY": heavy_legs, 
			"REGULAR": standard_legs, 
			"LIGHT": light_legs
		}, 
		"Head": {
			"LIGHT": light_head,
			"REGULAR": standard_head,
			"HEAVY": heavy_head
		},
		"Rifle" : {
			0: sub_machine_gun, 
			1: plasma_rifle,
			2: sniper_rifle
		}, 
		"Sword": {
			0: standard_sword, 
			1: heat_sabre,
			2: spear
		},
		"Rocket Launcher": {
			0: standard_rocket_launcher, 
			1: arm_rocket,
			2: thy_kingdom_come
		}

		
		
}


func _ready() -> void:
	SignalBus.show_part_preview.connect(show_part)
	

func _physics_process(delta: float) -> void:
	mech_preview.rotation.y += 0.01



func show_part(component : MechComponent) -> void:
	
	var component_preview : Node3D
	
	var category : String = component.get_category_type()
	var component_weight_class : String = component.get_weight_class()
	var component_focus : String = component.get_weapon_focus()
	
	
	
	if category == "Weapon":
		var weapon_component = component as MechWeapon
		component_preview = mech_parts[weapon_component.get_weapon_class()][weapon_component.shop_index]
	else:
		component_preview = mech_parts[category][component_weight_class]

	if previously_viewed == null:
		previously_viewed = component_preview
		if previously_viewed:
			previously_viewed.show()
		return
		
	if previously_viewed:
		previously_viewed.hide() #hide the old one
		previously_viewed = component_preview #load the new one as previously view
		if previously_viewed:
			previously_viewed.show() #show the new one
	

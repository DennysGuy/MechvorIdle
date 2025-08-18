class_name PartPreviewer extends Node3D

@onready var mech_preview: Node3D = $MechPreview

@onready var heavy_torso: Node3D = $MechPreview/HeavyTorso
@onready var standard_torso: Node3D = $MechPreview/StandardTorso
@onready var light_torso: Node3D = $MechPreview/LightTorso
@onready var melee_arms: Node3D = $MechPreview/MeleeArms
@onready var ranged_arms: Node3D = $MechPreview/RangedArms
@onready var heavy_legs: Node3D = $MechPreview/HeavyLegs
@onready var standard_legs: Node3D = $MechPreview/StandardLegs
@onready var light_legs: Node3D = $MechPreview/LightLegs
@onready var melee_head: Node3D = $MechPreview/MeleeHead
@onready var ranged_head: Node3D = $MechPreview/RangedHead
@onready var standard_rocket_launcher: Node3D = $MechPreview/StandardRocketLauncher
@onready var plasma_rocket_launcher: Node3D = $MechPreview/PlasmaRocketLauncher
@onready var standard_sword: Node3D = $MechPreview/StandardSword
@onready var plasma_rifle: Node3D = $MechPreview/PlasmaRifle
@onready var plasma_sword: Node3D = $MechPreview/PlasmaSword
@onready var standard_rifle: Node3D = $MechPreview/StandardRifle

var previously_viewed : Node3D

@onready var mech_parts: Dictionary = {
		"Torso": {
			"HEAVY": heavy_torso,
			"REGULAR": standard_torso, 
			"LIGHT": light_torso
		},
		"Arms": {
			"Ranged": ranged_arms, 
			"Melee": melee_arms
		},
		"Legs": {
			"HEAVY": heavy_legs, 
			"REGULAR": standard_legs, 
			"LIGHT": light_legs
		}, 
		"Head": {
			"Ranged": ranged_head, 
			"Melee": melee_head
		},
		"Rifle" : {
			"Standard": standard_rifle, 
			"Plasma": plasma_rifle
		}, 
		"Sword": {
			"Standard": standard_sword, 
			"Plasma": plasma_sword
		},
		"Rocket Launcher": {
			"Standard": standard_rocket_launcher, 
			"Plasma": plasma_rocket_launcher
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
	
	if category == "Torso" or category == "Legs":
		component_preview = mech_parts[category][component_weight_class]
	
	if category == "Arms" or category == "Head":
		component_preview = mech_parts[category][component_focus]
	
	if category == "Weapon":
		var weapon_component = component as MechWeapon
		component_preview = mech_parts[weapon_component.get_weapon_class()][weapon_component.get_weapon_type()]
	

	if previously_viewed == null:
		previously_viewed = component_preview
		previously_viewed.show()
		return
	
	previously_viewed.hide() #hide the old one
	previously_viewed = component_preview #load the new one as previously view
	previously_viewed.show() #show the new one
	

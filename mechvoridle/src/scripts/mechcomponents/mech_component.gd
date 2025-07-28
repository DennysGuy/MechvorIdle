class_name MechComponent extends Resource

@export_group("Descriptors")
@export var component_name : String
@export var icon : Texture2D
@export_multiline var description : String

@export_group("Bonus Stats")
@export var health : int
@export var plasma_resistance : float

@export_group("Resources Costs")
@export var refined_ferrite_cost : int
@export var plasma_cost : int
@export var platinum_cost : int #might just make the ferrite bars and plasma the only resources need but maybe some require plat

@export_group("Category")
@export_enum("Head", "Torso", "Legs", "Arms", "Weapon") var category : int
enum CATEGORY{HEAD, TORSO, LEGS, ARMS, WEAPON}

@export_enum("NA","Ranged", "Melee") var component_type : int
enum COMPONENT_TYPE {NA, RANGED, MELEE}

@export_enum("Heavy", "Standard", "Light") var weight_class : int
enum WEIGHT_CLASS{HEAVY, STANDARD, LIGHT}

func get_category_type() -> String:
	match(category):
		CATEGORY.HEAD:
			return "Head"
		CATEGORY.TORSO:
			return "Torso"
		CATEGORY.LEGS:
			return "Legs"
		CATEGORY.ARMS:
			return "Arms"
		CATEGORY.WEAPON:
			return "Weapon"
		_:
			return ""


func is_ranged_type() -> bool:
	return component_type == COMPONENT_TYPE.RANGED

func is_melee_type() -> bool:
	return component_type == COMPONENT_TYPE.MELEE

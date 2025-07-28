class_name OpponentMech extends Resource

@export_group("Details")
@export var mech_name : String

@export_group("Total Stats")
@export var total_health : int
@export var current_health : int
@export var total_crit_chance  : int
@export var total_stun_chance : int
@export var total_plasma_resistance : float

@export_group("Components")
@export var opponent_mech_components: Dictionary[String, MechComponent] = {
	"Head" : null,
	"Torso" : null,
	"Legs" : null,
	"Arms" : null,
	"LeftWeapon" : null,
	"RightWeapon" : null,
}

@export_group("Recon Tips")
@export_multiline var tip_1 : String
@export_multiline var tip_2 : String
@export_multiline var tip_3 : String

var recon_tips : Dictionary[int, String] = {
	0: tip_1,
	1: tip_2,
	2: tip_3,
}

func set_current_health(value : int) -> void:
	current_health = value

func get_total_health() -> int:
	return get_arms_component().health + get_head_component().health + get_torso_component().health + get_legs_component().health 

func set_total_plasma_resistance() -> float:
	return get_arms_component().plasma_resistance + get_head_component().plasma_resistance + get_torso_component().plasma_resistance+ get_legs_component().plasma_resistance

func get_head_component() -> MechHead:
	return opponent_mech_components["Head"]
	
func get_torso_component() -> MechTorso:
	return opponent_mech_components["Torso"]
	
func get_arms_component() -> MechArms:
	return opponent_mech_components["Arms"]

func get_legs_component() -> MechLegs:
	return opponent_mech_components["Legs"]

func get_left_weapon() -> MechWeapon:
	return opponent_mech_components["LeftWeapon"]

func get_right_weapon() -> MechWeapon:
	return opponent_mech_components["RightWeapon"]

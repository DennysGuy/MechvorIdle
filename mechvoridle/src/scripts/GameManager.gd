extends Node

var can_fight_boss : bool = false
var player_name : String = "Diabolical Bitch"
enum GAME_STATE {WON, LOST}
var current_game_state : int = -1
var fight_on : bool = false #give us time to do intro animations - if possible - will toggle off when game signals go off
var on_mining_panel : bool = false
var on_shop_panel : bool = false
var on_central_panel : bool = true
var raw_ferrite_count : int
var ferrite_bars_count : int
var platinum_count : int
var plasma_count : int
var owned_weapons_count : int
var owned_components_count : int
var chosen_opponent : OpponentMech
const MECH_PARTS_NEEDED = 6

const MIN_ARMS_FERRITE_BAR_COST = 2500
const MIN_LEGS_FERRITE_BAR_COST = 3000
const MIN_TORSO_FERRITE_BAR_COST = 4600
const MIN_HEAD_FERRITE_BAR_COST = 1800
const MIN_RIFLE_FERRITE_BAR_COST = 1200
const MIN_RIFLE_PLASMA_COST = 200
const MIN_SWORD_FERRITE_BAR_COST = 1000
const MIN_SWORD_PLASMA_COST = 600
const MIN_LAUNCHER_FERRITE_BAR_COST = 2200
const MIN_LAUNCHER_PLASMA_COST = 300

var audio_settings_Showing : bool = false


#mining panel
var ufo_attacking : bool = false

var ferrite_refinery_cost : int = 600 #test values
var plasma_generator_cost : int = 750 #test values

var drone_count : int
var refinery_stations_count : int

var can_traverse_panes : bool = true

var mining_laser_level : int = 0
var mining_laser_damage : int  = 3
var mining_laser_damage_upgrade_cost : int = 100
var mining_laser_damage_base_cost : int = 100

var mining_laser_speed : float = 1.0
var mining_laser_speed_level : int = 0
var mining_laser_speed_upgrade_interval : float = 0.3
var mining_laser_speed_base_cost : int = 100
var mining_laser_speed_cost : int = 100

var mining_laser_crit_chance_level : int = 0
var mining_laser_crit_chance : float = 0.0
var mining_laser_crit_chance_cost : int = 150
var mining_laser_crit_chance_interval : float = 0.05
var mining_laser_crit_chance_base_cost : int =  150

var platinum_gain_min : int = 2
var platinum_gain_max : int = 10

var platinum_gain_chance : float = 0.6

var total_drones_count : int = 0

const DRONES_TO_ACTIVATE_UFO : int = 3

var drones_count : int = 0
var drones_cost : int = 100
var drone_level : int = 0
var drone_base_cost : int = 100
var drone_damage : int =5

const UPGRADE_MULTIPLIER : float = 2.6

var drone_mining_speed_level : int = 0
var drone_mining_speed : float = 0.30
var drone_mining_speed_base_cost : int = 120
var drone_mining_speed_cost : int = 120
var drone_mining_speed_upgrade_interval : float = 0.1
var drone_damage_cost : int = 100
var drone_damage_base_cost : int = 150

var platinum_drone_cost : int = 100
var platinum_drone_count : int = 0
var platinum_drone_base_cost : int = 100

var platinum_drone_damage_level : int = 0
var platinum_drone_damage : int = 12
var platinum_drone_damage_cost : int = 150
var platinum_drone_damage_base_cost : int = 150

var platinum_drone_mining_speed : float = 0.15
var platinum_drone_mining_speed_cost : float = 200
var platinum_drone_mining_speed_base_cost : float = 150
var platinum_drone_mining_speed_level : int = 0
var platinum_drone_mining_speed_interval : float = 0.2


var ferrite_refinery_speed : float = 0.5
var ferrite_refinery_speed_cost : int = 100
var ferrite_refinery_speed_base_cost : int = 100
var ferrite_refinery_speed_level : int = 0
var ferrite_refinery_speed_upgrade_interval : float = 0.05

var ferrite_refinery_output_level : int = 0
var output_amount : int = 15
var output_upgrade_cost : int = 300
var output_upgrade_base_cost : int = 300

var ferrite_cost : int = 30
var ferrite_cost_platinum_cost : int = 500
var ferrite_cost_platinum_base_cost : int = 500

var plasma_generator_speed_level : int = 0
var plasma_generator_speed : float = 0.1
var plasma_generator_speed_upgrade_interval : float = 0.05
var plasma_generator_speed_cost : int = 300
var plasma_generator_speed_base_cost : int = 300

var plasma_generator_output_level : int = 0
var plasma_generator_output : int = 4
var plasma_generator_output_cost : int = 500
var plasma_generator_output_base_const : int = 500
var plasma_generator_output_upgrade_interval : int = 2

var plasma_generator_fuel_level : int = 0
var plasma_generator_fuel_consumption : int = 50
var plasma_generator_fuel_consumption_upgrade_interval : int = 5
var plasma_generator_fuel_consumption_speed : float = 0.05
var plasma_generator_fuel_cost : int = 3000
var plasma_generator_fuel_base_cost : int = 3000

#tutorial checklist

var visited_black_market : bool = false
var mining_facility_visited : bool = false
var asteroid_mined : bool = false
var plat_drone_purchased : bool = false
var mining_drone_purchased : bool = false
var recon_scout_purchased : bool = false
var upgrade_purchased : bool = false
var plasma_generator_station_purchased : bool = false
var ferrite_refinery_station_purchased : bool = false
var mech_component_purchased : bool = false
var flyby_asteroid_destroyed : bool = false
var ufo_destroyed : bool = false

enum CHECK_LIST_INDICATOR_TOGGLES
{
	VISITED_BLACK_MARKET, 
	VISITED_MINING_FACILITY,
	ASTEROID_MINED, 
	MINING_DRONE_PURCHASED, 
	PLAT_DRONE_PURCHASED, 
	RECON_SCOUT_PURCHASED,
	UPGRADE_PURCHASED,
	FERRITE_REFINERY_PURCHASED,
	PLASMA_GENERATOR_PURCHASED,
	MECH_COMPONENT_PURCHASED,
	FLYBY_ASTEROID_DESTROY,
	UFO_DESTROYED 

}

#stats page
var recon_scout_platinum_cost : int = 300
var recon_scout_platinum_base_cost : int = 300
var recon_scout_ferrite_bars_cost : int = 300
var total_health : int = 0
var current_health : int = 0
#combat
var player_stunned : bool = false
var opponent_stunned  : bool = false
var fill_bars : bool = false
const BASE_DODGE_CHANCE : float = 0.25

var opponent_option_1 : OpponentMech = preload("res://src/resources/opponenet_mechs/Boss_Option_1.tres")
var opponent_option_2 : OpponentMech = preload("res://src/resources/opponenet_mechs/Boss_Option_2.tres")
var opponent_option_3 : OpponentMech = preload("res://src/resources/opponenet_mechs/Boss_Option_3.tres")

var opponents_list : Array[OpponentMech] = [opponent_option_1, opponent_option_2, opponent_option_3]

var owned_mech_components : Dictionary[String, MechComponent] = {
	"Head" : null,
	"Torso" : null,
	"Legs" : null,
	"Arms" : null,
	"LeftWeapon" : null,
	"RightWeapon" : null
}

func get_owned_mech_head() -> MechHead:
	return owned_mech_components["Head"]

func get_owned_mech_torso() -> MechTorso:
	return owned_mech_components["Torso"]

func get_owned_mech_legs() -> MechLegs:
	return owned_mech_components["Legs"]

func get_owned_mech_arms() -> MechArms:
	return owned_mech_components["Arms"]

func get_left_weapon() -> MechWeapon:
	return owned_mech_components["LeftWeapon"]

func get_right_weapon() -> MechWeapon:
	return owned_mech_components["RightWeapon"]

func deduct_drone_count() -> void:
	drone_count -= 1
	drones_cost = drone_base_cost * pow(2, drones_count)

func increment_drone_count() -> void:
	drone_count += 1

	SignalBus.update_drone_count.emit()
	
func calculate_health() -> void:
	total_health = get_owned_mech_arms().health + get_owned_mech_head().health + get_owned_mech_legs().health + get_owned_mech_torso().health
	current_health = total_health

#shop panel
func add_mech_component(component : MechComponent) -> void: 
	var component_category : String = component.get_category_type()
	
	if component_category == "Weapon":
		if owned_mech_components["LeftWeapon"] == null:
			owned_mech_components["LeftWeapon"] = component
		else:
			owned_mech_components["RightWeapon"] = component
	else:	
		owned_mech_components[component_category] = component
	
	owned_components_count += 1
	

	print(owned_mech_components)
	print(owned_components_count)


func mech_component_slot_is_empty(category : String) -> bool:
	if category == "Weapon":
		if owned_mech_components["LeftWeapon"] == null or owned_mech_components["RightWeapon"] == null :
			return true
		else:
			return false
		
	return owned_mech_components[category] == null


func choose_mech_opponent() -> void:
	var rng_mech = opponents_list.pick_random()
	chosen_opponent = rng_mech

func reset():
	# Resources
	raw_ferrite_count = 0
	ferrite_bars_count = 0
	platinum_count = 0
	plasma_count = 0
	owned_weapons_count = 0
	owned_components_count = 0
	chosen_opponent = null
	can_traverse_panes = false
	# Mining panel
	ufo_attacking = false
	ferrite_refinery_cost = ferrite_cost_platinum_base_cost
	plasma_generator_cost = plasma_generator_fuel_base_cost

	# Mining Laser
	mining_laser_level = 1
	mining_laser_damage = 1
	mining_laser_damage_upgrade_cost = mining_laser_damage_base_cost
	mining_laser_crit_chance_level = 0
	mining_laser_crit_chance = 0.0
	mining_laser_crit_chance_cost = mining_laser_crit_chance_base_cost

	platinum_gain_min = 2
	platinum_gain_max = 10
	platinum_gain_chance = 0.6

	# Drones
	drones_count = 0
	drone_count = 0
	refinery_stations_count = 0
	drone_level = 0
	drone_damage = 5
	drone_damage_cost = drone_damage_base_cost
	drone_mining_speed_level = 0
	drone_mining_speed = 0.6
	drone_mining_speed_cost = drone_mining_speed_base_cost

	platinum_drone_count = 0
	platinum_drone_cost = platinum_drone_base_cost
	platinum_drone_damage_level = 1
	platinum_drone_damage = 10
	platinum_drone_damage_cost = platinum_drone_damage_base_cost
	platinum_drone_mining_speed_level = 0
	platinum_drone_mining_speed = 0.5
	platinum_drone_mining_speed_cost = platinum_drone_mining_speed_base_cost

	# Refinery Station
	ferrite_refinery_station_purchased = false
	ferrite_refinery_speed_level = 0
	ferrite_refinery_speed = 0.3
	ferrite_refinery_speed_cost = ferrite_refinery_speed_base_cost

	ferrite_refinery_output_level = 0
	output_amount = 4
	output_upgrade_cost = output_upgrade_base_cost

	ferrite_cost = 8
	ferrite_cost_platinum_cost = ferrite_cost_platinum_base_cost

	# Plasma Generator Station
	plasma_generator_station_purchased = false
	plasma_generator_speed_level = 0
	plasma_generator_speed = 0.1
	plasma_generator_speed_cost = plasma_generator_speed_base_cost

	plasma_generator_output_level = 0
	plasma_generator_output = 4
	plasma_generator_output_cost = plasma_generator_output_base_const

	plasma_generator_fuel_level = 0
	plasma_generator_fuel_consumption = 50
	plasma_generator_fuel_cost = plasma_generator_fuel_base_cost

	# Stats Page
	recon_scout_platinum_cost = recon_scout_platinum_base_cost
	recon_scout_ferrite_bars_cost = 600

	# Mech Stats
	total_health = 0
	current_health = 0

	# Combat
	player_stunned = false
	opponent_stunned = false
	fill_bars = false
	
	can_fight_boss = false
	can_traverse_panes = false
	# Mech Component Slots
	owned_mech_components = {
		"Head": null,
		"Torso": null,
		"Legs": null,
		"Arms": null,
		"LeftWeapon": null,
		"RightWeapon": null
	}

	

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

var mining_time_elapsed : String
var fight_time_elapsed : String

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

func _ready() -> void:
	#fight_scenario_4_test_fixture()
	pass
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
var drone_damage : int = 7

const UPGRADE_MULTIPLIER : float = 2.3

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

var ferrite_cost : int = 15
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
var mine_100_platinum : bool = false
var mining_drone_purchased : bool = false
var three_fly_by_drones_destroyed : bool = false
var plat_drone_purchased : bool = false
var upgrade_mining_drone_damage : bool = false
var upgrade_platinum_drone_speed : bool = false
var recon_scout_purchased : bool = false
var purchase_1_more_drone : bool = false
var ufo_destroyed : bool = false
var ferrite_refinery_station_purchased : bool = false
var plasma_generator_station_purchased : bool = false
var mech_component_purchased : bool = false
var mech_completed : bool = false


'''
	MISSION LIST (15/15)
	
	1. visit the shop (1/1)
	2. visit the mining facility (1/1)
	3. mine 100 patinum (100/100)
	4. purchase mining drone (1/1)
	5. destroy 3 fly by asteroids (3/3)
	6. purchase platinum drone (1/1)
	7. upgrade mining drone damage (1/1)
	8. upgrade platinum drone speed (1/1)
	9. purchase recon scout (1/1)
	10. purchase 1 more drone (1/1)
	11. destroy ufo (1/1)
	12. purchase ferrite ferinery (1/1)
	13. purchase plasma generator (1/1)
	14. purchase a mech component (1/1)
	15. complete mech! (5/5)
	-- if the player happens to be on complete mech - the completed all missions animation will appear during to fight transition animation
'''

enum CHECK_LIST_INDICATOR_TOGGLES
{
	VISITED_BLACK_MARKET, 
	VISITED_MINING_FACILITY,
	HUNDRED_PLATINUM_GAIN, 
	MINING_DRONE_PURCHASED,
	THREE_FLYBY_ASTEROIDS_DESTROYED, 
	PLAT_DRONE_PURCHASED, 
	UPGRADE_MINING_DRONE_DAMAGE,
	UPGRADE_PLATINUM_DRONE_SPEED,
	PURCHASE_1_MORE_DRONE,
	RECON_SCOUT_PURCHASED,
	UFO_DESTROYED,
	FERRITE_REFINERY_PURCHASED,
	PLASMA_GENERATOR_PURCHASED,
	MECH_COMPONENT_PURCHASED,
	COMPLETE_MECH
}

func get_mission_status(index : int) -> bool:
	
	match(index):
		CHECK_LIST_INDICATOR_TOGGLES.VISITED_BLACK_MARKET:
			return visited_black_market
		CHECK_LIST_INDICATOR_TOGGLES.VISITED_MINING_FACILITY:
			return mining_facility_visited
		CHECK_LIST_INDICATOR_TOGGLES.HUNDRED_PLATINUM_GAIN:
			return mine_100_platinum
		CHECK_LIST_INDICATOR_TOGGLES.THREE_FLYBY_ASTEROIDS_DESTROYED:
			return three_fly_by_drones_destroyed
		CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED:
			return plat_drone_purchased
		CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_MINING_DRONE_DAMAGE:
			return upgrade_mining_drone_damage
		CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PLATINUM_DRONE_SPEED:
			return upgrade_platinum_drone_speed
		CHECK_LIST_INDICATOR_TOGGLES.PURCHASE_1_MORE_DRONE:
			return purchase_1_more_drone
		CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED:
			return recon_scout_purchased
		CHECK_LIST_INDICATOR_TOGGLES.FERRITE_REFINERY_PURCHASED:
			return ferrite_refinery_station_purchased
		CHECK_LIST_INDICATOR_TOGGLES.PLASMA_GENERATOR_PURCHASED:
			return plasma_generator_station_purchased
		CHECK_LIST_INDICATOR_TOGGLES.MECH_COMPONENT_PURCHASED:
			return mech_component_purchased
		CHECK_LIST_INDICATOR_TOGGLES.COMPLETE_MECH:
			return mech_completed
		_:
			return false

func set_mission_status(index : int, value: bool) -> void:
	match(index):
		CHECK_LIST_INDICATOR_TOGGLES.VISITED_BLACK_MARKET:
			visited_black_market = value
		CHECK_LIST_INDICATOR_TOGGLES.VISITED_MINING_FACILITY:
			mining_facility_visited = value
		CHECK_LIST_INDICATOR_TOGGLES.HUNDRED_PLATINUM_GAIN:
			mine_100_platinum = value
		CHECK_LIST_INDICATOR_TOGGLES.THREE_FLYBY_ASTEROIDS_DESTROYED:
			three_fly_by_drones_destroyed = value
		CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED:
			plat_drone_purchased = value
		CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_MINING_DRONE_DAMAGE:
			upgrade_mining_drone_damage = value
		CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PLATINUM_DRONE_SPEED:
			upgrade_platinum_drone_speed = value
		CHECK_LIST_INDICATOR_TOGGLES.PURCHASE_1_MORE_DRONE:
			purchase_1_more_drone = value
		CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED:
			recon_scout_purchased = value
		CHECK_LIST_INDICATOR_TOGGLES.FERRITE_REFINERY_PURCHASED:
			ferrite_refinery_station_purchased = value
		CHECK_LIST_INDICATOR_TOGGLES.PLASMA_GENERATOR_PURCHASED:
			plasma_generator_station_purchased = value
		CHECK_LIST_INDICATOR_TOGGLES.MECH_COMPONENT_PURCHASED:
			mech_component_purchased = value
		CHECK_LIST_INDICATOR_TOGGLES.COMPLETE_MECH:
			mech_completed = value

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

#light
var opponent_option_1 : OpponentMech = preload("res://src/resources/opponenet_mechs/Boss_Option_1.tres").duplicate()
#standard
var opponent_option_2 : OpponentMech = preload("res://src/resources/opponenet_mechs/Boss_Option_2.tres").duplicate()
#heavy
var opponent_option_3 : OpponentMech = preload("res://src/resources/opponenet_mechs/Boss_Option_3.tres").duplicate()

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
	
func calculate_health() -> int:
	return get_owned_mech_arms().health + get_owned_mech_head().health + get_owned_mech_legs().health + get_owned_mech_torso().health
	

#shop panel
func add_mech_component(component : MechComponent) -> void: 
	
	var component_category : String = component.get_category_type()
	var component_weight_class : String = component.get_weight_class()
	var component_focus : String = component.get_weapon_focus()
	
	if component_category == "Torso" or component_category == "Legs":
		SignalBus.show_part.emit(component_category, component_weight_class)
	
	if component_category == "Arms" or component_category == "Head":
		SignalBus.show_part.emit(component_category, component_focus)
	
	if component_category == "Weapon":
		var weapon_component = component as MechWeapon
		var weapon_class = weapon_component.get_weapon_class()
		var weapon_type = weapon_component.get_weapon_type()
		if owned_mech_components["LeftWeapon"] == null:
			owned_mech_components["LeftWeapon"] = component
			SignalBus.show_weapon.emit(weapon_class, weapon_type, "Left")
		else:
			owned_mech_components["RightWeapon"] = component
			SignalBus.show_weapon.emit(weapon_class, weapon_type, "Right")
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

	visited_black_market  = false
	mining_facility_visited  = false
	mine_100_platinum = false
	mining_drone_purchased = false
	plat_drone_purchased  = false
	upgrade_mining_drone_damage = false
	upgrade_platinum_drone_speed  = false
	recon_scout_purchased  = false
	purchase_1_more_drone= false
	ufo_destroyed  = false
	ferrite_refinery_station_purchased = false
	plasma_generator_station_purchased = false
	mech_component_purchased = false
	mech_completed = false

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

#Test Variables



func light_build() -> void:
	owned_mech_components["Head"] = preload("res://src/resources/mechcomponents/heads/mech_head_2.tres")
	owned_mech_components["Torso"] = preload("res://src/resources/mechcomponents/torsos/mech_torso_1.tres")
	owned_mech_components["Arms"] = preload("res://src/resources/mechcomponents/arms/mech_arms_2.tres")
	owned_mech_components["Legs"] = preload("res://src/resources/mechcomponents/legs/mech_legs_2.tres")
	owned_mech_components["LeftWeapon"] = preload("res://src/resources/mechcomponents/weapons/swords/Sword-1.tres")
	owned_mech_components["RightWeapon"] = preload("res://src/resources/mechcomponents/weapons/swords/Sword-2.tres")


func standard_build() -> void:
	owned_mech_components["Head"] = preload("res://src/resources/mechcomponents/heads/mech_head_1.tres")
	owned_mech_components["Torso"] = preload("res://src/resources/mechcomponents/torsos/mech_torso_3.tres")
	owned_mech_components["Arms"] = preload("res://src/resources/mechcomponents/arms/mech_arms_1.tres")
	owned_mech_components["Legs"] = preload("res://src/resources/mechcomponents/legs/mech_legs_3.tres")
	owned_mech_components["LeftWeapon"] = preload("res://src/resources/mechcomponents/weapons/swords/Sword-1.tres")
	owned_mech_components["RightWeapon"] = preload("res://src/resources/mechcomponents/weapons/rifles/Rifle_1.tres")
	

func heavy_build() -> void:
	owned_mech_components["Head"] = preload("res://src/resources/mechcomponents/heads/mech_head_1.tres")
	owned_mech_components["Torso"] = preload("res://src/resources/mechcomponents/torsos/mech_torso_2.tres")
	owned_mech_components["Arms"] = preload("res://src/resources/mechcomponents/arms/mech_arms_1.tres")
	owned_mech_components["Legs"] = preload("res://src/resources/mechcomponents/legs/mech_legs_1.tres")
	owned_mech_components["LeftWeapon"] = preload("res://src/resources/mechcomponents/weapons/rocketlaunchers/Launcher-1.tres")
	owned_mech_components["RightWeapon"] = preload("res://src/resources/mechcomponents/weapons/rocketlaunchers/Launcher-2.tres")

#light - proper melee build vs heavy boss

'''
	We should see that the light build counters 
	the heavy boss with fast output damage, 
	high accuracy rate, high dodge rate
'''


func fight_scenario_1_test_fixture() -> void:
	light_build()
	chosen_opponent = opponent_option_3

#standard - proper ranged build vs melee boss
'''
	The standard player build boasts a sword and rifle
	beat light melee build as light melee build has less armor and has difficult 
	with decent accuracy from standard build 
'''

func fight_scenario_2_test_fixture() -> void:
	light_build()
	chosen_opponent = opponent_option_3.duplicate(true)

#heavy - proper ranged build vs light boss
'''
	This scenerio tests a player build that is weak against the boss
	The player should struggle a bit more to beat this boss
'''
func fight_scenario_3_test_fixture() -> void:
	heavy_build()
	
	chosen_opponent = opponent_option_1.duplicate(true)


#light mech - vs - standard 
'''
	The light build should struggle a bit against the standard build boss as 
	the standard build does well with both guns and swords with decent accuracy, 
	decent charge speed, and decent damage
'''

func fight_scenario_4_test_fixture() -> void:
	light_build()
	chosen_opponent = opponent_option_2.duplicate(true)
#Heavy Mech - proper build vs standard build
'''
	The heavy mech build vs the standard build - should be able to take down 
	standard build as even though they have decent all around speeds, 
	they will be hit more often than light builds - hence they get taken down easier
'''

func fight_scenario_5_test_fixture() -> void:
	heavy_build()
	chosen_opponent = opponent_option_2.duplicate(true)


#Light build vs Light build

'''
	testing light vs light - should be an even match

'''

func fight_scenario_6_test_fixture() -> void:
	light_build()
	chosen_opponent = opponent_option_1.duplicate(true)

#Standard vs Standard

'''
	testing standard vs standard - should be an even match
'''

func fight_scenario_7_test_fixture() -> void:
	standard_build()
	chosen_opponent = opponent_option_2.duplicate(true)

#Heavy vs Heavy
'''
	testing heavy vs heavy - should be an even match

'''

func fight_scenario_8_test_fixture() -> void:
	heavy_build()
	chosen_opponent = opponent_option_3.duplicate(true)

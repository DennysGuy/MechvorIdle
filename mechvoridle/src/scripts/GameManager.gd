extends Node

var can_fight_boss : bool = true

var raw_ferrite_count : int
var ferrite_bars_count : int
var platinum_count : int

#mining panel
var ufo_attacking : bool = false

var ferrite_refinery_cost : int = 1500
var plasma_generator_cost : int = 2000

var drone_count : int
var refinery_stations_count : int

var mining_laser_level : int = 1
var mining_laser_damage : int  = 1
var mining_laser_damage_upgrade_cost : int = 100
var mining_laser_damage_base_cost : int = 100


var mining_laser_crit_chance_level : int = 1
var mining_laser_crit_chance : float = 0.0
var mining_laser_crit_chance_cost : int = 150
var mining_laser_crit_chance_interval : float = 0.05
var mining_laser_crit_chance_base_cost : int =  150

var platinum_gain_min : int = 2
var platinum_gain_max : int = 10

var platinum_gain_chance : float = 0.6

var drones_count : int = 0
var drones_cost : int = 50
var drone_level : int = 1
var drone_base_cost : int = 200
var drone_damage : int = 1
var drone_mining_speed : float = 0.3
var drone_damage_cost : int = 100
var drone_damage_base_cost : int = 150

var ferrite_refinery_station_purchased = false

var ferrite_refinery_speed : float = 0.0
var ferrite_refinery_speed_cost : int = 100
var output_amount : int = 1 
var output_upgrade_cost : int = 250
var ferrite_cost : int = 8
var ferrite_cost_platinum_cost : int = 500

var plasma_generator_station_purchased = false

var plasma_generator_speed : float = 0.0
var plasma_generator_speed_cost : int = 200
var plasma_generator_output : int = 0
var plasma_generator_output_cost : int = 500
var plasma_generator_fuel_consumption : int = 8
var plasma_generator_fuel_cost : int = 700

#stats page
var recon_scout_platinum_cost : int = 1500
var recon_scout_ferrite_bars_cost : int = 100

#mech stats
var total_health : int = 0

var owned_mech_components : Dictionary = {
	"Head" : null,
	"Torso" : null,
	"Legs" : null,
	"Arms" : null,
	"LeftWeapon" : null,
	"RightWeapon" : null
}

#shop panel

func calculate_total_damage() -> void:
	pass

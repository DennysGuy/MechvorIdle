extends Node

var can_fight_boss : bool = true

var raw_ferrite_count : int
var ferrite_bars_count : int
var platinum_count : int

#mining panel
var ufo_attacking : bool = false

var drone_count : int
var refinery_stations_count : int

var mining_laser_damage : int  = 1
var mining_laser_damage_upgrade_cost : int = 100
var mining_laser_crit_chance : float
var mining_laser_crit_chance_cost : int

var drones_count : int = 0
var drones_cost : int = 100
var drone_damage : int = 1
var drone_damage_cost : int = 100

var ferrite_refinery_count : int = 0
var ferrite_refinery_cost : int = 100
var efficiency_bonus : int = 1 #on a per station basis
var efficiency_upgrade_cost : int = 100

#stats page
var recon_scout_cost : int = 1000

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

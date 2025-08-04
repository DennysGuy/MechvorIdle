extends Node

signal mining_drone_cost_changed(new_cost, new_count)
signal platinum_drone_cost_changed(new_cost, new_count)

var drones: Array = []

var mining_drones: Array[MiningDrone] = []
var platinum_drones: Array[PlatinumMiningDrone] = []

var mining_drone_base_cost: int = 100
var platinum_drone_base_cost: int = 100

# === GETTERS ===

func get_mining_drone_count() -> int:
	return mining_drones.size()

func get_platinum_drone_count() -> int:
	return platinum_drones.size()

func get_total_drone_count() -> int:
	return drones.size()

func get_mining_drone_cost() -> int:
	return mining_drone_base_cost * pow(2, get_mining_drone_count())

func get_platinum_drone_cost() -> int:
	return platinum_drone_base_cost * pow(2, get_platinum_drone_count())

# === REGISTRATION ===

func register_mining_drone(drone: Node) -> void:
	if drone not in drones:
		drones.append(drone)
		mining_drones.append(drone)
		update_mining_drone_cost()

func unregister_mining_drone(drone: Node) -> void:
	if drone in drones:
		drones.erase(drone)
		mining_drones.erase(drone)
		update_mining_drone_cost()

func register_platinum_drone(drone: Node) -> void:
	if drone not in drones:
		drones.append(drone)
		platinum_drones.append(drone)
		update_platinum_drone_cost()

func unregister_platinum_drone(drone: Node) -> void:
	if drone in drones:
		drones.erase(drone)
		platinum_drones.erase(drone)
		update_platinum_drone_cost()

# === COST UPDATERS ===

func update_mining_drone_cost() -> void:
	
	var new_cost = get_mining_drone_cost()
	var new_count = get_mining_drone_count()
	emit_signal("mining_drone_cost_changed", new_cost, new_count)
	print("Mining Drone count: %d | New cost: %d" % [get_mining_drone_count(), new_cost])

func update_platinum_drone_cost() -> void:
	var new_cost = get_platinum_drone_cost()
	var new_count = get_platinum_drone_count()
	emit_signal("platinum_drone_cost_changed", new_cost, new_count)
	print("Platinum Drone count: %d | New cost: %d" % [get_platinum_drone_count(), new_cost])

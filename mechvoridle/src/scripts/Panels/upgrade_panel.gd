class_name UpgradePanel extends ColorRect



#mining laser stuff
@onready var current_damage_tracker : Label = $CurrentDamageTracker
@onready var current_damage_cost : Label = $CurrentDamageCost
@onready var current_crit_chance_tracker : Label = $CurrentCritChanceTracker
@onready var current_crit_chance_cost : Label = $CurrentCritChanceCost
@onready var upgrades_access : Button = $UpgradesAccess
@onready var upgrade_damage : Button = $UpgradeDamage
@onready var upgrade_crit_chance : Button = $UpgradeCritChance


#drones stuff
@onready var drones_count_tracker_label : Label = $DronesCountTrackerLabel
@onready var drones_cost : Label = $DronesCost
@onready var drone_damage : Label = $DroneDamage
@onready var drone_damage_cost : Label = $DroneDamageCost
@onready var purchase_drone : Button = $PurchaseDrone
@onready var upgrade_drone_damage : Button = $UpgradeDroneDamage
@onready var drone_speed: Label = $DroneSpeed
@onready var drone_mining_speed_cost: Label = $DroneMiningSpeedCost
@onready var upgrade_drone_mining_speed: Button = $UpgradeDroneMiningSpeed



#refinery stuff
@onready var ferrite_refinery_speed = $FerriteRefinerySpeed
@onready var ferrite_refinery_speed_cost = $FerriteRefinerySpeedCost
@onready var efficiency_bonus :Label = $EfficiencyBonus
@onready var efficiency_bonus_cost : Label = $EfficiencyBonusCost
@onready var current_ferrite_cost : Label = $CurrentFerriteCost
@onready var ferrite_cost_plat_cost : Label = $FerriteCostPlatCost
@onready var upgrade_refinery_speed : Button = $UpgradeRefinerySpeed
@onready var upgrade_efficiency : Button = $UpgradeEfficiency
@onready var upgrade_ferrite_cost : Button = $UpgradeFerriteCost

#plasma generator stuff
@onready var generator_output : Label = $GeneratorOutput
@onready var output_cost : Label = $OutputCost
@onready var fuel_cost : Label = $FuelCost
@onready var fuel_platinum_cost : Label = $FuelPlatinumCost
@onready var plasma_generator_speed_upgrade : Button = $PlasmaGeneratorSpeedUpgrade
@onready var generator_output_upgrade : Button = $GeneratorOutputUpgrade
@onready var upgrade_fuel_cost : Button = $UpgradeFuelCost

var upgrade_panel_showing : bool = false

func _ready() -> void:
	current_damage_tracker.text = str(GameManager.mining_laser_damage)
	current_damage_cost.text = str(GameManager.mining_laser_damage_upgrade_cost)
	current_crit_chance_tracker.text = str(GameManager.mining_laser_crit_chance)
	current_crit_chance_cost.text = str(GameManager.mining_laser_crit_chance_cost)

	drones_count_tracker_label.text = str(GameManager.drones_count)
	drones_cost.text = str(GameManager.drones_cost)
	drone_damage.text = str(GameManager.drone_damage)
	drone_damage_cost.text = str(GameManager.drone_damage_cost)
	drone_speed.text = str(GameManager.drone_mining_speed * 100) + "%"
	drone_mining_speed_cost.text = str(GameManager.drone_mining_speed_cost)
	
	efficiency_bonus.text = str(GameManager.output_amount)
	efficiency_bonus_cost.text = str(GameManager.output_upgrade_cost)

func _process(delta: float) -> void:
	upgrade_damage.disabled = GameManager.platinum_count < GameManager.mining_laser_damage_upgrade_cost
	upgrade_crit_chance.disabled = GameManager.platinum_count < GameManager.mining_laser_crit_chance_cost
	purchase_drone.disabled = GameManager.platinum_count < GameManager.drones_cost
	if GameManager.drone_count > 0:
		upgrade_drone_damage.disabled = GameManager.platinum_count < GameManager.drone_damage_cost
		upgrade_drone_mining_speed.disabled = GameManager.platinum_count < GameManager.drone_mining_speed_cost
	else:
		upgrade_drone_damage.disabled = true
		upgrade_drone_mining_speed.disabled = true
	
	if GameManager.ferrite_refinery_station_purchased:
		upgrade_refinery_speed.disabled = GameManager.platinum_count < GameManager.ferrite_refinery_speed_cost
		upgrade_efficiency.disabled = GameManager.platinum_count < GameManager.output_upgrade_cost
	else:
		upgrade_refinery_speed.disabled = true
		upgrade_efficiency.disabled = true

	
	if GameManager.plasma_generator_station_purchased:
		upgrade_fuel_cost.disabled = GameManager.platinum_count < GameManager.plasma_generator_fuel_cost
		plasma_generator_speed_upgrade.disabled = GameManager.platinum_count < GameManager.plasma_generator_speed_cost
		generator_output_upgrade.disabled = GameManager.platinum_count < GameManager.plasma_generator_output_cost
	else:
		upgrade_fuel_cost.disabled = true
		plasma_generator_speed_upgrade.disabled = true
		generator_output_upgrade.disabled = true

	
	
func _on_upgrades_access_button_down():
	upgrade_panel_showing = !upgrade_panel_showing
	
	if upgrade_panel_showing:
		SignalBus.show_upgrade_panel.emit()
	else:
		SignalBus.hide_upgrade_panel.emit()

func _on_upgrade_damage_button_down():
	upgrade_mining_laser()
	current_damage_tracker.text = str(GameManager.mining_laser_damage)
	current_damage_cost.text = str(GameManager.mining_laser_damage_upgrade_cost)
	SignalBus.update_platinum_count.emit()

func _on_upgrade_crit_chance_button_down():
	upgrade_mining_critical_chance()
	current_crit_chance_tracker.text = str(GameManager.mining_laser_crit_chance * 100)+"%"
	current_crit_chance_cost.text = str(GameManager.mining_laser_crit_chance_cost)
	SignalBus.update_platinum_count.emit()

func _on_upgrade_drone_damage_button_down():
	upgrade_drones_damage()
	drone_damage.text = str(GameManager.drone_damage)
	drone_damage_cost.text = str(GameManager.drone_damage_cost)
	SignalBus.update_platinum_count.emit()

func _on_purchase_refinery_button_down():
	pass # Replace with function body.

func _on_upgrade_efficiency_button_down():
	pass # Replace with function body.

func _on_generator_output_upgrade_button_down():
	pass # Replace with function body.

func _on_upgrade_fuel_cost_button_down():
	pass # Replace with function body.

func _on_plasma_generator_speed_upgrade_button_down():
	pass # Replace with function body.

func _on_upgrade_ferrite_cost_button_down():
	pass # Replace with function body.

func _on_upgrade_refinery_speed_button_down():
	pass # Replace with function body.

func _on_hide_upgrades_panel_button_down():
	upgrade_panel_showing = false
	SignalBus.hide_upgrade_panel.emit()


func _on_purchase_ferrite_refinery_button_down():
	pass # Replace with function body.


func _on_purchase_plasma_generator_button_down():
	pass # Replace with function body.


func _on_purchase_drone_button_down():
	purchased_drone()
	SignalBus.add_drone.emit()
	drones_count_tracker_label.text = str(GameManager.drone_count)
	drones_cost.text = str(GameManager.drones_cost)
	SignalBus.update_platinum_count.emit()

func upgrade_mining_laser() -> void:
	GameManager.platinum_count -= GameManager.mining_laser_damage_upgrade_cost
	GameManager.mining_laser_level += 1
	GameManager.mining_laser_damage = GameManager.mining_laser_damage + GameManager.mining_laser_level * 2
	GameManager.mining_laser_damage_upgrade_cost = GameManager.mining_laser_damage_base_cost * pow(2, GameManager.mining_laser_level)
	GameManager.platinum_gain_min += 3
	GameManager.platinum_gain_max += 3
	
func upgrade_mining_critical_chance() -> void:
	GameManager.platinum_count -= GameManager.mining_laser_crit_chance_cost
	GameManager.mining_laser_crit_chance_level += 1
	GameManager.mining_laser_crit_chance += GameManager.mining_laser_crit_chance_interval
	GameManager.mining_laser_crit_chance_cost = GameManager.mining_laser_crit_chance_base_cost * pow(2, GameManager.mining_laser_crit_chance_level)

func purchased_drone() -> void:
	GameManager.platinum_count -= GameManager.drones_cost
	GameManager.drone_count += 1
	GameManager.drones_cost = GameManager.drone_base_cost * pow(2, GameManager.drone_count)

func upgrade_drones_damage() -> void:
	GameManager.platinum_count -= GameManager.drone_damage_cost
	GameManager.drone_level += 1
	GameManager.drone_damage = GameManager.drone_damage + GameManager.mining_laser_level * 2
	GameManager.drone_damage_cost = GameManager.drone_damage_base_cost * pow(2, GameManager.drone_level)


func _on_upgrade_drone_mining_speed_button_down() -> void:
	GameManager.platinum_count -= GameManager.drone_mining_speed_cost
	GameManager.drone_mining_speed_level += 1
	GameManager.drone_mining_speed += GameManager.drone_mining_speed_upgrade_interval
	GameManager.drone_mining_speed_cost = GameManager.drone_mining_speed_base_cost * pow(2, GameManager.drone_mining_speed_level)
	drone_speed.text = str(GameManager.drone_mining_speed * 100) + "%"
	drone_mining_speed_cost.text = str(GameManager.drone_mining_speed_cost)

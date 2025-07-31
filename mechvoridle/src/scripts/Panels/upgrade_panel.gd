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

#plat drones stuff

@onready var platinum_drones_cost: Label = $PlatinumDronesCost
@onready var purchase_platinum_drone: Button = $PurchasePlatinumDrone
@onready var platinum_drones_count: Label = $PlatinumDronesCount

@onready var plat_drone_damage: Label = $PlatDroneDamage
@onready var plat_drone_damage_cost: Label = $PlatDroneDamageCost
@onready var upgrade_plat_drone_damage: Button = $UpgradePlatDroneDamage

@onready var plat_drone_speed: Label = $PlatDroneSpeed
@onready var plat_drone_speed_cost: Label = $PlatDroneSpeedCost
@onready var upgrade_platinum_drone_mining_speed: Button = $UpgradePlatinumDroneMiningSpeed



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
@onready var auto_speed_plat_cost: Label = $AutoSpeedPlatCost
@onready var generator_auto_speed: Label = $GeneratorAutoSpeed

var upgrade_panel_showing : bool = false

#sfx
@onready var sfx_player : AudioStreamPlayer = $SfxPlayer


var open_upgrades_panel_sfx : AudioStream = SfxManager.UI_MINING_UPGRADE_MENU_OPEN_01
var close_upgrades_panel_sfx : AudioStream = SfxManager.UI_MINING_UPGRADE_MENU_CLOSE_01

var purchase_upgrade_sfx : Array[AudioStream] = [SfxManager.UI_SHOP_BUY_COMPLETE_01, SfxManager.UI_SHOP_BUY_COMPLETE_02, SfxManager.UI_SHOP_BUY_COMPLETE_03]

func _ready() -> void:
	SignalBus.update_drone_cost.connect(update_drone_cost)
	SignalBus.update_drone_count.connect(update_drone_count)
	SignalBus.update_platinum_drone_cost.connect(update_platinum_drone_cost)
	SignalBus.update_platinum_drone_count.connect(update_platinum_drone_count)
	
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
	
	platinum_drones_count.text = str(GameManager.platinum_drone_count)
	platinum_drones_cost.text = str(GameManager.platinum_drone_cost)
	plat_drone_damage.text = str(GameManager.platinum_drone_damage)
	plat_drone_damage_cost.text = str(GameManager.platinum_drone_damage_cost)
	plat_drone_speed.text = str(GameManager.platinum_drone_mining_speed * 100) + "%"
	plat_drone_speed_cost.text = str(GameManager.platinum_drone_mining_speed_cost)
	
	ferrite_refinery_speed.text = str(GameManager.ferrite_refinery_speed * 100) + "%"
	
	#plasma generator
	generator_auto_speed.text = str(GameManager.plasma_generator_speed * 100) + "%"
	auto_speed_plat_cost.text = str(GameManager.plasma_generator_speed_cost)
	output_cost.text = str(GameManager.plasma_generator_output_cost)
	generator_output.text = str(GameManager.plasma_generator_output)
	
	fuel_cost.text = str(GameManager.plasma_generator_fuel_consumption)
	fuel_platinum_cost.text = str(GameManager.plasma_generator_fuel_cost)
	
	
	efficiency_bonus.text = str(GameManager.output_amount)
	efficiency_bonus_cost.text = str(GameManager.output_upgrade_cost)

func _process(delta: float) -> void:
	upgrade_damage.disabled = GameManager.platinum_count < GameManager.mining_laser_damage_upgrade_cost
	upgrade_crit_chance.disabled = GameManager.platinum_count < GameManager.mining_laser_crit_chance_cost
	purchase_drone.disabled = GameManager.platinum_count < GameManager.drones_cost
	purchase_platinum_drone.disabled = GameManager.platinum_count < GameManager.platinum_drone_cost
	

	#platinum_drones_count.text = str(GameManager.platinum_drone_count)
	
	if GameManager.drones_count > 0:
		upgrade_drone_damage.disabled = GameManager.platinum_count < GameManager.drone_damage_cost
		upgrade_drone_mining_speed.disabled = GameManager.platinum_count < GameManager.drone_mining_speed_cost
	else:
		upgrade_drone_damage.disabled = true
		upgrade_drone_mining_speed.disabled = true
		
	if GameManager.platinum_drone_count > 0:
		upgrade_plat_drone_damage.disabled = GameManager.platinum_count < GameManager.platinum_drone_damage_cost
		upgrade_platinum_drone_mining_speed.disabled = GameManager.platinum_count < GameManager.drone_mining_speed_cost
	else:
		upgrade_plat_drone_damage.disabled = true
		upgrade_platinum_drone_mining_speed.disabled = true
	
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
		open_upgrades_panel()
		SignalBus.show_upgrade_panel.emit()
	else:
		close_upgrades_panel()
		SignalBus.hide_upgrade_panel.emit()

func _on_upgrade_damage_button_down():
	play_purchase_upgrade_sfx()
	upgrade_mining_laser()
	current_damage_tracker.text = str(GameManager.mining_laser_damage)
	current_damage_cost.text = str(GameManager.mining_laser_damage_upgrade_cost)
	SignalBus.update_platinum_count.emit()

func _on_upgrade_crit_chance_button_down():
	play_purchase_upgrade_sfx()
	upgrade_mining_critical_chance()
	current_crit_chance_tracker.text = str(GameManager.mining_laser_crit_chance * 100)+"%"
	current_crit_chance_cost.text = str(GameManager.mining_laser_crit_chance_cost)
	SignalBus.update_platinum_count.emit()

func _on_upgrade_drone_damage_button_down():
	play_purchase_upgrade_sfx()
	upgrade_drones_damage()
	drone_damage.text = str(GameManager.drone_damage)
	drone_damage_cost.text = str(GameManager.drone_damage_cost)
	SignalBus.update_platinum_count.emit()


func _on_upgrade_efficiency_button_down():
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.output_upgrade_cost
	GameManager.ferrite_refinery_output_level += 1
	GameManager.output_amount *= 2
	GameManager.ferrite_cost  *= 2
	GameManager.output_upgrade_cost = GameManager.output_upgrade_base_cost * pow(2, GameManager.ferrite_refinery_output_level)
	
	efficiency_bonus_cost.text = str(GameManager.output_upgrade_cost)
	efficiency_bonus.text = str(GameManager.output_amount)
	

func _on_generator_output_upgrade_button_down():
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.plasma_generator_output_cost
	GameManager.plasma_generator_output *= GameManager.plasma_generator_output_upgrade_interval
	GameManager.plasma_generator_output_level += 1
	GameManager.plasma_generator_output_cost = GameManager.plasma_generator_output_base_const * pow(2, GameManager.plasma_generator_output_level)
	generator_output.text = str(GameManager.plasma_generator_output)
	output_cost.text = str(GameManager.plasma_generator_output_cost)
	SignalBus.update_plasma_generator_output.emit()

func _on_upgrade_fuel_cost_button_down():
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.plasma_generator_fuel_cost
	GameManager.plasma_generator_fuel_consumption -= GameManager.plasma_generator_fuel_consumption_upgrade_interval
	GameManager.plasma_generator_fuel_level += 1
	GameManager.plasma_generator_fuel_cost = GameManager.plasma_generator_fuel_base_cost * pow(2, GameManager.plasma_generator_fuel_level)
	fuel_cost.text = str(GameManager.plasma_generator_fuel_consumption)
	fuel_platinum_cost.text = str(GameManager.plasma_generator_fuel_cost)
	SignalBus.update_fuel_consumption.emit()
	
func _on_plasma_generator_speed_upgrade_button_down():
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.plasma_generator_speed_cost
	GameManager.plasma_generator_speed += GameManager.plasma_generator_speed_upgrade_interval
	GameManager.plasma_generator_speed_level += 1
	GameManager.plasma_generator_fuel_cost = GameManager.plasma_generator_speed_base_cost * pow(2, GameManager.plasma_generator_speed_level)
	auto_speed_plat_cost.text = str(GameManager.plasma_generator_speed_cost)
	generator_auto_speed.text = str(GameManager.plasma_generator_speed * 100) + "%"
	SignalBus.update_plasma_generator_speed.emit()
	
	
func _on_hide_upgrades_panel_button_down():
	close_upgrades_panel()
	upgrade_panel_showing = false
	SignalBus.hide_upgrade_panel.emit()


func _on_purchase_drone_button_down():
	play_purchase_upgrade_sfx()
	purchased_drone()
	SignalBus.add_drone.emit()
	print(GameManager.drone_count)
	#GameManager.drone_count +=1
	#drones_count_tracker_label.text = str(GameManager.drone_count)
	drones_cost.text = str(GameManager.drones_cost)
	SignalBus.update_platinum_count.emit()

func upgrade_mining_laser() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.mining_laser_damage_upgrade_cost
	GameManager.mining_laser_level += 1
	GameManager.mining_laser_damage = GameManager.mining_laser_damage + GameManager.mining_laser_level * 2
	GameManager.mining_laser_damage_upgrade_cost = GameManager.mining_laser_damage_base_cost * pow(2, GameManager.mining_laser_level)
	GameManager.platinum_gain_min += 3
	GameManager.platinum_gain_max += 3
	
func upgrade_mining_critical_chance() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.mining_laser_crit_chance_cost
	GameManager.mining_laser_crit_chance_level += 1
	GameManager.mining_laser_crit_chance += GameManager.mining_laser_crit_chance_interval
	GameManager.mining_laser_crit_chance_cost = GameManager.mining_laser_crit_chance_base_cost * pow(2, GameManager.mining_laser_crit_chance_level)

func purchased_drone() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.drones_cost
	GameManager.drones_count += 1
	GameManager.total_drones_count += 1
	update_drone_count()
	GameManager.drones_cost = GameManager.drone_base_cost * pow(2, GameManager.drones_count)
	SignalBus.check_to_start_ufo_spawn.emit()
	
	print("Drone Count after purchase: " + str(GameManager.drone_count))

func upgrade_drones_damage() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.drone_damage_cost
	GameManager.drone_level += 1
	GameManager.drone_damage = GameManager.drone_damage + GameManager.drone_level * 2
	GameManager.drone_damage_cost = GameManager.drone_damage_base_cost * pow(2, GameManager.drone_level)


func _on_upgrade_drone_mining_speed_button_down() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.drone_mining_speed_cost
	GameManager.drone_mining_speed_level += 1
	GameManager.drone_mining_speed += GameManager.drone_mining_speed_upgrade_interval
	GameManager.drone_mining_speed_cost = GameManager.drone_mining_speed_base_cost * pow(2, GameManager.drone_mining_speed_level)
	drone_speed.text = str(GameManager.drone_mining_speed * 100) + "%"
	drone_mining_speed_cost.text = str(GameManager.drone_mining_speed_cost)


func _on_purchase_platinum_drone_button_down() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.platinum_drone_cost
	GameManager.platinum_drone_count += 1
	GameManager.total_drones_count += 1
	GameManager.platinum_drone_cost = GameManager.platinum_drone_cost * pow(2, GameManager.platinum_drone_count)
	platinum_drones_count.text = str(GameManager.platinum_drone_count)
	platinum_drones_cost.text = str(GameManager.platinum_drone_cost)
	SignalBus.add_platinum_drone.emit()
	SignalBus.check_to_start_ufo_spawn.emit()

func _on_upgrade_plat_drone_damage_button_down() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.platinum_drone_damage_cost
	GameManager.platinum_drone_damage_level += 1
	GameManager.platinum_drone_damage = GameManager.platinum_drone_damage + GameManager.platinum_drone_damage_level * 2
	GameManager.platinum_drone_damage_cost = GameManager.platinum_drone_damage_base_cost * pow(2, GameManager.platinum_drone_damage_level)
	plat_drone_damage.text = str(GameManager.platinum_drone_damage)
	plat_drone_damage_cost.text = str(GameManager.platinum_drone_damage_cost)

func _on_upgrade_platinum_drone_mining_speed_button_down() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.platinum_drone_mining_speed_cost
	GameManager.platinum_drone_mining_speed_level += 1
	GameManager.platinum_drone_mining_speed += GameManager.platinum_drone_mining_speed_interval
	GameManager.platinum_drone_mining_speed_cost = GameManager.platinum_drone_mining_speed_base_cost * pow(2, GameManager.drone_mining_speed_level)
	plat_drone_speed.text = str(GameManager.platinum_drone_mining_speed * 100) + "%"
	plat_drone_speed_cost.text = str(GameManager.platinum_drone_mining_speed_cost)

func _on_upgrade_refinery_speed_button_down() -> void:
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.ferrite_refinery_speed_cost
	GameManager.ferrite_refinery_speed_level += 1
	GameManager.ferrite_refinery_speed += GameManager.ferrite_refinery_speed_upgrade_interval
	GameManager.ferrite_refinery_speed_cost = GameManager.ferrite_refinery_speed_base_cost * pow(2, GameManager.ferrite_refinery_speed_level)
	ferrite_refinery_speed.text = str(GameManager.ferrite_refinery_speed * 100) +"%"
	ferrite_refinery_speed_cost.text = str(GameManager.ferrite_refinery_speed_cost)

func update_drone_count() -> void:
	drones_count_tracker_label.text = str(GameManager.drones_count)
	#print("AfterDeath: " + str(GameManager.drones_count))
	
func update_drone_cost() -> void:
	drones_cost.text = str(GameManager.drones_cost)

func update_platinum_drone_count() -> void:
	platinum_drones_count.text = str(GameManager.platinum_drone_count)

func update_platinum_drone_cost() -> void:
	platinum_drones_cost.text = str(GameManager.platinum_drone_cost)


func open_upgrades_panel() -> void:
	sfx_player.volume_db = -5.0
	sfx_player.stream = open_upgrades_panel_sfx
	sfx_player.play()

func close_upgrades_panel() -> void:
	sfx_player.volume_db = -5.0
	sfx_player.stream = close_upgrades_panel_sfx
	sfx_player.play()

func play_purchase_upgrade_sfx() -> void:
	sfx_player.volume_db = 0
	sfx_player.stream = purchase_upgrade_sfx.pick_random()
	sfx_player.play()

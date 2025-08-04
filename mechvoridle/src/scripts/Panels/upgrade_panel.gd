class_name UpgradePanel extends TextureRect



@export var asteroid_area : AsteroidArea
#mining laser stuff
@onready var current_damage_tracker : Label = $CurrentDamageTracker
@onready var current_damage_cost : Label = $CurrentDamageCost
@onready var current_crit_chance_tracker : Label = $CurrentCritChanceTracker
@onready var current_crit_chance_cost : Label = $CurrentCritChanceCost
@onready var upgrades_access : TextureButton = $UpgradesAccess
@onready var upgrade_damage : Button = $UpgradeDamage
@onready var upgrade_crit_chance : Button = $UpgradeCritChance

@onready var current_mining_laser_speed : Label = $CurrentMiningLaserSpeed
@onready var current_mining_laser_cost : Label = $CurrentMiningLaserCost
@onready var upgrades_available_label: Label = $UpgradesAvailableLabel


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
@onready var upgrade_mining_laser_speed: Button = $UpgradeMiningLaserSpeed

var mining_drones_cost : int = 100

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

var plat_drones_cost : int = 100

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

var mining_drones_count : int = 0
var plat_drones_count : int = 0
var total_dronse_count : int = 0
#sfx
@onready var sfx_player : AudioStreamPlayer = $SfxPlayer


var open_upgrades_panel_sfx : AudioStream = SfxManager.UI_MINING_UPGRADE_MENU_OPEN_01
var close_upgrades_panel_sfx : AudioStream = SfxManager.UI_MINING_UPGRADE_MENU_CLOSE_01

var purchase_upgrade_sfx : Array[AudioStream] = [SfxManager.MIN_UNIT_DRONE_DEPLOY_01, SfxManager.MIN_UNIT_DRONE_DEPLOY_02, SfxManager.MIN_UNIT_DRONE_DEPLOY_03, SfxManager.MIN_UNIT_DRONE_DEPLOY_04]

@onready var mining_laser_speed_indicator: Label = $mining_laser_speed_indicator
@onready var mining_laser_damage_indicator: Label = $mining_laser_damage_indicator
@onready var mining_laser_crit_indicator: Label = $mining_laser_crit_indicator
@onready var drone_available_indicator: Label = $drone_available_indicator
@onready var drone_damage_indicator: Label = $drone_damage_indicator
@onready var drone_speed_indicator: Label = $drone_speed_indicator
@onready var platinum_drone_available_indicator: Label = $Platinum_Drone_available_indicator
@onready var platinum_drone_damage_indicator: Label = $Platinum_Drone_damage_indicator
@onready var platinum_drone_speed_indicator: Label = $Platinum_Drone_speed_indicator
@onready var ferrite_refinery_speed_indicator: Label = $Ferrite_Refinery_speed_indicator
@onready var ferrite_refinery_output_indicator: Label = $Ferrite_Refinery_output_indicator
@onready var plasma_generator_speed_indicator: Label = $Plasma_Generator_speed_indicator
@onready var plasma_generator_output_indicator: Label = $Plasma_Generator_output_indicator
@onready var plasma_generator_fuel_indicator: Label = $Plasma_Generator_fuel_indicator


func _ready() -> void:

	DroneManager.mining_drone_cost_changed.connect(update_drone_cost)
	DroneManager.platinum_drone_cost_changed.connect(update_platinum_drone_cost)
	
	current_damage_tracker.text = str(GameManager.mining_laser_damage)
	current_damage_cost.text = str(GameManager.mining_laser_damage_upgrade_cost)
	current_crit_chance_tracker.text = str(GameManager.mining_laser_crit_chance)
	current_crit_chance_cost.text = str(GameManager.mining_laser_crit_chance_cost)

	drones_count_tracker_label.text = str(mining_drones_count)
	drones_cost.text = str(mining_drones_cost)
	drone_damage.text = str(GameManager.drone_damage)
	drone_damage_cost.text = str(GameManager.drone_damage_cost)
	drone_speed.text = str(int(GameManager.drone_mining_speed * 100)) + "%"
	drone_mining_speed_cost.text = str(GameManager.drone_mining_speed_cost)
	
	platinum_drones_count.text = str(plat_drones_count)
	platinum_drones_cost.text = str(plat_drones_cost)
	plat_drone_damage.text = str(GameManager.platinum_drone_damage)
	plat_drone_damage_cost.text = str(GameManager.platinum_drone_damage_cost)
	plat_drone_speed.text = str(int(GameManager.platinum_drone_mining_speed * 100)) + "%"
	plat_drone_speed_cost.text = str(int(GameManager.platinum_drone_mining_speed_cost))
	
	ferrite_refinery_speed.text = str(int(GameManager.ferrite_refinery_speed * 100)) + "%"
	ferrite_refinery_speed_cost.text = str(GameManager.ferrite_refinery_speed_cost)
	#plasma generator
	generator_auto_speed.text = str(int(GameManager.plasma_generator_speed * 100)) + "%"
	auto_speed_plat_cost.text = str(GameManager.plasma_generator_speed_cost)
	output_cost.text = str(GameManager.plasma_generator_output_cost)
	generator_output.text = str(GameManager.plasma_generator_output)
	
	fuel_cost.text = str(GameManager.plasma_generator_fuel_consumption)
	fuel_platinum_cost.text = str(GameManager.plasma_generator_fuel_cost)
	
	efficiency_bonus.text = str(GameManager.output_amount)
	efficiency_bonus_cost.text = str(GameManager.output_upgrade_cost)
	
	current_mining_laser_speed.text = str(int(GameManager.mining_laser_speed * 100))+"%"
	current_mining_laser_cost.text = str(GameManager.mining_laser_speed_cost)

func _process(delta: float) -> void:
	
	if upgrades_available():
		upgrades_available_label.show()
	else:
		upgrades_available_label.hide()
	
	
	mining_laser_speed_indicator.visible = show_upgrade_indicator(GameManager.mining_laser_speed_cost)
	mining_laser_damage_indicator.visible = show_upgrade_indicator(GameManager.mining_laser_damage_upgrade_cost)
	mining_laser_crit_indicator.visible = show_upgrade_indicator(GameManager.mining_laser_crit_chance_cost)
	drone_available_indicator.visible = show_upgrade_indicator(mining_drones_cost)
	drone_damage_indicator.visible = show_upgrade_indicator(GameManager.drone_damage_cost) and mining_drones_count > 0
	drone_speed_indicator.visible = show_upgrade_indicator(GameManager.drone_mining_speed_cost) and mining_drones_count > 0
	platinum_drone_available_indicator.visible = show_upgrade_indicator(plat_drones_cost)
	platinum_drone_damage_indicator.visible = show_upgrade_indicator(GameManager.platinum_drone_damage_cost) and mining_drones_count > 0
	platinum_drone_speed_indicator.visible = show_upgrade_indicator(GameManager.platinum_drone_mining_speed_cost) and plat_drones_count > 0
	ferrite_refinery_output_indicator.visible = show_upgrade_indicator(GameManager.output_upgrade_cost) and GameManager.ferrite_refinery_station_purchased
	ferrite_refinery_speed_indicator.visible = show_upgrade_indicator(GameManager.ferrite_refinery_speed_cost) and GameManager.ferrite_refinery_station_purchased
	plasma_generator_output_indicator.visible = show_upgrade_indicator(GameManager.plasma_generator_output_cost) and GameManager.plasma_generator_station_purchased
	plasma_generator_fuel_indicator.visible = show_upgrade_indicator(GameManager.plasma_generator_fuel_cost) and GameManager.plasma_generator_station_purchased
	plasma_generator_speed_indicator.visible = show_upgrade_indicator(GameManager.plasma_generator_speed_cost) and GameManager.plasma_generator_station_purchased
	
	upgrade_damage.disabled = GameManager.platinum_count <= GameManager.mining_laser_damage_upgrade_cost
	upgrade_crit_chance.disabled = GameManager.platinum_count <= GameManager.mining_laser_crit_chance_cost
	purchase_drone.disabled = GameManager.platinum_count <= mining_drones_cost
	purchase_platinum_drone.disabled = GameManager.platinum_count <= plat_drones_cost
	upgrade_mining_laser_speed.disabled = GameManager.platinum_count <= GameManager.mining_laser_speed_cost
	#platinum_drones_count.text = str(GameManager.platinum_drone_count)
	
	if mining_drones_count > 0:
		upgrade_drone_damage.disabled = GameManager.platinum_count <= GameManager.drone_damage_cost
		upgrade_drone_mining_speed.disabled = GameManager.platinum_count <= GameManager.drone_mining_speed_cost
	else:
		upgrade_drone_damage.disabled = true
		upgrade_drone_mining_speed.disabled = true
		
	if plat_drones_count > 0:
		upgrade_plat_drone_damage.disabled = GameManager.platinum_count <= GameManager.platinum_drone_damage_cost
		upgrade_platinum_drone_mining_speed.disabled = GameManager.platinum_count <= GameManager.platinum_drone_mining_speed_cost
	else:
		upgrade_plat_drone_damage.disabled = true
		upgrade_platinum_drone_mining_speed.disabled = true
	
	if GameManager.ferrite_refinery_station_purchased:
		upgrade_refinery_speed.disabled = GameManager.platinum_count <= GameManager.ferrite_refinery_speed_cost
		upgrade_efficiency.disabled = GameManager.platinum_count <= GameManager.output_upgrade_cost
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


func upgrades_available() -> bool:
	return (GameManager.platinum_count >= GameManager.drones_cost 
	or GameManager.platinum_count >= GameManager.mining_laser_damage_upgrade_cost 
	or GameManager.platinum_count >= GameManager.mining_laser_crit_chance_cost
	or GameManager.platinum_count >= GameManager.mining_laser_speed_cost 
	or GameManager.platinum_count >= mining_drones_cost
	or GameManager.platinum_count >= GameManager.drone_damage_cost 
	or GameManager.platinum_count >= GameManager.drone_mining_speed_cost 
	or GameManager.platinum_count >= plat_drones_cost
	or GameManager.platinum_count >= GameManager.platinum_drone_damage_cost 
	or GameManager.platinum_count >= GameManager.platinum_drone_mining_speed_cost 
	or GameManager.platinum_count >= GameManager.ferrite_refinery_speed_cost 
	or GameManager.platinum_count >= GameManager.output_upgrade_cost
	or GameManager.platinum_count >= GameManager.plasma_generator_fuel_cost
	or GameManager.platinum_count >= GameManager.plasma_generator_output_cost
	or GameManager.platinum_count >= GameManager.plasma_generator_speed_cost)

func show_upgrade_indicator(cost : int) -> bool:
	return GameManager.platinum_count >= cost
	
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
	GameManager.output_upgrade_cost = GameManager.output_upgrade_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.ferrite_refinery_output_level)
	
	efficiency_bonus_cost.text = str(GameManager.output_upgrade_cost)
	efficiency_bonus.text = str(GameManager.output_amount)
	

func _on_generator_output_upgrade_button_down():
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.plasma_generator_output_cost
	GameManager.plasma_generator_output *= GameManager.plasma_generator_output_upgrade_interval
	GameManager.plasma_generator_output_level += 1
	GameManager.plasma_generator_output_cost = GameManager.plasma_generator_output_base_const * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.plasma_generator_output_level)
	GameManager.plasma_generator_fuel_consumption *= 2
	fuel_cost.text = str(GameManager.plasma_generator_fuel_consumption)
	generator_output.text = str(GameManager.plasma_generator_output)
	output_cost.text = str(GameManager.plasma_generator_output_cost)
	SignalBus.update_plasma_generator_output.emit()

func _on_upgrade_fuel_cost_button_down():
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.plasma_generator_fuel_cost
	GameManager.plasma_generator_fuel_consumption -= GameManager.plasma_generator_fuel_consumption_upgrade_interval
	GameManager.plasma_generator_fuel_level += 1
	GameManager.plasma_generator_fuel_cost = GameManager.plasma_generator_fuel_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.plasma_generator_fuel_level)
	fuel_cost.text = str(GameManager.plasma_generator_fuel_consumption)
	fuel_platinum_cost.text = str(GameManager.plasma_generator_fuel_cost)
	SignalBus.update_fuel_consumption.emit()
	
func _on_plasma_generator_speed_upgrade_button_down():
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.plasma_generator_speed_cost
	GameManager.plasma_generator_speed += GameManager.plasma_generator_speed_upgrade_interval
	GameManager.plasma_generator_speed_level += 1
	GameManager.plasma_generator_fuel_cost = GameManager.plasma_generator_speed_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.plasma_generator_speed_level)
	auto_speed_plat_cost.text = str(GameManager.plasma_generator_speed_cost)
	generator_auto_speed.text = str(GameManager.plasma_generator_speed * 100) + "%"
	SignalBus.update_plasma_generator_speed.emit()
	
	
func _on_hide_upgrades_panel_button_down():
	close_upgrades_panel()
	upgrade_panel_showing = false
	SignalBus.hide_upgrade_panel.emit()


func _on_purchase_drone_button_down():
	if !GameManager.mining_drone_purchased:
		SignalBus.show_task_completed_indicator.emit(GameManager.CHECK_LIST_INDICATOR_TOGGLES.MINING_DRONE_PURCHASED)
		GameManager.mining_drone_purchased = true
		
	play_purchase_upgrade_sfx()
	purchased_drone()
	SignalBus.add_drone.emit()
	

func upgrade_mining_laser() -> void:
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.mining_laser_damage_upgrade_cost
	GameManager.mining_laser_level += 1
	GameManager.mining_laser_damage = GameManager.mining_laser_damage + GameManager.mining_laser_level * 2
	GameManager.mining_laser_damage_upgrade_cost = GameManager.mining_laser_damage_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.mining_laser_level)
	GameManager.platinum_gain_min += 3
	GameManager.platinum_gain_max += 3
	SignalBus.update_platinum_count.emit()
	
func upgrade_mining_critical_chance() -> void:
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.mining_laser_crit_chance_cost
	GameManager.mining_laser_crit_chance_level += 1
	GameManager.mining_laser_crit_chance += GameManager.mining_laser_crit_chance_interval
	GameManager.mining_laser_crit_chance_cost = GameManager.mining_laser_crit_chance_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.mining_laser_crit_chance_level)
	SignalBus.update_platinum_count.emit()
func purchased_drone() -> void:
	if !GameManager.mining_drone_purchased:
		SignalBus.show_task_completed_indicator.emit(GameManager.CHECK_LIST_INDICATOR_TOGGLES.MINING_DRONE_PURCHASED)
		GameManager.mining_drone_purchased = true
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.drones_cost
	SignalBus.update_platinum_count.emit()
	

func upgrade_drones_damage() -> void:
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.drone_damage_cost
	GameManager.drone_level += 1
	GameManager.drone_damage = int(GameManager.drone_damage + GameManager.drone_level * 2.7)
	GameManager.drone_damage_cost = GameManager.drone_damage_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.drone_level)


func _on_upgrade_drone_mining_speed_button_down() -> void:
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.drone_mining_speed_cost
	GameManager.drone_mining_speed_level += 1
	GameManager.drone_mining_speed += GameManager.drone_mining_speed_upgrade_interval
	GameManager.drone_mining_speed_cost = GameManager.drone_mining_speed_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.drone_mining_speed_level)
	drone_speed.text = str(int(GameManager.drone_mining_speed * 100)) + "%"
	drone_mining_speed_cost.text = str(GameManager.drone_mining_speed_cost)

func _on_purchase_platinum_drone_button_down() -> void:
	if !GameManager.plat_drone_purchased:
		SignalBus.show_task_completed_indicator.emit(GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED)
		GameManager.plat_drone_purchased = true
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.platinum_drone_cost
	SignalBus.add_platinum_drone.emit()
	SignalBus.update_platinum_count.emit()

func _on_upgrade_plat_drone_damage_button_down() -> void:
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.platinum_drone_damage_cost
	GameManager.platinum_drone_damage_level += 1
	GameManager.platinum_drone_damage = GameManager.platinum_drone_damage + GameManager.platinum_drone_damage_level * 2
	GameManager.platinum_drone_damage_cost = GameManager.platinum_drone_damage_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.platinum_drone_damage_level)
	plat_drone_damage.text = str(GameManager.platinum_drone_damage)
	plat_drone_damage_cost.text = str(GameManager.platinum_drone_damage_cost)
	SignalBus.update_platinum_count.emit()

func _on_upgrade_platinum_drone_mining_speed_button_down() -> void:
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.platinum_drone_mining_speed_cost
	GameManager.platinum_drone_mining_speed_level += 1
	GameManager.platinum_drone_mining_speed += GameManager.platinum_drone_mining_speed_interval
	GameManager.platinum_drone_mining_speed_cost = GameManager.platinum_drone_mining_speed_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.drone_mining_speed_level)
	plat_drone_speed.text = str(int(GameManager.platinum_drone_mining_speed * 100)) + "%"
	plat_drone_speed_cost.text = str(GameManager.platinum_drone_mining_speed_cost)
	SignalBus.update_platinum_count.emit()

func _on_upgrade_refinery_speed_button_down() -> void:
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.ferrite_refinery_speed_cost
	GameManager.ferrite_refinery_speed_level += 1
	GameManager.ferrite_refinery_speed += GameManager.ferrite_refinery_speed_upgrade_interval
	GameManager.ferrite_refinery_speed_cost = GameManager.ferrite_refinery_speed_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.ferrite_refinery_speed_level)
	ferrite_refinery_speed.text = str(int(GameManager.ferrite_refinery_speed * 100)) +"%"
	ferrite_refinery_speed_cost.text = str(GameManager.ferrite_refinery_speed_cost)
	SignalBus.update_platinum_count.emit()

func _on_upgrade_mining_laser_speed_button_down():
	toggle_upgrade_check_list_item()
	play_purchase_upgrade_sfx()
	GameManager.platinum_count -= GameManager.mining_laser_speed_cost
	GameManager.mining_laser_speed_level += 1
	GameManager.mining_laser_speed += GameManager.mining_laser_speed_upgrade_interval
	GameManager.mining_laser_speed_cost = GameManager.mining_laser_speed_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, GameManager.mining_laser_speed_level)
	current_mining_laser_cost.text = str(GameManager.mining_laser_speed_cost)
	current_mining_laser_speed.text = str(int(GameManager.mining_laser_speed * 100))+"%"
	SignalBus.update_mining_laser_speed.emit()
	
	
func update_drone_cost(new_cost : int, new_count : int) -> void:
	toggle_upgrade_check_list_item()
	mining_drones_cost = new_cost
	mining_drones_count = new_count
	drones_cost.text = str(new_cost)
	drones_count_tracker_label.text = str(new_count)
	SignalBus.check_to_start_ufo_spawn.emit()
	SignalBus.update_platinum_count.emit()


func update_platinum_drone_cost(new_cost : int, new_count : int) -> void:
	toggle_upgrade_check_list_item()
	plat_drones_cost = new_cost
	plat_drones_count = new_count
	platinum_drones_cost.text = str(plat_drones_cost)
	platinum_drones_count.text = str(plat_drones_count)
	SignalBus.update_platinum_count.emit()
	SignalBus.check_to_start_ufo_spawn.emit()
	

func toggle_upgrade_check_list_item() -> void:
	if !GameManager.upgrade_purchased:
		SignalBus.show_task_completed_indicator.emit(GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PURCHASED)
		GameManager.upgrade_purchased = true	

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


func get_total_drones_count() -> void:
	GameManager.total_drones_count = asteroid_area.drone_list.get_children().size()

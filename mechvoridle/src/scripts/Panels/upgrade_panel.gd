class_name UpgradePanel extends ColorRect

#mining laser stuff
@onready var current_damage_tracker : Label = $CurrentDamageTracker
@onready var current_damage_cost : Label = $CurrentDamageCost
@onready var current_crit_chance_tracker : Label = $CurrentCritChanceTracker
@onready var current_crit_chance_cost : Label = $CurrentCritChanceCost

#drones stuff
@onready var drones_count_tracker_label : Label = $DronesCountTrackerLabel
@onready var drones_cost : Label = $DronesCost
@onready var drone_damage : Label = $DroneDamage
@onready var drone_damage_cost : Label = $DroneDamageCost

#refinery stuff
@onready var ferrite_refinery_count : Label = $FerriteRefineryCount
@onready var ferrite_refinery_cost : Label = $FerriteRefineryCost
@onready var efficiency_bonus :Label = $EfficiencyBonus
@onready var efficiency_bonus_cost : Label = $EfficiencyBonusCost

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
	
	ferrite_refinery_count.text = str(GameManager.ferrite_refinery_count)
	ferrite_refinery_cost.text = str(GameManager.ferrite_refinery_cost)
	efficiency_bonus.text = str(GameManager.efficiency_bonus)
	efficiency_bonus_cost.text = str(GameManager.efficiency_upgrade_cost)

func _on_upgrades_access_button_down():
	upgrade_panel_showing = !upgrade_panel_showing
	
	if upgrade_panel_showing:
		SignalBus.show_upgrade_panel.emit()
	else:
		SignalBus.hide_upgrade_panel.emit()

func _on_upgrade_damage_button_down():
	pass # Replace with function body.

func _on_upgrade_crit_chance_button_down():
	pass # Replace with function body.

func _on_upgrade_drone_damage_button_down():
	pass # Replace with function body.

func _on_purchase_refinery_button_down():
	pass # Replace with function body.

func _on_upgrade_efficiency_button_down():
	pass # Replace with function body.

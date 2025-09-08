class_name DronePurchasePanel extends ColorRect

@export var drone_manager : DroneManager
@export var current_asteroid_scene : AsteroidArea


@onready var owned_drones_count : Label = %OwnedDronesCount
@onready var mining_drone_cost_label : Label= %MiningDroneCostLabel
@onready var mining_drone_label_count : Label = %MiningDroneLabelCount
@onready var platinum_drone_cost_label : Label = %PlatinumDroneCostLabel
@onready var platinum_drone_label_count : Label = %PlatinumDroneLabelCount
@onready var turret_drone_cost_label : Label = %TurretDroneCostLabel
@onready var turret_drone_label_count : Label = %TurretDroneLabelCount

@onready var mining_drone_purchase_indicator : Label = %MiningDronePurchaseIndicator
@onready var plat_drone_purchase_indicator : Label = %PlatDronePurchaseIndicator
@onready var turret_drone_purchase_indicator : Label = %TurretDronePurchaseIndicator

@onready var buy_mining_drone_button : Button = %BuyMiningDroneButton
@onready var buy_platinum_drone_button : Button = %BuyPlatinumDroneButton
@onready var buy_turret_drone_button : Button= %BuyTurretDroneButton


func _ready() -> void:
	pass


func _process(delta : float) -> void:
	if drone_manager.drones.size() < drone_manager.max_owned_drones:
		buy_mining_drone_button.disabled = GameManager.platinum_count < drone_manager.get_mining_drone_cost()
		buy_platinum_drone_button.disabled = GameManager.platinum_count < drone_manager.get_platinum_drone_cost()
		buy_turret_drone_button.disabled = GameManager.platinum_count < drone_manager.get_turret_drone_cost()
	else:
		buy_mining_drone_button.disabled = true
		buy_platinum_drone_button.disabled = true
		buy_turret_drone_button.disabled = true


func _on_buy_mining_drone_button_button_up():
	pass


func _on_buy_platinum_drone_button_button_up():
	pass # Replace with function body.


func _on_buy_turret_drone_button_button_up():
	GameManager.platinum_count -= GameManager.turret_drone_cost
	SignalBus.add_turret_drone.emit(current_asteroid_scene)
	SignalBus.update_platinum_count.emit()

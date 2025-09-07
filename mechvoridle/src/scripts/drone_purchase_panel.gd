class_name DronePurchasePanel extends ColorRect

@export var drone_manager : DroneManager

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
	pass

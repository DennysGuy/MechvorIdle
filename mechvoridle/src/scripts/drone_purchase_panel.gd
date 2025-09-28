class_name DronePurchasePanel extends ColorRect

@export var drone_manager : LocalDroneManager
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
	hide()
	SignalBus.set_asteroid_data.connect(set_asteroid_area_data)
	SignalBus.clear_asteroid_data.connect(clear_asteroid_data)


func _process(delta : float) -> void:
	if drone_manager:
		print("this is the current drone count: " + str(drone_manager.get_total_drone_count()))
		if drone_manager.get_total_drone_count() < drone_manager.max_owned_drones:
			buy_mining_drone_button.disabled = GameManager.platinum_count < drone_manager.get_mining_drone_cost()
			buy_platinum_drone_button.disabled = GameManager.platinum_count < drone_manager.get_platinum_drone_cost()
			buy_turret_drone_button.disabled = GameManager.platinum_count < drone_manager.get_turret_drone_cost()
		else:
			buy_mining_drone_button.disabled = true
			buy_platinum_drone_button.disabled = true
			buy_turret_drone_button.disabled = true
	else:
		print("no place selected.")

func _on_buy_mining_drone_button_button_up():
	GameManager.platinum_count -= drone_manager.get_mining_drone_cost()
	SignalBus.add_drone.emit(current_asteroid_scene)
	SignalBus.update_platinum_count.emit()
	update_drone_cost_labels()

func _on_buy_platinum_drone_button_button_up():
	GameManager.platinum_count -= drone_manager.get_platinum_drone_cost()
	SignalBus.add_platinum_drone.emit(current_asteroid_scene)
	SignalBus.update_platinum_count.emit()
	update_drone_cost_labels()

func _on_buy_turret_drone_button_button_up():
	GameManager.platinum_count -= drone_manager.get_turret_drone_cost()
	SignalBus.add_turret_drone.emit(current_asteroid_scene)
	SignalBus.update_platinum_count.emit()
	update_drone_cost_labels()
	
func _on_show_panel_button_button_down():
	SignalBus.show_drone_shop.emit()


func clear_asteroid_data() -> void:
	drone_manager = null
	current_asteroid_scene = null
	hide()
	
func set_asteroid_area_data(asteroid_area : AsteroidArea, drone_manager : LocalDroneManager) -> void:
	self.drone_manager = drone_manager
	current_asteroid_scene = asteroid_area
	update_drone_cost_labels()
	show()

		
func update_drone_cost_labels() -> void:
	owned_drones_count.text = "Owned Drones " + str(drone_manager.get_total_drone_count())+"/"+str(drone_manager.max_owned_drones)
	mining_drone_cost_label.text = "Cost: " + str(drone_manager.get_mining_drone_cost())
	platinum_drone_cost_label.text = "Cost: " + str(drone_manager.get_platinum_drone_cost())
	turret_drone_cost_label.text = "Cost: " + str(drone_manager.get_turret_drone_cost())	

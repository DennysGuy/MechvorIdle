class_name DroneDetailsPanel extends TextureRect

@onready var icon : TextureRect = $Icon
@onready var drone_type_label : Label = $DroneTypeLabel
@onready var health_label : Label = $HealthLabel
@onready var health_count_label : StatLabel = $HealthCountLabel
@onready var resource_focus_label : Label = $ResourceFocusLabel
@onready var sell_button : Button = $SellButton

var selected_drone

func _ready() -> void:
	SignalBus.hide_drone_details.connect(hide_data)
	SignalBus.show_drone_details.connect(show_data)
	SignalBus.update_drone_details_while_selected.connect(update_drone_data_while_selected)
	SignalBus.deselect_drone.connect(hide_data)
	
	hide_data()


func _process(delta : float) -> void:
	pass


func set_icon(selected_drone) -> void:
	if selected_drone is MiningDrone:
		icon.texture = preload("res://assets/graphics/mining_drone.png")
	elif selected_drone is PlatinumMiningDrone:
		icon.texture = preload("res://assets/graphics/platinum_drone.png")
	elif selected_drone is TurretDrone:
		icon.texture = preload("res://assets/graphics/TurretDrone.png")
	#add one later for the turret drone

func show_data(drone) -> void:
	
	if selected_drone:
		selected_drone.hide_outline()
		if selected_drone is TurretDrone:
			selected_drone.show_radius(false)
	selected_drone = drone
	if drone is MiningDrone:
		drone_type_label.text = "Mining Drone"
	elif drone is PlatinumMiningDrone:
		drone_type_label.text = "Platinum Drone"
	elif drone is TurretDrone:
		drone_type_label.text = "Turret Drone"
	
	health_count_label.text = str(drone.health)+"/"+str(drone.max_health)
	set_health_color(drone.health, drone.max_health, health_count_label)
	set_icon(drone)
	show_data_labels()

func update_drone_data_while_selected(drone) -> void:
	if selected_drone and drone == selected_drone:
		show_data(drone)

func hide_data() -> void:
	selected_drone = null
	sell_button.hide()
	icon.hide()
	drone_type_label.hide()
	health_label.hide()
	health_count_label.hide()
	resource_focus_label.hide()

func show_data_labels() -> void:
	if selected_drone is MiningDrone:
		sell_button.text = "Sell for " + str(DroneManager.get_mining_drone_cost()/2)
	elif selected_drone is PlatinumMiningDrone:
		sell_button.text = "Sell for " + str(DroneManager.get_platinum_drone_cost()/2)
	elif selected_drone is TurretDrone:
		sell_button.text = "Sell for " + str(DroneManager.get_turret_drone_cost()/2)
	sell_button.show()
	icon.show()
	drone_type_label.show()
	health_label.show()
	health_count_label.show()
	resource_focus_label.show()

func set_health_color(current_health : int, max_health : int, health_count_label : StatLabel):
	if	current_health >= round(max_health *0.8):
		health_count_label.set_text_color_green()
	elif current_health < round(max_health * 0.8) and current_health > round(max_health * 0.5):
		health_count_label.set_text_color_yellow()
	else:
		health_count_label.set_text_color_red()


func _on_sell_button_button_down():
	if selected_drone is MiningDrone:
		GameManager.platinum_count += round(DroneManager.get_mining_drone_cost()/2)
	elif selected_drone is PlatinumMiningDrone:
		GameManager.platinum_count += round(DroneManager.get_platinum_drone_cost()/2)
	elif selected_drone is TurretDrone:
		GameManager.platinum_count += round(DroneManager.get_turret_drone_cost()/2)
	
	selected_drone.queue_free()
	hide_data()
	
	

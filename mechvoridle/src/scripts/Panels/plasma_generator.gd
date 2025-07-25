class_name PlasmaGenerator extends Control
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var fuel_bar: ProgressBar = $FuelBar
@onready var label: Label = $PurchasePanel/Label
@onready var button: Button = $PurchasePanel/Button
@onready var purchase_panel: Panel = $PurchasePanel
@onready var output: Label = $Output
@onready var fuel_cost: Label = $FuelCost
@onready var speed: Label = $Speed

var fuel_tank : int 

func _ready() -> void:
	SignalBus.update_plasma_generator_output.connect(update_output)
	SignalBus.update_fuel_consumption.connect(update_fuel_cost)
	SignalBus.update_plasma_generator_speed.connect(update_speed)
	progress_bar.hide()
	progress_bar.show()
	fuel_cost.hide()
	output.hide()
	label.text = "Cost: " + str(GameManager.plasma_generator_cost)


func _process(delta : float) -> void:
	if is_instance_valid(button):
		button.disabled = GameManager.platinum_count < GameManager.plasma_generator_cost
	
	if GameManager.plasma_generator_station_purchased:
		if GameManager.raw_ferrite_count >= GameManager.plasma_generator_fuel_consumption and fuel_tank == 0:
			GameManager.raw_ferrite_count -= GameManager.plasma_generator_fuel_consumption
			fuel_tank = GameManager.plasma_generator_fuel_consumption
			fuel_bar.value = fuel_bar.max_value
			var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
			resource_acquired_label.output = "-"+str(GameManager.plasma_generator_fuel_consumption)+" Ferrite"
			resource_acquired_label.position = Vector2(125, 0)
			add_child(resource_acquired_label)
			
		if fuel_tank > 0:
			fuel_bar.value -= GameManager.plasma_generator_fuel_consumption_speed
			if fuel_bar.value == 0:
				fuel_tank = 0
		
		
		if fuel_bar.value > 0 and fuel_tank > 0 : # we'll pause production if we have no fuel in the take
			progress_bar.value += GameManager.plasma_generator_speed
			if progress_bar.value == progress_bar.max_value:
				obtain_resources()
				progress_bar.value = 0
	
func obtain_resources():
	GameManager.plasma_count += GameManager.plasma_generator_output
	SignalBus.update_plasma_count.emit()
	var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	resource_acquired_label.output = "+"+str(GameManager.plasma_generator_output)+" Plasma"
	resource_acquired_label.position = Vector2.ZERO
	add_child(resource_acquired_label)


func _on_button_button_down() -> void:
	GameManager.platinum_count -= GameManager.plasma_generator_cost
	GameManager.plasma_generator_station_purchased = true
	SignalBus.update_platinum_count.emit()
	progress_bar.show()
	fuel_bar.show()
	output.show()
	fuel_cost.show()
	update_fuel_cost()
	update_output()
	update_speed()
	purchase_panel.queue_free()

func update_fuel_cost() -> void:
	fuel_cost.text = "Fuel Cost: -" + str(GameManager.plasma_generator_fuel_consumption)

func update_output() -> void:
	output.text = "Output: " + str(GameManager.plasma_generator_output)

func update_speed() -> void:
	speed.text = "Speed: " + str(GameManager.plasma_generator_speed * 100) + "%"

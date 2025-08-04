class_name FerriteRefineryStation extends Control


@onready var refinery_cost_label: Label = $PurchasePanel/RefineryCostLabel
@onready var purchase_refinery_station: TextureButton = $PurchasePanel/PurchaseRefineryStation
@onready var purchase_panel: ColorRect = $PurchasePanel
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var output_label: Label = $OutputLabel
@onready var cost_label: Label = $CostLabel
@onready var refined_ferrite_ui_icon: Sprite2D = $RefinedFerriteUiIcon
@onready var ferrite_ui_icon: Sprite2D = $FerriteUiIcon

var refinery_stock : int

func _ready() -> void:
	refined_ferrite_ui_icon.hide()
	ferrite_ui_icon.hide()
	output_label.hide()
	cost_label.hide()
	refinery_cost_label.text = "Cost: " + str(GameManager.ferrite_refinery_cost)
	progress_bar.hide()

func _process(delta: float) -> void:
	if  is_instance_valid(purchase_refinery_station):
		purchase_refinery_station.disabled = GameManager.raw_ferrite_count < GameManager.ferrite_refinery_cost
	
	if GameManager.ferrite_refinery_station_purchased:
		#grab resources -- if enough
		refined_ferrite_ui_icon.show()
		ferrite_ui_icon.show()
		output_label.show()
		cost_label.show()
		output_label.text = "Output: " + str(GameManager.output_amount)
		cost_label.text = "Cost: " + str(GameManager.ferrite_cost)
		#fill progress bar
		#give resources
		if GameManager.raw_ferrite_count >= GameManager.ferrite_cost and refinery_stock == 0:
			GameManager.raw_ferrite_count -= GameManager.ferrite_cost
			var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
			resource_acquired_label.output = "-"+str(GameManager.ferrite_cost)
			resource_acquired_label.set_resource_as_ferrite()
			resource_acquired_label.position = Vector2(130,0)
			add_child(resource_acquired_label)
			refinery_stock = GameManager.ferrite_cost
			SignalBus.update_ferrite_count.emit()
			print(refinery_stock)
		
		if refinery_stock > 0:
			progress_bar.value += GameManager.ferrite_refinery_speed
			if progress_bar.value == progress_bar.max_value:
				obtain_resources()
				progress_bar.value = 0


func _on_purchase_refinery_station_button_down() -> void:

	SignalBus.show_task_completed_indicator.emit(GameManager.CHECK_LIST_INDICATOR_TOGGLES.FERRITE_REFINERY_PURCHASED)
	GameManager.ferrite_refinery_station_purchased = true
	GameManager.raw_ferrite_count -= GameManager.ferrite_refinery_cost
	
	progress_bar.show()
	purchase_panel.queue_free()
	SignalBus.update_platinum_count.emit()


func obtain_resources() -> void:
	refinery_stock = 0
	GameManager.ferrite_bars_count += GameManager.output_amount
	SignalBus.update_ferrite_bars_count.emit()
	var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	resource_acquired_label.output = "+"+str(GameManager.output_amount)
	resource_acquired_label.set_resource_as_ferrite_bar()
	resource_acquired_label.position = Vector2.ZERO
	add_child(resource_acquired_label)

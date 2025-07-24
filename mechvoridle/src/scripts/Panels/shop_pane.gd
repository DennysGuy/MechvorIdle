class_name ShopPane extends Control
@onready var ferrite_bars_count : Label= $ColorRect/Shop/FerriteBarsCount
@onready var platinum_count : Label = $ColorRect/Shop/PlatinumCount
@onready var plasma_count: Label = $ColorRect/Shop/PlasmaCount

func _ready() -> void:
	SignalBus.update_ferrite_bars_count.connect(update_ferrite_bars_count)
	SignalBus.update_platinum_count.connect(update_platinum_count)
	SignalBus.update_plasma_count.connect(update_plasma_count)
	
	update_ferrite_bars_count()
	update_plasma_count()
	update_platinum_count()
	
func _process(delta : float) -> void:
	pass

func _on_central_hub_navigation_button_up():
	SignalBus.move_to_central_hub_from_shop_pane.emit()

func update_ferrite_bars_count() -> void:
	ferrite_bars_count.text = str(GameManager.ferrite_bars_count)

func update_platinum_count() -> void:
	platinum_count.text = str(GameManager.platinum_count)

func update_plasma_count() -> void:
	plasma_count.text = str(GameManager.plasma_count)

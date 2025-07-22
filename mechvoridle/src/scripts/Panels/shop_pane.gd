class_name ShopPane extends Control

func _ready() -> void:
	pass

func _process(delta : float) -> void:
	pass


func _on_central_hub_navigation_button_up():
	SignalBus.move_to_central_hub_from_shop_pane.emit()

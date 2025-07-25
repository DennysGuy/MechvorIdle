class_name ShopMenuItemPanel extends Control

@onready var item_name: Label = $ItemName

var component : MechComponent

func _ready() -> void:
	if component:
		item_name.text = component.component_name
	else:
		item_name.text = "No Component Found"
	


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			SignalBus.transfer_item_to_shop_panel.emit(component)

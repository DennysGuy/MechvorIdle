class_name ShopMenuItemPanel extends Control

@onready var item_name: Label = $ItemName
@onready var audio_stream_player :AudioStreamPlayer = $AudioStreamPlayer

var component : MechComponent

func _ready() -> void:
	if component:
		item_name.text = component.component_name
	else:
		item_name.text = "No Component Found"
	


func _on_gui_input(event: InputEvent) -> void:
	pass
			


func _on_mouse_entered():
	SfxManager.play_button_hover(audio_stream_player)


func _on_pressed():
	SfxManager.play_button_click(audio_stream_player)
	SignalBus.transfer_item_to_shop_panel.emit(component)

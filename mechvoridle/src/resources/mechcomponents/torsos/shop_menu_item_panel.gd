class_name ShopMenuItemPanel extends Control

@onready var item_name: Label = $ItemName
@onready var audio_stream_player :AudioStreamPlayer = $AudioStreamPlayer
@onready var component_available_indicator: Label = $ComponentAvailableIndicator


var component : MechComponent

func _ready() -> void:
	
	SignalBus.update_list_item_text.connect(change_text_to_purchased)
	
	if component:
		
	
		if component.get_category_type() == "Weapon" and GameManager.owned_mech_components["LeftWeapon"] and GameManager.owned_mech_components["RightWeapon"]:
			item_name.text = "[Weapons Already Owned]"
		elif component.get_category_type() != "Weapon" and GameManager.owned_mech_components[component.get_category_type()]:
			item_name.text = "["+component.get_category_type()+" Already Owned]"
		else:
			item_name.text = component.component_name
	else:
		item_name.text = "No Component Found"
	
func _process(delta: float) -> void:
	
	if component and component.category == component.CATEGORY.WEAPON:
		if !GameManager.owned_mech_components["LeftWeapon"] or !GameManager.owned_mech_components["RightWeapon"]:
			component_available_indicator.visible = GameManager.ferrite_bars_count >=  component.refined_ferrite_cost and GameManager.plasma_count >= component.plasma_cost
		else:
			component_available_indicator.visible = false
	else:
		#need to check if slot is available
		component_available_indicator.visible = GameManager.ferrite_bars_count >= component.refined_ferrite_cost and GameManager.mech_component_slot_is_empty(component.get_category_type())

func _on_gui_input(event: InputEvent) -> void:
	pass
			

func change_text_to_purchased(component_category : String) -> void:
	if component.get_category_type() == component_category:
		item_name.text= "["+component.get_category_type()+" already owned]"


func _on_mouse_entered():
	SfxManager.play_button_hover(audio_stream_player)


func _on_pressed():
	SfxManager.play_button_click(audio_stream_player)
	SignalBus.transfer_item_to_shop_panel.emit(component)
	SignalBus.update_stats_panel.emit(component)
	SignalBus.show_part_preview.emit(component)

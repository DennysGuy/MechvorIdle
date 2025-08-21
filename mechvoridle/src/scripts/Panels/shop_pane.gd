class_name ShopPane extends Control
@onready var ferrite_bars_count : Label= $ColorRect/FerriteBarsCount
@onready var platinum_count : Label = $ColorRect/PlatinumCount
@onready var plasma_count: Label = $ColorRect/PlasmaCount
@onready var description_text_box: RichTextLabel = $ColorRect/DescriptionTextBox
@onready var item_menu: VBoxContainer = $ColorRect/ScrollContainer/ItemMenu
@onready var slot_is_filled_label: Label = $ColorRect/SlotIsFilledLabel
@onready var part_class: Label = $ColorRect/PartClass
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sfx_player  : AudioStreamPlayer = $SfxPlayer

@onready var purchase_button: TextureButton = $ColorRect/PurchaseButton

@onready var item_name: Label = $ItemName

@onready var part_name: Label = $ColorRect/PartName
@onready var ferrite_cost: Label = $ColorRect/FerriteCost
@onready var plasma_cost: Label = $ColorRect/PlasmaCost
@onready var platinum_cost: Label = $ColorRect/PlatinumCost
@onready var manufacture_logo : TextureRect = $ColorRect/HBoxContainer2/ManufactureLogo
@onready var manufacturer = $ColorRect/HBoxContainer2/Manufacturer


@onready var confirmation_box: TextureRect = $ColorRect/ConfirmationBox
@onready var confirmation_button: Button = $ColorRect/ConfirmationBox/ConfirmationButton
@onready var cancellation_button: TextureButton = $ColorRect/ConfirmationBox/CancellationButton

@onready var sub_viewport : SubViewport = $ColorRect/SubViewportContainer/SubViewport

@onready var parts_owned_label: Label = $ColorRect/PartsOwnedLabel

@export var main_hub : MainHub

@onready var head_indicator: Label = $ColorRect/HeadIndicator
@onready var torso_indicator: Label = $ColorRect/TorsoIndicator
@onready var arms_indicator: Label = $ColorRect/ArmsIndicator
@onready var legs_indicator: Label = $ColorRect/LegsIndicator
@onready var rifles_indicator: Label = $ColorRect/RiflesIndicator
@onready var swords_indicator: Label = $ColorRect/SwordsIndicator
@onready var launchers_indicator: Label = $ColorRect/LaunchersIndicator

var selected_component : MechComponent
var confirmation_box_is_showing : bool = false
@onready var sub_viewport_2: SubViewport = $ColorRect/SubViewportContainer2/SubViewport


func _ready() -> void:
	SignalBus.update_ferrite_bars_count.connect(update_ferrite_bars_count)
	SignalBus.update_plasma_count.connect(update_plasma_count)
	SignalBus.transfer_item_to_shop_panel.connect(update_description_box)
	sub_viewport.own_world_3d = true
	sub_viewport_2.own_world_3d = true
	manufacturer.text = "N/A"
	manufacture_logo.texture = null
	slot_is_filled_label.hide()
	display_component_list("Heads")
	update_ferrite_bars_count()
	update_plasma_count()
	update_parts_owned_label()
	hide_confirmation_panel()
	
	
func _process(delta : float) -> void:
	
	head_indicator.visible = show_armor_component_available_indicator(GameManager.MIN_HEAD_FERRITE_BAR_COST, "Head") and GameManager.mech_component_slot_is_empty("Head")
	torso_indicator.visible = show_armor_component_available_indicator(GameManager.MIN_TORSO_FERRITE_BAR_COST, "Torso") and GameManager.mech_component_slot_is_empty("Torso")
	arms_indicator.visible = show_armor_component_available_indicator(GameManager.MIN_ARMS_FERRITE_BAR_COST, "Arms") and GameManager.mech_component_slot_is_empty("Arms")
	legs_indicator.visible = show_armor_component_available_indicator(GameManager.MIN_LEGS_FERRITE_BAR_COST, "Legs") and GameManager.mech_component_slot_is_empty("Legs")
	rifles_indicator.visible = show_weapon_component_available_indicator(GameManager.MIN_RIFLE_FERRITE_BAR_COST, GameManager.MIN_RIFLE_PLASMA_COST) 
	swords_indicator.visible = show_weapon_component_available_indicator(GameManager.MIN_SWORD_FERRITE_BAR_COST, GameManager.MIN_SWORD_PLASMA_COST) 
	launchers_indicator.visible_characters = show_weapon_component_available_indicator(GameManager.MIN_LAUNCHER_FERRITE_BAR_COST, GameManager.MIN_LAUNCHER_PLASMA_COST)
	
	if selected_component:
		if selected_component.get_category_type() == "Weapon" and GameManager.owned_weapons_count == 2 or confirmation_box_is_showing:
			purchase_button.disabled = true
		else:
			if GameManager.mech_component_slot_is_empty(selected_component.get_category_type()):
				purchase_button.disabled = GameManager.ferrite_bars_count < selected_component.refined_ferrite_cost or GameManager.plasma_count < selected_component.plasma_cost	
			else:
				purchase_button.disabled = 	true	
	else:
		purchase_button.disabled = true

func _on_central_hub_navigation_button_up():
	SignalBus.move_to_central_hub_from_shop_pane.emit()

func update_ferrite_bars_count() -> void:
	ferrite_bars_count.text = str(GameManager.ferrite_bars_count)

func update_plasma_count() -> void:
	plasma_count.text = str(GameManager.plasma_count)

func update_description_box(component: MechComponent) -> void:
	
	var component_category : String = component.get_category_type()
	
	if not GameManager.mech_component_slot_is_empty(component_category) \
	or component_category == "Weapon" and GameManager.owned_weapons_count == 2:
		slot_is_filled_label.text = component_category + " component already owned."
		slot_is_filled_label.show()
	else:
		slot_is_filled_label.hide()
	
	selected_component = component
	description_text_box.text = selected_component.description
	part_name.text = selected_component.component_name
	ferrite_cost.text = "Ferrite Bars: " + str(selected_component.refined_ferrite_cost)
	plasma_cost.text = "Plasma: " + str(selected_component.plasma_cost)
	part_class.text = "Class: " + selected_component.get_category_type()
	manufacturer.text = component.get_manufacturer_name()
	manufacture_logo.texture = component.get_manufacturer_icon()

func show_armor_component_available_indicator(value : int, component_name : String) -> bool:
	return GameManager.ferrite_bars_count >= value and GameManager.mech_component_slot_is_empty(component_name)
	
func show_weapon_component_available_indicator(ferrite_bars_value : int, plasma_value) -> bool:
	return GameManager.ferrite_bars_count >= ferrite_bars_value and GameManager.plasma_count >= plasma_value and GameManager.owned_weapons_count >= 2


func _on_heads_button_button_down() -> void:
	display_component_list("Heads")
	show_already_purchased_label("Head")

func _on_torsos_button_button_down() -> void:
	display_component_list("Torsos")
	show_already_purchased_label("Torso")

func _on_arms_button_button_down() -> void:
	display_component_list("Arms")
	show_already_purchased_label("Arms")

func _on_legs_button_button_down() -> void:
	display_component_list("Legs")
	show_already_purchased_label("Legs")

func _on_rifles_button_button_down() -> void:
	display_component_list("Rifles")
	show_already_purchased_label("Weapon")
	
func _on_swords_button_button_down() -> void:
	display_component_list("Swords")
	show_already_purchased_label("Weapon")

func _on_rocket_launchers_button_button_down() -> void:
	display_component_list("Rocket Launchers")
	show_already_purchased_label("Weapon")

func display_component_list(component_name : String):
	SfxManager.play_button_click(sfx_player)
	clear_container()

	var list : Dictionary = ShopList.shop_list[component_name]
	for key in list.keys():
		var list_item : ShopMenuItemPanel = preload("uid://gtctbxlpobla").instantiate()
		list_item.component = list[key]
		item_menu.add_child(list_item)

func clear_container() -> void:
	for item in item_menu.get_children():
		item.queue_free()

func _on_purchase_button_button_down() -> void:
	SfxManager.play_button_click(sfx_player)
	show_confirmation_panel()


func _on_confirmation_button_button_down() -> void:
	if !GameManager.mech_component_purchased:
		SignalBus.add_to_mission_counter.emit(1, GameManager.CHECK_LIST_INDICATOR_TOGGLES.MECH_COMPONENT_PURCHASED)
	
	GameManager.mech_component_purchased = true
	
	if !GameManager.mech_completed:
		SignalBus.add_to_mission_counter.emit(1, GameManager.CHECK_LIST_INDICATOR_TOGGLES.COMPLETE_MECH)
	
		
	SfxManager.play_button_click(sfx_player)
	sfx_player.stream = [SfxManager.UI_SHOP_BUY_COMPLETE_01,SfxManager.UI_SHOP_BUY_COMPLETE_02,SfxManager.UI_SHOP_BUY_COMPLETE_03].pick_random()
	sfx_player.play()
	GameManager.ferrite_bars_count -= selected_component.refined_ferrite_cost
	GameManager.plasma_count -= selected_component.plasma_cost
	GameManager.add_mech_component(selected_component)
	update_description_box(selected_component)
	update_parts_owned_label()
	hide_confirmation_panel()
	SignalBus.update_parts_owned_on_previewer.emit()
	if GameManager.owned_components_count >= GameManager.MECH_PARTS_NEEDED:
		main_hub.animation_player.play("AllPartsBoughtStartFight")
		SignalBus.stop_ufo_spawn.emit()
		SignalBus.fade_out_alert.emit()
		GameManager.can_traverse_panes = false
	

func show_confirmation_panel() -> void:
	confirmation_box_is_showing = true
	animation_player.play("PanelSwoopIn")
	disable_confirmation_button(false)

func hide_confirmation_panel() -> void:
	confirmation_box_is_showing = false
	animation_player.play("PanelSwoopOut")
	disable_confirmation_button(true)

func _on_cancellation_button_button_down() -> void:
	SfxManager.play_button_click(sfx_player)
	sfx_player.stream = [SfxManager.UI_SHOP_BUY_NO_CASH_01,SfxManager.UI_SHOP_BUY_NO_CASH_02, SfxManager.UI_SHOP_BUY_NO_CASH_03].pick_random()
	sfx_player.play()
	hide_confirmation_panel()
	
func disable_confirmation_button(value : bool) -> void:
	confirmation_button.disabled = value
	cancellation_button.disabled = value


func show_already_purchased_label(component_name : String):
	if not GameManager.mech_component_slot_is_empty(component_name) \
	or component_name == "Weapon" and GameManager.owned_weapons_count == 2:
		slot_is_filled_label.text = component_name+ " component already owned."
		slot_is_filled_label.show()
	else:
		slot_is_filled_label.hide()
	
func update_parts_owned_label() -> void:
	parts_owned_label.text = "Parts Owned: " + str(GameManager.owned_components_count) + "/" + str(GameManager.MECH_PARTS_NEEDED)


func _on_purchase_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_cancellation_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_confirmation_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_heads_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_torsos_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_arms_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_legs_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_rifles_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_swords_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)


func _on_rocket_launchers_button_mouse_entered():
	SfxManager.play_button_hover(sfx_player)

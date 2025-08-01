class_name ShopPane extends Control
@onready var ferrite_bars_count : Label= $ColorRect/FerriteBarsCount
@onready var platinum_count : Label = $ColorRect/PlatinumCount
@onready var plasma_count: Label = $ColorRect/PlasmaCount
@onready var description_text_box: RichTextLabel = $ColorRect/DescriptionTextBox
@onready var item_menu: VBoxContainer = $ColorRect/ScrollContainer/ItemMenu
@onready var slot_is_filled_label: Label = $ColorRect/SlotIsFilledLabel
@onready var part_class: Label = $ColorRect/PartClass

@onready var purchase_button: Button = $ColorRect/PurchaseButton

@onready var item_name: Label = $ItemName

@onready var part_name: Label = $ColorRect/PartName
@onready var ferrite_cost: Label = $ColorRect/FerriteCost
@onready var plasma_cost: Label = $ColorRect/PlasmaCost
@onready var platinum_cost: Label = $ColorRect/PlatinumCost

@onready var confirmation_box: ColorRect = $ColorRect/ConfirmationBox
@onready var confirmation_button: Button = $ColorRect/ConfirmationBox/ConfirmationButton
@onready var cancellation_button: Button = $ColorRect/ConfirmationBox/CancellationButton
@onready var weight_class : Label = $ColorRect/WeightClass
@onready var weapon_type_focus : Label = $ColorRect/WeaponTypeFocus

@onready var parts_owned_label: Label = $ColorRect/PartsOwnedLabel

@export var main_hub : MainHub

var selected_component : MechComponent
var confirmation_box_is_showing : bool = false

func _ready() -> void:
	SignalBus.update_ferrite_bars_count.connect(update_ferrite_bars_count)
	SignalBus.update_plasma_count.connect(update_plasma_count)
	SignalBus.transfer_item_to_shop_panel.connect(update_description_box)
	slot_is_filled_label.hide()
	display_component_list("Heads")
	update_ferrite_bars_count()
	update_plasma_count()
	update_parts_owned_label()
	hide_confirmation_panel()
	
	
func _process(delta : float) -> void:
	
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
	weight_class.text = "Weight Class: " + selected_component.get_weight_class()
	weapon_type_focus.text = "Focus: " + selected_component.get_weapon_focus()

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
	show_confirmation_panel()


func _on_confirmation_button_button_down() -> void:
	GameManager.ferrite_bars_count -= selected_component.refined_ferrite_cost
	GameManager.plasma_count -= selected_component.plasma_cost
	GameManager.add_mech_component(selected_component)
	update_description_box(selected_component)
	update_parts_owned_label()
	hide_confirmation_panel()
	if GameManager.owned_components_count >= GameManager.MECH_PARTS_NEEDED:
		main_hub.animation_player.play("AllPartsBoughtStartFight")
		GameManager.can_traverse_panes = false
	

func show_confirmation_panel() -> void:
	confirmation_box_is_showing = true
	confirmation_box.show()
	disable_confirmation_button(false)

func hide_confirmation_panel() -> void:
	confirmation_box_is_showing = false
	confirmation_box.hide()
	disable_confirmation_button(true)

func _on_cancellation_button_button_down() -> void:
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

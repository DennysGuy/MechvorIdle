class_name ComponentSelectionMenu extends ColorRect

@onready var part_selected_notifier: Label = $PartSelectedNotifier

@onready var stats: RichTextLabel = $Stats
@onready var description: RichTextLabel = $Description
@onready var how_to_play: RichTextLabel = $HowToPlay
@onready var units_container: VBoxContainer = $ScrollContainer/UnitsContainer
@onready var currently_selected: Label = $CurrentlySelected

var selected_component : MechComponent 

var arms_1 : MechArms = preload("uid://cjuugvmjr36lj")
var arms_2 : MechArms = preload("uid://dx4e1hvellmxq")
var arms_3 : MechArms = preload("uid://4vf13bdn8i41")

var legs_1 : MechLegs = preload("uid://cpmb51aj71fpr")
var legs_2 : MechLegs = preload("uid://k1p5grxnndv3")
var legs_3 : MechLegs = preload("uid://kkoht6ubl33m")

var head_1 : MechHead = preload("uid://b7cbnbqyrpcv1")
var head_2 : MechHead = preload("uid://upu7rl2b14if")
var head_3 : MechHead = preload("uid://cmbchudcdtn2r")

var torso_1 : MechTorso = preload("uid://d2s3tleah2tvp")
var torso_2 : MechTorso = preload("uid://lr8shvddq7me")
var torso_3 : MechTorso = preload("uid://bjr7icnj7rnhl")

var rifle_1 : MechWeapon = preload("uid://dplngps46dubl")
var rifle_2 : MechWeapon = preload("uid://dbxh8e0i8qfhr")
var rifle_3 : MechWeapon = preload("uid://bs55jm2j143et")

var sword_1 : MechWeapon = preload("uid://baw08qvkimdvm")
var sword_2 : MechWeapon = preload("uid://brltesmvysom")
var sword_3 : MechWeapon = preload("uid://dyau5slcsx26u")

var launcher_2 : MechWeapon = preload("uid://d0us0h3brlcaf")

@onready var mech_arms : Array[MechComponent] = [arms_1,arms_2,arms_3]
@onready var mech_legs : Array[MechComponent] = [legs_1,legs_2,legs_3]
@onready var mech_torsos : Array[MechComponent] = [torso_1,torso_2,torso_3]
@onready var mech_heads : Array[MechComponent] = [head_1,head_2,head_3]

@onready var mech_weapons : Array[MechComponent] =[
	sword_2,
	rifle_1,
	launcher_2,
	sword_1,
	rifle_2,
	sword_3,
	rifle_3,
]

var selected_parts_list : MenuController.SELECTED_PARTS_LIST 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuController.show_sub_category_menu.connect(select_parts_list)
	MenuController.update_selected_part.connect(select_component)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_up() -> void:
	hide()


func populate_unit_container() -> void:
	clear_unit_container()
	match selected_parts_list:
		MenuController.SELECTED_PARTS_LIST.MECH_HEADS:
			create_unit_buttons(mech_heads)
			select_component(GameManager.get_owned_mech_head())
			update_selected_text(GameManager.get_owned_mech_head())
		MenuController.SELECTED_PARTS_LIST.MECH_ARMS:
			create_unit_buttons(mech_arms)
			select_component(GameManager.get_owned_mech_arms())
			update_selected_text(GameManager.get_owned_mech_arms())
		MenuController.SELECTED_PARTS_LIST.MECH_LEGS:
			create_unit_buttons(mech_legs)
			select_component(GameManager.get_owned_mech_legs())
			update_selected_text(GameManager.get_owned_mech_legs())
		MenuController.SELECTED_PARTS_LIST.MECH_TORSOS:
			create_unit_buttons(mech_torsos)
			select_component(GameManager.get_owned_mech_torso())
			update_selected_text(GameManager.get_owned_mech_torso())
		MenuController.SELECTED_PARTS_LIST.LEFT_WEAPON:
			create_unit_buttons(mech_weapons)
			select_component(GameManager.get_left_weapon())
			update_selected_text(GameManager.get_left_weapon())
		MenuController.SELECTED_PARTS_LIST.RIGHT_WEAPON:
			create_unit_buttons(mech_weapons)
			select_component(GameManager.get_right_weapon())
			update_selected_text(GameManager.get_right_weapon())

func populate_text_boxes(mech_component : MechComponent) -> void:
	stats.text = mech_component.stats
	description.text = mech_component.description
	how_to_play.text = mech_component.how_to_play

func clear_unit_container() -> void:
	for unit_button in units_container.get_children():
		unit_button.queue_free()


func update_selected_text(mech_component : MechComponent) -> void:
	currently_selected.text = "Selected: %s" % [mech_component.component_name]

func _on_back_2_button_up() -> void:
	equip_component()

func select_parts_list(list : MenuController.SELECTED_PARTS_LIST) -> void:
	selected_parts_list = list
	populate_unit_container()
	
	show()


func create_unit_buttons(list : Array[MechComponent]) -> void:
	clear_unit_container()
	for part in list:
		var unit_button : UnitPanelButton = preload("uid://bc51ym7w3jhsv").instantiate()
		unit_button.mech_component = part
		units_container.add_child(unit_button)

func select_component(mech_component : MechComponent) -> void:
	selected_component = mech_component
	stats.text = selected_component.stats
	description.text = selected_component.description
	how_to_play.text = selected_component.how_to_play
	SignalBus.show_part_preview.emit(selected_component)

	match selected_parts_list:
		MenuController.SELECTED_PARTS_LIST.MECH_ARMS:
			if selected_component == GameManager.get_owned_mech_arms():
				part_selected_notifier.show()
			else:
				part_selected_notifier.hide()
		MenuController.SELECTED_PARTS_LIST.MECH_HEADS:
			if selected_component == GameManager.get_owned_mech_head():
				part_selected_notifier.show()
			else:
				part_selected_notifier.hide()
		MenuController.SELECTED_PARTS_LIST.MECH_LEGS:
			if selected_component == GameManager.get_owned_mech_legs():
				part_selected_notifier.show()
			else:
				part_selected_notifier.hide()
		MenuController.SELECTED_PARTS_LIST.MECH_TORSOS:
			if selected_component == GameManager.get_owned_mech_torso():
				part_selected_notifier.show()
			else:
				part_selected_notifier.hide()
		MenuController.SELECTED_PARTS_LIST.LEFT_WEAPON:
			if selected_component == GameManager.get_left_weapon():
				part_selected_notifier.show()
			else:
				part_selected_notifier.hide()
		MenuController.SELECTED_PARTS_LIST.RIGHT_WEAPON:
			if selected_component == GameManager.get_right_weapon():
				part_selected_notifier.show()
			else:
				part_selected_notifier.hide()

func equip_component() -> void:
	match selected_parts_list:
		MenuController.SELECTED_PARTS_LIST.MECH_ARMS:
			GameManager.owned_mech_components["Arms"] = selected_component
			update_selected_text(GameManager.get_owned_mech_arms())
			part_selected_notifier.show()
		MenuController.SELECTED_PARTS_LIST.MECH_HEADS:
			GameManager.owned_mech_components["Head"] = selected_component
			update_selected_text(GameManager.get_owned_mech_head())
			part_selected_notifier.show()
		MenuController.SELECTED_PARTS_LIST.MECH_LEGS:
			GameManager.owned_mech_components["Legs"] = selected_component
			update_selected_text(GameManager.get_owned_mech_legs())
			part_selected_notifier.show()
		MenuController.SELECTED_PARTS_LIST.MECH_TORSOS:
			GameManager.owned_mech_components["Torso"] = selected_component
			update_selected_text(GameManager.get_owned_mech_torso())
			part_selected_notifier.show()
		MenuController.SELECTED_PARTS_LIST.LEFT_WEAPON:
			GameManager.owned_mech_components["LeftWeapon"] = selected_component
			update_selected_text(GameManager.get_left_weapon())
			part_selected_notifier.show()
		MenuController.SELECTED_PARTS_LIST.RIGHT_WEAPON:
			GameManager.owned_mech_components["RightWeapon"] = selected_component
			update_selected_text(GameManager.get_right_weapon())
			part_selected_notifier.show()
	
	MenuController.set_selected_part.emit()

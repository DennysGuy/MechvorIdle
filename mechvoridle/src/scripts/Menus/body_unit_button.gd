class_name BodyUnitButton extends Control

enum SELECTED_PARTS_LIST {
	MECH_HEADS,
	MECH_ARMS,
	MECH_LEGS,
	MECH_TORSOS,
	LEFT_WEAPON,
	RIGHT_WEAPON
}

@export_enum("mech_heads","mech_arms","mech_legs","mech_torsos","left_weapon","right_weapon") var part_list

@onready var corporation_icon: TextureRect = $CorporationIcon
@onready var body_part_label: Label = $BodyPartLabel
@onready var unit_name: Label = $UnitName

var mech_component : MechComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_selected_component()
	MenuController.set_selected_part.connect(set_selected_component)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_button_up() -> void:
	print("PRESSED!")
	MenuController.show_sub_category_menu.emit(part_list)

func set_selected_component() -> void:
	match part_list:
		MenuController.SELECTED_PARTS_LIST.MECH_HEADS:
			mech_component = GameManager.get_owned_mech_head()
			body_part_label.text = "Head Unit"
		MenuController.SELECTED_PARTS_LIST.MECH_ARMS:
			mech_component = GameManager.get_owned_mech_arms()
			body_part_label.text = "Arms Unit"
		MenuController.SELECTED_PARTS_LIST.MECH_LEGS:
			mech_component = GameManager.get_owned_mech_legs()
			body_part_label.text = "Legs Unit"
		MenuController.SELECTED_PARTS_LIST.MECH_TORSOS:
			mech_component = GameManager.get_owned_mech_torso()
			body_part_label.text = "Torso Unit"
		MenuController.SELECTED_PARTS_LIST.LEFT_WEAPON:
			mech_component = GameManager.get_left_weapon()
			body_part_label.text = "L-Hand Arms"
		MenuController.SELECTED_PARTS_LIST.RIGHT_WEAPON:
			mech_component = GameManager.get_right_weapon()
			body_part_label.text = "R-Hand Arms"
			
	if mech_component:
		corporation_icon.texture = mech_component.get_manufacturer_icon()
		unit_name.text = mech_component.component_name
	

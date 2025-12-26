extends Node

@warning_ignore("unused_signal")
signal show_sub_category_menu(sub_category : int)
signal update_selected_part(component : MechComponent)
signal set_selected_part

enum SELECTED_PARTS_LIST {
	MECH_HEADS,
	MECH_ARMS,
	MECH_LEGS,
	MECH_TORSOS,
	LEFT_WEAPON,
	RIGHT_WEAPON
}

class_name WeaponState extends State

enum POSITION {NONE, LEFT, RIGHT}
@export var weapon_position : POSITION = POSITION.NONE
@export var input_map : String

var weapon_component : MechWeapon

func get_position() -> POSITION:
	return weapon_position

func set_position_as_left() -> void:
	weapon_position = POSITION.LEFT
	weapon_component = GameManager.get_left_weapon()

func set_position_as_right() -> void:
	weapon_position = POSITION.RIGHT
	weapon_component = GameManager.get_right_weapon()

func is_left_position() -> bool:
	return weapon_position == POSITION.LEFT

func is_right_position() -> bool:
	return weapon_position == POSITION.RIGHT

class_name WeaponState extends State

enum POSITION {NONE, LEFT, RIGHT}
@export var weapon_position : POSITION = POSITION.NONE

func get_position() -> POSITION:
	return weapon_position

func set_position_as_left() -> void:
	weapon_position = POSITION.LEFT

func set_position_as_right() -> void:
	weapon_position = POSITION.RIGHT

func is_left_position() -> bool:
	return weapon_position == POSITION.LEFT

func is_right_position() -> bool:
	return weapon_position == POSITION.RIGHT

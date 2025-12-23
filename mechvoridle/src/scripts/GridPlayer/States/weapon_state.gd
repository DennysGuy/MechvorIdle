class_name WeaponState extends State

enum POSITION {LEFT, RIGHT}
@export var weapon_position : POSITION
@export var input_map : String

var weapon_component : MechWeapon
var heat_stacks : int = 0

func _process(delta: float) -> void:
	pass

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

func attack_tile(multiplier : int = 1, divisor : int = 1) -> void:
	if parent.locked_on_tile and parent.locked_on_tile.occupant:
		parent.locked_on_tile.occupant.damage_actor(weapon_component.damage * multiplier, false, weapon_component)
		GameManager.enable_hit_freeze(0.2,0.3)
		GameManager.add_heat(weapon_component.damage * multiplier, divisor)

class_name Weapon1Aim extends State

@export var weapon_1_fire : State
@export var idle : State

var offset : int = 0

func enter() -> void:
	offset = -2
	match GameManager.get_right_weapon().weapon_class:
		0:
			animation_name = "WideSwordAimRight"
	
	parent.animation_player.play(animation_name)

func exit() -> void:
	pass
func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_released("mine_asteroid"):
		return weapon_1_fire
	
	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
	
	if Input.is_action_just_pressed("move_up") and GameManager.get_right_weapon().attack_pattern.can_shift:
		var checked_x : float = parent.current_tile.coordinates.x + offset
		var checked_tile : Tile = GridManager.get_tile(parent.tiles, Vector2(parent.current_tile.coordinates.x + offset, parent.current_tile.coordinates.y))
		if !checked_tile:
			offset = -2
		else:
			offset += 1 

	return null

func process_frame(_delta: float) -> State:

	parent.scanned_attack_pattern = GameManager.get_right_weapon().attack_pattern.scan_tiles_of_effect(parent, parent.tiles, offset)
	return null

func process_physics(_delta: float) -> State:
	return null

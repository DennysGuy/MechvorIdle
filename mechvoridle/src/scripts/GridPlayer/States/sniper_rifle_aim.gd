class_name SniperRifleAIm extends WeaponState

const MIN_COLUMN := 0
const MAX_COLUMN := 3

var firing : bool = false
var offset_x : int = 0 
var offset_y : int = 0
@export var idle : State
@export var sniper_rifle_fire : WeaponState



func enter() -> void:
	firing = false
	parent.can_move = false
	parent.current_weapon_scanning = weapon_component
	offset_y = parent.current_tile.coordinates.y
	selected_tile = GridManager.get_tile(parent.tiles, Vector2(0, offset_y))
	print(selected_tile)
	if is_right_position():
		animation_name = "AimRifleRight"
	elif is_left_position():
		animation_name = "AimRifleLeft"
		
	parent.animation_player.play(animation_name)

func exit() -> void:
	if !firing:
		parent.can_move = true
		parent.can_fire_vulcans = true
		selected_tile.clear_targeted_overlay()
		selected_tile = null

func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_pressed("move_left"):
		if selected_tile:
			selected_tile.clear_targeted_overlay()

		offset_y -= 1
		if offset_y < MIN_COLUMN:
			offset_y = MIN_COLUMN
		
	selected_tile = GridManager.get_tile(parent.tiles, Vector2(0, offset_y))
	if selected_tile:
		selected_tile.set_targeted_overlay()

	if Input.is_action_just_pressed("move_right"):
		if selected_tile:
			selected_tile.clear_targeted_overlay()
		offset_y += 1
		if offset_y > MAX_COLUMN:
			offset_y = MAX_COLUMN
	
	selected_tile = GridManager.get_tile(parent.tiles, Vector2(0, offset_y))
	if selected_tile:
		selected_tile.set_targeted_overlay()
			
	return null

func process_frame(_delta: float) -> State:
	
	if Input.is_action_just_released(input_map):
		return sniper_rifle_fire
		
	if Input.is_action_just_pressed("fire_vulcans"):
		firing = true
	

	
	return null

func process_physics(_delta: float) -> State:
	return null

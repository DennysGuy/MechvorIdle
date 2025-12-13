class_name SniperRifleAimLeft extends WeaponState

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
	parent.locked_on_tile = GridManager.get_tile(parent.tiles, Vector2(0, offset_y))
	print(parent.locked_on_tile)
	SfxManager.play_sfx(SfxManager.SNIPER_AIM)
	animation_name = "AimRifleLeft"
	parent.laser_sight_left.show()
	parent.animation_player.play(animation_name)

func exit() -> void:
	if !firing:
		parent.target_location = null
		parent.can_move = true
		parent.can_fire_vulcans = true
		parent.locked_on_tile.clear_targeted_overlay()
		parent.locked_on_tile = null

		parent.laser_sight_left.hide()

func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_pressed("move_left"):
		SfxManager.play_sfx(SfxManager.SHIFT_1)
		if parent.locked_on_tile:
			parent.locked_on_tile.clear_targeted_overlay()

		offset_y -= 1
		if offset_y < MIN_COLUMN:
			offset_y = MIN_COLUMN
		
	parent.locked_on_tile = GridManager.get_tile(parent.tiles, Vector2(0, offset_y))
	if parent.locked_on_tile:
		parent.target_location = parent.locked_on_tile.marker_3d
		parent.locked_on_tile.set_targeted_overlay()

	if Input.is_action_just_pressed("move_right"):
		SfxManager.play_sfx(SfxManager.SHIFT_1)
		if parent.locked_on_tile:
			parent.locked_on_tile.clear_targeted_overlay()
		offset_y += 1
		if offset_y > MAX_COLUMN:
			offset_y = MAX_COLUMN
	
	parent.locked_on_tile = GridManager.get_tile(parent.tiles, Vector2(0, offset_y))
	
	if parent.locked_on_tile:
		parent.target_location = parent.locked_on_tile.marker_3d
		parent.locked_on_tile.set_targeted_overlay()
			
	return null

func process_frame(_delta: float) -> State:
	
	if Input.is_action_just_released(input_map):
		firing = true
		return sniper_rifle_fire
		
	if Input.is_action_just_pressed("fire_vulcans"):
		return idle
	
	return null

func process_physics(_delta: float) -> State:
	return null

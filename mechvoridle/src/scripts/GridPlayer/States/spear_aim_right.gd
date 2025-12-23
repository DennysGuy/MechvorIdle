class_name SpearAimRight extends WeaponState

@export var idle : State
@export var spear_fire : WeaponState

var time : float = 0.0
var firing : bool = false
var tiles_x_left : int = 4
var scanned_tiles : Array[Vector2]

func enter() -> void:
	tiles_x_left = 4
	parent.can_move = false
	firing = false
	time = 1
	var starting_coords : Vector2 = Vector2(4,parent.current_tile.coordinates.y)
	parent.scanned_attack_pattern.append(starting_coords)
	var starting_tile : Tile = GridManager.get_tile(parent.tiles,starting_coords)
	starting_tile.set_targeted_overlay()

	parent.targeted_tiles.append(starting_tile)
	parent.animation_player.play("SpearAimRight")
	
func exit() -> void:
	if !firing:
		parent.can_fire_vulcans = true
		parent.can_move = true
		parent.scanned_attack_pattern.clear()
		GridManager.clear_targeted_tiles()

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	time -= 4 * _delta
	if time <= 0.0 and tiles_x_left > 0:
		tiles_x_left -= 1

		var coordinates : Vector2 = Vector2(tiles_x_left, parent.current_tile.coordinates.y)
		parent.scanned_attack_pattern.append(coordinates)
		print("THESE ARE NEXT COORDINATES: %s" % coordinates)
		var appended_tile : Tile = GridManager.get_tile(parent.tiles, coordinates)
		appended_tile.set_targeted_overlay()
		parent.targeted_tiles.append(appended_tile)
			
		time = 1
	
	return null

func process_physics(_delta: float) -> State:
	
	if Input.is_action_just_pressed("fire_vulcans"):
		return idle
	
	if Input.is_action_just_released(input_map):
		firing = true
		return spear_fire
	
	return null
		

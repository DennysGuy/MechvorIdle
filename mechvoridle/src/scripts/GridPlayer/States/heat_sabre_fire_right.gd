class_name HeatSabreFireRight extends WeaponState

@export var idle : State

var dashing : bool = false

func enter() -> void:
	GameManager.can_fire_weapon_1 = false
	parent.can_move = false
	dashing = true
	move_to_end_of_grid()

	
func exit() -> void:
	SignalBus.issue_weapon_attack.emit(weapon_position)
	GridManager.clear_targeted_tiles()
	parent.can_move = true
	parent.can_fire_vulcans = true
	parent.locked_on_tile = null
	
func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if !dashing:
		return idle
	return null

func move_to_end_of_grid() -> void:
	var starting_tile : Tile= parent.current_tile
	
	for coordinates in parent.scanned_attack_pattern:
		var tile : Tile = GridManager.get_tile(parent.tiles, Vector2(coordinates.x * -1, starting_tile.coordinates.y))

		if tile.occupant:
			parent.locked_on_tile = tile
			parent.animation_player.play("HeatSabreSwingRight")
			attack_tile(1)
			await get_tree().create_timer(0.3).timeout
			attack_tile(1)
			break
		print(tile.coordinates)
		SignalBus.move_actor_to_tile.emit(parent,tile)
		
	await get_tree().create_timer(0.3).timeout
	dashing = false
	SignalBus.move_actor_to_tile.emit(parent,starting_tile)

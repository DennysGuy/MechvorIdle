class_name SpearAimFireRight extends WeaponState

@export var idle : State
var dashing = false
func enter() -> void:
	dashing = true
	parent.can_hurt = false
	parent.animation_player.play("SpearAimLungeRight")
	move_to_end_of_grid()

func exit() -> void:
	parent.can_move = true
	parent.can_fire_vulcans = true
	parent.scanned_attack_pattern.clear()
	GridManager.clear_targeted_tiles()

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if !dashing:
		return idle
	
	return null

func process_physics(_delta: float) -> State:
	return null
		

func move_to_end_of_grid() -> void:
	var starting_tile : Tile= parent.current_tile
	
	for coordinates in parent.scanned_attack_pattern:
		print("THESE ARE COORDINATES SCANNED: %s" % coordinates)
		var tile : Tile = GridManager.get_tile(parent.tiles, coordinates)
		if tile.occupant:
			tile.occupant.damage_actor(weapon_component.damage)
			GameManager.enable_hit_freeze(0.2,0.2)
			
		SignalBus.move_actor_to_tile.emit(parent,tile)
		
	await get_tree().create_timer(0.3).timeout
	dashing = false

	SignalBus.move_actor_to_tile.emit(parent,starting_tile)

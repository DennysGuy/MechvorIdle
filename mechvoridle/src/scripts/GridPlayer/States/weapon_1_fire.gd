class_name Weapon1Fire extends State

@export var idle : State

func enter() -> void:
	parent.can_move = false
	GameManager.can_fire_weapon_1 = false
	var previous_tile = parent.current_tile
	
	
	match GameManager.get_right_weapon().weapon_class:
		0:
			dash_attack()
			animation_name = "WideSwordSwing"
		1:
			GameManager.get_right_weapon().attack_enemy(parent, parent.tiles, parent.scanned_attack_pattern)
			animation_name = "RifleShotRight"

	parent.animation_player.play(animation_name)
	await get_tree().create_timer(0.3).timeout
	SignalBus.move_actor_to_tile.emit(parent, previous_tile)
	parent.state_machine.change_state(idle)


func dash_attack() -> void:
	var tile_to : Tile = GridManager.get_tile(parent.tiles, GridManager.targeted_tiles[0].coordinates + Vector2(1,0))
	
	GameManager.get_right_weapon().attack_enemy(parent, parent.tiles, parent.scanned_attack_pattern)
	SignalBus.move_actor_to_tile.emit(parent, tile_to)
	
	GridManager.clear_targeted_tiles()
		
func exit() -> void:
	parent.can_move = true
	parent.can_fire_vulcans = true
	SignalBus.issue_weapon_attack.emit(0)
	
	pass

func process_input(_event: InputEvent) -> State:
	
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

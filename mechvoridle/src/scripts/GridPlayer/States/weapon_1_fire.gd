class_name Weapon1Fire extends WeaponState

@export var idle : State

func enter() -> void:
	parent.can_move = false
	GameManager.can_fire_weapon_1 = false
	SignalBus.hide_damage_mulitplier_label.emit()
	var previous_tile = parent.current_tile
	
	dash_attack()
	if is_right_position():
		animation_name = "WideSwordSwing"
	elif is_left_position():
		animation_name = "WideSwordSwingLeft"

	parent.animation_player.play(animation_name)
	SignalBus.shake_camera.emit(0.6)
	await get_tree().create_timer(0.3).timeout
	
	SignalBus.move_actor_to_tile.emit(parent, previous_tile)
	parent.state_machine.change_state(idle)


func dash_attack() -> void:
	if GridManager.targeted_tiles.is_empty():
		return 
		
	var tile_to : Tile = GridManager.get_tile(parent.tiles, GridManager.targeted_tiles[0].coordinates + Vector2(1,0))
	var sfx := weapon_component.primary_projectile_discharge
	SfxManager.play_sfx(sfx)
	weapon_component.attack_enemy(parent, parent.tiles, parent.scanned_attack_pattern)
	SignalBus.move_actor_to_tile.emit(parent, tile_to)
	
	GridManager.clear_targeted_tiles()
		
func exit() -> void:
	parent.can_move = true
	parent.can_fire_vulcans = true
	weapon_component.damage = weapon_component.base_damage
	SignalBus.issue_weapon_attack.emit(0)
	
	pass

func process_input(_event: InputEvent) -> State:
	
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

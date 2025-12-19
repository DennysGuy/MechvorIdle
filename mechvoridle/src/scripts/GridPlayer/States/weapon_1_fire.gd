class_name WideSwordSwingRight extends WeaponState

@export var idle : State

func enter() -> void:
	parent.can_move = false
	GameManager.can_fire_weapon_1 = false
	SignalBus.hide_damage_mulitplier_label.emit()
	var previous_tile = parent.current_tile
	GameManager.add_heat(weapon_component.damage,2)
	dash_attack()

	animation_name = "WideSwordSwing"

	parent.animation_player.play(animation_name)
	SignalBus.shake_camera.emit(0.6)
	await get_tree().create_timer(0.3).timeout
	
	SignalBus.move_actor_to_tile.emit(parent, previous_tile)
	parent.state_machine.change_state(idle)

func dash_attack() -> void:
		
	var tile_to : Tile
	if !GridManager.locked_on_enemies.is_empty():
		var targeted_enemy : GridActor = GridManager.locked_on_enemies[0]
		tile_to = GridManager.get_tile(parent.tiles,targeted_enemy.current_tile.coordinates + Vector2(1,0))
		if targeted_enemy:
			targeted_enemy.damage_actor(int(weapon_component.damage * GameManager.next_multiplier),false,weapon_component)
	else:
		tile_to = GridManager.get_tile(parent.tiles, Vector2(1, parent.current_tile.coordinates.y))
		var get_tile_in_front : Tile = GridManager.get_tile(parent.tiles,Vector2(0, parent.current_tile.coordinates.y))
		if get_tile_in_front.occupant:
			get_tile_in_front.occupant.damage_actor(int(weapon_component.damage * GameManager.next_multiplier))
			
			
	var sfx := weapon_component.primary_projectile_discharge
	SfxManager.play_sfx(sfx,3)
	SignalBus.move_actor_to_tile.emit(parent, tile_to)
	GameManager.reset_next_attack_multiplier()
	GridManager.clear_targeted_tiles()
		
func exit() -> void:
	parent.can_move = true
	parent.can_fire_vulcans = true
	weapon_component.damage = weapon_component.base_damage
	SignalBus.issue_weapon_attack.emit(weapon_position)
	GridManager.remove_all_enemies_from_locked_on_list()

func process_input(_event: InputEvent) -> State:
	
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

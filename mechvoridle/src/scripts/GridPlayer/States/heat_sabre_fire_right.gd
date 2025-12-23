class_name HeatSabreFireRight extends WeaponState

@export var idle : State

var dashing : bool = false
var super_attack : bool = false
func enter() -> void:
	GameManager.can_fire_weapon_1 = false
	parent.can_move = false
	dashing = true
	SfxManager.play_sfx(SfxManager.H_SABRE_DASH)
	move_to_end_of_grid()

	
func exit() -> void:
	SignalBus.issue_weapon_attack.emit(weapon_position)
	GridManager.clear_targeted_tiles()
	GameManager.reset_next_attack_multiplier()
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
			update_heat_stacks()
			
			parent.locked_on_tile = tile
			parent.animation_player.play("HeatSabreSwingRight")
			issue_attack()
			await get_tree().create_timer(0.3).timeout
			issue_attack_2()
			break
		SignalBus.move_actor_to_tile.emit(parent,tile)
		
	await get_tree().create_timer(0.3).timeout
	dashing = false
	super_attack = false
	SignalBus.move_actor_to_tile.emit(parent,starting_tile)

func update_heat_stacks() -> void:
	var label_text : String = ""
	heat_stacks += 1
	
	if heat_stacks == 4:
		label_text = "Heat Attack Ready!"
	else:
		label_text = "RHS Stacks : %s" % [heat_stacks]
	
	if heat_stacks > 4:
		heat_stacks = 0
		super_attack = true
		label_text = "RHS Stacks : %s" % [heat_stacks]
	
	
	
	SignalBus.update_heat_stacks_right.emit(label_text)

func issue_attack() -> void:
	if super_attack:
		SfxManager.play_sfx(SfxManager.H_SABRE_SWING_1_SPECIAL)
		attack_tile(int(4 * GameManager.next_multiplier),2)
		SignalBus.shake_camera.emit(0.7)
	else:
		SfxManager.play_sfx(SfxManager.H_SABRE_SWING_1)
		attack_tile(int(1 * GameManager.next_multiplier),2)
		SignalBus.shake_camera.emit(0.3)

func issue_attack_2() -> void:
	if super_attack:
		SfxManager.play_sfx(SfxManager.H_SABRE_SWING_2_SPECIAL)
		attack_tile(int(4 * GameManager.next_multiplier),2)
		SignalBus.shake_camera.emit(0.7)
	else:
		SfxManager.play_sfx(SfxManager.H_SABRE_SWING_2)
		attack_tile(int(1 * GameManager.next_multiplier),2)
		SignalBus.shake_camera.emit(0.3)

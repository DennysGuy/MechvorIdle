class_name SniperRifleFireLeft extends WeaponState

@export var idle : State

func enter() -> void:
	animation_name = "RifleShotLeft"
	parent.laser_sight_left.hide()
	GameManager.can_fire_weapon_2 = false
	SfxManager.play_sfx(SfxManager.get_sniper_shot())
	var multiplier : int = 1
	if parent.locked_on_tile:
		multiplier += abs(parent.current_tile.coordinates.y - parent.locked_on_tile.coordinates.y)
	
	GameManager.add_heat(weapon_component.damage)
	attack_tile(multiplier)
	parent.animation_player.play(animation_name)
	
	await get_tree().create_timer(0.5).timeout
	parent.state_machine.change_state(idle)
	
func exit() -> void:
	SignalBus.issue_weapon_attack.emit(weapon_position)
	parent.target_location = null
	parent.can_fire_vulcans = true
	parent.can_move = true
	parent.locked_on_tile.clear_targeted_overlay()
	parent.locked_on_tile = null
	
func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

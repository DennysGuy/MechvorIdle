class_name ShoulderRocketFireRight extends WeaponState

@export var idle : State

func enter() -> void:
	parent.can_move = false
	GameManager.can_fire_weapon_1 = false
	await get_tree().create_timer(0.5).timeout
	parent.state_machine.change_state(idle)

func exit() -> void:
	parent.can_fire_vulcans = true
	SignalBus.issue_weapon_attack.emit(weapon_position)
	GridManager.remove_all_enemies_from_locked_on_list()
	parent.can_move = true

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	return null
		

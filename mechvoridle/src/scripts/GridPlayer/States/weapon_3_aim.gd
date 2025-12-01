class_name ArmRocketAim extends WeaponState

func enter() -> void:
	parent.current_weapon_scanning = weapon_component
	
func exit() -> void:
	parent.current_weapon_scanning = null

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
		

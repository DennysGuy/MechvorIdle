class_name SubMachineGunAim extends WeaponState

@export var idle : State
@export var sub_machine_gun_fire : State

func enter() -> void:
	if is_right_position():
		animation_name = "AimRifleRight"
	elif is_left_position():
		animation_name = "AimRifleLeft"
	
	parent.animation_player.play(animation_name)
	#We will handle aim functionailty 
func exit() -> void:
	parent.current_weapon_scanning = null

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if Input.is_action_just_released(input_map):
		return sub_machine_gun_fire

	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
	
	return null

func process_physics(_delta: float) -> State:
	return null

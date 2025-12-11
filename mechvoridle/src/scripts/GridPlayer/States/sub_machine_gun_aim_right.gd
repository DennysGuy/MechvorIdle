class_name SubMachineGunAimRight extends WeaponState

@export var idle : State
@export var sub_machine_gun_fire_right : State

func enter() -> void:
	animation_name = "AimRifleRight"
	parent.animation_player.play(animation_name)
	#We will handle aim functionailty 
	
func exit() -> void:
	parent.current_weapon_scanning = null

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if Input.is_action_just_released(input_map):
		return sub_machine_gun_fire_right

	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
	
	return null

func process_physics(_delta: float) -> State:
	parent.scanned_attack_pattern = weapon_component.attack_pattern.scan_tiles_of_effect(parent, parent.tiles)
	return null

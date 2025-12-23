class_name ArmRocketAimLeft extends WeaponState

@export var idle : State
@export var arm_rocket_fire : WeaponState 

var firing : bool = false
var can_fire : bool = false
func enter() -> void:
	firing = false
	can_fire = false
	animation_name = "AimArmRocketLeft"

	parent.animation_player.play(animation_name)
	

	var sfx := weapon_component.charge_up
	SfxManager.play_sfx(sfx)
	
func exit() -> void:
	if !firing:
		parent.can_fire_vulcans = true

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	
	parent.scanned_attack_pattern = weapon_component.attack_pattern.scan_tiles_of_effect(parent, parent.tiles)
	
	return null

func process_physics(_delta: float) -> State:

	if Input.is_action_just_released(input_map):
		firing = true
		return arm_rocket_fire
		
	if Input.is_action_just_pressed("fire_vulcans"):
		return idle

	return null
		

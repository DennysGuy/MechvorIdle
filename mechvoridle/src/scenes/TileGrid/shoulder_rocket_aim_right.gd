class_name ShoulderRocketAimRight extends WeaponState

@export var idle : State
@export var shoulder_rocket_fire : WeaponState

var firing : bool = false

func enter() -> void:
	firing = false
	parent.animation_player.play("ShoulderRocketAimRight")

func exit() -> void:
	if !firing:
		GridManager.remove_all_enemies_from_locked_on_list()
		parent.can_fire_vulcans = true


func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	parent.scanned_attack_pattern = weapon_component.attack_pattern.scan_tiles_of_effect(parent, parent.tiles)
	return null

func process_physics(_delta: float) -> State:
	if Input.is_action_just_pressed("fire_vulcans"):
		return idle
	
	if Input.is_action_just_released(input_map):
		firing = true
		return shoulder_rocket_fire
	
	return null
		

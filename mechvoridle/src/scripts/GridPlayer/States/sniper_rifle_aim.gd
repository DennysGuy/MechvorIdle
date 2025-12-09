class_name SniperRifleAIm extends WeaponState

const MIN_COLUMN := 0
const MAX_COLUMN := 4

var firing : bool = false
var offset_x : int = 0 
var offset_y : int = 0
@export var idle : State
@export var sniper_rifle_fire : WeaponState

func enter() -> void:
	firing = false
	parent.can_move = false
	parent.current_weapon_scanning = weapon_component
	offset_x = 0
	offset_y = 0
	if is_right_position():
		animation_name = "AimRifleRight"
	elif is_left_position():
		animation_name = "AimRifleLeft"
		
	parent.animation_player.play(animation_name)

func exit() -> void:
	if !firing:
		parent.can_move = true
		parent.can_fire_vulcans = true

func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_pressed("move_left"):
		offset_y += 1
			

	if Input.is_action_just_pressed("move_right"):
		offset_y -= 1
			
	return null

func process_frame(_delta: float) -> State:
	
	if Input.is_action_just_released(input_map):
		return sniper_rifle_fire
		
	if Input.is_action_just_pressed("fire_vulcans"):
		firing = true
	
	parent.scanned_attack_pattern = weapon_component.attack_pattern.scan_tiles_of_effect(parent, parent.tiles, 0, offset_y)
	
	return null

func process_physics(_delta: float) -> State:
	return null

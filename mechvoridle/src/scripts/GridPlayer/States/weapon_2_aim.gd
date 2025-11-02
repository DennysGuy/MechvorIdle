class_name Weapon2Aim extends State

@export var weapon_2_fire : State
@export var idle : State

var offset : int = 0

func enter() -> void:
	offset = 0
	match GameManager.get_left_weapon().weapon_class:
		1:
			animation_name = "AimRifleLeft"
	
	parent.animation_player.play(animation_name)
	
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_released("set_drone_destination"):
		return weapon_2_fire
	
	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
	
	if Input.is_action_just_pressed("move_up") and GameManager.get_left_weapon().attack_pattern.can_shift:
		offset += 1 
	

	if Input.is_action_just_pressed("move_down") and GameManager.get_left_weapon().attack_pattern.can_shift:
		offset -= 1


	return null

func process_frame(_delta: float) -> State:
	
	parent.scanned_attack_pattern = GameManager.get_left_weapon().attack_pattern.scan_tiles_of_effect(parent, parent.tiles)
	
	return null

func process_physics(_delta: float) -> State:
	return null

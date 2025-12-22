class_name RifleAimRight extends WeaponState

@export var rifle_right_fire : State
@export var idle : State

var offset : int = 0
func enter() -> void:
	offset = 0
	parent.rifle_charged_up = false
	parent.charge_up_timer.wait_time = 0.6
	parent.current_weapon_scanning = weapon_component
	
	animation_name = "AimRifleRight"

	parent.animation_player.play(animation_name)
	parent.charge_up_timer.start()
	var sfx := weapon_component.charge_up
	SfxManager.play_sfx(sfx)
	
func exit() -> void:
	parent.current_weapon_scanning = null

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_released(input_map):
		return rifle_right_fire

	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
		
	return null

func process_frame(_delta: float) -> State:
	if !parent.rifle_charged_up:
		parent.scanned_attack_pattern = weapon_component.attack_pattern.scan_tiles_of_effect(parent, parent.tiles)

	else:
		parent.scanned_attack_pattern = weapon_component.secondary_attack_pattern.scan_tiles_of_effect(parent, parent.tiles)

	return null

func process_physics(_delta: float) -> State:
	return null


func _on_charge_up_timer_timeout() -> void:
	parent.rifle_charged_up = true

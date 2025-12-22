class_name HeatSabreAimLeft extends WeaponState

@export var idle : State
@export var heat_sabre_fire : WeaponState

var firing : bool = false

func enter() -> void:
	firing = false
	var sfx := weapon_component.charge_up
	parent.current_weapon_scanning = weapon_component
	SfxManager.play_sfx(sfx)
	
	parent.animation_player.play("HeatSabreAimLeft")

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
		return heat_sabre_fire
		
	if Input.is_action_just_pressed("fire_vulcans"):
		return idle
	
	return null

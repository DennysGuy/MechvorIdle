class_name WideSwordAim extends WeaponState


#I NEED TO FIGURE OUT IF WE'RE DOING LEFT OR RIGHT!!!

@export var wide_sword_swing_fire : State
@export var idle : State

var offset : int = 0
var shift_time : float = 0.5
var damage_multiplier := 1.0
var i : int = 0
var is_attacking : bool = false

func enter() -> void:
	is_attacking = false
	var sfx := weapon_component.charge_up
	parent.current_weapon_scanning = weapon_component
	print(parent.current_weapon_scanning)
	SfxManager.play_sfx(sfx)
	damage_multiplier = 1.0
	i = 0
	shift_time = 0.5
	parent.delay_timer.wait_time = shift_time
	parent.delay_timer.start()
	offset = -2
	
	if is_right_position():
		parent.animation_player.play("WideSwordAimRight")
	elif is_left_position():
		parent.animation_player.play("WideSwordAimLeft")

func exit() -> void:
	parent.current_weapon_scanning = null
	if !is_attacking:
		GridManager.remove_all_enemies_from_locked_on_list()
	weapon_component.damage *= damage_multiplier
	
	
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_released(input_map):
		is_attacking = true
		return wide_sword_swing_fire
	
	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
	
	

	return null

func process_frame(_delta: float) -> State:
	parent.scanned_attack_pattern = weapon_component.attack_pattern.scan_tiles_of_effect(parent, parent.tiles, offset)
	return null

func process_physics(_delta: float) -> State:
	if parent.delay_timer.time_left <= 0:
		var checked_x : float = parent.current_tile.coordinates.x + offset
		var checked_tile : Tile = GridManager.get_tile(parent.tiles, Vector2(checked_x, parent.current_tile.coordinates.y))
		if !checked_tile:
			offset = -2
		else:
			offset += 1 

		if i < 3:
			shift_time -= 0.3
			i += 1
			damage_multiplier += 0.35
		else:
			shift_time = 0.75
			damage_multiplier = 1.0
			i = 0
		
		SignalBus.show_damage_multiplier_label.emit(damage_multiplier)
		parent.delay_timer.wait_time = shift_time
		parent.delay_timer.start()
		
		
	return null

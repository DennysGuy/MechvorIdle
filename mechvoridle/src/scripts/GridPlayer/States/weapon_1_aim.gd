class_name Weapon1Aim extends State

@export var weapon_1_fire : State
@export var idle : State

var offset : int = 0
var shift_time : float = 0.5
var damage_multiplier := 1.0
var i : int = 0
func enter() -> void:
	GameManager.get_right_weapon().damage = 30.0
	damage_multiplier = 1.0
	i = 0
	shift_time = 0.5
	parent.delay_timer.wait_time = shift_time
	parent.delay_timer.start()
	offset = -2

	parent.animation_player.play("WideSwordAimRight")

func exit() -> void:
	GameManager.get_right_weapon().damage *= damage_multiplier
	print("RIGHT WEAPON DAMAGE: " + str(GameManager.get_right_weapon().damage))
	
	
func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_released("mine_asteroid"):
		return weapon_1_fire
	
	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
	
	

	return null

func process_frame(_delta: float) -> State:


	parent.scanned_attack_pattern = GameManager.get_right_weapon().attack_pattern.scan_tiles_of_effect(parent, parent.tiles, offset)
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

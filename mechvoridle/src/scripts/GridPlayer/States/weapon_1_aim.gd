class_name Weapon1Aim extends State

@export var weapon_1_fire : State
@export var idle : State

var offset : int = 0
var shift_time : float = 0.5
var i : int = 0
func enter() -> void:
	i = 0
	shift_time = 0.5
	parent.delay_timer.wait_time = shift_time
	parent.delay_timer.start()
	offset = -2
	match GameManager.get_right_weapon().weapon_class:
		0:
			animation_name = "WideSwordAimRight"
	
	parent.animation_player.play(animation_name)

func exit() -> void:
	pass
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
		else:
			shift_time = 0.75
			i = 0
		
		
		parent.delay_timer.wait_time = shift_time
		parent.delay_timer.start()
		
		
	return null

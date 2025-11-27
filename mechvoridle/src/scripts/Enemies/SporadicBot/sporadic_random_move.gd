class_name SporadicRandomMove extends State

@export var idle : State
@export var attack : State
@export var three_tile_shot : State
@export var timer_wait : float = 0.3
var time_to_shoot : int = 0
@export var interval_min_val : int = 2
@export var interval_max_val : int = 4
var interval : int = 0

var three_shot_state : bool = false

var random_direction_list : Array[Vector2] = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]

func enter() -> void:
	
	var random_num : int = randi_range(0,100)
	
	if random_num <= 25:
		three_shot_state = true

	else:
		SfxManager.play_sfx(SfxManager.get_enemy_movement_whoosh())
		interval = 1
		
		var coordinates : Vector2 = Vector2.ZERO
		
		var rand_num : int = randi_range(0,100)
		if rand_num <= 75:
			print("HEY PLAYA")
			coordinates = Vector2(randi_range(0,3), GridManager.player.current_tile.coordinates.y)
			print("THESE ARE MY NEW COORDS: %s" % [coordinates] )
		else:
			var random_tile : Tile = parent.tiles.get_children().pick_random()
			coordinates = random_tile.coordinates
		
		
		SignalBus.send_actor_to_tile.emit(parent, coordinates, parent.row_limit, parent.col_limit)
		time_to_shoot += 1
		parent.timer.wait_time = timer_wait
		parent.timer.start()

func exit() -> void:
	three_shot_state = false

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.timer.time_left <= 0:
		
		if three_shot_state:
			return three_tile_shot
		
		if time_to_shoot >= interval:
			time_to_shoot = 0
			return attack
			
		return idle
	
	return null

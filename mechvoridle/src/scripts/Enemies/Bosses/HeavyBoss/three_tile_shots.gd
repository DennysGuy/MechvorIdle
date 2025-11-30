class_name ThreeTileShots extends State

@export var idle : State
var initial_tile : Tile
var is_active : bool = false
var is_attacking : bool = false

func enter() -> void:
	is_active = true
	is_attacking = true
	# Move to the initial tile (1,0)
	initial_tile = GridManager.get_tile(parent.tiles, Vector2(0, 0))
	if initial_tile:
		SignalBus.move_actor_to_tile.emit(parent, initial_tile)

	# Determine vertical path (current y → 2)
	var target_y : int = 3
	var start_y : int = parent.current_tile.coordinates.y

	for y in range(start_y, target_y + 1):
		if !is_active:
			return

		# Step 1: Move to the next tile
		var next_tile : Tile = GridManager.get_tile(parent.tiles, Vector2(0, y))
		if next_tile:
			SignalBus.move_actor_to_tile.emit(parent, next_tile)

		if !is_active:
			return

		# Step 2: Perform attack at this tile
		parent.animation_player.speed_scale = 1.0
		parent.animation_player.play("CanonArmFire")

		# Wait for shot duration
		var timeout = await get_tree().create_timer(0.6).timeout
		if !is_active:
			return

	# Finished all moves + shots
	is_attacking = false

func process_physics(_delta: float) -> State:
	if !is_attacking:
		return idle
	return null


func exit() -> void:
	is_active = false	# stops async continuation
	is_attacking = false
	parent.animation_player.speed_scale = 1.0

extends State

@export var taunt : State

func enter() -> void:
	var destined_tile : Tile = GridManager.get_tile(parent.tiles,Vector2(0,1))
	SignalBus.move_actor_to_tile.emit(parent, destined_tile)
	parent.animation_player.play("Guard")

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	#we'll have some sort of func that will call waves of enemies
	if parent.change_phase:
		return taunt
	
	return null
		

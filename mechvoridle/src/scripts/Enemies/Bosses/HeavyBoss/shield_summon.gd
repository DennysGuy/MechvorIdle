extends State

@export var taunt : State

func enter() -> void:
	parent.can_hurt = false
	var destined_tile : Tile = GridManager.get_tile(parent.tiles,Vector2(0,1))
	SignalBus.move_actor_to_tile.emit(parent, destined_tile)
	parent.animation_player.play("Guard")
	await get_tree().create_timer(1.5).timeout
	parent.spawn_mini_wave()
	
func exit() -> void:
	parent.hide_shield()
	parent.can_hurt = true

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	#we'll have some sort of func that will call waves of enemies
	if parent.change_phase:
		SignalBus.apply_timer_consequences.emit()
		return taunt
	
	return null
		

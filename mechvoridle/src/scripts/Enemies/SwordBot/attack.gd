class_name SwordBotAttack extends State

@export var idle : State

func enter() -> void:
	dash_attack()

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
		
func dash_attack() -> void:
	var tile_to : Tile = GridManager.get_tile(parent.tiles, parent.tile_to_attack.coordinates - Vector2(1,0))
	
	parent.weapon.attack_enemy(parent, parent.tiles)
	SignalBus.move_actor_to_tile.emit(parent, tile_to)
	parent.animation_player.play("Swing")
	await get_tree().create_timer(0.25).timeout
	SignalBus.move_actor_to_tile.emit(parent, parent.destined_tile)
	parent.tile_to_attack.clear_targeted_overlay()
	parent.state_machine.change_state(idle)
	

class_name SwordBotAttack extends State

@export var idle : State
@export var stagger : State
func enter() -> void:
	parent.is_attacking = true
	var tile_to : Tile
	if parent.tile_to_attack:
		tile_to  = GridManager.get_tile(parent.tiles, parent.tile_to_attack.coordinates - Vector2(1,0))

	if tile_to:
		var pitch_scale := 1.0
		
		if GameManager.in_overdrive_mode:
			pitch_scale = 0.7
		
		SfxManager.play_sfx(SfxManager.SWORD_BOT_SWING,0,false,pitch_scale)
		SignalBus.move_actor_to_tile.emit(parent, tile_to)
		if is_instance_valid(GridManager.player):
			parent.attack_player(parent.tile_to_attack.occupant)
		if parent.in_stagger_state:
			parent.state_machine.change_state(stagger)
		else:
			parent.animation_player.play("Swing")
			if !GameManager.in_overdrive_mode:
				parent.timer.wait_time = 0.8
			else:
				parent.timer.wait_time = 0.3
			parent.timer.start()

func exit() -> void:
	parent.is_attacking = false
	if !parent.is_slave and parent.destined_tile:
		var slave_destined_tile : Tile = GridManager.get_tile(parent.tiles, parent.destined_tile.coordinates - Vector2(1,0))
		SignalBus.slave_attack.emit(slave_destined_tile, parent.tile_to_attack)
	if parent.tile_to_attack:
		parent.tile_to_attack.clear_targeted_overlay()
	if !parent.in_stagger_state and !parent.is_slave:
		parent.tile_to_attack = null
		parent.destined_tile = null

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		if parent.destined_tile:
			SignalBus.move_actor_to_tile.emit(parent, parent.destined_tile)
		if parent.tile_to_attack:
			parent.tile_to_attack.clear_targeted_overlay()
		parent.state_machine.change_state(idle)
	
	return null

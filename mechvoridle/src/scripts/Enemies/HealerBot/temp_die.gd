class_name TempDeath extends State


func enter() -> void:
	if parent == GridManager.player:
		SignalBus.transition_lose_screen.emit()
	
	if parent is SwordBot and !parent.is_slave:
		if parent.is_slave:
			SignalBus.slave_to_idle.emit()
		else:
			SignalBus.free_slave.emit()
			
	parent.queue_free()

func exit() -> void:

		
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

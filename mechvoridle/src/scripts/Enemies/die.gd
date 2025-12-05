class_name EnemyDead extends State

@export var idle : State 
func enter() -> void:
	GameManager.update_score(parent.score)
	SignalBus.spawn_health_crate.emit(parent.drop_chance)
	if parent.animation_player:
		parent.animation_player.play("die")
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:

	return null

func process_physics(_delta: float) -> State:
	return null

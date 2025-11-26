class_name PlayerDeath extends State

const PLAYER_LOSE_EXPLOSIONS = preload("uid://dsmnsm604ayt5")

func enter() -> void:
	SfxManager.play_sfx(PLAYER_LOSE_EXPLOSIONS)
	SignalBus.transition_lose_screen.emit()
	parent.animation_player.speed_scale = 0.2
	parent.animation_player.play("Death")

func exit() -> void:

		
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

class_name PlayerDeath extends State

const PLAYER_LOSE_EXPLOSIONS = preload("uid://dsmnsm604ayt5")

func enter() -> void:
	parent.can_move = false
	SfxManager.play_sfx(PLAYER_LOSE_EXPLOSIONS,3)
	parent.animation_player.speed_scale = 0.2
	parent.animation_player.play("Death")
	SignalBus.transition_lose_screen.emit()

func exit() -> void:

		
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

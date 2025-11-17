class_name BossWait extends State

@export var idle : State

func enter() -> void:
	parent.animation_player.play("Idle")

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if GameManager.fight_on:
		return idle
	
	return null
		

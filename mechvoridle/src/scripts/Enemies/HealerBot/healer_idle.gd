class_name HealerIdle extends State

@export var heal : State

func enter() -> void:
	parent.animation_player.play("idle")
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:

	return null

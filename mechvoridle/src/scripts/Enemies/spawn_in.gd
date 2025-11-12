class_name EnemySpawnIn extends State

@export var idle : State

func enter() -> void:
	parent.can_hurt = false
	parent.hit_flash_animation_player.play("SpawnIn")

func exit() -> void:
	parent.can_hurt = true
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.can_move:
		return idle
	return null
		

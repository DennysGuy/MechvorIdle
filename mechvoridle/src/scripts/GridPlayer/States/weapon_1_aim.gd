class_name Weapon1Aim extends State

@export var weapon_1_fire : State
@export var idle : State

func enter() -> void:
	match GameManager.get_right_weapon().weapon_class:
		0:
			animation_name = "WideSwordAimRight"
	
	parent.animation_player.play(animation_name)

func exit() -> void:
	pass
func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_released("mine_asteroid"):
		return weapon_1_fire
	
	if Input.is_action_just_pressed("fire_vulcans"):
		parent.can_move = true
		parent.can_fire_vulcans = true
		return idle
	
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

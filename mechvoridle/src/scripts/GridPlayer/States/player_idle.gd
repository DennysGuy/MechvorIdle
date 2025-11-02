class_name PlayerIdle extends State

@export var weapon_1_aim : State

@export var weapon_2_aim : State


func enter() -> void:
	parent.animation_player.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_pressed("mine_asteroid") and GameManager.can_fire_weapon_1:
		parent.can_fire_vulcans = false
		return weapon_1_aim
		
		
	
	if Input.is_action_just_pressed("set_drone_destination") and GameManager.can_fire_weapon_2:
		parent.can_fire_vulcans = false
		return weapon_2_aim
		
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

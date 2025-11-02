class_name Weapon1Fire extends State

@export var idle : State

func enter() -> void:
	parent.can_move = false
	GameManager.can_fire_weapon_1 = false
	
	GameManager.get_right_weapon().attack_enemy(parent,parent.tiles,parent.scanned_attack_pattern)
	
	GridManager.clear_targeted_tiles()

	match GameManager.get_right_weapon().weapon_class:
		0:
			animation_name = "WideSwordSwing"

	parent.animation_player.play(animation_name)
	await get_tree().create_timer(0.3).timeout
	parent.state_machine.change_state(idle)
			
func exit() -> void:
	parent.can_move = true
	parent.can_fire_vulcans = true
	SignalBus.issue_weapon_attack.emit(0)
	
	pass

func process_input(_event: InputEvent) -> State:
	
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

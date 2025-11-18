class_name Weapon2Fire extends State

@export var idle : State

func enter() -> void:
	parent.can_move = false
	GameManager.can_fire_weapon_2 = false
	#GameManager.get_left_weapon().attack_enemy(parent,parent.tiles,parent.scanned_attack_pattern)
	
	
	match GameManager.get_left_weapon().weapon_class:
		1:
			animation_name = "RifleShotLeft"
			
	GridManager.clear_targeted_tiles()
	var sfx : AudioStream
	if parent.rifle_charged_up:
		sfx = GameManager.get_left_weapon().primary_projectile_discharge
	else:
		sfx = GameManager.get_left_weapon().secondary_projectile_discharge
		
	SfxManager.play_sfx(sfx)
	parent.animation_player.play(animation_name)
	await get_tree().create_timer(0.5).timeout
	parent.state_machine.change_state(idle)
	
func exit() -> void:
	SignalBus.issue_weapon_attack.emit(1)
	parent.can_fire_vulcans = true
	parent.can_move = true
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null


func _on_charge_up_timer_timeout() -> void:
	pass # Replace with function body.

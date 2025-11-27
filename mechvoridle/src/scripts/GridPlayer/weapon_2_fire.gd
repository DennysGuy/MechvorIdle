class_name Weapon2Fire extends WeaponState

@export var idle : State

func enter() -> void:
	parent.can_move = false
	
	#GameManager.get_left_weapon().attack_enemy(parent,parent.tiles,parent.scanned_attack_pattern)
	
	if is_right_position():
		animation_name = "ArmRocketFireRight"
		GameManager.can_fire_weapon_1 = false
	elif is_left_position():
		animation_name = "RifleShotLeft"
		GameManager.can_fire_weapon_2 = false
			
	GridManager.clear_targeted_tiles()
	var sfx : AudioStream
	if parent.rifle_charged_up:
		SignalBus.shake_camera.emit(1.0)
		sfx = weapon_component.primary_projectile_discharge
	else:
		SignalBus.shake_camera.emit(0.7)
		sfx = weapon_component.secondary_projectile_discharge
		
	SfxManager.play_sfx(sfx)
	parent.animation_player.play(animation_name)
	await get_tree().create_timer(0.5).timeout
	parent.state_machine.change_state(idle)
	
func exit() -> void:
	SignalBus.issue_weapon_attack.emit(1)
	parent.can_fire_vulcans = true
	parent.can_move = true

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null


func _on_charge_up_timer_timeout() -> void:
	pass # Replace with function body.

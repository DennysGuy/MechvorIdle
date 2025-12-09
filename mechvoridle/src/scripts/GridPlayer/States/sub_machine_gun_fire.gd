class_name SubMachineGunFire extends WeaponState

@export var idle : State

func enter() -> void:
	parent.can_move = false
	if is_right_position():
		animation_name = "SubMachineGunFireRight"
		GameManager.can_fire_weapon_1 = false
	elif is_left_position():
		animation_name = "SubMachineGunShotLeft"
		GameManager.can_fire_weapon_2 = false
	
	parent.animation_player.play(animation_name)
	weapon_component.attack_enemy(parent,parent.tiles)
	parent.timer.wait_time = 0.5
	parent.timer.start()
	#We will handle aim functionailty 
func exit() -> void:
	GameManager.reset_next_attack_multiplier()
	SignalBus.issue_weapon_attack.emit(weapon_position)
	parent.can_fire_vulcans = true
	parent.can_move = true

func process_input(_event: InputEvent) -> State:
	
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	if parent.timer.time_left <= 0:
		return idle
	return null

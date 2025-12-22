class_name ArmRocketFireRight extends WeaponState


@export var idle : State

func enter() -> void:
	parent.can_move = false
	
	animation_name = "ArmRocketFireRight"
	GameManager.can_fire_weapon_1 = false
	
	GridManager.clear_targeted_tiles()
	var sfx : AudioStream
	
	SignalBus.shake_camera.emit(0.7)
	sfx = weapon_component.secondary_projectile_discharge
	
	GameManager.add_heat(weapon_component.damage,3)
	parent.fire_projectile(weapon_component,parent.arm_rocket_1_spout,8)
	
	SfxManager.play_sfx(sfx)
	parent.animation_player.play(animation_name)
	await get_tree().create_timer(0.5).timeout
	parent.state_machine.change_state(idle)
	
func exit() -> void:
	parent.can_move = true
	SignalBus.issue_weapon_attack.emit(weapon_position)
	parent.can_fire_vulcans = true
	

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

class_name SubMachineGunFireRight extends WeaponState

@export var idle : State

func enter() -> void:
	parent.can_move = false
	animation_name = "SubmachinegunFireRight"
	GameManager.can_fire_weapon_1 = false
	
	parent.animation_player.play(animation_name)
	weapon_component.attack_enemy(parent,parent.tiles)
	parent.timer.wait_time = 0.5
	parent.timer.start()
	#We will handle aim functionailty 
func exit() -> void:
	GameManager.reset_next_attack_multiplier()
	SignalBus.issue_weapon_attack.emit(POSITION.RIGHT)
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

func fire_smg_muzzle_flare_right() -> void:
	var muzzle_flare : WeaponMuzzleFlare =  preload("uid://bqgicaqmm0vsq").instantiate()
	muzzle_flare.global_position = parent.rifle_1_spout.global_position
	
	SfxManager.play_sfx(SfxManager.get_smg_shot())
	add_child(muzzle_flare)
	weapon_component.attack_enemy(parent,parent.tiles,[])
	print("HIT WITH SMG!")

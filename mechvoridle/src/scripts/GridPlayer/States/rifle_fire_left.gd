class_name RifleFireLeft extends WeaponState

@export var idle : State

func enter() -> void:
	parent.can_move = true
	#GameManager.get_left_weapon().attack_enemy(parent,parent.tiles,parent.scanned_attack_pattern)
	

	animation_name = "RifleShotLeft"
	GameManager.can_fire_weapon_2 = false
	fire_rifle()
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
	SignalBus.issue_weapon_attack.emit(weapon_position)
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


func fire_rifle() -> void:
	var weapon_spout : Marker3D
	weapon_spout = parent.rifle_2_spout

	if !parent.rifle_charged_up:
		GameManager.add_heat(weapon_component.damage,3)
		parent.fire_projectile(weapon_component, weapon_spout)
	else:
		var damage_reduction_multiplier : float = 0.75
		weapon_component.secondary_attack_pattern.issue_attack(parent, parent.tiles, int(weapon_component.damage * damage_reduction_multiplier * GameManager.next_multiplier),weapon_component.hit_freeze)
		GameManager.reset_next_attack_multiplier()
		var sniper_blast : SniperBlast = preload("uid://cboxtbu6wo1sy").instantiate()
		sniper_blast.global_position = weapon_spout.global_position
		get_parent().add_child(sniper_blast)

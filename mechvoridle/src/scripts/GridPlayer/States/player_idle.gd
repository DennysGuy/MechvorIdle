class_name GridPlayerIdle extends State

#TODO Need to see the aim state on load in for whatever weapon is equipped
#TODO Need to determine which weapon and which hand its in for proper animation and firing pos (if applicable)

@export var weapon_1_aim : State
@export var weapon_2_aim : State

func enter() -> void:
	parent.animation_player.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	if parent.can_move:
		if Input.is_action_just_pressed("mine_asteroid") and GameManager.can_fire_weapon_1:
			parent.can_fire_vulcans = false
			return weapon_1_aim
		
		if Input.is_action_just_pressed("set_drone_destination") and GameManager.can_fire_weapon_2:
			parent.can_fire_vulcans = false
			return weapon_2_aim
		
		if Input.is_action_just_pressed("overdrive_activate") and GameManager.can_activate_overdrive:
			#activate overdrive mode and timer
			SignalBus.show_overdrive_visuals.emit()
			SignalBus.start_overdrive_mode.emit()
			SignalBus.set_move_speed_to_od.emit()
			SignalBus.set_slow_factor_twenty.emit()
			GameManager.in_overdrive_mode = true
			GameManager.can_activate_overdrive = false
			SfxManager.play_sfx(SfxManager.OD_MODE_ACTIVATE,2)
		
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

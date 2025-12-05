class_name SwordBotPrepare extends State

@export var idle : State
@export var attack : State
var issued_slave_signal : bool = false

const SWORD_BOT_PREPARE = preload("uid://svuomkbnqg4e")

func enter() -> void:
	parent.is_attacking = true
	issued_slave_signal = false
	if parent.tile_to_attack:
		parent.tile_to_attack.set_enemy_targeted_overlay()
	SfxManager.play_sfx(SWORD_BOT_PREPARE, -1)
	parent.animation_player.play("Prepare")
	var true_wait_time = 0.5
	if GameManager.in_overdrive_mode:
		true_wait_time = 1.0

	parent.timer.wait_time = true_wait_time
	parent.timer.start()

func exit() -> void:
	#if !parent.is_slave:
		#SignalBus.slave_prepare.emit()
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if parent.timer.time_left <= 0:
		return attack
	
	return null
		

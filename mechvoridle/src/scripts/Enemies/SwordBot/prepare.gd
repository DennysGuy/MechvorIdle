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
	parent.timer.wait_time = 0.5
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
		

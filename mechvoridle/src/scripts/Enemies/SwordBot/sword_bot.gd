class_name SwordBot extends GridEnemy

@onready var timer: Timer = $Timer

var destined_tile : Tile
var tile_to_attack : Tile
var in_stagger_state : bool = false
var is_blocking : bool = false
var is_slave : bool = false
@export var stagger_state : State
@export var pursue_state : State
@export var attack_state : State
@export var idle_state : State

'''
signals needed 
- slave follow (pursue)
- slave attack 
- slave free (set slave to false - if true)
'''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	SignalBus.heal_enemy.connect(heal)
	SignalBus.slave_follow.connect(slave_pursue)
	SignalBus.slave_attack.connect(slave_attack)
	SignalBus.slave_prepare.connect(slave_prepare)
	SignalBus.owner_to_idle.connect(owner_to_idle)
	SignalBus.free_slave.connect(free_slave)
	
	state_machine.init(self)

func _exit_tree() -> void:
	if tile_to_attack:
		tile_to_attack.clear_targeted_overlay()
		
	GridManager.enemies.erase(self)
	GridManager.check_wave_status()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func attack_player(player : GridActor) -> void:
	var shake_amount : float = 0.0
	if player is GridPlayer:
		if player.shield_active:
			SfxManager.play_sfx(SfxManager.get_shield_impact())
			SfxManager.play_sfx(SfxManager.SWORD_DEFLECT_OFF_SHIELD)
			var true_damage := weapon.damage
			var shield_bonus_time := GridManager.player.shield_bonus_time
			var calculated_damage := GameManager.calculate_shield_bonus(shield_bonus_time, true_damage)
					
			if calculated_damage > 0:
				true_damage = calculated_damage
				
			GameManager.damage_shield(true_damage)
			shake_amount = 0.8
			in_stagger_state = true
		else:
			shake_amount = 1.3
			var pitch_scale := 1.0
			if GameManager.in_overdrive_mode:
				pitch_scale = 0.6
			SfxManager.play_sfx(SfxManager.SWORD_BOT_SWORD_IMPACT,2,false,pitch_scale)
			player.damage_actor(weapon.damage)
		
		SignalBus.shake_camera.emit(shake_amount)

func slave_pursue(set_destined_tile : Tile, slave_tile_to_attack : Tile) -> void:
	if is_slave:
		tile_to_attack = slave_tile_to_attack
		destined_tile = set_destined_tile
		state_machine.change_state(pursue_state)

func slave_attack(new_destined_tile : Tile, new_tile_to_attack : Tile) -> void:
	if is_slave:
		if not destined_tile:
			destined_tile = new_destined_tile
		if not tile_to_attack:
			tile_to_attack = new_tile_to_attack
		
		state_machine.change_state(attack_state)

func slave_prepare() -> void:
	if is_slave:
		state_machine.change_state(pursue_state)

func owner_to_idle() -> void:
	if is_slave:
		state_machine.change_state(idle_state)

func free_slave() -> void:
	if is_slave:
		is_slave = false

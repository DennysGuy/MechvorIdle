class_name SwordBot extends GridEnemy

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $SwordBot/AnimationPlayer

@onready var health_label: Label = $EnemyHPLabel/HealthLabel

var destined_tile : Tile
var tile_to_attack : Tile
var in_stagger_state : bool = false
var is_blocking : bool = false
@export var stagger_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	SignalBus.heal_enemy.connect(heal)
	
	state_machine.init(self)

func _exit_tree() -> void:
	if tile_to_attack:
		tile_to_attack.clear_targeted_overlay()
		
	GridManager.enemies.erase(self)
	GridManager.check_wave_status()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_label.text = str(health)
	state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func attack_player(player : GridActor) -> void:
	if player is GridPlayer:
		if player.shield_active:
			in_stagger_state = true
		else:
			player.damage_actor(weapon.damage)

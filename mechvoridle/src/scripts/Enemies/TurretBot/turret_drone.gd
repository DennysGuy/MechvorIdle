class_name TurretEnemy extends GridEnemy


@export var shoot : State
@onready var timer: Timer = $Timer

@onready var spawn_in_animation_player: AnimationPlayer = $SpawnInPlayer

func _ready() -> void:
	super()
	SignalBus.heal_enemy.connect(heal)
	state_machine.init(self)

func _process(delta) -> void:
	state_machine.process_frame(delta)
	
func _physics_process(delta : float) -> void:

	state_machine.process_physics(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _enter_tree() -> void:
	print("TURRET ENEMY HAS ENTERED!")

func _exit_tree() -> void:
	GridManager.enemies.erase(self)
	GridManager.check_wave_status()
	

func fire_rocket() -> void:
	var pitch_scale := 1.0
	if GameManager.in_overdrive_mode:
		pitch_scale = 0.7
	SfxManager.play_sfx(SfxManager.ROCKET_LAUNCHER_FIRE, 1.0, false, pitch_scale)
	fire_projectile(weapon,level)

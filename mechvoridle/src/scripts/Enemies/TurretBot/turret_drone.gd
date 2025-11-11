class_name TurretEnemy extends GridEnemy


@onready var animation_player: AnimationPlayer = $Turretanimated/AnimationPlayer


@export var shoot : State
@onready var timer: Timer = $Timer
@onready var health_label: Label = $EnemyHPLabel/HealthLabel

func _ready() -> void:
	super()
	SignalBus.heal_enemy.connect(heal)
	state_machine.init(self)

func _process(delta) -> void:
	health_label.text = str(health)+"/"+str(max_health)
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
	fire_projectile(weapon)

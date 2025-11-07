class_name HealerBot extends GridEnemy

@onready var animation_player: AnimationPlayer = $HealerBot/AnimationPlayer

@onready var health_label: Label = $EnemyHPLabel/HealthLabel
@onready var timer: Timer = $Timer

@onready var pulse_point: Marker3D = $PulsePoint
@onready var pulse_point2: Marker3D = $PulsePoint2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	state_machine.init(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_label.text = str(health)
	state_machine.process_frame(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _enter_tree() -> void:
	print("HEALER ENEMY HAS ENTERED!")

func _exit_tree() -> void:
	GridManager.enemies.erase(self)
	GridManager.check_wave_status()

class_name HealerBot extends GridEnemy

@onready var animation_player: AnimationPlayer = $healer/AnimationPlayer


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
	health_label.text = str(health)+"/"+str(max_health)
	state_machine.process_frame(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _exit_tree() -> void:
	GridManager.enemies.erase(self)
	GridManager.check_wave_status()


func heal_enemies() -> void:
	var pulse : HealPulse = preload("uid://dmyiefkprcywd").instantiate()
	pulse.global_position = pulse_point.global_position
	get_parent().add_child(pulse)
	
	var pulse_2 : HealPulse = preload("uid://dmyiefkprcywd").instantiate()
	pulse_2.global_position = pulse_point2.global_position
	get_parent().add_child(pulse_2)
	SignalBus.heal_enemy.emit()

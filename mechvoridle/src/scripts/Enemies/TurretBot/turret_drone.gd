class_name TurretEnemy extends GridEnemy

@onready var state_machine: StateMachine = $StateMachine

@onready var animation_player: AnimationPlayer = $TurretBot/AnimationPlayer

@export var shoot : State
@onready var timer: Timer = $Timer
@onready var health_label: Label = $EnemyHPLabel/HealthLabel

func _ready() -> void:
	timer.wait_time = randf_range(3,4)
	timer.start()
	state_machine.init(self)

func _process(delta) -> void:
	health_label.text = str(health)
	state_machine.process_frame(delta)
	
func _physics_process(delta : float) -> void:

	state_machine.process_physics(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _on_timer_timeout() -> void:
	state_machine.change_state(shoot)

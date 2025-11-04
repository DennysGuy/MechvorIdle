class_name SporadicEnemy extends GridEnemy
@export var row_limit : int = 2
@export var col_limit : int = 3
@onready var animation_player: AnimationPlayer = $zaper2/AnimationPlayer

var random_direction_list : Array[Vector2] = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]

@onready var laser_spout: Marker3D = $LaserSpout
@onready var health_label: Label = $EnemyHPLabel/HealthLabel

@onready var timer: Timer = $Timer

var laser_count_down : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.init(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if is_dead:
		print("I SHOULD BE DED")
	health_label.text = str(health)
	state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func fire_laser() -> void:
	fire_projectile(weapon)

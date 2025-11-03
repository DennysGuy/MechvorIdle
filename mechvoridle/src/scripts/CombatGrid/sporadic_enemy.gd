class_name SporadicEnemy extends GridEnemy
@export var row_limit : int = 2
@export var col_limit : int = 3
@onready var animation_player: AnimationPlayer = $model/AnimationPlayer
@onready var timer: Timer = $Timer
var random_direction_list : Array[Vector2] = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]

@onready var laser_spout: Marker3D = $LaserSpout
@onready var health_label: Label = $EnemyHPLabel/HealthLabel


var laser_count_down : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	animation_player.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_label.text = str(health)

func fire_laser() -> void:
	fire_projectile(weapon)

func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(0.5,1.0)
	SignalBus.move_enemy.emit(self, random_direction_list.pick_random(),row_limit,col_limit)
	laser_count_down += 1
	if laser_count_down >= 3:
		fire_laser()
		laser_count_down = 0

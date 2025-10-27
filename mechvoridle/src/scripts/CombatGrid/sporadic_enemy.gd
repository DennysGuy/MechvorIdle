class_name SporadicEnemy extends GridEnemy
@export var row_limit : int = 2
@export var col_limit : int = 3
@onready var animation_player: AnimationPlayer = $model/AnimationPlayer
@onready var timer: Timer = $Timer
var random_direction_list : Array[Vector2] = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]

@onready var laser_spout: Marker3D = $LaserSpout
@onready var health_label: Label = $SubViewport/HealthLabel

var laser_count_down : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	animation_player.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_label.text = str(health)


func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(0.5,1.0)
	SignalBus.move_enemy.emit(self, random_direction_list.pick_random(),row_limit,col_limit)
	laser_count_down += 1
	if laser_count_down >= 3:
		fire_laser()
		laser_count_down = 0

func fire_laser() -> void:
	var laser : PlasmaBullet = weapon.projectile.instantiate()
	laser.global_position = laser_spout.global_position
	
	var destined_tile : Tile = GridManager.get_tile(tiles, weapon.attack_pattern.get_destined_tile_coordinates(self))
	
	laser = weapon.spawn_projectile(laser_spout, destined_tile, tiles, self)
	
	get_parent().add_child(laser)

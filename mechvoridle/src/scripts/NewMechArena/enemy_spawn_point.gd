extends Marker3D

@export var enemy : PackedScene
@export var set_time : float
@onready var timer: Timer = $Timer
@onready var enemies: Node = $"../Enemies"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = set_time
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if enemies.get_children().size() < get_parent().room_enemy_cap:
		spawn_enemy()


func spawn_enemy() -> void:
	var selected_enemy : Enemy = enemy.instantiate()
	selected_enemy.global_transform.origin = global_transform.origin
	enemies.add_child(selected_enemy)

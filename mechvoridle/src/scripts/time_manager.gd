extends Node

var slow_time_factor : float = 1.0
var enemy_tween_speed : float = 0.15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.set_slow_factor_twenty.connect(set_slow_factor_twenty)
	SignalBus.revert_move_speed_to_norm.connect(revert_slow_factor_normal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_enemy_delta(_delta : float) -> float:
	return _delta * slow_time_factor

func set_slow_factor_twenty() -> void:
	slow_time_factor = 0.2
	enemy_tween_speed = 1.4

func revert_slow_factor_normal() -> void:
	slow_time_factor = 1.0
	enemy_tween_speed = 0.15

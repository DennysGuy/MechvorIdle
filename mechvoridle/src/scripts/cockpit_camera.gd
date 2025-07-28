class_name CockPitCamera extends Camera2D

signal start_screen_shake

@export_category("Camera Shake Properties")
@export var random_strength : float = 0.0
@export var shake_fade : float = 0.0
var rng = RandomNumberGenerator.new()
var shake_strength = random_strength
@onready var timer = $Timer

func _ready() -> void:
	timer.wait_time = 1.5
	SignalBus.shake_camera.connect(set_shake_strength)
	shake_strength = 0


func _process(delta : float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = random_offset()
	

func set_shake_strength(value : float):
	shake_strength = value
	shake_fade = 3

func apply_shake() -> void:
	shake_strength = random_strength

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

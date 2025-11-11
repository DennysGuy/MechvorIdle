extends Camera3D

@export var shake_strength: float = 0.2
@export var shake_decay: float = 2.0

var rng := RandomNumberGenerator.new()
var shake_timer: float = 0.0
var base_transform: Transform3D

func _ready() -> void:
	SignalBus.shake_camera.connect(start_shake)
	base_transform = transform

func _process(delta: float) -> void:
	# Always reset to base
	transform = base_transform
	
	if shake_timer > 0.0:
		shake_timer -= delta * shake_decay
		
		var offset := Vector3(
			rng.randf_range(-shake_strength, shake_strength),
			rng.randf_range(-shake_strength, shake_strength),
			rng.randf_range(-shake_strength, shake_strength)
		) * shake_timer
		
		# Apply shake on top of the base transform
		transform.origin += offset

func start_shake(duration: float = 0.5) -> void:
	shake_timer = duration

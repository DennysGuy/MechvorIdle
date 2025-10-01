class_name PlasmaBullet extends Area3D

var damage : int
var speed : float = 20
var direction : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if direction != Vector3.ZERO:
		#velocity = direction * speed
		global_translate(direction * speed * delta)

func _on_timer_timeout() -> void:
	queue_free()

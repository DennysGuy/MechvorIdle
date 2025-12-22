class_name WristRockets extends GridProjectile

@onready var wrist_rockets: Node3D = $WristRockets

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wrist_rockets.rotation.z += 0.1

func _physics_process(delta: float) -> void:
	if direction:
		#velocity = direction * speed
		global_translate(direction * speed * delta)


func _on_timer_timeout() -> void:
	queue_free()


func _on_hit_box_area_entered(area: Area3D) -> void:
	impact_prjectile(area)

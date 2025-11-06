class_name PlasmaBullet extends GridProjectile


@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if direction:
		#velocity = direction * speed
		global_translate(direction * speed * delta)

func _on_timer_timeout() -> void:
	queue_free()


func _on_hit_box_area_entered(area: Area3D) -> void:
	impact_prjectile(area)
		

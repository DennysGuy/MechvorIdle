class_name PlasmaBullet extends Area3D

@export var damage : int
var speed : float = 20
var direction : Vector3 = Vector3.ZERO
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	look_at(global_transform.origin + direction, Vector3.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if direction != Vector3.ZERO:
		#velocity = direction * speed
		global_translate(direction * speed * delta)

func _on_timer_timeout() -> void:
	queue_free()




func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		var enemy : Enemy = body
		enemy.damage(damage)
		queue_free()


func _on_area_entered(area: Area3D) -> void:
	var parent = area.get_parent()
	if parent is Enemy:
		parent.damage(damage)
		queue_free()

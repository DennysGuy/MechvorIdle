class_name BasicEnemy1 extends Enemy

var direction : Vector3
var movement_speed : float = 3.0

@onready var node_3d: Node3D = $Node3D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	super()


func _physics_process(delta: float) -> void:
	direction = (player.global_transform.origin - global_transform.origin).normalized()
	look_at(player.global_transform.origin + direction, Vector3.UP)
	velocity = direction * movement_speed 
	
	move_and_slide()

func _on_hit_box_body_entered(body: Node3D) -> void:
	if body is Player:
		kill()

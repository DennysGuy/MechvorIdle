class_name BasicEnemy1 extends Enemy

var direction : Vector3
var movement_speed : float = 3.0

var time_passed := 0.0
var amplitude := 1.0
var frequency := 2.0
var speed := 1.0
var angle := 0.0
var radius := 3.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var node_3d: Node3D = $Node3D

func _ready() -> void:
	animation_player.play("bob")
	player = get_tree().get_first_node_in_group("Player")
	super()


func _physics_process(delta: float) -> void:
	direction = (player.global_transform.origin - global_transform.origin).normalized()
	look_at(player.global_transform.origin + direction, Vector3.UP)
	velocity = direction * movement_speed 
	
	angle += speed * delta
	
	time_passed += delta
	var x := cos(angle) * radius
	var z := sin(angle) * radius
	
	#var offset := Vector3(x,z,global_transform.origin.z)
	#node_3d.global_transform.origin += offset 
	
	move_and_slide()

func _on_hit_box_body_entered(body: Node3D) -> void:
	if body is Player:
		GameManager.current_health -= damage_amount
		SignalBus.update_player_health.emit()
		kill()

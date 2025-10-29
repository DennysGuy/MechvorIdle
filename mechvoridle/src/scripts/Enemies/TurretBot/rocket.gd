extends GridProjectile
@onready var rocket: Node3D = $Rocket
@onready var pivot_point: Marker3D = $PivotPoint


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pivot_point.rotation.z += 0.01

func _physics_process(delta: float) -> void:
	global_translate(direction * speed * delta)

func _on_hit_box_area_entered(area: Area3D) -> void:
	impact_prjectile(area)

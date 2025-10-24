extends Node3D

@onready var csg_mesh_3d: CSGMesh3D = $CSGMesh3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	rotation.z += 0.5


func _on_timer_timeout() -> void:
	csg_mesh_3d.visible = !csg_mesh_3d.visible

extends Node3D

@onready var csg_mesh_3d: CSGMesh3D = $CSGMesh3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation.z = randf_range(0,360)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	pass

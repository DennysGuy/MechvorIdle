class_name WeaponMuzzleFlare extends Node3D

@onready var flare: Node3D = $Flare

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_scale := randf_range(1.0,1.5)
	flare.scale = Vector3(random_scale,random_scale,random_scale)
	flare.rotation.z = randf_range(-30.0,30.0)
	await get_tree().create_timer(0.05).timeout
	queue_free()

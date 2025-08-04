class_name MiningAsteroid extends Node3D


func _ready() -> void:
	pass

func _physics_process(delta) -> void:
	rotation.y += 0.1 * delta

class_name TestCubeCharacter extends CharacterBody3D

@onready var coob: Node3D = $Coob


func _ready() -> void:
	pass

func _process(delta : float) -> void:
	print("Forward: ", -coob.global_transform.basis.z)
	print("Right: ", coob.global_transform.basis.x)
	print("Up: ", coob.global_transform.basis.y)

func _physics_process(delta: float) -> void:
	pass

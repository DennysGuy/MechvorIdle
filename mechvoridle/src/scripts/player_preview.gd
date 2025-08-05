class_name PlayerPreview extends Node3D

@onready var mech_preview : Node3D= $MechPreview

func _ready() -> void:
	pass

func _process(delta) -> void:
	pass

func _physics_process(delta) -> void:
	mech_preview.rotation.y += 0.01

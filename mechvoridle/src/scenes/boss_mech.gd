class_name BossMech extends Node3D

@onready var animation_player : AnimationPlayer = $HeavyBoss/AnimationPlayer


func _ready() -> void:
	animation_player.play("Idle")

class_name DestinationMarker extends Node2D
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_out")


func remove_marker():
	queue_free()

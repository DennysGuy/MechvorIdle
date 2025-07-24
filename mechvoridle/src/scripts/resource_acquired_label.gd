class_name ResourceAcquiredLabel extends Node2D



@export var output : String
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var label : Label = $Bus/Label


func _ready() -> void:
	label.text = output
	animation_player.play("Float and Fade")


func erase() -> void:
	queue_free()

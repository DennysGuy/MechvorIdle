class_name GridActor extends Node3D


@export var current_tile : Tile
const  WAIT_TIME : float = 0.2
@export var can_move : bool = true
@export var health : int = 100
@export var max_health : int 
@export var tiles : Node


func damage_actor(value : int) -> void:
	health -= value
	print("I was hit! Current HP:%s" % [health])
	if health <= 0:
		#place holder for now
		queue_free()

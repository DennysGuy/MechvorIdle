class_name GridActor extends Node3D


@export var current_tile : Tile
@export var wait_time : float = 0.15
@export var can_move : bool = true
@export var health : int = 100



func damage_actor(value : int) -> void:
	health -= value
	print("I was hit! Current HP:%s" % [health])
	if health <= 0:
		#place holder for now
		queue_free()

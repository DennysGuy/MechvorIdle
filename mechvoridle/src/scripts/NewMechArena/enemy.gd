class_name Enemy extends CharacterBody3D

@export var enemy_name : String
@export var health : int 
@export var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func kill() -> void:
	queue_free()

func damage(damage : int) -> void:
	health -= damage
	if health <= 0:
		kill()

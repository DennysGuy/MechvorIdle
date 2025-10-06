class_name Enemy extends CharacterBody3D

@export var enemy_name : String
@export var health : int 
@export var player : Player
@export var damage_amount : int

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func kill() -> void:
	var random_int : int = randi_range(0,100)
	if random_int <= 9:
		var key_card : KeyCardObject = preload("uid://dnelhljps8fea").instantiate()
		key_card.global_transform.origin = global_transform.origin
		get_parent().get_parent().key_cards.add_child(key_card)
	
	queue_free()

func damage(damage : int) -> void:
	health -= damage
	if health <= 0:
		kill()

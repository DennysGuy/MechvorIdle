class_name GridProjectile extends Node3D

@export var damage : int
@export var speed : float = 20
@export var direction : Vector3
@export var tile : Tile
@export var tiles : Node
@export var weapon_origin : MechWeapon
@export var weapon_owner : GridActor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

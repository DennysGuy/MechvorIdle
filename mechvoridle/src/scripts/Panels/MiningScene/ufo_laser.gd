class_name UFOLaser extends CharacterBody2D


var speed : int = 150
var dir : Vector2
var target
var damage : int 

func _ready() -> void:
	damage = randi_range(1,3)
	dir = target.position - position
func _process(delta) -> void:
	pass

func _physics_process(delta : float) -> void:
	velocity = dir.normalized() * speed
	move_and_slide()

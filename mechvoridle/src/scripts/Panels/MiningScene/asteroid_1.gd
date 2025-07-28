class_name Asteroid extends CharacterBody2D


@export var speed : float
@export var dir : Vector2
@export var mining_asteroid : Area2D
@export var health : int 
@export var damage : int
@onready var graphic: Sprite2D = $Graphic

@onready var asteroid_animation_player: AnimationPlayer = $AsteroidAnimationPlayer

signal deliver_resources 

func _ready() -> void:
	dir = mining_asteroid.position - position

func _process(delta : float) -> void:
	graphic.rotation += 0.02
	

func _physics_process(delta: float) -> void:
	
	velocity = dir.normalized() * speed
	move_and_slide()


func _on_delete_asteroid_timer_timeout() -> void:
	queue_free()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass

func damage_asteroid() -> void:
	asteroid_animation_player.play("hit_flash")
	health -= 1
	if health <= 0:
		deliver_resources.emit()
		queue_free() #will replace with animation



func _on_asteroid_click_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("HIT!")
		damage_asteroid()

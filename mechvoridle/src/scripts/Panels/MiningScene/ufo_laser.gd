class_name UFOLaser extends CharacterBody2D


var speed : int = 150
var dir : Vector2
var target
var damage : int 
@onready var sfx_player : AudioStreamPlayer2D = $SfxPlayer

var laser_sfx : Array[AudioStream] = [SfxManager.MIN_UNIT_UFO_LASER_01, SfxManager.MIN_UNIT_UFO_LASER_02, SfxManager.MIN_UNIT_UFO_LASER_03, SfxManager.MIN_UNIT_UFO_LASER_04]

func _ready() -> void:
	sfx_player.stream = laser_sfx.pick_random()
	sfx_player.volume_db = 5.0
	sfx_player.play()
	
	damage = randi_range(1,3)
	dir = target.position - position
func _process(delta) -> void:
	pass

func _physics_process(delta : float) -> void:
	velocity = dir.normalized() * speed
	move_and_slide()

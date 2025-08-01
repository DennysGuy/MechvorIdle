class_name Explosion extends Node2D


enum size {SMALL, MEDIUM, LARGE, DRONE, PLATINUM_DRONE, UFO_HAZARD}
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_player = $SfxPlayer

var size_set : int 
var explosion_sfx_list : Array[AudioStream] = [SfxManager.MIN_UNIT_DRONE_DESTROY_01, SfxManager.MIN_UNIT_DRONE_DESTROY_02, SfxManager.MIN_UNIT_DRONE_DESTROY_03]
var drone_destroy_list : Array[AudioStream] = [SfxManager.MIN_UNIT_DRONE_DESTROY_01, SfxManager.MIN_UNIT_DRONE_DESTROY_02, SfxManager.MIN_UNIT_DRONE_DESTROY_03]
func _ready() -> void:
	set_asteroid_scale()
	animated_sprite_2d.play("default")

func set_asteroid_scale() -> void:
	sfx_player.volume_db = -4.0
	match size_set:
		size.SMALL:
			sfx_player.stream = explosion_sfx_list[0]
			sfx_player.play()
			animated_sprite_2d.scale = Vector2(1,1)
		size.MEDIUM:
			sfx_player.stream = explosion_sfx_list[1]
			sfx_player.play()
			animated_sprite_2d.scale = Vector2(2,2)
		size.LARGE:
			sfx_player.stream = explosion_sfx_list[2]
			sfx_player.play()
			animated_sprite_2d.scale = Vector2(3,3)
		size.DRONE:
			sfx_player.stream = drone_destroy_list.pick_random()
			sfx_player.play()
			animated_sprite_2d.scale = Vector2(1,1)
		size.PLATINUM_DRONE:
			sfx_player.stream = drone_destroy_list.pick_random()
			sfx_player.play()
			animated_sprite_2d.scale = Vector2(1.5,1.5)
		size.UFO_HAZARD:
			animated_sprite_2d.scale = Vector2(3,3)
			sfx_player.stream = drone_destroy_list.pick_random()
			sfx_player.play()


func _on_animated_sprite_2d_animation_finished():
	hide()


func _on_sfx_player_finished():
	get_parent().queue_free()

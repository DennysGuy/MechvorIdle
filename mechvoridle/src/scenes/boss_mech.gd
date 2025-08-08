class_name BossMech extends Node3D

@onready var heavy_mech_animation_player : AnimationPlayer = $HeavyBoss/AnimationPlayer
@onready var standard_mech_animation_player : AnimationPlayer = $StandardBoss/AnimationPlayer
@onready var light_mech_animation_player = $LightBoss/AnimationPlayer
@onready var heavy_boss := $HeavyBoss
@onready var standard_boss := $StandardBoss
@onready var light_boss := $LightBoss

@onready var mech_animation_players : Array[Node3D] = [light_boss, standard_boss, heavy_boss]


func _ready() -> void:
	heavy_mech_animation_player.play("Idle")
	standard_mech_animation_player.play("Idle")
	light_mech_animation_player.play("Idle")
	
	SignalBus.show_specified_boss.connect(show_boss)

func show_boss(value : int):
	mech_animation_players[value].show()

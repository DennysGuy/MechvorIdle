class_name WinPanel extends Control


@onready var replay = $Replay
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_in")

func _on_replay_button_down():
	
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	GameManager.reset()
	get_tree().change_scene_to_file("res://src/scenes/MainMenu.tscn")

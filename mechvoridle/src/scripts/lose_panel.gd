class_name LosePanel extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("fade_in")


func _on_replay_button_down():
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	GameManager.reset()
	GameManager.chosen_opponent = GameManager.opponents_list.pick_random()
	get_tree().change_scene_to_file("res://src/scenes/MainHub.tscn")

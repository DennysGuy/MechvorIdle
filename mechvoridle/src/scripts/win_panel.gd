class_name WinPanel extends Control


@onready var replay = $Replay
@onready var animation_player = $AnimationPlayer
@onready var fight_time : Label = $FightTime
@onready var mine_time : Label = $MineTime

func _ready() -> void:
	animation_player.play("fade_in")
	fight_time.text = "Fight Finished Time: " + GameManager.fight_time_elapsed
	mine_time.text = "Mech Contstruction Time: " + GameManager.mining_time_elapsed

func _on_replay_button_down():
	
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	GameManager.reset()
	get_tree().change_scene_to_file("res://src/scenes/MainMenu.tscn")

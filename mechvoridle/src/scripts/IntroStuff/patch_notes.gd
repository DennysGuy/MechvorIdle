extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Fade_In")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func go_to_tutorial_panel() -> void:
	get_tree().change_scene_to_file("res://src/scenes/IntroStuff/TutorialPanel.tscn")

func _on_next_button_down() -> void:
	animation_player.play("Fade_Out")

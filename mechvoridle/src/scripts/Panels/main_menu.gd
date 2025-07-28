class_name MainMenu extends Control
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_in")
	
	
func _process(delta : float) -> void:
	pass




func _on_play_button_down():
		GameManager.choose_mech_opponent()
		print(GameManager.chosen_opponent.mech_name)
		animation_player.play("fade_out")
		await animation_player.animation_finished
		get_tree().change_scene_to_file("res://src/scenes/MainHub.tscn")


func _on_settings_button_down():
	pass # Replace with function body.

class_name MainMenu extends Control
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sfxplayer: AudioStreamPlayer = $sfxplayer

func _ready() -> void:
	animation_player.play("fade_in")
	audio_stream_player.play()
	
func _process(delta : float) -> void:
	pass




func _on_play_button_down():
		GameManager.choose_mech_opponent()
		print(GameManager.chosen_opponent.mech_name)
		animation_player.play("fade_out")
		SfxManager.play_button_click(sfxplayer)
		await animation_player.animation_finished
		get_tree().change_scene_to_file("res://src/scenes/MainHub.tscn")




func _on_play_mouse_entered() -> void:
	SfxManager.play_button_hover(sfxplayer)

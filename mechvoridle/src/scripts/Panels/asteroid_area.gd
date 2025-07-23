class_name AsteroidArea extends Node2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("hover")

func _process(delta : float) -> void:
	pass


func _on_texture_rect_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("yo joe!")
			GameManager.raw_ferrite_count += GameManager.mining_laser_damage
			SignalBus.update_ferrite_count.emit()

extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Fade_In")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_controller_mappings_button_up() -> void:
	pass # Replace with function body.


func _on_basic_movement_button_down() -> void:
	pass # Replace with function body.


func _on_attacking_button_down() -> void:
	pass # Replace with function body.


func _on_vulcan_machine_gun_button_down() -> void:
	pass # Replace with function body.


func _on_counter_guard_button_down() -> void:
	pass # Replace with function body.


func _on_heat_button_up() -> void:
	pass # Replace with function body.


func _on_hp_energy_button_up() -> void:
	pass # Replace with function body.


func _on_guard_slide_button_up() -> void:
	pass # Replace with function body.


func _on_grading_multiplier_button_up() -> void:
	pass # Replace with function body.


func _on_over_drive_mode_button_up() -> void:
	pass # Replace with function body.

func go_to_combat() -> void:
	get_tree().change_scene_to_file("res://src/scenes/TileGrid/CombatGrid.tscn")

func _on_start_game_button_up() -> void:
	animation_player.play("Fade_Out")

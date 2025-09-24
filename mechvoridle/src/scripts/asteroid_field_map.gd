class_name AsteroidFieldMap extends Node2D

var selected_asteroid : int 

@onready var asteroid_name : Label = $DescriptionPanel/AsteroidName
@onready var rich_text_label : RichTextLabel = $DescriptionPanel/RichTextLabel

var asteroid_area_1 : AsteroidArea = preload("res://src/scenes/AsteroidArea.tscn").instantiate()
var asteroid_area_2 : AsteroidArea = preload("uid://davrhw222g8uv").instantiate()
var asteroid_area_3 : AsteroidArea = preload("uid://cnxjsj1ffl05m").instantiate()

enum ASTEROIDS
{
	ASTEROID_1,
	ASTEROID_2,
	ASTEROID_3
}

func _ready() -> void:
	pass
	
	


func _on_asteroid_area_1_button_up():
	#show stats based on asteroid stats
	selected_asteroid = ASTEROIDS.ASTEROID_1
	asteroid_name.text = asteroid_area_1.asteroid_name
	rich_text_label.text = "Drone slots increase - 15%"

func _on_asteroid_area_2_button_up():
	selected_asteroid = ASTEROIDS.ASTEROID_2
	asteroid_name.text = asteroid_area_2.asteroid_name
	rich_text_label.text = "Hazards Increase - + 10%\nResource Bonus - 10%"


func _on_asteroid_area_3_button_up():
	selected_asteroid = ASTEROIDS.ASTEROID_3
	asteroid_name.text = asteroid_area_3.asteroid_name
	rich_text_label.text = "Mining speed increase - 5%"
	
func update_description_panel_details() -> void:
	pass


func _on_move_to_asteroid_button_up():
	match selected_asteroid:
		ASTEROIDS.ASTEROID_1:
			GameManager.selected_location = GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_AREA_1
		ASTEROIDS.ASTEROID_2:
			GameManager.selected_location = GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_AREA_2
		ASTEROIDS.ASTEROID_3:
			GameManager.selected_location = GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_AREA_3
	
	SignalBus.change_maps.emit()

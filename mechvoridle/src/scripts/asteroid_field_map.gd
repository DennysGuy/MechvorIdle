class_name AsteroidFieldMap extends Node2D

var selected_asteroid : int 
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



func _on_asteroid_area_2_button_up():
	pass # Replace with function body.


func _on_asteroid_area_3_button_up():
	pass # Replace with function body.


func _on_move_to_asteroid_button_up():
	match selected_asteroid:
		ASTEROIDS.ASTEROID_1:
			GameManager.selected_location = GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_AREA_1
			SignalBus.change_maps.emit()

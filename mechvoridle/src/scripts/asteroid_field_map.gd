class_name AsteroidFieldMap extends Node2D

var selected_asteroid : int 
@onready var purchase_asteroid: Button = $DescriptionPanel/PurchaseAsteroid

@onready var asteroid_name : Label = $DescriptionPanel/AsteroidName
@onready var rich_text_label : RichTextLabel = $DescriptionPanel/RichTextLabel

var asteroid_area_1 : AsteroidArea = preload("res://src/scenes/AsteroidArea.tscn").instantiate()
var asteroid_area_2 : AsteroidArea = preload("uid://davrhw222g8uv").instantiate()
var asteroid_area_3 : AsteroidArea = preload("uid://cnxjsj1ffl05m").instantiate()
@onready var move_to_asteroid: Button = $DescriptionPanel/MoveToAsteroid

enum ASTEROIDS
{
	ASTEROID_1,
	ASTEROID_2,
	ASTEROID_3
}

func _ready() -> void:
	move_to_asteroid.hide()
	purchase_asteroid.hide()
	SignalBus.update_asteroid_panel_data.connect(update_panel_info)
	


func _on_asteroid_area_1_button_up():
	#show stats based on asteroid stats
	selected_asteroid = ASTEROIDS.ASTEROID_1
	asteroid_name.text = asteroid_area_1.asteroid_name
	rich_text_label.text = "Drone slots increase - 15%"
	move_to_asteroid.show()
	move_to_asteroid.disabled = false
	purchase_asteroid.hide()
	purchase_asteroid.disabled = true

func update_panel_info(asteroid_area : AsteroidArea, asteroid_index : int, is_purchased : bool, cost : int = 0) -> void:
	asteroid_name.text = asteroid_area.asteroid_name
	selected_asteroid = asteroid_index
	rich_text_label.text = "Asteroid descriptor goes here"
	if is_purchased:
		purchase_asteroid.hide()
		move_to_asteroid.disabled = false
		move_to_asteroid.show()
	else:
		purchase_asteroid.show()
		purchase_asteroid.disabled = GameManager.platinum_count <= asteroid_area.cost
		move_to_asteroid.disabled = true
		move_to_asteroid.show()
	
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


func _on_purchase_asteroid_button_up() -> void:
	SignalBus.purchase_asteroid.emit(selected_asteroid)

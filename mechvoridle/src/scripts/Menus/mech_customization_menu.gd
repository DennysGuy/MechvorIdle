class_name MechCustomizationMenu extends Control

@onready var tutorials: Control = $Tutorials
@onready var component_selection_menu: ColorRect = $ComponentSelectionMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuController.show_sub_category_menu.connect(show_component_selection_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://src/scenes/TileGrid/CombatGrid.tscn")


func _on_button_2_button_up() -> void:
	tutorials.show()

func show_component_selection_menu() -> void:
	#will need to add the buttons for the particular unit
	component_selection_menu.show()

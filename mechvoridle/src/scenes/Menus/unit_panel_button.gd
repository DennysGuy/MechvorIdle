class_name UnitPanelButton extends Control

var mech_component : MechComponent

@onready var icon: TextureRect = $Icon
@onready var title: Label = $Title


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon.texture = mech_component.get_manufacturer_icon()
	title.text = mech_component.component_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_button_up() -> void:
	MenuController.update_selected_part.emit(mech_component)
	SignalBus.show_part_preview.emit(mech_component)

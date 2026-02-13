class_name FilterController extends Control


func _ready() -> void:
	SignalBus.toggle_filter.connect(toggle_filter)
	

func toggle_filter(toggle : bool) -> void:

	if !toggle:
		hide()
	else:
		show()
	

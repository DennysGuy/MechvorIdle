class_name StatLabel extends Label

enum LABEL_TYPE {STAT, EFFECT}

var total_effect : float

func _ready() -> void:
	pass

func _process(delta) -> void:
	pass

func set_text_color_green() -> void:
	add_theme_color_override("font_color", Color.SEA_GREEN)

func set_text_color_red() -> void:
	add_theme_color_override("font_color", Color.INDIAN_RED)

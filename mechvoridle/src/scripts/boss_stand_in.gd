extends TextureRect

@onready var mat := material as ShaderMaterial
var tween : Tween

func _ready():
	self.mouse_filter = Control.MOUSE_FILTER_STOP # So clicks register on this
	tween = get_tree().create_tween()
	if not tween:
		print("Add a Tween node named 'Tween' as a child.")

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		flash()
		GameManager.chosen_opponent.current_health -= 10
		var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
		resource_acquired_label.output = "-10"
		resource_acquired_label.global_position = get_viewport().get_mouse_position()
		get_parent().add_child(resource_acquired_label)
		SignalBus.update_opponent_health_bar.emit()

func flash():
	# Set flash to full white instantly
	mat.set_shader_parameter("flash_amount", 1.0)
	# Animate back to 0
	tween.stop_all()
	tween.tween_property(mat, "shader_parameter/flash_amount", 0.0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

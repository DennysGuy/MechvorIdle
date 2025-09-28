class_name AsteroidButton extends TextureButton


@onready var cost_label: Label = $CostLabel
@onready var cost_indicator: Label = $CostIndicator

@export var cost : int
@export var asteroid_packed : PackedScene
var asteroid_area : AsteroidArea
@export_enum("asteroid 1", "asteroid 2", "asteroid 3") var asteroid_num : int
var asteroid_index : int
var is_purchased : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	asteroid_area = asteroid_packed.instantiate()
	cost_label.text = str(asteroid_area.cost)
	SignalBus.purchase_asteroid.connect(purchase_asteroid)
	asteroid_index = asteroid_num

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	cost_indicator.visible = GameManager.platinum_count >= asteroid_area.cost and !is_purchased

func purchase_asteroid(selected_area : int) -> void:
	if selected_area == asteroid_index:
		is_purchased = true
		GameManager.platinum_count -= cost
		SignalBus.update_plasma_count.emit()
		cost_label.hide()


func _on_button_up() -> void:
	SignalBus.update_asteroid_panel_data.emit(asteroid_area, asteroid_index, is_purchased)

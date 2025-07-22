class_name CentralHubPanel extends Control


var can_fight_boss : bool = false

func _ready() -> void:
	pass
	

func _process(delta) -> void:
	pass


func _on_start_fight_button_up():
	if can_fight_boss:
		start_fight()


func _on_mining_pane_navigation_button_up() -> void:
	SignalBus.move_to_mining_pane.emit()


func _on_shop_pane_navigation_button_up() -> void:
	SignalBus.move_to_shop_pane.emit()


func start_fight() -> void:
	pass

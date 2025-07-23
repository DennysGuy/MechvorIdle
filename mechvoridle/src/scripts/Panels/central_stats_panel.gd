class_name CentralHubPanel extends Control

@onready var elapsed_time = $ColorRect/ResourcesPanel/ElapsedTime


@onready var raw_ferrite_count = $ColorRect/ResourcesPanel/RawFerriteCount
@onready var ferrite_bars_count = $ColorRect/ResourcesPanel/FerriteBarsCount
@onready var platinum_bars_count = $ColorRect/ResourcesPanel/PlatinumBarsCount


func _ready() -> void:
	SignalBus.update_ferrite_count.connect(update_raw_ferrite_count)
	SignalBus.update_ferrite_bars_count.connect(update_ferrite_bars_count)
	SignalBus.update_platinum_count.connect(update_platinum_count)
	
	update_raw_ferrite_count()
	update_ferrite_bars_count()
	update_platinum_count()
	

func _process(delta) -> void:
	pass


func _on_start_fight_button_up():
	if GameManager.can_fight_boss:
		start_fight()


func _on_mining_pane_navigation_button_up() -> void:
	SignalBus.move_to_mining_pane.emit()

func _on_shop_pane_navigation_button_up() -> void:
	SignalBus.move_to_shop_pane.emit()


func start_fight() -> void:
	get_tree().change_scene_to_file("res://src/scenes/MechFightArena.tscn")

func _on_purchase_recon_scout_button_down():
	pass # Replace with function body.

func update_raw_ferrite_count() -> void:
	raw_ferrite_count.text = str(GameManager.raw_ferrite_count)

func update_ferrite_bars_count() -> void:
	ferrite_bars_count.text = str(GameManager.ferrite_bars_count)

func update_platinum_count() -> void:
	platinum_bars_count.text = str(GameManager.platinum_count)

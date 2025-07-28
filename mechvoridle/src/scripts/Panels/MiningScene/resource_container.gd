class_name ResourceContainer extends Node

@export var parent : Asteroid

@export_group("Ferrite")
@export var ferrite_min_value : int
@export var ferrite_max_value : int

@export_group("Ferrite Bars")
@export var ferrite_bars_min_value : int
@export var ferrite_bars_max_value : int

@export_group("Platinum")
@export var platinum_min_value : int
@export var platinum_max_value : int

@export_group("Plasma Value")
@export var plasma_min_value : int
@export var plasma_max_value : int

func _ready() -> void:
	parent.deliver_resources.connect(deliver_resource)


func deliver_resource() -> void:
	var random_ferrite_amount : int = randi_range(ferrite_min_value, ferrite_max_value)
	var random_ferrite_bars_amount : int = randi_range(ferrite_bars_min_value, ferrite_bars_max_value)
	var random_platinum_amount : int = randi_range(platinum_min_value, platinum_max_value)
	var random_plasma_amount : int = randi_range(plasma_min_value, plasma_max_value)
	
	if random_ferrite_amount > 0:
		GameManager.raw_ferrite_count += random_ferrite_amount
		generate_label(random_ferrite_amount, "Ferrite")
		SignalBus.update_ferrite_count.emit()
	if random_ferrite_bars_amount > 0:
		GameManager.ferrite_bars_count += random_ferrite_bars_amount
		generate_label(random_ferrite_bars_amount, "Ferrite Bars")
		SignalBus.update_ferrite_bars_count.emit()
	if random_platinum_amount > 0:
		GameManager.platinum_count += random_platinum_amount
		generate_label(random_platinum_amount, "Platinum")
		SignalBus.update_plasma_count.emit()
	if random_plasma_amount > 0:
		GameManager.plasma_count += random_plasma_amount
		generate_label(random_plasma_amount, "Plasma")
		SignalBus.update_plasma_count.emit()


func generate_label(amount : int, resource_name : String):
	var _offset : int = randi_range(-10,10)
	var ran_ferrite_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	ran_ferrite_label.output = "+"+str(amount)+resource_name
	ran_ferrite_label.global_position = parent.global_position + Vector2(_offset, _offset)
	parent.get_parent().add_child(ran_ferrite_label)

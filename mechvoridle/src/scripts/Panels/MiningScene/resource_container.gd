class_name ResourceContainer extends Node

@export var parent : Node

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
		generate_label(random_ferrite_amount, 0)
		SignalBus.update_ferrite_count.emit()
	if random_ferrite_bars_amount > 0:
		GameManager.ferrite_bars_count += random_ferrite_bars_amount
		generate_label(random_ferrite_bars_amount, 1)
		SignalBus.update_ferrite_bars_count.emit()
	if random_platinum_amount > 0:
		GameManager.platinum_count += random_platinum_amount
		generate_label(random_platinum_amount, 2)
		SignalBus.update_plasma_count.emit()
	if random_plasma_amount > 0:
		GameManager.plasma_count += random_plasma_amount
		generate_label(random_plasma_amount, 3)
		SignalBus.update_plasma_count.emit()


func generate_label(amount : int, resource_icon : int):
	var _offset : int = randi_range(-10,10)
	var ran_ferrite_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	ran_ferrite_label.output = "+"+str(amount)
	ran_ferrite_label.resource = set_resource(ran_ferrite_label, resource_icon)
	ran_ferrite_label.position = parent.position + Vector2(_offset, _offset)
	parent.get_parent().add_child(ran_ferrite_label)
	SignalBus.update_ferrite_bars_count.emit()
	SignalBus.update_ferrite_count.emit()
	SignalBus.update_platinum_count.emit()
	SignalBus.update_plasma_count.emit()

func set_resource(resource_label : ResourceAcquiredLabel, resource : int) -> int:
	match (resource):
		0:
			return resource_label.RESOURCE.FERRITE
		1:
			return resource_label.RESOURCE.FERRITE_BAR
		2: 
			return resource_label.RESOURCE.PLATINUM
		3: 
			return resource_label.RESOURCE.PLASMA
		_:
			return 0

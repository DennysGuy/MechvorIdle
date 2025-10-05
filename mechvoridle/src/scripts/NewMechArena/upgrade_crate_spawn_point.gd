class_name UpgradeCrateSpawnPoint extends Marker3D

var spot_occupied : bool = false
@export var id : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.free_crate_spawn_location.connect(free_location)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func free_location(index : int) -> void:
	if index == id:
		spot_occupied = false

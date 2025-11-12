class_name HealthCrate extends SupplyCrate

@export var health_amount : int 

@onready var crate: Node3D = $Crate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	crate.rotation.y += 0.01

class_name Coob extends Node3D

@onready var body: Node3D = $Body

@onready var globe: CSGSphere3D = $"../Globe"


var speed := 1.0
var angle := 0.0
var radius := 3.0

func _ready() -> void:
	print(atan2(0,-1))

func _process(delta : float) -> void:
	pass
	#print("Forward: ", -body.global_transform.basis.z)
	#print("Right: ", body.global_transform.basis.x)
	#print("Up: ", body.global_transform.basis.y)

var time_passed := 0.0
var amplitude := 1.0
var frequency := 2.0

func _physics_process(delta: float) -> void:
	time_passed += delta
	
	angle += speed * delta
	var x = cos(angle) * radius
	var z = sin(angle) * radius
	
	
	var bob = sin(time_passed * frequency) * amplitude
	globe.global_transform.origin.y = 2.0 + bob
	
	globe.rotation.y += -0.01
	var offset := Vector3(x,z,0)
	global_transform.origin = globe.global_transform.origin + offset
	
	look_at(globe.global_transform.origin)

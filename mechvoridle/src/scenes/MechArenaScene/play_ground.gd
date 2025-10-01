class_name PlayGround extends Node3D

@onready var body: Node3D = $Body

@onready var globe: CSGSphere3D = $Globe



@onready var coob_2: Node3D = $Coob2
@onready var coob: Node3D = $Coob

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
	#time_passed += delta
	#
	angle += speed * delta
	var x = cos(angle) * radius * 2
	var z = sin(angle) * radius * 2
	#
	#var bob = sin(time_passed * frequency *4) * (amplitude*2)
	#globe.global_transform.origin.y = 2.0 + bob
	#globe.global_transform.origin = Vector3(x,(2.0+bob),0)
	#globe.rotation.y += -0.01
	#var offset := Vector3(x,0,z)
	#coob.global_transform.origin =  offset
	#coob_2.global_transform.origin = -offset
	#
	#coob.look_at(coob_2.global_transform.origin)
	#coob_2.look_at(coob.global_transform.origin)
	
	coob_2.global_transform.origin = Vector3(x,0,0)
	
	var dir = coob_2.global_transform.origin - coob.global_transform.origin
	var angle_2 = atan2(dir.x, dir.z)
	coob.rotation.y = angle_2

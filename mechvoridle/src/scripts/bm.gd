class_name BM
extends Node3D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var animation_player = $AnimationPlayer

enum STATES { BOB, NOD }
var current_state : int = STATES.BOB

func _ready() -> void:
	animation_tree.active = true
	state_machine.start("Bob")  # Start at "Bob" state

func _process(delta: float) -> void:
	pass

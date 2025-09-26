class_name DroneFire extends State

@export var idle_state : State
@export var charge_state : State
@onready var state_machine : StateMachine= $".."

func enter() -> void:
	parent.animation_player.play("fire_laser")	
	if parent.tracked_hostile:
		if parent.tracked_hostile is Asteroid and parent.tracked_hostile.health > 0:
			parent.tracked_hostile.damage_asteroid(parent.damage)
		
		elif parent.tracked_hostile is UFO:
			parent.tracked_hostile.damage_ufo(parent.damage)
		
	await parent.animation_player.animation_finished
	
	if parent.tracked_hostile:
		state_machine.change_state(charge_state)
	else:
		state_machine.change_state(idle_state)
	
func exit() -> void:
	pass


@warning_ignore("unused_parameter")
func process_physics(delta: float) -> State:

	return null

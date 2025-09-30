extends CharacterBody3D

@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $Mech/AnimationPlayer

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _ready() -> void:

	state_machine.init(self)

func _process(delta) -> void:
	state_machine.process_frame(delta)
	
	
func _physics_process(delta : float) -> void:
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	state_machine.process_physics(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

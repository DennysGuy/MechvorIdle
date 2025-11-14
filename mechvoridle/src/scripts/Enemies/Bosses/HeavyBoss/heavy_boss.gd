class_name HeavyBoss extends GridBoss

enum PHASES {
	INTRO,
	INTRO_TAUNT,
	ATTACK_PHASE1,
	ATTACK_PHASE2,
	ATTACK_PHASE3,
	DEAD
}
@onready var animation_player: AnimationPlayer = $HeavyBoss/AnimationPlayer
@onready var misc_animation_player: AnimationPlayer = $MiscAnimationPlayer

var current_phase : PHASES = PHASES.INTRO

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_hurt = false
	state_machine.init(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func shake_camera_on_taunt() -> void:
	SignalBus.shake_camera.emit(2.2)

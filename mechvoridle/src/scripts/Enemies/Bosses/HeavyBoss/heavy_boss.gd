class_name HeavyBoss extends GridBoss

enum PHASES {
	ATTACK_PHASE1,
	ATTACK_PHASE2,
	ATTACK_PHASE3
}

@export var row_limit : int = 2
@export var col_limit : int = 3

var current_phase : PHASES
var destined_tile : Tile
@onready var animation_player: AnimationPlayer = $HeavyBoss/AnimationPlayer
@onready var misc_animation_player: AnimationPlayer = $MiscAnimationPlayer

@onready var timer: Timer = $Timer
@onready var phase_timer: Timer = $PhaseTimer

var change_phase : bool = false
var random_direction_list : Array[Vector2] = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]
var idle_time : float = 2.0
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


func _on_phase_timer_timeout() -> void:
	var prev_phase : PHASES = current_phase
	var new_phase : PHASES = current_phase
	
	while prev_phase == new_phase:
		var keys : Array[int] = [0,1,2]
		new_phase = keys.pick_random()
	
	current_phase = new_phase
	change_phase = true

class_name GridBoss extends GridActor
@export var score : int
@export var animation_player : AnimationPlayer
@export var level : int = 1
@onready var in_berzerk_mode : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.speed_scale = TimeManager.enemy_tween_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

class_name GridPlayer extends Node3D

@export var current_tile : Tile
var wait_time : float = 0.15
var can_move : bool = true
@onready var animation_player: AnimationPlayer = $blockbench_export/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left") and can_move:
		SignalBus.move_player.emit(Vector2.UP)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
		
	if Input.is_action_pressed("move_right") and can_move:
		SignalBus.move_player.emit(Vector2.DOWN)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
	
	if Input.is_action_pressed("move_up") and can_move:
		SignalBus.move_player.emit(Vector2.LEFT)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
	
	if Input.is_action_pressed("move_down") and can_move:
		SignalBus.move_player.emit(Vector2.RIGHT)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true

class_name MiniRocket extends Node3D

@onready var mini_rocket: Node3D = $MiniRocket
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_launching : bool = true

var selected_tile : Tile

const DAMAGE = 45

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_launching:
		animation_player.play("Launch")
	else:
		animation_player.play("Fall")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func attack_tile() -> void:
	var wait_time : float = 1.0
	if selected_tile.occupant and selected_tile.occupant == GridManager.player:
		
		if GridManager.player.shield_active:
			GameManager.damage_shield(DAMAGE)
			wait_time = 0.3
		else:
			GridManager.player.damage_actor(DAMAGE)
			wait_time = 0.7
	
	SignalBus.shake_camera.emit(wait_time)
	
	selected_tile.clear_targeted_overlay()
	queue_free() #replace with explosion anime later

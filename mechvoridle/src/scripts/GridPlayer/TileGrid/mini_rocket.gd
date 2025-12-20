class_name MiniRocket extends Node3D

@onready var mini_rocket: Node3D = $MiniRocket
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_launching : bool = true

var selected_tile : Tile

const DAMAGE = 70

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.speed_scale = TimeManager.slow_time_factor
	if is_launching:
		animation_player.play("Launch")
	else:
		animation_player.play("Fall")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_impact_sfx() -> void:
	SfxManager.play_sfx(SfxManager.BOSS_ROCKET_IMPACT)

func attack_tile() -> void:
	var wait_time : float = 1.0
	if selected_tile.occupant and selected_tile.occupant == GridManager.player:
		
		if GridManager.player.shine_value > 0:
			var true_damage := DAMAGE
			var shield_bonus_time := GridManager.player.shine_value
			var calculated_damage := GameManager.calculate_shield_bonus(shield_bonus_time, true_damage)
					
			if calculated_damage > 0:
				true_damage = calculated_damage
					
			print("TRUE DAMAGE TO SHIELD: %s" % [true_damage])	
			GameManager.damage_shield(true_damage)
			wait_time = 0.3
		else:
			GridManager.player.damage_actor(DAMAGE)
			wait_time = 0.7
	
	SignalBus.shake_camera.emit(wait_time)
	
	selected_tile.clear_targeted_overlay()
	queue_free() #replace with explosion anime later

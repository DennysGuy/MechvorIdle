class_name GridEnemy extends GridActor

@export var weapon : MechWeapon


func _ready() -> void:
	can_move = false
	SignalBus.apply_timer_consequences.connect(apply_timer_consequences)
	SignalBus.enable_enemy_movement.connect(enable_enemy_movement)

func heal() -> void:
	health += int(max_health * 0.5)
	
	if health >= max_health:
		health = max_health

func apply_timer_consequences() -> void:
	damage_actor(1000)

func enable_enemy_movement() -> void:
	can_move = true

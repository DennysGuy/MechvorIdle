class_name GridEnemy extends GridActor

@export var weapon : MechWeapon

func _ready() -> void:
	SignalBus.apply_timer_consequences.connect(apply_timer_consequences)


func heal() -> void:
	health += int(max_health * 0.5)
	
	if health >= max_health:
		health = max_health

func apply_timer_consequences() -> void:
	damage_actor(1000)

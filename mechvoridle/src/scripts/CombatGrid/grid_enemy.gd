class_name GridEnemy extends GridActor

@export var weapon : MechWeapon


func heal() -> void:
	health += int(max_health * 0.5)
	
	if health >= max_health:
		health = max_health

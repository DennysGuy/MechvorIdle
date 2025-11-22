class_name GridEnemy extends GridActor

@export var weapon : MechWeapon
@export var spawn_rings : Node3D

@export var drop_chance : int

func _ready() -> void:
	can_move = false
	SignalBus.apply_timer_consequences.connect(apply_timer_consequences)
	SignalBus.enable_enemy_movement.connect(enable_enemy_movement)
	health_label.text = "%s/%s" % [health, max_health]
	
func heal() -> void:
	var value : int = int(max_health * 0.5)
	health += value
	
	var damage_label : GridDamageLabel = preload("uid://w3nvxv0mdub").instantiate()
	damage_label.label.text = "+%s" % [value]
	damage_label.set_as_heal()
	damage_label.position = damage_label_marker.position
	add_child(damage_label)
	
	if health >= max_health:
		health = max_health

func apply_timer_consequences() -> void:
	damage_actor(1000)

func enable_enemy_movement() -> void:
	can_move = true

func play_teleport_sfx() -> void:
	SfxManager.play_sfx(SfxManager.TELEPORT_IN, 3)

func clear_rings() -> void:
	for ring in spawn_rings.get_children():
		ring.queue_free()

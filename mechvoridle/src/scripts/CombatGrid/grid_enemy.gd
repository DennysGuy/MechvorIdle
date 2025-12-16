class_name GridEnemy extends GridActor

@export var enemy_name : String
@export var weapon : MechWeapon
@export var spawn_rings : Node3D
@export var animation_player : AnimationPlayer

@export var drop_chance : int
@export var score : int
@export var level : int = 1
@export var explosion_marker : Marker3D
@export var name_tag : Label

@export var level_1_hp : int
@export var level_2_hp : int
@export var level_3_hp : int

func _ready() -> void:
	can_move = false
	animation_player.speed_scale = TimeManager.slow_time_factor
	SignalBus.apply_timer_consequences.connect(apply_timer_consequences)
	SignalBus.enable_enemy_movement.connect(enable_enemy_movement)
	if health_label:
		health_label.text = "%s/%s" % [health, max_health]
	
	if name_tag:
		name_tag.text = "LV.%s %s" % [level,enemy_name]
	
	match level:
		1: 
			max_health = level_1_hp
			health = max_health
		2: 
			max_health = level_2_hp
			health = max_health
		3: 
			max_health = level_3_hp
			health = max_health
	
	
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

func _exit_tree() -> void:
	GridManager.remove_enemy_from_locked_on_list(self)

func apply_timer_consequences() -> void:
	damage_actor(1000)

func enable_enemy_movement() -> void:
	can_move = true

func play_teleport_sfx() -> void:
	SfxManager.play_sfx(SfxManager.TELEPORT_IN, 3)

func clear_rings() -> void:
	for ring in spawn_rings.get_children():
		ring.queue_free()


func spawn_basic_explosion() -> void:
	var explosion = preload("uid://dv6sujg7ehpfx").instantiate()
	explosion.position = explosion_marker.position
	add_child(explosion)
	SfxManager.play_sfx(SfxManager.BASIC_ENEMY_EXPLOSION,1)

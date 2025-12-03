class_name GridActor extends Node3D


@export var current_tile : Tile
@export var hurt_time : float
const  WAIT_TIME : float = 0.25

@export var state_machine : StateMachine
@export var can_move : bool = true
var can_hurt : bool = true
var is_attacking : bool = false
@export var health : int = 100
@export var max_health : int 
@export var tiles : Node
@export var weapon_spout : Marker3D
@export var lock_on_cross_hair : LockOnCrossHair


@export var damage_label_marker : Marker3D
@export var hit_flash_animation_player : AnimationPlayer
@export var health_label : Label

@export_group("States")
@export var hurt : State
@export var death : State

var is_dead : bool = false

func damage_actor(value : int, is_vulcan : bool = false) -> void:
	if is_dead:
		return
	
	if !can_hurt:
		create_damage_label(0, 1)
		return
	
	create_damage_label(value)
	
	if hit_flash_animation_player:
		hit_flash_animation_player.play("HitFlash")
	
	if is_vulcan:
		SfxManager.play_sfx(SfxManager.get_vulcan_impact())
	
	health -= value
	
	if self == GridManager.player:
		SignalBus.update_player_health_bar.emit()
	else:
		update_health_bar()
	
	if health <= 0:
		#place holder for now
		health = 0
		is_dead = true
		
		if self != GridPlayer and !is_vulcan:
			SignalBus.update_momentum_meter_amount.emit(2)
			GameManager.check_momentum_level()
			
		state_machine.change_state(death)
	else:
		if not is_vulcan and hurt:
			GameManager.enable_hit_freeze(0.25, 0.15)
			state_machine.change_state(hurt)

	if self != GridManager.player:
		SignalBus.start_healing.emit()

func fire_projectile(weapon : MechWeapon, selected_weapon_spout : Marker3D = weapon_spout) -> void:
	var projectile : GridProjectile = weapon.projectile.instantiate()
	projectile.global_position = selected_weapon_spout.global_position
	
	var destined_tile : Tile = GridManager.get_tile(tiles, weapon.attack_pattern.get_destined_tile_coordinates(self))
	if weapon.weapon_owner == weapon.WeaponOwner.PLAYER:
		destined_tile.set_targeted_overlay()
	else:
		destined_tile.set_enemy_targeted_overlay()
		
	projectile = weapon.spawn_projectile(selected_weapon_spout, destined_tile, tiles, self)
	
	get_parent().add_child(projectile)

func create_damage_label(amount : int, type : int = 0) -> void:
	var damage_label : GridDamageLabel = preload("uid://w3nvxv0mdub").instantiate()
	
	match type:
		0:
			damage_label.label.text = "-%s" % [amount]
			damage_label.set_as_damage()
		1:
			damage_label.label.text = "inv."
			damage_label.set_as_invincible()
		2:
			damage_label.label.text = "+%s" % [amount]
			damage_label.set_as_heal()
	
	damage_label.position = damage_label_marker.position
	add_child(damage_label)

func update_health_bar():
	health_label.text = str(health)+"/"+str(max_health)

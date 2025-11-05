class_name GridActor extends Node3D


@export var current_tile : Tile
@export var hurt_time : float
const  WAIT_TIME : float = 0.2
@export var state_machine : StateMachine
@export var can_move : bool = true
@export var health : int = 100
@export var max_health : int 
@export var tiles : Node
@export var weapon_spout : Marker3D

@export_group("States")
@export var hurt : State
@export var death : State

var is_dead : bool = false

func damage_actor(value : int, is_vulcan : bool = false) -> void:
	health -= value
	print("I was hit! Current HP:%s" % [health])
	if is_dead:
		return
	
	if health <= 0:
		#place holder for now
		health = 0
		is_dead = true
		state_machine.change_state(death)
	else:
		if not is_vulcan:
			state_machine.change_state(hurt)

	
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

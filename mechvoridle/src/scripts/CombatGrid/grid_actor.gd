class_name GridActor extends Node3D


@export var current_tile : Tile
const  WAIT_TIME : float = 0.2
@export var can_move : bool = true
@export var health : int = 100
@export var max_health : int 
@export var tiles : Node
@export var weapon_spout : Marker3D

func damage_actor(value : int) -> void:
	health -= value
	print("I was hit! Current HP:%s" % [health])
	if health <= 0:
		#place holder for now
		queue_free()


func fire_projectile(weapon : MechWeapon, selected_weapon_spout : Marker3D = weapon_spout) -> void:
	var projectile : GridProjectile = weapon.projectile.instantiate()
	projectile.global_position = selected_weapon_spout.global_position
	
	var destined_tile : Tile = GridManager.get_tile(tiles, weapon.attack_pattern.get_destined_tile_coordinates(self))
	destined_tile.set_targeted_overlay()
	projectile = weapon.spawn_projectile(selected_weapon_spout, destined_tile, tiles, self)
	
	get_parent().add_child(projectile)

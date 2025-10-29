class_name GridEnemy extends GridActor

@export var weapon : MechWeapon
@export var weapon_spout : Marker3D


func fire_projectile() -> void:
	var projectile : GridProjectile = weapon.projectile.instantiate()
	projectile.global_position = weapon_spout.global_position
	
	var destined_tile : Tile = GridManager.get_tile(tiles, weapon.attack_pattern.get_destined_tile_coordinates(self))
	destined_tile.set_targeted_overlay()
	projectile = weapon.spawn_projectile(weapon_spout, destined_tile, tiles, self)
	
	get_parent().add_child(projectile)

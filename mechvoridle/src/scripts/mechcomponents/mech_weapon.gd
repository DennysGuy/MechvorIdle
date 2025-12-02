class_name MechWeapon extends MechComponent

@export_enum("Standard", "Plasma") var weapon_type : int
@export_enum("Sword", "Rifle", "RocketLauncher") var weapon_class : int
@export var shop_index : int
enum WEAPON_CLASS {SWORD, RIFLE, ROCKETLAUNCHER}

enum WeaponOwner {PLAYER, ENEMY}
@export var weapon_owner : WeaponOwner = WeaponOwner.PLAYER

@export var base_damage : float
@export var damage : float
@export var cool_down_time : float
@export var number_of_hits : int
@export var charge_time : float
@export var charge_speed : float
@export var crit_chance : float
@export var crit_damage : float
@export var accuracy : float
@export var stun_chance : float
@export var plasma_damage_bonus : float

@export var attack_pattern : AttackPattern
@export var secondary_attack_pattern : AttackPattern

@export_group("Visuals")
@export var projectile : PackedScene
@export var secondary_projectile : PackedScene

@export_group("Projectile Audio")
@export var primary_projectile_discharge : AudioStream
@export var secondary_projectile_discharge : AudioStream

@export_group("Impact Audio")
@export var primary_impact : AudioStream
@export var secondary_impact : AudioStream

@export_group("Charge")
@export var charge_up : AudioStream

func get_weapon_class() -> String:
	match(weapon_class):
		WEAPON_CLASS.SWORD:
			return "Sword"
		WEAPON_CLASS.RIFLE:
			return "Rifle"
		WEAPON_CLASS.ROCKETLAUNCHER:
			return "Rocket Launcher"
		_:
			return ""

func attack_enemy(actor : GridActor, tiles : Node, scanned_attack_pattern : Array = [], is_vulcan : bool = false) -> void:
	var true_damage := damage
	if actor is GridPlayer:
		true_damage *= GameManager.next_multiplier
	
	if crit_landed():
		true_damage *= crit_damage
	
	attack_pattern.issue_attack(actor, tiles, int(true_damage), scanned_attack_pattern, is_vulcan)

func crit_landed() -> bool:
	var chance : float = crit_chance
	if weapon_owner == WeaponOwner.PLAYER and GameManager.owned_mech_components["Head"]:
		chance += GameManager.owned_mech_components["Head"].crit_chance
	chance *= 100
	
	var random_int = randi_range(0,100)
	if random_int <= chance:
		return true
	
	return false


func spawn_projectile(laser_spout : Marker3D, destined_tile : Tile, tiles : Node, owner : GridActor) -> GridProjectile:
	var grid_projectile  = projectile.instantiate() as GridProjectile
	grid_projectile.global_position = laser_spout.global_position
	grid_projectile.direction = (destined_tile.target_marker.global_transform.origin - laser_spout.global_transform.origin).normalized()
	grid_projectile.tile = destined_tile
	grid_projectile.tiles = tiles
	grid_projectile.damage = damage
	grid_projectile.weapon_origin = self
	grid_projectile.weapon_owner = owner
	
	return grid_projectile

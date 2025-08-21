class_name MechWeapon extends MechComponent

@export_enum("Standard", "Plasma") var weapon_type : int
@export_enum("Sword", "Rifle", "RocketLauncher") var weapon_class : int
enum WEAPON_TYPE {NORMAL, PLASMA}
enum WEAPON_CLASS {SWORD, RIFLE, ROCKETLAUNCHER}

@export var damage : int
@export var number_of_hits : int
@export var charge_time : float
@export var charge_speed : float
@export var crit_chance : float
@export var accuracy : float
@export var stun_chance : float
@export var plasma_damage_bonus : float

func get_weapon_type() -> String:
	match(weapon_type):
		WEAPON_TYPE.NORMAL:
			return "Standard"
		WEAPON_TYPE.PLASMA:
			return "Plasma"
		_:
			return ""

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

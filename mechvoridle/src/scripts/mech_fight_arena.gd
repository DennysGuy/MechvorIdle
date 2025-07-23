class_name MechFightArena extends Control


#player visuals
@onready var weapon_1 = $Background/Weapon1
@onready var weapon_2 = $Background/Weapon2
@onready var weapon_1_charge_bar : ProgressBar= $Weapon1ChargeBar
@onready var weapon_1_charge_bar_2 : ProgressBar = $Weapon1ChargeBar2
@onready var health_bar : ProgressBar = $HealthBar

#boss gui visuals
@onready var boss_title = $Background/BossTitle
@onready var boss_weapon_1 = $Background/BossWeapon1
@onready var boss_weapon_2 = $Background/BossWeapon2
@onready var boss_weapon_1_charge_bar = $Background/BossWeapon1ChargeBar
@onready var boss_weapon_2_charge_bar = $Background/BossWeapon2ChargeBar
@onready var boss_health_bar = $Background/BossHealthBar


func _ready() -> void:
	pass

func _process(delta : float) -> void:
	pass

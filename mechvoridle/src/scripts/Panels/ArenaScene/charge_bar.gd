class_name ChargeBar extends Control

@export_group("details")
@export_enum("Player", "Enemy") var target
@export_enum("Left Weapon", "Right Weapon") var weapon_position : int

@export var boss_health_bar : BossHealthBar
@export var player_health_bar : PlayerHealth
@onready var damage_layer : AudioStreamPlayer = $DamageLayer

@export var boss_label_marker : Marker2D
@export var player_label_marker : Marker2D

enum WEAPON_POSITION {LEFT_WEAPON, RIGHT_WEAPON}
enum TARGET{PLAYER, ENEMY}
@onready var sfx_player : AudioStreamPlayer = $SFXPlayer

@onready var weapon_charge_bar : TextureProgressBar = $WeaponChargeBar

@onready var weapon_name : Label = $WeaponName

@export var weapon : MechWeapon 

const NEAR_MISS_SWING_WHOOSH_3_233426 = preload("res://assets/audio/SFX/COMBAT/near-miss-swing-whoosh-3-233426.mp3")
const NEAR_MISS_SWING_WHOOSH_5_233428 = preload("res://assets/audio/SFX/COMBAT/near-miss-swing-whoosh-5-233428.mp3")

@onready var missed_sfx : Array[AudioStream] = [NEAR_MISS_SWING_WHOOSH_3_233426, NEAR_MISS_SWING_WHOOSH_5_233428]

var selected_torso : MechTorso
var selected_head : MechHead
var selected_arms : MechArms
var selected_legs : MechLegs

var target_legs : MechLegs

var selected_sfx : AudioStream

var true_charge_speed : float
var true_accuracy : float
var true_stun_chance : float
var true_target_dodge_chance : float
var true_crit_chance

@onready var sword_sfx : AudioStream = SfxManager.COM_PLY_ATK_SWORD_01
@onready var rifle_sfx : AudioStream = SfxManager.COM_PLY_ATK_RIFLE_01
@onready var launcher_sfx : AudioStream = SfxManager.COM_PLY_ATK_ROCKET_01

@onready var sword_hits_vox : Array[AudioStream] = [SfxManager.VOX_COM_ENE_DAMAGE_13, SfxManager.COM_PLY_DAMAGE_02, SfxManager.COM_PLY_DAMAGE_04]
@onready var rifle_hits_vox : Array[AudioStream] = [SfxManager.VOX_COM_ENE_DAMAGE_06, SfxManager.VOX_COM_ENE_DAMAGE_07, SfxManager.VOX_COM_ENE_DAMAGE_08 ]
@onready var launcher_hits_vox : Array[AudioStream] = [SfxManager.VOX_COM_ENE_DAMAGE_05, SfxManager.VOX_COM_ENE_DAMAGE_09, SfxManager.VOX_COM_ENE_DAMAGE_10]

@onready var hull_damage_hits : Array[AudioStream] = [SfxManager.COM_PLY_DAMAGE_01, SfxManager.COM_PLY_DAMAGE_02, SfxManager.COM_PLY_DAMAGE_03, SfxManager.COM_PLY_DAMAGE_04, SfxManager.COM_PLY_DAMAGE_05, SfxManager.COM_PLY_DAMAGE_06, SfxManager.COM_PLY_DAMAGE_07, SfxManager.COM_PLY_DAMAGE_08]


@onready var cockpit_damage : AudioStreamPlayer = $CockpitDamage


func _ready() -> void:
	weapon_charge_bar.min_value = 0
	weapon_charge_bar.max_value = 100
	if belongs_to_player():
		selected_torso = GameManager.get_owned_mech_torso()
		selected_head = GameManager.get_owned_mech_head()
		selected_arms = GameManager.get_owned_mech_arms()
		target_legs = GameManager.chosen_opponent.get_legs_component()
		
		if weapon_is_left_side():
			weapon = GameManager.get_left_weapon()
		else:
			weapon = GameManager.get_right_weapon()

	elif belongs_to_enemy():
		selected_arms = GameManager.chosen_opponent.get_arms_component()
		selected_torso = GameManager.chosen_opponent.get_torso_component()
		selected_head = GameManager.chosen_opponent.get_head_component()
		target_legs = GameManager.get_owned_mech_legs()
		
		if weapon_is_left_side():
			weapon = GameManager.chosen_opponent.get_left_weapon()
		else:
			weapon = GameManager.chosen_opponent.get_right_weapon()
	weapon_name.text = weapon.component_name
	true_charge_speed = weight_class_modifier_final_value(selected_torso, selected_torso.charge_speed_modifier, weapon.charge_speed)
	true_accuracy = weapon.accuracy + component_type_final_value(selected_head, selected_head.accuracy_bonus)

	true_target_dodge_chance = weight_class_modifier_final_value(target_legs, target_legs.dodge_chance_modifier, GameManager.BASE_DODGE_CHANCE)
	true_crit_chance = weapon.crit_chance + component_type_final_value(selected_arms, selected_arms.crit_chance_modifier)

	match weapon.get_weapon_class():
			"Sword":
				selected_sfx = sword_sfx.duplicate()
				sfx_player.stream = sword_sfx
			"Rifle":
				selected_sfx = rifle_sfx.duplicate()
				sfx_player.stream = rifle_sfx
			"Rocket Launcher":
				selected_sfx = launcher_sfx.duplicate()
				sfx_player.stream = launcher_sfx

func _physics_process(delta : float) -> void:
	
	if GameManager.fight_on:
		weapon_charge_bar.value += true_charge_speed
		if weapon_charge_bar.value >= weapon_charge_bar.max_value:
			if belongs_to_player():
				damage_target(GameManager.chosen_opponent.current_health, true_target_dodge_chance)
			elif belongs_to_enemy():
				damage_target(GameManager.current_health, true_target_dodge_chance)
				
				
			weapon_charge_bar.value = 0

func belongs_to_player() -> bool:
	return target == TARGET.ENEMY

func belongs_to_enemy() -> bool:
	return target == TARGET.PLAYER

func weapon_is_left_side() -> bool:
	return weapon_position == WEAPON_POSITION.LEFT_WEAPON

func weapon_is_right_side() -> bool:
	return weapon_position == WEAPON_POSITION.RIGHT_WEAPON

func weight_class_modifier_final_value(component : MechComponent, component_modifier_value : float, weapon_base_value : float) -> float:
	match component.weight_class:
		component.WEIGHT_CLASS.LIGHT:
			if component.category == component.CATEGORY.LEGS:
				return weapon_base_value  + component_modifier_value
			else:
				return weapon_base_value - component_modifier_value
		component.WEIGHT_CLASS.STANDARD:
			if component.category == component.CATEGORY.LEGS:
				return weapon_base_value + (component_modifier_value * 0.5)
			else:
				return weapon_base_value - (component_modifier_value * 0.5)
		component.WEIGHT_CLASS.HEAVY:
			if component.category == component.CATEGORY.LEGS:
				return weapon_base_value  - component_modifier_value
			else:
				return weapon_base_value + component_modifier_value
		_:
			return 0.0

func component_type_final_value(component : MechComponent, component_modifier_value : float) -> float:
	match(component.component_type):
		component.COMPONENT_TYPE.RANGED:
			if weapon.component_type == weapon.COMPONENT_TYPE.MELEE:
				return -component_modifier_value
			else:
				return component_modifier_value
		component.COMPONENT_TYPE.MELEE:
			if weapon.component_type == weapon.COMPONENT_TYPE.RANGED:
				return -component_modifier_value
			else:
				return component_modifier_value
		_:
			return 0.0
			
func damage_target(target_health : int, opponent_dodge_chance : float) -> void:
	var damage_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
	#calculate hit
	if attempt_attack_landed(true_accuracy, opponent_dodge_chance):
		#calculate crit_chance
		var random_damage : int = randi_range(weapon.damage - 40, weapon.damage)
		if crit_landed(true_crit_chance):
			var true_damage : int = random_damage * 2
			damage_label.output = "-"+str(true_damage)
			if belongs_to_player():
				boss_health_bar.current_health_tracker -= int(true_damage)
				boss_health_bar.update_health_bar()
				damage_label.position = boss_label_marker.position
				play_random_vox()
			elif belongs_to_enemy():
				player_health_bar.current_health_tracker -= random_damage
				player_health_bar.update_health_bar()
				SignalBus.shake_camera.emit()
				damage_label.position = player_label_marker.position
				play_random_hull_damage()
			damage_label.resource = set_icon_for_crit_damage(weapon.get_weapon_class())
			get_parent().add_child(damage_label)
			
			sfx_player.play()
			return
		
		damage_label.output = "-"+str(weapon.damage)
		if belongs_to_player():	
			boss_health_bar.current_health_tracker -= random_damage
			boss_health_bar.update_health_bar()
			damage_label.position = boss_label_marker.position
			play_random_vox()
		elif belongs_to_enemy():
			player_health_bar.current_health_tracker -= random_damage
			player_health_bar.update_health_bar()
			damage_label.position = player_label_marker.position
			SignalBus.shake_camera.emit(3)
			play_random_hull_damage()
		damage_label.resource = set_icon_for_standard_damage(weapon.get_weapon_class())
		
	else:
		if belongs_to_enemy():
			damage_label.position = player_label_marker.position
		elif belongs_to_player():
			damage_label.position = boss_label_marker.position
			
		#sfx_player.stream = missed_sfx.pick_random()
		damage_label.resource = set_icon_for_standard_damage("Missed")
		damage_label.output = "Missed!"
		

	sfx_player.play()
	#sfx_player.stream = selected_sfx
	get_parent().add_child(damage_label)
			
	#need to add labelto show how much damage was applied to enemy

	
func attempt_attack_landed(attacker_accuracy : float, target_dodge_chance : float) -> bool:
	var hit_chance = attacker_accuracy/(attacker_accuracy + target_dodge_chance)
	var roll = randf()
	return roll <= hit_chance

func crit_landed(crit_chance : float) -> bool:
	var roll = randf()
	return roll <= crit_chance

func set_icon_for_standard_damage(weapon_type : String) ->  int:
	match(weapon_type):
		"Rifle":
			return ResourceAcquiredLabel.RESOURCE.RIFLE
		"Sword":
			return ResourceAcquiredLabel.RESOURCE.SWORD
		"Rocket Launcher":
			return ResourceAcquiredLabel.RESOURCE.ROCKETLAUNCHER
		"Missed":
			return ResourceAcquiredLabel.RESOURCE.MISSED
		_:
			return 0

func set_icon_for_crit_damage(weapon_type : String) ->  int:
	match(weapon_type):
		"Rifle":
			return ResourceAcquiredLabel.RESOURCE.RIFLECRIT
		"Sword":
			return ResourceAcquiredLabel.RESOURCE.SWORDCRIT
		"Rocket Launcher":
			return ResourceAcquiredLabel.RESOURCE.ROCKETLAUNCHERCRIT
		_:
			return 0

func play_random_vox() -> void:
	match weapon.get_weapon_class():
		"Sword":
			damage_layer.stream = sword_hits_vox.pick_random()
		"Rifle":
			damage_layer.stream = rifle_hits_vox.pick_random()
		"Rocket Launcher":
			damage_layer.stream = launcher_hits_vox.pick_random()
	
	damage_layer.play()

func play_random_hull_damage() -> void:
	cockpit_damage.stream = hull_damage_hits.pick_random()
	cockpit_damage.play()

class_name ChargeBar extends ColorRect

@export_group("details")
@export_enum("Player", "Enemy") var target
@export_enum("Left Weapon", "Right Weapon") var weapon_position : int

enum WEAPON_POSITION {LEFT_WEAPON, RIGHT_WEAPON}
enum TARGET{PLAYER, ENEMY}

@onready var weapon_charge_bar : ProgressBar = $WeaponChargeBar
@onready var weapon_name : Label = $WeaponName

@export var weapon : MechWeapon 

var selected_torso : MechTorso
var selected_head : MechHead
var selected_arms : MechArms
var target_legs : MechLegs

var true_charge_speed : float
var true_accuracy : float
var true_stun_chance : float
var true_target_dodge_chance : float
var true_crit_chance


func _ready() -> void:
	
	if belongs_to_player():
		selected_torso = GameManager.get_owned_mech_torso()
		selected_head = GameManager.get_owned_mech_head()
		selected_arms = GameManager.get_owned_mech_arms()
		target_legs = GameManager.chosen_opponent.get_legs_component()
		
		if weapon_is_left_side():
			weapon = GameManager.get_left_weapon()
		else:
			weapon = GameManager.get_right_weapon()

	else:
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

func _process(delta : float) -> void:
	
	if GameManager.fight_on:
		weapon_charge_bar.value += true_charge_speed
		if weapon_charge_bar.value >= weapon_charge_bar.max_value:
			if belongs_to_player():
				damage_target(GameManager.chosen_opponent.current_health)
			else:
				damage_target(GameManager.current_health)
				SignalBus.shake_camera.emit()
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
			return weapon_base_value  + component_modifier_value
		component.WEIGHT_CLASS.STANDARD:
			return weapon_base_value + (component_modifier_value * 0.5)
		component.WEIGHT_CLASS.HEAVY:
			return weapon_base_value  - component_modifier_value
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
			
func damage_target(target_health : int) -> void:

	#calculate hit
	if attempt_attack_landed(true_accuracy, true_target_dodge_chance):
		#calculate crit_chance
		if crit_landed(true_crit_chance):
			if belongs_to_player():
				GameManager.chosen_opponent.current_health -= int(weapon.damage * 2)
				SignalBus.update_opponent_health_bar.emit()
			else:
				GameManager.current_health -= int(weapon.damage * 2)
				SignalBus.update_player_health_bar.emit()
				SignalBus.shake_camera.emit()
			return
		
		if belongs_to_player():	
			GameManager.chosen_opponent.current_health -= weapon.damage
			SignalBus.update_opponent_health_bar.emit()
		else:
			GameManager.current_health -= weapon.damage
			SignalBus.update_player_health_bar.emit()
			SignalBus.shake_camera.emit()
			
	#need to add labelto show how much damage was applied to enemy

	
func attempt_attack_landed(attacker_accuracy : float, target_dodge_chance : float) -> bool:
	var hit_chance = attacker_accuracy/(attacker_accuracy + target_dodge_chance)
	var roll = randf()
	return roll <= hit_chance

func crit_landed(crit_chance : float) -> bool:
	var roll = randf()
	return roll <= crit_chance

class_name MechStatsPanel extends ColorRect

@onready var total_armor_amount: Label = $TotalArmorAmount
@onready var mobility_amount: StatLabel = $MobilityAmount
@onready var max_hit_chance: Label = $MaxHitChance


#weapon 1 labels

@onready var weapon_1: Label = $Weapon1
@onready var dpcw_1_amount: Label = $DPCW1Amount
@onready var charge_speed_amount: StatLabel = $ChargeSpeedAmount
@onready var crit_chance_perc: StatLabel = $CritChancePerc
@onready var stun_chance_w_1_perc: StatLabel = $StunChanceW1Perc
@onready var accuracy : Label = $Accuracy
@onready var accuracy_rate : StatLabel = $AccuracyRate
@onready var crit_damage_perc : StatLabel = $CritDamagePerc

#weapon 2 labels

@onready var weapon_2: Label = $Weapon2
@onready var dpcw_1_amount_2: Label = $DPCW1Amount2
@onready var charge_speed_amount_2: StatLabel = $ChargeSpeedAmount2
@onready var crit_chance_perc_2: StatLabel = $CritChancePerc2
@onready var stun_chance_w_1_perc_2: StatLabel = $StunChanceW1Perc2
@onready var accuracy_2 : Label = $Accuracy2
@onready var accuracy_rate_2 : StatLabel = $AccuracyRate2
@onready var crit_damage_perc_2 : StatLabel = $CritDamagePerc2


func _ready() -> void:
	SignalBus.update_accuracy_stats_on_mech_head_purchased.connect(update_weapon_accuracy_on_head_purchase)
	SignalBus.update_charge_speed_stats_on_mech_torso_purchased.connect(update_weapon_charge_speed_on_torso_purchase)
	SignalBus.update_crit_damage_stats_on_mech_arms_purchased.connect(update_weapon_crit_chance_on_head_purchase)
	SignalBus.update_crit_stats_on_mech_head_purchased.connect(update_weapon_crit_chance_on_head_purchase)
	SignalBus.update_dodge_stats_on_mech_legs_purchased.connect(update_total_mobility)
	SignalBus.update_stun_stats_on_mech_legs_purchased.connect(update_weapon_stun_chance_on_legs_purchase)
	
	SignalBus.update_weapon_1_name_on_purchased.connect(update_weapon_1_name)
	SignalBus.update_weapon_1_accuracy_stats_on_purchased.connect(update_weapon_1_accuracy_on_weapon_purchase)
	SignalBus.update_weapon_1_charge_speed_stats_on_purchased.connect(update_weapon_1_charge_speed_on_weapon_purcahse)
	SignalBus.update_weapon_1_crit_chance_stats_on_purchased.connect(update_weapon_1_crit_chance_on_weapon_purchase)
	SignalBus.update_weapon_1_stun_stats_on_purchased.connect(update_weapon_1_stun_chance_on_weapon_purchase)
	SignalBus.update_weapon_1_dpc_stats_on_purchased.connect(update_weapon_1_dpc)
	
	SignalBus.update_weapon_2_name_on_purchased.connect(update_weapon_2_name)
	SignalBus.update_weapon_2_accuracy_stats_on_purchased.connect(update_weapon_2_accuracy_on_weapon_purchase)
	SignalBus.update_weapon_2_charge_speed_stats_on_purchased.connect(update_weapon_2_charge_speed_on_weapon_purcahse)
	SignalBus.update_weapon_2_crit_chance_stats_on_purchased.connect(update_weapon_2_crit_chance_on_weapon_purchase)
	SignalBus.update_weapon_2_stun_stats_on_purchased.connect(update_weapon_2_stun_chance_on_weapon_purchase)
	SignalBus.update_weapon_2_dpc_stats_on_purchased.connect(update_weapon_2_dpc)
	
	SignalBus.update_total_armor_amount.connect(update_total_armor_amount)
	
	total_armor_amount.text = "0"
	mobility_amount.text = str(GameManager.BASE_DODGE_CHANCE * 100) +"%"
	weapon_1.text = "Weapon 1 - N/A"
	dpcw_1_amount.text = "0"
	charge_speed_amount.text = "0"
	crit_chance_perc.text = "0%"
	stun_chance_w_1_perc.text= "0%"
	accuracy_rate.text = "0%"
	
	weapon_2.text = "Weapon 2 - N/A"
	dpcw_1_amount_2.text = "0"
	charge_speed_amount_2.text = "0"
	crit_chance_perc_2.text = "0%"
	stun_chance_w_1_perc_2.text= "0%"
	accuracy_rate_2.text = "0%"

func _process(delta : float) -> void:
	pass


func update_total_armor_amount() -> void:
	total_armor_amount.text = str(GameManager.calculate_current_total_health())

func update_total_mobility(component : MechLegs) -> void:
	var base_dodge_chance : float = GameManager.BASE_DODGE_CHANCE * 100
	var added_dodge_chance : float =  base_dodge_chance * component.dodge_chance_modifier
	mobility_amount.text = str(base_dodge_chance + added_dodge_chance) +"%" +" (15% + "+str(added_dodge_chance)+"%)"

func update_max_hit_chance(component : MechArms) -> void:
	max_hit_chance.text = str(component.max_hits_chance * 100) +"%"

func update_weapon_1_name(component : MechWeapon) -> void:
	weapon_1.text = "Weapon 1 - " + component.get_weapon_class()

func update_weapon_1_dpc(component : MechWeapon) -> void:
	dpcw_1_amount.text = str(component.damage)

func update_weapon_1_charge_speed_on_weapon_purcahse(component : MechWeapon) -> void:
	var charge_speed : float = roundf(component.charge_speed * 100)
	if !GameManager.owned_mech_components["Torso"]:
		charge_speed_amount.text = str(roundf(charge_speed))
	else:
		var owned_torso : MechTorso= GameManager.owned_mech_components["Torso"]
		var torso_charge_speed_bonus : float = owned_torso.charge_speed_modifier
		var added_charge_speed_bonus : float = charge_speed * torso_charge_speed_bonus
		charge_speed_amount.text = calculate_stat(component, owned_torso, charge_speed, added_charge_speed_bonus, charge_speed_amount)

func update_weapon_charge_speed_on_torso_purchase(component : MechTorso) -> void:
	var torso_charge_speed_bonus : float = component.charge_speed_modifier
	if GameManager.owned_mech_components["LeftWeapon"]:
		var left_weapon : MechWeapon = GameManager.owned_mech_components["LeftWeapon"]
		var charge_speed : float = roundf(left_weapon.charge_speed * 100)
		var added_charge_speed_bonus : float = charge_speed * torso_charge_speed_bonus
		charge_speed_amount.text = calculate_stat(left_weapon, component, charge_speed, added_charge_speed_bonus, charge_speed_amount)
	
	if GameManager.owned_mech_components["RightWeapon"]:
		var right_weapon : MechWeapon = GameManager.owned_mech_components["RightWeapon"]
		var charge_speed : float = roundf(right_weapon.charge_speed*100)
		var added_charge_speed_bonus : float = charge_speed * torso_charge_speed_bonus * 100
		charge_speed_amount.text = calculate_stat(right_weapon, component, charge_speed, added_charge_speed_bonus, charge_speed_amount)

func update_weapon_1_crit_chance_on_weapon_purchase(component : MechWeapon) -> void:
	var crit_chance : float = roundf(component.crit_chance * 100) 

	if GameManager.owned_mech_components["Head"]:
		var owned_head : MechHead = GameManager.owned_mech_components["Head"]
		var head_crit_chance_bonus : float = owned_head.crit_chance
		var added_crit_chance_bonus : float = roundf(crit_chance * head_crit_chance_bonus)
		crit_chance_perc.text = calculate_stat(component, owned_head, crit_chance, added_crit_chance_bonus, crit_chance_perc)+ "%"
	else:
		crit_chance_perc.text = str(roundf(crit_chance)) + "%"

func update_weapon_crit_chance_on_head_purchase(component : MechHead) -> void:
	var crit_chance_bonus : float = component.crit_chance
	if GameManager.owned_mech_components["LeftWeapon"]:
		var left_weapon : MechWeapon = GameManager.owned_mech_components["LeftWeapon"]
		var weapon_crit_chance : float = roundf(left_weapon.crit_chance * 100)
		var added_crit_chance_bonus : float = roundf(weapon_crit_chance * crit_chance_bonus)
		crit_chance_perc.text = calculate_stat(left_weapon, component, weapon_crit_chance, added_crit_chance_bonus,crit_chance_perc) + "%"

	if GameManager.owned_mech_components["RightWeapon"]:
		var right_weapon : MechWeapon = GameManager.owned_mech_components["RightWeapon"]
		var weapon_crit_chance : float = roundf(right_weapon.crit_chance * 100)
		var added_crit_chance_bonus : float = roundf(weapon_crit_chance * crit_chance_bonus)
		crit_chance_perc_2.text = calculate_stat(right_weapon, component, weapon_crit_chance, added_crit_chance_bonus,crit_chance_perc) + "%"

func update_weapon_1_accuracy_on_weapon_purchase(component : MechWeapon) -> void:
	var hit_chance : float = roundf(component.accuracy * 100)
	if !GameManager.owned_mech_components["Head"]:
		accuracy_rate.text = str(roundf(hit_chance))+ "%"
	else:
		var owned_head : MechHead = GameManager.owned_mech_components["Head"]
		var hit_chance_bonus : float = owned_head.accuracy_bonus
		var added_bonus : float = roundf(hit_chance * hit_chance_bonus)
		accuracy_rate.text = calculate_stat(component, owned_head, hit_chance, added_bonus, accuracy_rate) +"%"

func update_weapon_accuracy_on_head_purchase(component : MechHead) -> void:
	var hit_chance : float = component.accuracy_bonus
	if GameManager.owned_mech_components["LeftWeapon"]:
		var left_weapon : MechWeapon = GameManager.owned_mech_components["LeftWeapon"]
		var hit_chance_bonus : float = roundf(left_weapon.accuracy * 100)
		var added_bonus : float = roundf(hit_chance * hit_chance_bonus)
		accuracy_rate.text = calculate_stat(left_weapon, component, hit_chance_bonus, added_bonus, accuracy_rate) + "%"

	if GameManager.owned_mech_components["RightWeapon"]:
		var right_weapon : MechWeapon = GameManager.owned_mech_components["RightWeapon"]
		var hit_chance_bonus : float = roundf(right_weapon.accuracy * 100)
		var added_bonus : float = roundf(hit_chance * hit_chance_bonus)
		accuracy_rate_2.text = calculate_stat(right_weapon, component, hit_chance_bonus, added_bonus, accuracy_rate)+ "%"

func update_weapon_1_stun_chance_on_weapon_purchase(component : MechWeapon) -> void:
	var stun_chance : float = roundf(component.stun_chance * 100)
	if !GameManager.owned_mech_components["Legs"]:
		stun_chance_w_1_perc.text = str(stun_chance)+"%"
	else:
		var owned_legs : MechLegs = GameManager.owned_mech_components["Legs"]
		var stun_chance_bonus : float = owned_legs.stun_chance
		var added_bonus : float = roundf(stun_chance * stun_chance_bonus)
		stun_chance_w_1_perc.text = str(stun_chance + added_bonus) + "% " + "("+str(stun_chance)+" + "+str(added_bonus)+")"

func update_weapon_stun_chance_on_legs_purchase(component : MechLegs) -> void:
	var stun_chance_bonus : float = component.stun_chance
	if GameManager.owned_mech_components["LeftWeapon"]:
		var left_weapon : MechWeapon = GameManager.owned_mech_components["LeftWeapon"]
		var stun_chance : float = roundf(left_weapon.stun_chance * 100)
		var added_bonus : float = roundf(stun_chance * stun_chance_bonus)
		stun_chance_w_1_perc.text = str(stun_chance + added_bonus) + "% " + "("+str(stun_chance)+" + "+str(added_bonus)+")"

	if GameManager.owned_mech_components["RightWeapon"]:
		var right_weapon : MechWeapon = GameManager.owned_mech_components["RightWeapon"]
		var stun_chance : float = roundf(right_weapon.stun_chance*100)
		var added_bonus : float = roundf(stun_chance * stun_chance_bonus)
		stun_chance_w_1_perc_2.text =  str(stun_chance + added_bonus) + "% " + "("+str(stun_chance)+" + "+str(added_bonus)+")"

func update_weapon_1_crit_damage_on_purchase(component : MechWeapon) -> void:
	pass

func update_weapon_crit_damage_on_arms_purchase(component : MechArms) -> void:
	pass

func update_weapon_2_name(component : MechWeapon) -> void:
	weapon_2.text = "Weapon 2 - " + component.get_weapon_class()

func update_weapon_2_dpc(component : MechWeapon) -> void:
	dpcw_1_amount_2.text = str(component.damage)

func update_weapon_2_charge_speed_on_weapon_purcahse(component : MechWeapon) -> void:
	var charge_speed : float = roundf(component.charge_speed * 100)
	if !GameManager.owned_mech_components["Torso"]:
		charge_speed_amount_2.text = str(charge_speed)
	else:
		var owned_torso : MechTorso = GameManager.owned_mech_components["Torso"]
		var torso_charge_speed_bonus : float = owned_torso.charge_speed_modifier
		var added_charge_speed_bonus : float = charge_speed * torso_charge_speed_bonus
		charge_speed_amount_2.text = calculate_stat(component, owned_torso, charge_speed, added_charge_speed_bonus, charge_speed_amount_2)
	

func update_weapon_2_crit_chance_on_weapon_purchase(component : MechWeapon) -> void:
	var crit_chance : float = roundf(component.crit_chance * 100)
	if !GameManager.owned_mech_components["Head"]:
		crit_chance_perc_2.text = str(crit_chance)+ "%"
	else:
		var owned_head : MechHead = GameManager.owned_mech_components["Head"]
		var head_crit_chance_bonus : float = owned_head.crit_chance
		var added_bonus : float = crit_chance * head_crit_chance_bonus
		crit_chance_perc_2.text = calculate_stat(component, owned_head, crit_chance, added_bonus, crit_chance_perc_2) + "%"

func update_weapon_2_accuracy_on_weapon_purchase(component : MechWeapon) -> void:
	var hit_chance : float = roundf(component.accuracy * 100)
	if !GameManager.owned_mech_components["Head"]:
		accuracy_rate_2.text = str(hit_chance)+ "%"
	else:
		var owned_head : MechHead = GameManager.owned_mech_components["Head"]
		var hit_chance_bonus : float = owned_head.accuracy_bonus
		var added_bonus : float = hit_chance * hit_chance_bonus
		accuracy_rate_2.text = calculate_stat(component, owned_head, hit_chance, added_bonus, accuracy_rate_2) + "%"

func update_weapon_2_stun_chance_on_weapon_purchase(component : MechWeapon) -> void:
	var stun_chance : float = roundf(component.stun_chance * 100)
	if !GameManager.owned_mech_components["Legs"]:
		stun_chance_w_1_perc_2.text = str(stun_chance)+ "%"
	else:
		var owned_legs : MechLegs = GameManager.owned_mech_components["Legs"]
		var stun_chance_bonus : float = owned_legs.stun_chance
		var added_bonus : float = roundf(stun_chance * stun_chance_bonus)
		stun_chance_w_1_perc_2.text = str(stun_chance + added_bonus) + "%" + " ("+str(stun_chance)+" + "+str(stun_chance_bonus)+")"

func update_weapon_2_crit_damage_on_weapon_purchase(component : MechWeapon) -> void:
	pass

func calculate_stat(weapon : MechWeapon, component : MechComponent, base_stat : float, bonus_stat : float, stat_label : StatLabel) -> String:
	var stat_show : String
	var new_stat_calc : float
	match (component.get_weight_class()):
		"HEAVY":
			if weapon.component_type == weapon.COMPONENT_TYPE.RANGED:
				new_stat_calc = roundf(base_stat + bonus_stat)
				stat_show = str(new_stat_calc)+" ("+str(base_stat)+" + "+str(bonus_stat)+")"
			else:
				new_stat_calc = roundf(base_stat - bonus_stat)
				stat_show = str(new_stat_calc)+" ("+str(base_stat)+" - "+str(bonus_stat)+")"
		"REGULAR":
			new_stat_calc = roundf(base_stat + bonus_stat)
			stat_show = str(new_stat_calc)+" ("+str(base_stat)+" + "+str(bonus_stat)+")"
		
		"LIGHT":
			if weapon.component_type == weapon.COMPONENT_TYPE.MELEE:
				new_stat_calc = roundf(base_stat + bonus_stat)
				stat_show = str(new_stat_calc) +" ("+str(base_stat)+" + "+str(bonus_stat)+")"
			else:
				new_stat_calc = roundf(base_stat - bonus_stat)
				stat_show = str(new_stat_calc) +" ("+str(base_stat)+" - "+str(bonus_stat)+")"
		_:
			return ""
	if new_stat_calc > base_stat:
		stat_label.set_text_color_green()
	elif new_stat_calc < base_stat:
		stat_label.set_text_color_red()

	return stat_show

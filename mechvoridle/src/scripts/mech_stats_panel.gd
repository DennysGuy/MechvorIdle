class_name MechStatsPanel extends ColorRect

@onready var total_armor_amount: Label = $TotalArmorAmount
@onready var mobility_amount: Label = $MobilityAmount


#weapon 1 labels

@onready var weapon_1: Label = $Weapon1
@onready var dpcw_1_amount: Label = $DPCW1Amount
@onready var charge_speed_amount: Label = $ChargeSpeedAmount
@onready var crit_chance_perc: Label = $CritChancePerc
@onready var stun_chance_w_1_perc: Label = $StunChanceW1Perc

#weapon 2 labels

@onready var weapon_2: Label = $Weapon2
@onready var dpcw_1_amount_2: Label = $DPCW1Amount2
@onready var charge_speed_amount_2: Label = $ChargeSpeedAmount2
@onready var crit_chance_perc_2: Label = $CritChancePerc2
@onready var stun_chance_w_1_perc_2: Label = $StunChanceW1Perc2


func _ready() -> void:
	total_armor_amount.text = "0"
	mobility_amount.text = str(GameManager.BASE_DODGE_CHANCE * 100) +"%"
	weapon_1.text = "Weapon 1 - N/A"
	dpcw_1_amount.text = "0"
	charge_speed_amount.text = "0"
	crit_chance_perc.text = "0%"
	stun_chance_w_1_perc.text= "0%"
	
	weapon_2.text = "Weapon 2 - N/A"
	dpcw_1_amount_2.text = "0"
	charge_speed_amount_2.text = "0"
	crit_chance_perc_2.text = "0%"
	stun_chance_w_1_perc_2.text= "0%"
	

func _process(delta : float) -> void:
	pass


func update_total_armor_amount() -> void:
	total_armor_amount.text = str(GameManager.calculate_current_total_health())

func update_total_mobility(component : MechLegs) -> void:
	mobility_amount.text = str(GameManager.BASE_DODGE_CHANCE + component.dodge_chance_modifier) + "("+str(GameManager.BASE_DODGE_CHANCE)+" + "+str(component.stun_chance) 

func update_weapon_1_name(component : MechWeapon) -> void:
	weapon_1.text = "Weapon 1 - " + component.component_name + "("+component.get_weapon_class()+")"

func update_weapon_1_dpc(component : MechWeapon) -> void:
	dpcw_1_amount.text = str(component.damage)

func update_weapon_1_charge_speed_on_weapon_purcahse(component : MechWeapon) -> void:
	pass

func update_weapon_1_charge_speed_on_torso_purchase(component : MechTorso) -> void:
	pass

func update_weapon_1_crit_chance_on_weapon_purchase(component : MechWeapon) -> void:
	pass

func update_weapon_1_crit_chance_on_head_purchase(component : MechHead) -> void:
	pass
	
func update_weapon_1_stun_chance_on_weapon_purchase(component : MechWeapon) -> void:
	pass

func update_weapon_1_stun_chance_on_legs_purchase(component : MechLegs) -> void:
	pass

func update_weapon_2_name(component : MechWeapon) -> void:
	weapon_1.text = "Weapon 2 - " + component.component_name + "("+component.get_weapon_class()+")"

func update_weapon_2_dpc(component : MechWeapon) -> void:
	dpcw_1_amount_2.text = str(component.damage)

func update_weapon_2_charge_speed_on_weapon_purcahse(component : MechWeapon) -> void:
	pass

func update_weapon_2_charge_speed_on_torso_purchase(component : MechTorso) -> void:
	pass

func update_weapon_2_crit_chance_on_weapon_purchase(component : MechWeapon) -> void:
	pass

func update_weapon_2_crit_chance_on_head_purchase(component : MechHead) -> void:
	pass
	
func update_weapon_2_stun_chance_on_weapon_purchase(component : MechWeapon) -> void:
	pass

func update_weapon_2_stun_chance_on_legs_purchase(component : MechLegs) -> void:
	pass

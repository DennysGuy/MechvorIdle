class_name PartsOwnedListPanel extends ColorRect

@onready var owned_head_name : Label = $OwnedHeadName
@onready var owned_torso_name : Label = $OwnedTorsoName
@onready var owned_legs_name : Label = $OwnedLegsName
@onready var owned_weapon_1 : Label = $OwnedWeapon1
@onready var owned_weapon_2 : Label = $OwnedWeapon2
@onready var owned_arms_name : Label = $OwnedArmsName



func _ready() -> void:
	owned_head_name.text = "Buy Head to see stats"
	owned_torso_name.text = "Buy Torso to see stats"
	owned_legs_name.text = "Buy Legs to see stats"
	owned_arms_name.text = "Buy Arms to see stats"
	owned_weapon_1.text = "Buy weapon to see stats"
	owned_weapon_2.text = "Buy weapon to see stats"
	
	SignalBus.update_mech_head_name.connect(update_head_name)
	SignalBus.update_mech_torso_name.connect(update_torso_name)
	SignalBus.update_mech_arms_name.connect(update_arms_name)
	SignalBus.update_mech_legs_name.connect(update_legs_name)
	SignalBus.update_weapon_1_name_on_purchased.connect(update_weapon_one_name)
	SignalBus.update_weapon_2_name_on_purchased.connect(update_weapon_two_name)
	

func _process(delta : float) -> void:
	pass

func update_head_name(mech_head : MechHead) -> void:
	owned_head_name.text = mech_head.component_name

func update_torso_name(mech_torso : MechTorso) -> void:
	owned_torso_name.text = mech_torso.component_name

func update_legs_name(mech_legs : MechLegs) -> void:
	owned_legs_name.text = mech_legs.component_name

func update_arms_name(mech_arms : MechArms) -> void:
	owned_arms_name.text = mech_arms.component_name

func update_weapon_one_name(weapon : MechWeapon) -> void:
	owned_weapon_1.text = weapon.component_name

func update_weapon_two_name(weapon : MechWeapon) -> void:
	owned_weapon_2.text = weapon.component_name

func _on_show_mech_stats_button_down():
	SignalBus.toggle_mech_stats_panels.emit()

func _on_button_button_down():
	SignalBus.hide_mech_stats_panels.emit()

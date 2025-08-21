class_name EffectsDescriptor extends RichTextLabel

func _ready() -> void:
	SignalBus.update_stats_panel.connect(update_stats_panel)
	var place_holder_label : StatLabel = preload("res://src/scenes/StatLabel.tscn").instantiate()
	place_holder_label.text = "Select a component.s"
	add_child(place_holder_label)
func _process(delta) -> void:
	pass


func update_stats_panel(mech_component : MechComponent) -> void:
	clear_container()
	match (mech_component.get_category_type()):
		"Head":
			var head_comp : MechHead = mech_component as MechHead
			if head_comp.get_weight_class() == "LIGHT":
				text = "Armor Bonus: " + "[color=yellow]+"+str(head_comp.health)+"[/color]\n"+\
				"Melee Accuracy Mod: " + "[color=green]+"+str(roundf(head_comp.accuracy_bonus*100))+"%[/color]\n"+\
				"Melee Crit Chance Mod: "+"[color=green]+"+str(roundf(head_comp.crit_chance*100))+"%[/color]\n"+\
				"Range Accuracy Mod: " + "[color=red]-"+str(roundf(head_comp.accuracy_bonus*100))+"%[/color]\n"+\
				"Range Crit Chance Mod: "+"[color=red]-"+str(roundf(head_comp.crit_chance*100))+"%[/color]\n"
				
			if head_comp.get_weight_class() == "HEAVY":
				text = "Armor Bonus: " + "[color=green]+"+str(head_comp.health)+"[/color]\n"+\
				"Range Accuracy Mod: " + "[color=green]+"+str(roundf(head_comp.accuracy_bonus*100))+"%[/color]\n"+\
				"Range Crit Chance Mod: "+"[color=green]+"+str(roundf(head_comp.crit_chance*100))+"%[/color]\n"+\
				"Melee Accuracy Mod: " + "[color=red]-"+str(roundf(head_comp.accuracy_bonus*100))+"%[/color]\n"+\
				"Melee Crit Chance Mod: "+"[color=red]-"+str(roundf(head_comp.crit_chance*100))+"%[/color]\n"
				
			if head_comp.get_weight_class() == "REGULAR":
				text = "Armor Bonus: " + "+"+str(head_comp.health)+"\n"+\
				"Range Accuracy Mod: " + "[color=green]+"+str(roundf(head_comp.accuracy_bonus*100))+"%[/color]\n"+\
				"Range Crit Chance Mod: "+"[color=red]-"+str(roundf(head_comp.crit_chance*100))+"%[/color]\n"+\
				"Melee Accuracy Chance Mod: " + "[color=red]-"+str(roundf(head_comp.accuracy_bonus*100))+"%[/color]\n"+\
				"Melee Crit Chance Mod: "+"[color=green]+"+str(roundf(head_comp.crit_chance*100))+"%[/color]\n"
				
		"Torso":
			var torso_comp : MechTorso = mech_component as MechTorso
			if torso_comp.get_weight_class() == "HEAVY":
				text = "Armor Bonus: " + "[color=green]+"+str(torso_comp.health)+"[/color]\n"+\
				"Range Weapon Charge Mod: "+"[color=green]+"+ str(torso_comp.charge_speed_modifier*100)+"%[/color]\n"+\
				"Melee Weapon Charge Mod: "+"[color=red]-"+ str(torso_comp.charge_speed_modifier*100)+"%[/color]\n"
			elif torso_comp.get_weight_class() == "LIGHT":
				text = "Armor Bonus: " + "[color=yellow]+"+str(torso_comp.health)+"[/color]\n"+\
				"Melee Weapon Charge Mod: " +"[color=green]+"+ str(torso_comp.charge_speed_modifier*100)+"%[/color]\n" +\
				"Range Weapon Charge Mod: "+"[color=red]-"+ str(torso_comp.charge_speed_modifier*100)+"%[/color]\n"
			elif torso_comp.get_weight_class() == "REGULAR":
				text = "Armor Bonus: +" +str(torso_comp.health)+"\n"+\
				"Melee Charge Mod: [color=yellow]+" +str(torso_comp.charge_speed_modifier*100)+"[/color]\n"+\
				"Range Weapon Charge Mod: "+"[color=yellow]+"+ str(torso_comp.charge_speed_modifier*100)+"%[/color]\n"
			
		"Arms":
			var arms_comp : MechArms = mech_component as MechArms
			if arms_comp.get_weight_class() == "HEAVY":
				text = "Armor Bonus: " + "[color=green]+"+str(arms_comp.health)+"[/color]\n"+\
				"Range Crit Damage Mod: " +"[color=green]+"+ str(floor(arms_comp.crit_damage_modifier*100))+"%[/color]\n"+\
				"Melee Crit Damage Mod: " +"[color=red]-"+ str(floor(arms_comp.crit_damage_modifier*100))+"%[/color]\n"+\
				"Max Hits Chance: "+"[color=green]+"+ str(arms_comp.max_hits_chance*100)
			elif arms_comp.get_weight_class() == "LIGHT":
				text = "Armor Bonus: " + "[color=ryellow]+"+str(arms_comp.health)+"[/color]\n"+\
				"MeleeCrit Damage Mod: " +"[color=green]+"+ str(floor(arms_comp.crit_damage_modifier*100))+"%[/color]\n"+\
				"Range Crit Damage Mod: " +"[color=red]-"+ str(floor(arms_comp.crit_damage_modifier*100))+"%[/color]\n"+\
				"Max Hits Chance: "+"[color=red]+"+ str(arms_comp.max_hits_chance*100)
			elif arms_comp.get_weight_class() == "REGULAR":
				text = "Armor Bonus: " +str(arms_comp.health)+"\n"+\
				"Melee Crit Damage Mod: " +"+"+ str(floor(arms_comp.crit_damage_modifier*100))+"%\n"+\
				"Range Crit Damage Mod: " + "+"+ str(floor(arms_comp.crit_damage_modifier*100))+"%\n"+\
				"Max Hits Chance: "+"[color=yellow]+"+ str(arms_comp.max_hits_chance*100)
		"Legs":
			var legs_comp : MechLegs = mech_component as MechLegs
			if legs_comp.get_weight_class() == "HEAVY":
				text = "Armor Bonus: " + "[color=green]+"+str(legs_comp.health)+"[/color]\n"+\
				"Mobility (Dodge Chance): " +"[color=red]"+ str(floor(legs_comp.dodge_chance_modifier*100))+"%[/color]\n"+\
				"Stun Chance: "+"[color=green]+"+ str(floor(legs_comp.stun_chance*100))+"%"
			elif legs_comp.get_weight_class() == "LIGHT":
				text = "Armor Bonus: " + "[color=yellow]+"+str(legs_comp.health)+"[/color]\n"+\
				"Mobility (Dodge Chance): "+"[color=green]+"+ str(roundf(legs_comp.dodge_chance_modifier*100))+"%[/color]\n"+\
				"Stun Chance: "+"[color=red]"+ str(floorf(legs_comp.stun_chance*100)) + "%"
			elif legs_comp.get_weight_class() == "REGULAR":
				text = "Armor Bonus: +" + str(legs_comp.health)+"\n"+\
				"Mobility (Dodge Chance): +"+ str(floorf(legs_comp.dodge_chance_modifier*100))+"%\n"+\
				"Stun Chance: +"+ str(floorf(legs_comp.stun_chance*100)) + "%"
		"Weapon":
			var weapon : MechWeapon = mech_component as MechWeapon
			text = "Weapon Class: " + str(weapon.get_weapon_class())+"\n"+\
			"DPC (Damage Per Cycle): " + str(weapon.damage)+"\n"+\
			"Charge Up Base Speed: " + str(weapon.charge_speed * 100) +"\n"+\
			"Base Crit Chance: " + str(weapon.crit_chance * 100) + "%\n"+\
			"Hit Rate (Accuracy): " + str(weapon.accuracy * 100) + "%\n"+\
			"Stun Chance: " + str(weapon.stun_chance) + "%"

func clear_container() -> void:
	for child in get_children():
		child.queue_free()

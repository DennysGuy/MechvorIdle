class_name StatsVBox extends VBoxContainer

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
			var head_comp = mech_component as MechHead
			var armor_stat : StatLabel =  preload("res://src/scenes/StatLabel.tscn").instantiate()
			armor_stat.text = "Armor -" + str(head_comp.health)
			var accuracy_stat : StatLabel = preload("res://src/scenes/StatLabel.tscn").instantiate()
			accuracy_stat.text = "Accuracy mod - " + str(head_comp.accuracy_bonus*100)+"%"
			add_child(armor_stat)
			add_child(accuracy_stat)
		"Torso":
			var torso_comp = mech_component as MechTorso
			var armor_stat : StatLabel =  preload("res://src/scenes/StatLabel.tscn").instantiate()
			armor_stat.text = "Armor -" + str(torso_comp.health)
			var charge_speed_mod : StatLabel = preload("res://src/scenes/StatLabel.tscn").instantiate()
			charge_speed_mod.text = "CSpeed Mod - " + str(torso_comp.charge_speed_modifier *100)+ "%"
			add_child(armor_stat)
			add_child(charge_speed_mod)
		"Arms":
			var arms_comp = mech_component as MechArms
			var armor_stat : StatLabel =  preload("res://src/scenes/StatLabel.tscn").instantiate()
			armor_stat.text = "Armor -" + str(arms_comp.health)
			var crit_chance_mod : StatLabel = preload("res://src/scenes/StatLabel.tscn").instantiate()
			crit_chance_mod.text = "Crit Chance Mod - " + str(arms_comp.crit_chance_modifier *100)+ "%"
			add_child(armor_stat)
			add_child(crit_chance_mod)
		"Legs":
			var legs_comp = mech_component as MechLegs
			var armor_stat : StatLabel =  preload("res://src/scenes/StatLabel.tscn").instantiate()
			armor_stat.text = "Armor -" + str(legs_comp.health)
			var mobile_mod : StatLabel = preload("res://src/scenes/StatLabel.tscn").instantiate()
			mobile_mod.text = "Mobility Mod - " + str(legs_comp.dodge_chance_modifier *100)+ "%"
			add_child(armor_stat)
			add_child(mobile_mod)
		"Weapon":
			pass

func clear_container() -> void:
	for child in get_children():
		child.queue_free()

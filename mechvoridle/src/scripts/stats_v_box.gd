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
			var head_comp = mech_component as MechHead
			if head_comp.get_weapon_focus() == "Ranged":
				text = "Armor Bonus: " + "[color=green]+"+str(head_comp.health)+"[/color]\nMelee Accuracy Bonus: "+"[color=red]-"+str(head_comp.accuracy_bonus*100)+"%[/color]\nRanged Accuracy Bonus: "+"[color=green]+"+str(head_comp.accuracy_bonus*100)+"%[/color]"
			else:
				text = "Armor Bonus: " + "[color=green]+"+str(head_comp.health)+"[/color]\nMelee Accuracy Bonus: "+"[color=green]+"+str(head_comp.accuracy_bonus*100)+"%[/color]\nRanged Accuracy Bonus: "+"[color=red]-"+str(head_comp.accuracy_bonus*100)+"%[/color]"
			
		"Torso":
			var torso_comp = mech_component as MechTorso
			
		"Arms":
			var arms_comp = mech_component as MechArms
			
		"Legs":
			var legs_comp = mech_component as MechLegs
			
		"Weapon":
			pass

func clear_container() -> void:
	for child in get_children():
		child.queue_free()

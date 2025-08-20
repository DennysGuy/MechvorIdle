extends Node

var shop_list : Dictionary = {
	"Heads": {
		0 : preload("res://src/resources/mechcomponents/heads/mech_head_1.tres"),
		1 : preload("res://src/resources/mechcomponents/heads/mech_head_2.tres"),
		2 : preload("res://src/resources/mechcomponents/heads/mech_head_3.tres")
	},
	"Torsos": {
		0 : preload("res://src/resources/mechcomponents/torsos/mech_torso_1.tres"),
		1 : preload("res://src/resources/mechcomponents/torsos/mech_torso_2.tres"),
		2 : preload("res://src/resources/mechcomponents/torsos/mech_torso_3.tres")
	},
	"Arms": {
		0: preload("res://src/resources/mechcomponents/arms/mech_arms_1.tres"),
		1: preload("res://src/resources/mechcomponents/arms/mech_arms_2.tres"),
		2: preload("res://src/resources/mechcomponents/arms/mech_arms_3.tres")
	},
	"Legs": {
		0: preload("res://src/resources/mechcomponents/legs/mech_legs_1.tres"),
		1: preload("res://src/resources/mechcomponents/legs/mech_legs_2.tres"),
		2: preload("res://src/resources/mechcomponents/legs/mech_legs_3.tres"),
	},
	"Rifles": {
		0: preload("res://src/resources/mechcomponents/weapons/rifles/Rifle_1.tres"),
		1: preload("res://src/resources/mechcomponents/weapons/rifles/Rifle_2.tres"),
	},
	"Swords": {
		0: preload("res://src/resources/mechcomponents/weapons/swords/Sword-1.tres"),
		1: preload("res://src/resources/mechcomponents/weapons/swords/Sword-2.tres")
	},
	"Rocket Launchers":{
		0: preload("res://src/resources/mechcomponents/weapons/rocketlaunchers/Launcher-1.tres"),
		1: preload("res://src/resources/mechcomponents/weapons/rocketlaunchers/Launcher-2.tres")
	}
		
		
	
	
}

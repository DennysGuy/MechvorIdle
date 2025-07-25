extends Node

var shop_list : Dictionary = {
	"Heads": {
		0 : preload("res://src/resources/mechcomponents/heads/mech_head_1.tres"),
		1 : preload("res://src/resources/mechcomponents/heads/mech_head_2.tres"),
	},
	"Torsos": {
		0 : preload("res://src/resources/mechcomponents/torsos/mech_torso_1.tres"),
		1 : preload("res://src/resources/mechcomponents/torsos/mech_torso_2.tres")
	},
	"Arms": {
		0: preload("res://src/resources/mechcomponents/arms/mech_arms_1.tres"),
		1: preload("res://src/resources/mechcomponents/arms/mech_arms_2.tres")
	},
	"Legs": {
		0: preload("res://src/resources/mechcomponents/legs/mech_legs_1.tres"),
		1: preload("res://src/resources/mechcomponents/legs/mech_legs_2.tres")
	},
	"Rifles": {
		0: preload("res://src/resources/mechcomponents/weapons/rifles/Rifle_1.tres"),
		1: preload("res://src/resources/mechcomponents/weapons/rifles/Rifle_2.tres")
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

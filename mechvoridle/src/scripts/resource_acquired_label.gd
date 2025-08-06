class_name ResourceAcquiredLabel extends Node2D



@export var output : String
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var label : Label = $Bus/HBoxContainer/Label
@onready var icon : TextureRect = $Bus/HBoxContainer/Icon

@export_enum("Ferrite", "Ferrite Bar", "Platinum", "Plasma", "Rifle", "RifleCrit", "Sword", "SwordCrit", "RocketLauncher", "RocketLauncherCrit", "Missed", "Vulcan","NA") var resource : int
enum RESOURCE {FERRITE, FERRITE_BAR, PLATINUM, PLASMA, RIFLE, RIFLECRIT, SWORD, SWORDCRIT, ROCKETLAUNCHER, ROCKETLAUNCHERCRIT, MISSED, VULCAN, NA}

func _ready() -> void:
	label.text = output
	set_icon_texture()
	animation_player.play("Float and Fade")


func erase() -> void:
	queue_free()

func set_icon_texture() -> void:
	var icon_texture : Texture2D
	match(resource):
		RESOURCE.FERRITE:
			icon_texture = preload("res://assets/graphics/ferrite_ui_icon.png")
		RESOURCE.FERRITE_BAR:
			icon_texture = preload("res://assets/graphics/refined_ferrite_ui_icon.png")
		RESOURCE.PLATINUM:
			icon_texture = preload("res://assets/graphics/platinum_ui_icon.png")
		RESOURCE.PLASMA:
			icon_texture = preload("res://assets/graphics/plasma_ui_icon.png")
		RESOURCE.RIFLE:
			icon_texture = preload("res://assets/graphics/UI/Combat/RifleDamage.png")
		RESOURCE.RIFLECRIT:
			icon_texture = preload("res://assets/graphics/UI/Combat/RifleDamageCrit.png")
		RESOURCE.SWORD:
			icon_texture = preload("res://assets/graphics/UI/Combat/SwordDamage.png")
		RESOURCE.SWORDCRIT:
			icon_texture = preload("res://assets/graphics/UI/Combat/SwordDamageCrit.png")
		RESOURCE.ROCKETLAUNCHER:
			icon_texture = preload("res://assets/graphics/UI/Combat/RocketLauncherDamage.png")
		RESOURCE.ROCKETLAUNCHERCRIT:
			icon_texture = preload("res://assets/graphics/UI/Combat/RocketLauncherDamageCrit.png")
		RESOURCE.MISSED:
			icon_texture = preload("res://assets/graphics/UI/Combat/MissedIcon.png")
		RESOURCE.VULCAN:
			icon_texture = preload("res://assets/graphics/UI/Combat/VulcanDamageIcon.png")
		
	icon.texture = icon_texture


func set_resource_as_ferrite() -> void:
	resource = RESOURCE.FERRITE

func set_resource_as_ferrite_bar() -> void:
	resource = RESOURCE.FERRITE_BAR

func set_resource_as_platinum() -> void:
	resource = RESOURCE.PLATINUM

func set_resource_as_plasma() -> void:
	resource = RESOURCE.PLASMA

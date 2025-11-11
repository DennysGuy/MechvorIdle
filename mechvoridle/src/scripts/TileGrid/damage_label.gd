class_name GridDamageLabel extends Node3D

@export var label : Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum LABEL_TYPE {DAMAGE, HEAL, INVINCIBLE}
@export var label_type : LABEL_TYPE

var red : Color = Color.MAROON
var green : Color = Color.DARK_SEA_GREEN
var grey : Color = Color.WEB_GRAY

var animation_names : Array[String] = ["Fling_Left", "Fling_Right"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match label_type:
		LABEL_TYPE.DAMAGE:
			label.set("theme_override_colors/font_color", red)
			animation_player.play(animation_names.pick_random())
		LABEL_TYPE.HEAL:
			label.set("theme_override_colors/font_color", green)
			animation_player.play("Float")
		LABEL_TYPE.INVINCIBLE:
			label.set("theme_override_colors/font_color", grey)
			animation_player.play("Float")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_as_damage() -> void:
	label_type = LABEL_TYPE.DAMAGE

func set_as_heal() -> void:
	label_type = LABEL_TYPE.HEAL

func set_as_invincible() -> void:
	label_type = LABEL_TYPE.INVINCIBLE

extends NinePatchRect

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var label : Label= $Label

@export var guide_label : String

func _ready() -> void:
	label.text = guide_label
	animation_player.play("flash")

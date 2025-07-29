class_name AlertPane extends Control
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Alert")
	SignalBus.silence_ship_alarm.connect(silence_alarm)

func silence_alarm() -> void:
	queue_free()

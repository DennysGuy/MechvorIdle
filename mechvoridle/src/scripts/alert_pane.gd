class_name AlertPane extends Control
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var vox_player : AudioStreamPlayer = $VOXPlayer
@onready var alarm_player  : AudioStreamPlayer = $AlarmPlayer

func _ready() -> void:
	vox_player.stream = SfxManager.VOX_ALARM_UFO_ALERT_01
	vox_player.play()
	alarm_player.play()
	animation_player.play("Alert")
	SignalBus.silence_ship_alarm.connect(play_fade_out_animation)

func silence_alarm() -> void:
	queue_free()


func stop_vox_player() -> void:
	vox_player.stop()

func play_fade_out_animation() -> void:
	animation_player.play("FadeOutAlert")

func play_vox_ufo_destroyed() -> void:
	vox_player.stream = SfxManager.VOX_NOT_UFO_DOWN_01
	vox_player.play()

class_name ElapsedTimer extends Control

var milliseconds : int
var seconds : int
var minutes : int
@onready var milliseconds_label: Label = $Seconds
@onready var seconds_label: Label = $Minutes
@onready var minutes_label: Label = $Hours
@onready var time: Label = $Time

var time_elapsed := 0.0


func _process(delta):
	time_elapsed += delta
	time.text = format_time(time_elapsed)

func format_time(time: float) -> String:
	var minutes := int(time) / 60
	var seconds := int(time) % 60
	var milliseconds := int((time - int(time)) * 1000)
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

class_name ElapsedTimer extends Control

var milliseconds : int
var seconds : int
var minutes : int
@onready var milliseconds_label: Label = $Seconds
@onready var seconds_label: Label = $Minutes
@onready var minutes_label: Label = $Hours
@onready var time: Label = $Time

var time_elapsed := 0.0

var timer_up = false

func _ready() -> void:
	SignalBus.start_fight.connect(stop_mining_timer)
	SignalBus.begin_round.connect(start_timer)
	SignalBus.stop_fight.connect(stop_fight_timer)
	time.text = "00:00:000"
	
func _process(delta):
	if timer_up:
		time_elapsed += delta
		time.text = format_time(time_elapsed)

func format_time(time: float) -> String:
	var minutes := int(time) / 60
	var seconds := int(time) % 60
	var milliseconds := int((time - int(time)) * 1000)
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func stop_mining_timer() -> void:
	GameManager.mining_time_elapsed = time.text
	timer_up = false
	time_elapsed = 0.0

func stop_fight_timer() -> void:
	GameManager.fight_time_elapsed = time.text
	timer_up = false
	time_elapsed = 0.0
	
func start_timer() -> void:
	timer_up = true

extends Node

const WAVE_TIME : int = 15
const MAX_CHANCES : int = 3
var chances_left : int = 3

var in_challenge_wave : bool = false
var challenge_mode_won : bool = false
var win_threshold_count : int = 0
var current_count : int = 0

const CHALLENGE_CHEST = preload("uid://mutb6sqjaftb")


@warning_ignore("unused_signal")
signal start_challenge

@warning_ignore("unused_signal")
signal end_challenge

func _ready() -> void:
	challenge_mode_won = false
	in_challenge_wave = false

func increment_win_threshold() -> void:
	current_count += 1
	if current_count >= win_threshold_count:
		challenge_mode_won = true
	SignalBus.update_current_challenge_count.emit()

func decrement_chances() -> void:
	chances_left -= 1
	SignalBus.update_chances_left.emit()


func reset_wave_details() -> void:
	in_challenge_wave = false
	challenge_mode_won = false
	win_threshold_count = 0
	current_count = 0

func start_challenge_wave() -> void:
	in_challenge_wave = true

func end_challenge_wave() -> void:
	in_challenge_wave = false

var challenge_chests : Dictionary = {
	1:	
		{
			"enemy": CHALLENGE_CHEST.duplicate(true),
			"coordinates": Vector2(0,3),
			"is_slave": false,
			"is_boss": false,
			"level" : 1
		}	
	,
	2: 
		{
			"enemy": CHALLENGE_CHEST.duplicate(true),
			"coordinates": Vector2(0,3),
			"is_slave": false,
			"is_boss": false,
			"level" : 1 ##WE WILL NEED TO CHANGE THIS EVENTUALLY
		}
	,
	3: 
		{
			"enemy": CHALLENGE_CHEST.duplicate(true),
			"coordinates": Vector2(0,3),
			"is_slave": false,
			"is_boss": false,
			"level" : 1 ##WE WILL NEED TO CHANGE THIS EVENTUALLY
		}
	
}

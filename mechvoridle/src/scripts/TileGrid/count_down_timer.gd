class_name CountDownTimer extends RichTextLabel

var seconds : int = 45
var milliseconds : int = 0

var timer_started : bool
@onready var marker_2d: Marker2D = $Marker2D

var seconds_tracker : int = 0
var count_down : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.add_time.connect(add_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if timer_started:
		if count_down:
			count_down_time(delta)
		else:
			increment_time(delta)
			
		set_time(seconds,milliseconds)
		
func count_down_time(_delta : float) -> void:
	if milliseconds == 0:
		seconds -= 1
		seconds_tracker += 1
		milliseconds = 100
				
	else:
		milliseconds -= _delta
		
	if seconds <= 0:
		stop_timer()
		GameManager.timed_out = true
		if ChallengeWaveManager.in_challenge_wave:
			ChallengeWaveManager.end_challenge.emit()
			SignalBus.play_failure_animation.emit()	
		else:
			SignalBus.apply_timer_consequences.emit()
			SignalBus.spawn_next_wave.emit()
		
		GameManager.timed_out = false

func increment_time(_delta : float) -> void:
	if milliseconds >= 99:
		seconds += 1
		milliseconds = 0
	else:
		milliseconds += _delta
	
		

func set_time(added_seconds : int, added_milliseconds : int = 0) -> void:
	seconds = added_seconds
	milliseconds = added_milliseconds
	set_label()

func start_timer() -> void:
	timer_started = true

func stop_timer() -> void:
	seconds = 0
	milliseconds = 0

	timer_started = false
	set_time(0,0)
	
	
func set_label() -> void:
	text = ""
	append_text("[font_size=35]%s[/font_size][font_size=20].%s[/font_size]" % [seconds,milliseconds])

func add_time(value : int) -> void:
	seconds += value

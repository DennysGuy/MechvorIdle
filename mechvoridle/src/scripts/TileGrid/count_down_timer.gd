class_name CountDownTimer extends RichTextLabel

var seconds : int = 30
var milliseconds : int = 0

var timer_started : bool
@onready var marker_2d: Marker2D = $Marker2D

var seconds_tracker : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.add_time.connect(add_time)
	#start_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("shoot"):
		#timer_started = true
	pass

func _physics_process(delta: float) -> void:
	if timer_started:
		if milliseconds == 0:
			seconds -= 1
			seconds_tracker += 1
			milliseconds = 100
				
			if seconds_tracker >= 60:
				seconds_tracker = 0
				
		else:
			@warning_ignore("narrowing_conversion")
			milliseconds -= delta
		
		if seconds <= 0:
			stop_timer()
		
			SignalBus.apply_timer_consequences.emit()
			SignalBus.spawn_next_wave.emit(true)

			
		
		set_time(seconds,milliseconds)
		
	
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
	
func set_label() -> void:
	text = ""
	append_text("[font_size=40]%s[/font_size][font_size=24].%s[/font_size]" % [seconds,milliseconds])

func add_time(value : int) -> void:
	seconds += value

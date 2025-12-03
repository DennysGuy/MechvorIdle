class_name MomentumMeter extends TextureProgressBar

@onready var ready_label: Label = $ReadyLabel
@onready var count_tracker_label: Label = $CountTrackerLabel

var drain_momentum_meter : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.overdrive_mode_ready.connect(show_ready_label)
	SignalBus.overdrive_mode_disabled.connect(hide_ready_label)
	SignalBus.start_overdrive_mode.connect(start_overdrive_mode)
	SignalBus.update_momentum_count.connect(update_momentum_amount_counter)
	update_momentum_amount_counter()
	ready_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if drain_momentum_meter:
		value -= delta
		if value <= 0:
			GameManager.in_overdrive_mode = false
			drain_momentum_meter = false
			GameManager.momentum_meter_amount = 0
			update_momentum_amount_counter()
			

func show_ready_label() -> void:
	ready_label.show()

func start_overdrive_mode() -> void:
	hide_ready_label()
	drain_momentum_meter = true

func hide_ready_label() -> void:
	ready_label.hide()

func update_momentum_amount_counter() -> void:
	count_tracker_label.text = "%s/%s" % [GameManager.momentum_meter_amount, GameManager.MAX_MOMENTUM_METER_AMOUNT]

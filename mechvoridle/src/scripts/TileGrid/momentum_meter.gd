class_name MomentumMeter extends TextureProgressBar

@onready var ready_label: Label = $ReadyLabel
@onready var count_tracker_label: Label = $CountTrackerLabel

var drain_momentum_meter : bool = false
@onready var ready_player: AnimationPlayer = $ReadyPlayer
@onready var bonus_label: RichTextLabel = $BonusLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ready_player.play("ReadLabelPulse")
	SignalBus.overdrive_mode_ready.connect(show_ready_label)
	SignalBus.overdrive_mode_disabled.connect(hide_ready_label)
	SignalBus.start_overdrive_mode.connect(start_overdrive_mode)
	SignalBus.update_momentum_count.connect(update_momentum_amount_counter)
	SignalBus.update_od_bonuses.connect(update_od_bonuses)
	update_momentum_amount_counter()
	update_od_bonuses()
	ready_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if drain_momentum_meter:
		value -= delta
		if value <= 0:
			GameManager.in_overdrive_mode = false
			GameManager.momentum_meter_amount = 0
			SignalBus.hide_overdrive_visuals.emit()
			SignalBus.revert_move_speed_to_norm.emit()
			SignalBus.revert_slow_factor_normal.emit()
			update_momentum_amount_counter()
			SignalBus.update_od_bonuses.emit()
			drain_momentum_meter = false
			SfxManager.play_sfx(SfxManager.OD_POWER_DOWN)
			

func show_ready_label() -> void:
	ready_label.show()

func start_overdrive_mode() -> void:
	hide_ready_label()
	drain_momentum_meter = true

func hide_ready_label() -> void:
	ready_label.hide()

func update_momentum_amount_counter() -> void:
	count_tracker_label.text = "%s/%s" % [GameManager.momentum_meter_amount, GameManager.MAX_MOMENTUM_METER_AMOUNT]


func update_od_bonuses() -> void:
	bonus_label.text ="crit BNS: %s\ncoolDwn: %s\ndmg reduc: %s\nShld BNS: %s\nMV BNS: %s\nscore Multi: x%s" % [
	GameManager.overdrive_crit_chance_bonus,
	GameManager.overdrive_cooldown_bonus,
	GameManager.overdrive_damage_reduction_bonus,
	GameManager.overdrive_shield_strength_bonus,
	GameManager.overdrive_movement_speed_bonus,
	GameManager.overdrive_score_mulitplier_bonus
	]
	

class_name OverHeatMeter extends TextureProgressBar

@onready var number_count: Label = $NumberCount
@onready var icon_indicator: TextureRect = $IconIndicator

@onready var indicator_animator: AnimationPlayer = $IndicatorAnimator

const HEAT_METER_OVER_HEATED = preload("uid://dyxiimphrqjrb")
const HEAT_METER_WARNING_SIGN = preload("uid://0qgn0lcfxkir")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.update_heat_level.connect(update_heat_amount)
	ChallengeWaveManager.update_heat_meter.connect(update_heat_meter)
	max_value = GameManager.max_heat_contained
	value = GameManager.current_heat_contained
	number_count.text = "%s/%s" % [int(value),int(max_value)]
	#indicator_animator.play("Blink")
	icon_indicator.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.over_heated == true:
		value -= 30 * delta
		if value <= 0:
			if GameManager.momentum_meter_level >= 1:
				GameManager.can_activate_overdrive = true
			value = 0
			icon_indicator.hide()
			indicator_animator.stop()
			GameManager.reset_stats_overheated()
			GameManager.current_heat_contained = 0
			GameManager.over_heated = false
			GridManager.player.can_use_shield = true
			SfxManager.play_sfx(SfxManager.MECH_STATUS_RECOVERED,5)
			#change altered values back to normal
		update_number_count()

func update_heat_meter() -> void:
	number_count.text = "%s/%s" % [int(value),int(GameManager.max_heat_contained)]
	max_value = GameManager.max_heat_contained

func update_heat_amount() -> void:

	update_meter()
	update_number_count() 
	
	if value >= int(max_value * 0.75):
		icon_indicator.texture = HEAT_METER_WARNING_SIGN
		icon_indicator.show()
		indicator_animator.play("Blink")
	else:
		icon_indicator.hide()
		indicator_animator.stop()
	
	if value >= max_value:
		value = max_value
		GameManager.over_heated = true
		GridManager.player.can_use_shield = false
		GameManager.can_activate_overdrive = false
		GameManager.set_stats_overheated()
		SfxManager.play_sfx(SfxManager.OVER_HEATED,5)
		icon_indicator.texture= HEAT_METER_OVER_HEATED
		icon_indicator.show()
		indicator_animator.play("Blink")
		#convert to over heat mode (decrement value until 0)
		#increase vulcan interval, half damage output
		#start count down

func update_meter() -> void:
	var tween := create_tween()
	tween.tween_property(
		self,
		"value",
		GameManager.current_heat_contained,
		0.2  # duration
	)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	
func update_number_count() -> void:
	number_count.text = "%s/%s" % [int(value),int(max_value)]
	#var tween:= create_tween()
	#tween.set_trans(Tween.TRANS_CUBIC)
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(number_count,"scale",1.2,0.1)
	#tween.tween_property(number_count,"scale",1.0,0.1)

func play_warning_sfx() -> void:
	if !GameManager.over_heated:
		SfxManager.play_sfx(SfxManager.OVER_HEAT_WARNING,3)

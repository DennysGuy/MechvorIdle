class_name BossHealthBar extends Control

@onready var boss_title : Label = $BossTitle
@onready var boss_health_bar : TextureProgressBar = $BossHealthBar
@onready var max_health : Label = $MaxHealth
@onready var current_health : Label = $CurrentHealth

var fill_health_bar : bool = false

var max_health_tracker : int = 0
var current_health_tracker : int = 0
func _ready() -> void:
	boss_title.text = GameManager.chosen_opponent.mech_name
	SignalBus.update_opponent_health_bar.connect(update_health_bar)
	max_health_tracker = GameManager.chosen_opponent.get_total_health()
	current_health_tracker = max_health_tracker
	boss_health_bar.max_value = max_health_tracker
	max_health.text = str(max_health_tracker)
	current_health.text = str(current_health_tracker)
	#boss_health_bar.value = boss_health_bar.max_value

func _process(delta : float) -> void:
	if fill_health_bar:
		boss_health_bar.value += 50
		if boss_health_bar.value >= boss_health_bar.max_value:
			fill_health_bar = false
			
func update_health_bar() -> void:
	
	boss_health_bar.value = current_health_tracker
	current_health.text = str(int(boss_health_bar.value))
	if boss_health_bar.value <= 0:
		SignalBus.win_game.emit()

func start_filling_health_bars() -> void:
	fill_health_bar = true

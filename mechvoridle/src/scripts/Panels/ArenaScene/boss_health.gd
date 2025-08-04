class_name BossHealthBar extends Control

@onready var boss_title : Label = $BossTitle
@onready var boss_health_bar : TextureProgressBar = $BossHealthBar
@onready var max_health : Label = $MaxHealth
@onready var current_health : Label = $CurrentHealth


func _ready() -> void:
	boss_title.text = GameManager.chosen_opponent.mech_name
	SignalBus.update_opponent_health_bar.connect(update_health_bar)
	GameManager.chosen_opponent.total_health = GameManager.chosen_opponent.get_total_health()
	GameManager.chosen_opponent.current_health = GameManager.chosen_opponent.total_health
	boss_health_bar.max_value = GameManager.chosen_opponent.total_health
	max_health.text = str(GameManager.chosen_opponent.total_health)
	current_health.text = str(GameManager.chosen_opponent.current_health)
	#boss_health_bar.value = boss_health_bar.max_value
	

func _process(delta : float) -> void:
	if GameManager.fill_bars:
		boss_health_bar.value += 50
		if boss_health_bar.value >= boss_health_bar.max_value:
			GameManager.fill_bars = false

func update_health_bar() -> void:
	boss_health_bar.value = GameManager.chosen_opponent.current_health
	current_health.text = str(boss_health_bar.value)
	if boss_health_bar.value <= 0:
		SignalBus.win_game.emit()

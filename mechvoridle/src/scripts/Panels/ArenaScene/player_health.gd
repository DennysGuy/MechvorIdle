class_name PlayerHealth extends ColorRect

@onready var health_bar : ProgressBar = $HealthBar
@onready var player_name : Label = $PlayerName
@onready var max_health : Label = $MaxHealth
@onready var current_health : Label = $CurrentHealth

func _ready() -> void:
	player_name.text = GameManager.player_name
	SignalBus.update_player_health_bar.connect(update_health_bar)
	GameManager.calculate_health()
	health_bar.max_value = GameManager.total_health
	max_health.text = str(GameManager.total_health)
	current_health.text = str(GameManager.current_health)

func _process(delta : float) -> void:
	if GameManager.fill_bars:
		health_bar.value += 50
		if health_bar.value >= health_bar.max_value:
			GameManager.fill_bars = false

func update_health_bar() -> void:
	health_bar.value = GameManager.current_health
	if health_bar.value <= 0:
		SignalBus.lose_game.emit()

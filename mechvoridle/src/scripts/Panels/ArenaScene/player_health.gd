class_name PlayerHealth extends ColorRect

@onready var health_bar : ProgressBar = $HealthBar
@onready var player_name : Label = $PlayerName

func _ready() -> void:
	player_name.text = GameManager.player_name
	SignalBus.update_player_health_bar.connect(update_health_bar)
	GameManager.calculate_health()
	health_bar.max_value = GameManager.total_health
	health_bar.value = GameManager.current_health

func _process(delta : float) -> void:
	pass

func update_health_bar() -> void:
	health_bar.value = GameManager.current_health
	if health_bar.value <= 0:
		SignalBus.lose_game.emit()

class_name PlayerHealth extends Control

@onready var health_bar : TextureProgressBar = $HealthBar
@onready var player_name : Label = $PlayerName
@onready var max_health : Label = $MaxHealth
@onready var current_health : Label = $CurrentHealth

var max_health_tracker : int
var current_health_tracker : int

var fill_health_bars : bool = false


func _ready() -> void:
	player_name.text = GameManager.player_name
	#SignalBus.update_player_health_bar.connect(update_health_bar)
	max_health_tracker = GameManager.calculate_health()
	current_health_tracker = max_health_tracker
	health_bar.max_value = max_health_tracker
	max_health.text = str(max_health_tracker)
	current_health.text = str(current_health_tracker)

func _process(delta : float) -> void:
	if fill_health_bars:
		health_bar.value += 50
		if health_bar.value >= health_bar.max_value:
			fill_health_bars = false

func update_health_bar() -> void:
	health_bar.value = current_health_tracker
	current_health.text = str(current_health_tracker)
	if health_bar.value <= 0:
		SignalBus.lose_game.emit()

func start_filling_health_bars() -> void:
	fill_health_bars = true

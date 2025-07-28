class_name BossHealthBar extends ColorRect

@onready var boss_title : Label = $BossTitle
@onready var boss_health_bar : ProgressBar = $BossHealthBar


func _ready() -> void:
	boss_title.text = GameManager.chosen_opponent.mech_name
	SignalBus.update_opponent_health_bar.connect(update_health_bar)
	boss_health_bar.max_value = GameManager.chosen_opponent.get_total_health()
	boss_health_bar.value = boss_health_bar.max_value

func _process(delta : float) -> void:
	pass

func update_health_bar() -> void:
	boss_health_bar.value = GameManager.chosen_opponent.current_health
	
	if boss_health_bar.value <= 0:
		SignalBus.win_game.emit()

class_name ResourceTrackerPanel extends Panel


@onready var ferrite_count : Label = $FerriteCount
@onready var ferrite_bars_count : Label = $FerriteBarsCount
@onready var platinum_count : Label = $PlatinumCount

func _ready() -> void:
	SignalBus.update_ferrite_count.connect(update_ferrite_count)
	SignalBus.update_ferrite_bars_count.connect(update_ferrite_bars_count)
	SignalBus.update_platinum_count.connect(update_platinum_count)
	
	ferrite_count.text = str(GameManager.raw_ferrite_count)
	ferrite_bars_count.text = str(GameManager.ferrite_bars_count)
	platinum_count.text = str(GameManager.platinum_count)

func update_ferrite_count() -> void:
	ferrite_count.text = str(GameManager.raw_ferrite_count)

func update_ferrite_bars_count() -> void:
	ferrite_bars_count.text = str(GameManager.ferrite_bars_count)

func update_platinum_count() -> void:
	ferrite_bars_count.text = str(GameManager.platinum_count)

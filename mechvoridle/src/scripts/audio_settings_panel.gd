class_name AudioSettingsPanel extends Panel

@onready var music_slider: HSlider = $MusicSlider
@onready var sfx_slider: HSlider = $SFXSlider
@onready var ambience_slider: HSlider = $AmbienceSlider

var min_music_value : float = -30.0
var max_music_value : float = 10.0
var min_sfx_value : float = -30.0
var max_sfx_value : float = 15.0
var min_ambience_value : float = -30.0
var max_ambience_value : float = 12.0

func _ready() -> void:
	music_slider.max_value = max_music_value
	music_slider.min_value = min_music_value
	music_slider.value = -14.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_slider.value)
	
	sfx_slider.max_value = max_sfx_value
	sfx_slider.min_value = min_sfx_value
	sfx_slider.value = -3.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_slider.value)
	
	ambience_slider.max_value = max_ambience_value
	ambience_slider.min_value = min_ambience_value
	ambience_slider.value = -4.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiance"), sfx_slider.value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)


func _on_ambience_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiance"), value)


func _on_button_button_down() -> void:
	GameManager.audio_settings_Showing = !GameManager.audio_settings_Showing
	
	if GameManager.audio_settings_Showing:
		SignalBus.show_audio_settings.emit()
	else:
		SignalBus.hide_audio_settings.emit()

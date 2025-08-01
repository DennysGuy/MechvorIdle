class_name MainHub extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var music_player : AudioStreamPlayer = $MusicPlayer
@onready var sfx_player_layer_1 : AudioStreamPlayer = $SFXPlayerLayer1
@onready var sfx_player_layer_2 : AudioStreamPlayer = $SFXPlayerLayer2

@onready var ship_ambiance_player : AudioStreamPlayer = $ShipAmbiancePlayer
@onready var audio_settings_animation_player: AnimationPlayer = $AudioSettingsAnimationPlayer
@onready var vox_player: AudioStreamPlayer = $VoxPlayer

@onready var exit_hub : AudioStream = SfxManager.UI_NAV_SWITCH_TAB_A_EXIT_HUB_01
@onready var enter_hub : AudioStream = SfxManager.UI_NAV_SWITCH_TAB_A_ENTER_HUB_01
@onready var mining_panel_nav_sfx : Array[AudioStream] = [SfxManager.UI_NAV_SWITCH_TAB_B_MINING_01, SfxManager.UI_NAV_SWITCH_TAB_B_MINING_02, SfxManager.UI_NAV_SWITCH_TAB_B_MINING_03, SfxManager.UI_NAV_SWITCH_TAB_B_MINING_03, SfxManager.UI_NAV_SWITCH_TAB_B_MINING_04]
@onready var shop_panel_nav_sfx : Array[AudioStream] = [SfxManager.UI_NAV_SWITCH_TAB_B_SHOP_01, SfxManager.UI_NAV_SWITCH_TAB_B_SHOP_02, SfxManager.UI_NAV_SWITCH_TAB_B_SHOP_03, SfxManager.UI_NAV_SWITCH_TAB_B_SHOP_04, SfxManager.UI_NAV_SWITCH_TAB_B_SHOP_05]
func _ready() -> void:
	music_player.play()
	ship_ambiance_player.play()
	animation_player.play("fade_in")
	SignalBus.move_to_mining_pane.connect(move_to_mining_pane)
	SignalBus.move_to_shop_pane.connect(move_to_shop_pane)
	SignalBus.move_to_central_hub_from_mining_page.connect(move_from_mining_pane_to_central_pane)
	SignalBus.move_to_central_hub_from_shop_pane.connect(move_from_shop_pane_to_central_pane)
	SignalBus.sound_ship_alarm.connect(insert_ship_alarm)
	SignalBus.silence_ship_alarm.connect(remove_ship_alarm)
	SignalBus.show_audio_settings.connect(show_audio_settings)
	SignalBus.hide_audio_settings.connect(hide_audio_settings)
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_left") and GameManager.can_traverse_panes:
		if GameManager.on_shop_panel:
			move_from_shop_pane_to_central_pane()
		elif GameManager.on_central_panel:
			move_to_mining_pane()

	if Input.is_action_just_pressed("move_right") and GameManager.can_traverse_panes:
		if GameManager.on_mining_panel:
			move_from_mining_pane_to_central_pane()
		elif GameManager.on_central_panel:
			move_to_shop_pane()

func _process(delta : float) ->void:
	pass


func move_to_mining_pane() -> void:
	play_nav_from_hub_to_mining_sfx()
	GameManager.on_mining_panel = true
	GameManager.on_shop_panel = false
	GameManager.on_central_panel = false
	animation_player.play("NavigateToMiningPage")

func move_to_shop_pane() -> void:
	player_enter_shop_from_hub_sfx()
	GameManager.on_central_panel = false
	GameManager.on_mining_panel = false
	GameManager.on_shop_panel = true
	animation_player.play("NavigateToShopPane")

func move_from_mining_pane_to_central_pane() -> void:
	play_enter_hub_from_mining_sfx()
	GameManager.on_mining_panel = false
	GameManager.on_shop_panel = false
	GameManager.on_central_panel = true
	animation_player.play("NavigateFromMiningPageToCentralHub")

func move_from_shop_pane_to_central_pane() -> void:
	play_enter_hub_from_shop_sfx()
	GameManager.on_mining_panel = false
	GameManager.on_shop_panel = false
	GameManager.on_central_panel = true
	animation_player.play("NavigateFromShopToCentralHub")

func insert_ship_alarm() -> void:
	var ship_alarm : AlertPane = preload("res://src/scenes/AlertPane.tscn").instantiate()
	add_child(ship_alarm)

func remove_ship_alarm() -> void:

	get_tree().get_first_node_in_group("ship alarm")

func play_nav_from_hub_to_mining_sfx():
	sfx_player_layer_1.stream = exit_hub 
	sfx_player_layer_2.stream = mining_panel_nav_sfx.pick_random()
	sfx_player_layer_1.play()
	sfx_player_layer_2.play()

func play_enter_hub_from_mining_sfx():
	sfx_player_layer_1.stream = enter_hub
	sfx_player_layer_2.stream = mining_panel_nav_sfx.pick_random()
	sfx_player_layer_1.play()
	sfx_player_layer_2.play()

func play_enter_hub_from_shop_sfx():
	sfx_player_layer_1.stream = enter_hub
	sfx_player_layer_2.stream = shop_panel_nav_sfx.pick_random()
	sfx_player_layer_1.play()
	sfx_player_layer_2.play()


func player_enter_shop_from_hub_sfx():
	sfx_player_layer_1.stream = exit_hub
	sfx_player_layer_2.stream = shop_panel_nav_sfx.pick_random()
	sfx_player_layer_1.play()
	sfx_player_layer_2.play()

func show_audio_settings() -> void:
	audio_settings_animation_player.play("show")

func hide_audio_settings() -> void:
	audio_settings_animation_player.play("hide")

func play_ready_fight_vox_sfx() -> void:
	vox_player.stream = SfxManager.VOX_NOT_ARENA_ACCESS_01
	vox_player.play()
	await vox_player.finished
	GameManager.can_fight_boss = true

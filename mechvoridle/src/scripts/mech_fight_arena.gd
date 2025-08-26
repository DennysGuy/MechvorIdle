class_name MechFightArena extends Control


#player visuals
@onready var weapon_1 = $Weapon1
@onready var weapon_2 = $Weapon2
@onready var weapon_1_charge_bar : ProgressBar= $Weapon1ChargeBar
@onready var weapon_1_charge_bar_2 : ProgressBar = $Weapon1ChargeBar2
@onready var health_bar : ProgressBar = $HealthBar
@onready var cockpit_camera : Camera2D = $CockpitCamera
@onready var music_player : AudioStreamPlayer = $MusicPlayer
@onready var vulcan_sfx_player : AudioStreamPlayer = $VulcanSFXPlayer
@onready var fx_animation_player : AnimationPlayer = $FXAnimationPlayer

#boss gui visuals
@export var boss_health_bar : BossHealthBar
@export var player_health_bar : PlayerHealth
@export var animation_player : AnimationPlayer

#testing
@export_enum("Test Mode", "Production Mode") var set_mode : int
enum SET_MODE{TEST_MODE, PRODUCTION_MODE}

@export_enum("scene 1", "scene 2", "scene 3", "scene 4", "scene 5") var selected_scene : int
enum SELECTED_SCENE {SCENE_1, SCENE_2, SCENE_3, SCENE_4, SCENE_5}
@onready var nameof_player : Label = $NameofPlayer
@onready var nameof_enemy : Label = $NameofEnemy

@onready var vulcan_firing_sfx : Array[AudioStream] = [SfxManager.COM_PLY_CLICK_VUL_01, SfxManager.COM_PLY_CLICK_VUL_02, SfxManager.COM_PLY_CLICK_VUL_03, SfxManager.COM_PLY_CLICK_VUL_04, SfxManager.COM_PLY_CLICK_VUL_05, SfxManager.COM_PLY_CLICK_VUL_06, SfxManager.COM_PLY_CLICK_VUL_07, SfxManager.COM_PLY_CLICK_VUL_08]
@onready var cockpit_ambience : AudioStreamPlayer = $CockpitAmbience
@onready var random_taunt_voix : Array[AudioStream] = [SfxManager.VOX_COM_ENE_TAUNT_ARROGANT_01, SfxManager.VOX_COM_ENE_TAUNT_ARROGANT_02, SfxManager.VOX_COM_ENE_TAUNT_POWERFUL_01, SfxManager.VOX_COM_ENE_TAUNT_POWERFUL_02, SfxManager.VOX_COM_ENE_TAUNT_HATEFUL_01, SfxManager.VOX_COM_ENE_TAUNT_HATEFUL_02]


func _ready() -> void:
	nameof_player.text = GameManager.player_name
	nameof_enemy.text = GameManager.chosen_opponent.mech_name
	music_player.stream = preload("res://assets/audio/music/boss1.ogg")
	music_player.play()
	animation_player.play("start_fight_sequnce")
	#setup player and boss gear and weapons etc.
	#start game -- we'll change to a sequence later
	SignalBus.win_game.connect(win_game)
	SignalBus.lose_game.connect(lose_game)
	SignalBus.show_specified_boss.emit(GameManager.chosen_opponent.index)
	cockpit_ambience.play()
	
func _process(delta : float) -> void:
	pass


func start_fight() -> void:
	GameManager.fight_on = true
	SignalBus.begin_round.emit()

func stop_fight() -> void:
	GameManager.fight_on = false
	SignalBus.stop_fight.emit()
	

@onready var enemy_death_explosions : AudioStreamPlayer= $EnemyDeathExplosions
@onready var enemy_death_vox : AudioStreamPlayer = $EnemyDeathVox

	
func win_game() -> void:
	enemy_death_explosions.play()
	enemy_death_vox.play()
	stop_fight()
	animation_player.play("fade_to_white")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://src/scenes/WinPanel.tscn")
	#play win sequence and go to win screen results

@onready var player_death_explosions : AudioStreamPlayer = $PlayerDeathExplosions

func lose_game() -> void:
	stop_fight()
	player_death_explosions.play()
	animation_player.play("fade_to_white")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://src/scenes/LosePanel.tscn")

func _on_boss_stand_in_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("working?")

func fill_all_bars() -> void:
	GameManager.fill_bars = true


func _on_boss_container_gui_input(event):
	pass


func _on_control_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and GameManager.fight_on:
			vulcan_sfx_player.stream = vulcan_firing_sfx.pick_random()
			vulcan_sfx_player.play()
			
			boss_health_bar.current_health_tracker -= 25
			var resource_acquired_label : ResourceAcquiredLabel = preload("res://src/scripts/ResourceAcquiredLabel.tscn").instantiate()
			resource_acquired_label.output = "-25"
			resource_acquired_label.global_position = get_viewport().get_mouse_position()
			resource_acquired_label.resource = ResourceAcquiredLabel.RESOURCE.VULCAN
			get_parent().add_child(resource_acquired_label)
			boss_health_bar.update_health_bar()
			fx_animation_player.play("hit_flash")


func _on_music_player_finished():
	music_player.stream = preload("res://assets/audio/music/boss2.ogg")
	music_player.play()

@onready var ready_sfx : AudioStreamPlayer = $Ready
@onready var set_sfx : AudioStreamPlayer = $Set
@onready var fight_sfx : AudioStreamPlayer = $Fight
@onready var taunt : AudioStreamPlayer = $Taunt


func _play_ready() -> void:
	ready_sfx.play()

func _play_set() -> void:
	set_sfx.play()

func _play_fight() -> void:
	fight_sfx.play()

func _play_random_taunt() -> void:
	taunt.stream = random_taunt_voix.pick_random()
	taunt.play()
@onready var enemy_enters : AudioStreamPlayer= $EnemyEnters

func enemy_enters_screen() -> void:
	enemy_enters.play()

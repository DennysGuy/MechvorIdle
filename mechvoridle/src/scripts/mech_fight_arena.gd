class_name MechFightArena extends Control


#player visuals
@onready var weapon_1 = $Background/Weapon1
@onready var weapon_2 = $Background/Weapon2
@onready var weapon_1_charge_bar : ProgressBar= $Weapon1ChargeBar
@onready var weapon_1_charge_bar_2 : ProgressBar = $Weapon1ChargeBar2
@onready var health_bar : ProgressBar = $HealthBar
@onready var cockpit_camera : Camera2D = $CockpitCamera

#boss gui visuals

@onready var boss_health_bar : BossHealthBar = $Background/BossHealthBar
@onready var animation_player : AnimationPlayer = $AnimationPlayer

#testing
@export_enum("Test Mode", "Production Mode") var set_mode : int
enum SET_MODE{TEST_MODE, PRODUCTION_MODE}

@export_enum("scene 1", "scene 2", "scene 3", "scene 4", "scene 5") var selected_scene : int
enum SELECTED_SCENE {SCENE_1, SCENE_2, SCENE_3, SCENE_4, SCENE_5}


func _ready() -> void:
	
	###NEED TO SET BACK TO PROD BEFORE PUSHING!####
	if set_mode == SET_MODE.TEST_MODE:
		match(selected_scene):
			SELECTED_SCENE.SCENE_1:
				GameManager.fight_scenario_test_fixture_1()
			SELECTED_SCENE.SCENE_2:
				GameManager.fight_scenario_2_test_fixture()
			SELECTED_SCENE.SCENE_3:
				GameManager.fight_scenario_3_test_fixture()
			SELECTED_SCENE.SCENE_4:
				GameManager.fight_scenario_4_test_fixture()
			SELECTED_SCENE.SCENE_5:
				GameManager.fight_scenario_5_test_fixture()
		
	animation_player.play("start_fight_sequnce")
	#setup player and boss gear and weapons etc.
	#start game -- we'll change to a sequence later
	SignalBus.win_game.connect(win_game)
	SignalBus.lose_game.connect(lose_game)

func _process(delta : float) -> void:
	pass


func start_fight() -> void:
	GameManager.fight_on = true

func stop_fight() -> void:
	GameManager.fight_on = false

func win_game() -> void:
	stop_fight()
	animation_player.play("fade_to_white")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://src/scenes/WinPanel.tscn")
	#play win sequence and go to win screen results

func lose_game() -> void:
	stop_fight()
	animation_player.play("fade_to_white")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://src/scenes/LosePanel.tscn")

func _on_boss_stand_in_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("working?")

func fill_all_bars() -> void:
	GameManager.fill_bars = true

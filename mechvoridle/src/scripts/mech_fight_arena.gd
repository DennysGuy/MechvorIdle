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


func _ready() -> void:
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

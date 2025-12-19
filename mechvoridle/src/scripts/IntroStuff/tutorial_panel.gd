extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tutorial_panels: Control = $TutorialPanels

@onready var basic_movement_pane: ColorRect = $TutorialPanels/BasicMovementPane
@onready var active_cool_down_attacks_pane: ColorRect = $TutorialPanels/ActiveCoolDownAttacksPane
@onready var vulcan_machine_gun_pane: ColorRect = $TutorialPanels/VulcanMachineGunPane
@onready var counter_guard_pane: ColorRect = $TutorialPanels/CounterGuardPane
@onready var health_and_energy: ColorRect = $TutorialPanels/HealthAndEnergy
@onready var overdrive_mode: ColorRect = $TutorialPanels/OverdriveMode
@onready var guard_slide: ColorRect = $TutorialPanels/GuardSlide
@onready var grading_multiplier: ColorRect = $TutorialPanels/GradingMultiplier
@onready var patch_notes: ColorRect = $TutorialPanels/PatchNotes

@onready var heat_meter_pane: ColorRect = $TutorialPanels/HeatMeterPane
@onready var waves: ColorRect = $TutorialPanels/Waves
@onready var control_mappings: ColorRect = $TutorialPanels/ControlMappings


@onready var movement_demo: AnimatedSprite2D = $TutorialPanels/BasicMovementPane/MovementDemo
@onready var cooldown_demo: AnimatedSprite2D = $TutorialPanels/ActiveCoolDownAttacksPane/CooldownDemo
@onready var vulcan_demo: AnimatedSprite2D = $TutorialPanels/VulcanMachineGunPane/VulcanDemo
@onready var counter_guard_demo: AnimatedSprite2D = $TutorialPanels/CounterGuardPane/CounterGuardDemo
@onready var over_drive_mode: AnimatedSprite2D = $TutorialPanels/OverdriveMode/OverDriveMode
@onready var wave_spawn_in_demo: AnimatedSprite2D = $TutorialPanels/Waves/WaveSpawnInDemo
@onready var counter_guard_basic: AnimatedSprite2D = $TutorialPanels/GuardSlide/CounterGuardBasic
@onready var guard_slide_demo: AnimatedSprite2D = $TutorialPanels/GuardSlide/GuardSlideDemo
@onready var guard_multiplier_demo: AnimatedSprite2D = $TutorialPanels/GradingMultiplier/GuardMultiplierDemo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_tutorial_panes()
	animation_player.play("Fade_In")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_controller_mappings_button_up() -> void:
	control_mappings.show()


func _on_basic_movement_button_down() -> void:
	movement_demo.play("default")
	basic_movement_pane.show()


func _on_attacking_button_down() -> void:
	cooldown_demo.play("default")
	active_cool_down_attacks_pane.show()


func _on_vulcan_machine_gun_button_down() -> void:
	vulcan_demo.play("default")
	vulcan_machine_gun_pane.show()


func _on_counter_guard_button_down() -> void:
	counter_guard_demo.play()
	counter_guard_pane.show()


func _on_heat_button_up() -> void:
	heat_meter_pane.show()


func _on_hp_energy_button_up() -> void:
	health_and_energy.show()


func _on_guard_slide_button_up() -> void:
	counter_guard_basic.play("default")
	guard_slide_demo.play("default")
	guard_slide.show()


func _on_grading_multiplier_button_up() -> void:
	guard_multiplier_demo.play("default")
	grading_multiplier.show()


func _on_over_drive_mode_button_up() -> void:
	over_drive_mode.play("default")
	overdrive_mode.show()

func go_to_combat() -> void:
	get_tree().change_scene_to_file("res://src/scenes/TileGrid/CombatGrid.tscn")

func _on_start_game_button_up() -> void:
	animation_player.play("Fade_Out")


func _on_start_movment_tutorial_button_up() -> void:
	pass # Replace with function body.

	
func hide_tutorial_panes() -> void:
	for panel in tutorial_panels.get_children():
		panel.hide()


func _on_start_movement_tutorial_button_up() -> void:
	pass # Replace with function body.


func _on_back_from_movement_tutorial_button_up() -> void:
	movement_demo.stop()
	basic_movement_pane.hide()


func _on_start_attacks_tutorial_button_up() -> void:
	pass # Replace with function body.


func _on_back_from_cooldown_attacks_button_up() -> void:
	cooldown_demo.hide()
	active_cool_down_attacks_pane.hide()


func _on_start_vulcan_machine_gun_tutorial_button_up() -> void:
	pass # Replace with function body.


func _on_back_from_vulcan_machine_gun_button_up() -> void:
	vulcan_demo.stop()
	vulcan_machine_gun_pane.hide()


func _on_start_counter_guarding_tutorial_button_up() -> void:
	pass # Replace with function body.


func _on_back_from_counter_guarding_button_up() -> void:
	counter_guard_demo.stop()
	counter_guard_pane.hide()


func _on_back_from_heat_meter_button_up() -> void:
	heat_meter_pane.hide()


func _on_back_from_health_and_energy_button_up() -> void:
	health_and_energy.hide()


func _on_back_from_over_drive_mode_button_up() -> void:
	over_drive_mode.stop()
	overdrive_mode.hide()


func _on_back_from_waves_button_up() -> void:
	wave_spawn_in_demo.stop()
	waves.hide()


func _on_waves_button_down() -> void:
	wave_spawn_in_demo.play("default")
	waves.show()


func _on_back_from_guard_slide_button_up() -> void:
	counter_guard_basic.stop()
	guard_slide_demo.stop()
	guard_slide.hide()


func _on_start_grading_tutorial_button_up() -> void:
	pass # Replace with function body.


func _on_back_from_grading_multiplier_button_up() -> void:
	guard_multiplier_demo.stop()
	grading_multiplier.hide()


func _on_view_patch_notes_button_down() -> void:
	patch_notes.show()


func _on_back_from_patch_notes_button_up() -> void:
	patch_notes.hide()


func _on_back_from_controller_mappings_button_up() -> void:
	control_mappings.hide()

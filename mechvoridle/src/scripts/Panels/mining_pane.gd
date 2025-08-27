class_name MiningPane extends Control

@onready var animation_player = $AnimationPlayer
@onready var sub_viewport : SubViewport = $ColorRect/SubViewportContainer/SubViewport
@onready var buy_mech_part_label: Label = $ColorRect/BuyMechPartLabel
@onready var recon_scout_indicator: Label = $ColorRect/ReconScoutIndicator

@onready var owned_drones_count : Label = $ColorRect/OwnedDronesCount

func _ready() -> void:
	SignalBus.show_upgrade_panel.connect(show_upgrade_panel)
	SignalBus.hide_upgrade_panel.connect(hide_upgrade_panel)
	SignalBus.update_owned_drones_count.connect(update_drone_count)
	update_drone_count()
	
	
	#sub_viewport.own_world_3d = false
func _process(_delta : float) -> void:
	buy_mech_part_label.visible = show_buy_mech_part_indicator()
	recon_scout_indicator.visible = GameManager.platinum_count >= GameManager.recon_scout_platinum_cost
func _on_central_hub_navigation_button_up():
	SignalBus.move_to_central_hub_from_mining_page.emit()

func show_upgrade_panel() -> void:
	animation_player.play("ShowUpgradePanel")

func hide_upgrade_panel() -> void:
	animation_player.play("HideAnimationPanel")


func show_buy_mech_part_indicator() -> bool:
	return (
		GameManager.ferrite_bars_count >= GameManager.MIN_LEGS_FERRITE_BAR_COST 
		or GameManager.ferrite_bars_count >= GameManager.MIN_ARMS_FERRITE_BAR_COST
		or GameManager.ferrite_bars_count >= GameManager.MIN_HEAD_FERRITE_BAR_COST
		or GameManager.ferrite_bars_count >= GameManager.MIN_TORSO_FERRITE_BAR_COST
		or GameManager.ferrite_bars_count >= GameManager.MIN_RIFLE_FERRITE_BAR_COST and GameManager.plasma_count >= GameManager.MIN_RIFLE_PLASMA_COST
		or GameManager.ferrite_bars_count >= GameManager.MIN_SWORD_FERRITE_BAR_COST and GameManager.plasma_count >= GameManager.MIN_SWORD_PLASMA_COST
		or GameManager.ferrite_bars_count >= GameManager.MIN_LAUNCHER_FERRITE_BAR_COST and GameManager.plasma_count >= GameManager.MIN_LAUNCHER_PLASMA_COST
	)


func update_drone_count() -> void:
	var current_drone_count : int = DroneManager.drones.size()
	var max_owned_drone_count : int = GameManager.max_owned_drones
	owned_drones_count.text = "Owned Drones " + str(current_drone_count) + "/" + str(max_owned_drone_count)

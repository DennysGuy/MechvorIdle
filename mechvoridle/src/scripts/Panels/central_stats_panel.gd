class_name CentralHubPanel extends Control

@onready var elapsed_time = $ColorRect/ResourcesPanel/ElapsedTime
@onready var line_edit = $ColorRect/NameEntryBox/LineEdit
@onready var current_owned_components: Label = $ColorRect/CurrentOwnedComponents


@onready var raw_ferrite_count = $ColorRect/ResourcesPanel/RawFerriteCount
@onready var ferrite_bars_count = $ColorRect/ResourcesPanel/FerriteBarsCount
@onready var platinum_bars_count = $ColorRect/ResourcesPanel/PlatinumBarsCount
@onready var plasma_count: Label = $ColorRect/ResourcesPanel/PlasmaCount
@onready var start_fight_button: TextureButton = $ColorRect/HBoxContainer/StartFight
@onready var recon_text : RichTextLabel = $ColorRect/TipsPanel/ReconText
@onready var platinum_cost : Label = $ColorRect/TipsPanel/PlatinumCost
@onready var purchase_recon_scout : Button = $ColorRect/TipsPanel/PurchaseReconScout
@onready var name_entry_box = $ColorRect/NameEntryBox
@onready var confirm_start_fight = $ColorRect/NameEntryBox/ConfirmStartFight
@onready var recon_scout_indicator: Label = $ColorRect/ReconScoutIndicator

@onready var animation_player = $AnimationPlayer
@onready var sub_viewport = $ColorRect/MechComponentsTrackerPanel/PlayerPreviewSubviewportContainer/SubViewport


@onready var recon_tips_list : Array[String] = [GameManager.chosen_opponent.tip_1, GameManager.chosen_opponent.tip_2, GameManager.chosen_opponent.tip_3]
var recon_scouts_left : int = 3
var recon_index : int = 0
func _ready() -> void:
	sub_viewport.own_world_3d = true
	SignalBus.update_ferrite_count.connect(update_raw_ferrite_count)
	SignalBus.update_ferrite_bars_count.connect(update_ferrite_bars_count)
	SignalBus.update_platinum_count.connect(update_platinum_count)
	SignalBus.update_plasma_count.connect(update_plasma_count)
	SignalBus.update_parts_owned_on_previewer.connect(update_currently_owned_components_count)
	purchase_recon_scout.text = "Buy Scout "+ "("+str(recon_scouts_left)+")"
	platinum_cost.text = str(GameManager.recon_scout_platinum_cost)
	hide_entry_box()
	update_raw_ferrite_count()
	update_ferrite_bars_count()
	update_platinum_count()
	update_plasma_count()

func _process(delta) -> void:
	
	recon_scout_indicator.visible = GameManager.platinum_count >= GameManager.recon_scout_platinum_cost and recon_scouts_left >= 0
	
	if not GameManager.can_fight_boss:
		start_fight_button.disabled = true
	else:
		start_fight_button.disabled = false
		
	purchase_recon_scout.disabled = GameManager.platinum_count <= GameManager.recon_scout_platinum_base_cost and recon_scouts_left >= 0

func _on_start_fight_button_up():
	if GameManager.can_fight_boss:
		show_entry_box()

func _on_mining_pane_navigation_button_up() -> void:
	SignalBus.move_to_mining_pane.emit()

func _on_shop_pane_navigation_button_up() -> void:
	SignalBus.move_to_shop_pane.emit()


func start_fight() -> void:
	SignalBus.start_fight.emit()

func _on_purchase_recon_scout_button_down():
	if recon_scouts_left > 0:
		if !GameManager.recon_scout_purchased:
			SignalBus.show_task_completed_indicator.emit(GameManager.CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED)
			GameManager.recon_scout_purchased = true
		GameManager.platinum_count -= GameManager.recon_scout_platinum_cost
		recon_text.text = recon_tips_list[recon_index]
		recon_index += 1
		GameManager.recon_scout_platinum_cost = GameManager.recon_scout_platinum_base_cost * pow(GameManager.UPGRADE_MULTIPLIER, recon_index+1)
		recon_scouts_left -= 1
		purchase_recon_scout.text = "Buy Scout " + "("+str(recon_scouts_left)+")"
		platinum_cost.text = str(GameManager.recon_scout_platinum_cost)
		SignalBus.update_platinum_count.emit()

func update_raw_ferrite_count() -> void:
	raw_ferrite_count.text = str(GameManager.raw_ferrite_count)

func update_ferrite_bars_count() -> void:
	ferrite_bars_count.text = str(GameManager.ferrite_bars_count)

func update_platinum_count() -> void:
	platinum_bars_count.text = str(GameManager.platinum_count)

func update_plasma_count() -> void:
	plasma_count.text = str(GameManager.plasma_count)

func hide_entry_box() -> void:
	name_entry_box.hide()
	confirm_start_fight.disabled = true

func show_entry_box() -> void:
	name_entry_box.show()
	animation_player.play("EntryBoxSwoopIn")
	confirm_start_fight.disabled = false

func _on_confirm_start_fight_button_down():
	if line_edit.text == "":
		GameManager.player_name = "RAVEN20XX"
	else:
		GameManager.player_name = line_edit.text
		start_fight()

func update_currently_owned_components_count() -> void:
	current_owned_components.text = str(GameManager.owned_components_count)

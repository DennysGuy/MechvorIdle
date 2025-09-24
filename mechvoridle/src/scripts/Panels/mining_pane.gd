class_name MiningPane extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var drone_shop_animation_player : AnimationPlayer = $DroneShopAnimationPlayer

#location subviewports
@onready var asteroid_field_map : SubViewportContainer = $ColorRect/AsteroidFieldMap

@onready var asteroid_area_3: SubViewportContainer = $ColorRect/AsteroidArea3
@onready var asteroid_area_3_scene: AsteroidArea = $ColorRect/AsteroidArea3/SubViewport/AsteroidArea


@onready var asteroid_area_2: SubViewportContainer = $ColorRect/AsteroidArea2
@onready var asteroid_area_2_scene: AsteroidArea = $ColorRect/AsteroidArea2/SubViewport/AsteroidArea

@onready var asteroid_area_1 : SubViewportContainer = $ColorRect/AsteroidArea1
@onready var asteroid_area_1_scene : AsteroidArea = $ColorRect/AsteroidArea1/SubViewport/AsteroidArea

@onready var sub_viewport : SubViewport = $ColorRect/AsteroidArea1/SubViewport
@onready var buy_mech_part_label: Label = $ColorRect/BuyMechPartLabel
@onready var recon_scout_indicator: Label = $ColorRect/ReconScoutIndicator
@onready var drone_purchase_panel : DronePurchasePanel = $ColorRect/DronePurchasePanel

var drone_purchase_panel_showing : bool = false
#@onready var owned_drones_count : Label = %OwnedDronesCount

func _ready() -> void:
	SignalBus.show_upgrade_panel.connect(show_upgrade_panel)
	SignalBus.hide_upgrade_panel.connect(hide_upgrade_panel)
	SignalBus.change_maps.connect(play_fade_animation)
	SignalBus.show_drone_shop.connect(toggle_drone_purchase_panel)
	#SignalBus.update_owned_drones_count.connect(update_drone_count)
	#update_drone_count()
	
	
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

func play_fade_animation() -> void:
	animation_player.play("FadeBetweenLayers")

func switch_layer() -> void:
	
	match GameManager.selected_location:
		GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_AREA_1:
			print("hi asteroid area 1 here")
			asteroid_area_1.show()
			#I'm guessing that we'll end up connecting all of the components to this field  here
			asteroid_field_map.hide()
			SignalBus.set_asteroid_data.emit(asteroid_area_1_scene, asteroid_area_1_scene.local_drone_manager)
			
		GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_AREA_2:
			asteroid_area_2.show()
			asteroid_field_map.hide()
			SignalBus.set_asteroid_data.emit(asteroid_area_2_scene, asteroid_area_1_scene.local_drone_manager)
		
		GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_AREA_3:
			asteroid_area_3.show()
			asteroid_field_map.hide()
			SignalBus.set_asteroid_data.emit(asteroid_area_3_scene, asteroid_area_3_scene.local_drone_manager)
		
		GameManager.ASTEROID_FIELD_LOCATIONS.ASTEROID_FIELD_MAP:
			drone_shop_animation_player.play("RESET")
			asteroid_area_1.hide()
			asteroid_area_2.hide()
			asteroid_area_3.hide()
			asteroid_field_map.show()
			SignalBus.clear_asteroid_data.emit()

func toggle_drone_purchase_panel() -> void:
	
	if drone_purchase_panel_showing:
		hide_drone_shop_panel()
	else:
		show_drone_shop_panel()
		
	drone_purchase_panel_showing = !drone_purchase_panel_showing

		
func show_drone_shop_panel() -> void:
	drone_shop_animation_player.play("drone_shop_swoop_in")

func hide_drone_shop_panel() -> void:
	drone_shop_animation_player.play("drone_shop_swoop_out")

#func update_drone_count() -> void:
	#var current_drone_count : int = DroneManager.drones.size()
	#var max_owned_drone_count : int = GameManager.max_owned_drones
	#owned_drones_count.text = "Owned Drones " + str(current_drone_count) + "/" + str(max_owned_drone_count)

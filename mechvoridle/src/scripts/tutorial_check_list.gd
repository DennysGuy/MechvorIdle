class_name TutorialCheckList extends ColorRect

@onready var black_market_indicator: TextureRect = $BlackMarketIndicator
@onready var mining_facility_indicator: TextureRect = $MiningFacilityIndicator
@onready var min_asteroid_indicator: TextureRect = $MinAsteroidIndicator
@onready var mining_drone_indicator: TextureRect = $MiningDroneIndicator
@onready var plat_drone_indicator: TextureRect = $PlatDroneIndicator
@onready var upgrade_indicator: TextureRect = $UpgradeIndicator
@onready var recon_scout_indicator: TextureRect = $ReconScoutIndicator
@onready var ferrite_refinery_indicator: TextureRect = $FerriteRefineryIndicator
@onready var plasma_gen_indicator: TextureRect = $PlasmaGenIndicator
@onready var mech_component_indicator: TextureRect = $MechComponentIndicator
@onready var fly_by_asteroid_indicator: TextureRect = $FlyByAsteroidIndicator
@onready var ufo_indicator: TextureRect = $UFOIndicator

var check_list_showing : bool = false

func _ready() -> void:
	SignalBus.show_task_completed_indicator.connect(show_task_completed_indicator)
	black_market_indicator.hide()
	mining_facility_indicator.hide()
	min_asteroid_indicator.hide()
	mining_drone_indicator.hide()
	plat_drone_indicator.hide()
	upgrade_indicator.hide()
	recon_scout_indicator.hide()
	ferrite_refinery_indicator.hide()
	plasma_gen_indicator.hide()
	mech_component_indicator.hide()
	fly_by_asteroid_indicator.hide()
	ufo_indicator.hide()

func _process(delta: float) -> void:
	pass


func show_task_completed_indicator(index : int) -> void:
	match index:
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.VISITED_BLACK_MARKET:
			black_market_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.VISITED_MINING_FACILITY:
			mining_facility_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.ASTEROID_MINED:
			min_asteroid_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.MINING_DRONE_PURCHASED:
			mining_drone_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED: 
			plat_drone_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PURCHASED:
			upgrade_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED:
			recon_scout_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.FERRITE_REFINERY_PURCHASED:
			ferrite_refinery_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLASMA_GENERATOR_PURCHASED:
			plasma_gen_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.MECH_COMPONENT_PURCHASED:
			mech_component_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.FLYBY_ASTEROID_DESTROY:
			fly_by_asteroid_indicator.show()
		GameManager.CHECK_LIST_INDICATOR_TOGGLES.UFO_DESTROYED:
			ufo_indicator.show()


func _on_open_tutorial_checklist_button_down() -> void:
	
	if !check_list_showing:
		SignalBus.show_check_list.emit()
	else:
		SignalBus.hide_check_list.emit()
	
	check_list_showing  = !check_list_showing

func _on_close_tutorial_checklist_button_down() -> void:
	if check_list_showing:
		SignalBus.hide_check_list.emit()
		
	check_list_showing  = !check_list_showing

class_name TutorialCheckList extends Control



var current_phase_mission_completed_count : int = 0
var mission_phase : int = 0
var current_total_mission_count : int = 0
const TOTAL_MISSION_COUNT : int = 16
const MISSION_PHASE_TOTAL_COUNT : int = 3
@onready var sfx_player : AudioStreamPlayer = $SfxPlayer

@onready var beep_sfx : Array[AudioStream] = [SfxManager.UI_MISC_TEXT_CRAWL_01, SfxManager.UI_MISC_TEXT_CRAWL_02, SfxManager.UI_MISC_TEXT_CRAWL_03]


@onready var mission_list_item_container : VBoxContainer = $MissionListItemContainer


@onready var missions_list : Dictionary = {
	0: {
		0: {
			"task": "Visit the shop.",
			"count": 1,
			"icon": null,
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.VISITED_BLACK_MARKET
		},
		1: {
			"task": "Visit the Mining Facility.",
			"count": 1,
			"icon": null,
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.VISITED_MINING_FACILITY
		},
		2: {
			"task": "Get 100 Platinum with Mine Laser.",
			"count": 100,
			"icon": preload("res://assets/graphics/platinum_ui_icon.png"),
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.HUNDRED_PLATINUM_GAIN
		}
	},
	1: {
		0: {
			"task": "Purchase a mining drone.",
			"count": 1,
			"icon": preload("res://assets/graphics/mining_drone.png"),
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "0",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.MINING_DRONE_PURCHASED
		},
		1: {
			"task": "Destroy 3 Fly By Asteroids",
			"count": 3,
			"icon": preload("res://assets/graphics/Asteroid1.png"),
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.THREE_FLYBY_ASTEROIDS_DESTROYED
		},
		2: {
			"task": "Purchase a Platinum Mining Drone",
			"count": 1,
			"submission" : true,
			"submission max count": 100, 
			"submission resource" : "Platinum",
			"icon": preload("res://assets/graphics/platinum_drone.png"),
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLAT_DRONE_PURCHASED
		}
	},
	2: {
		0: {
			"task": "Upgrade Mining Drone damage once.",
			"count": 1,
			"icon": preload("res://assets/graphics/mining_drone.png"),
			"submission" : true,
			"submission max count": GameManager.drone_damage_cost, 
			"submission resource" : "Platinum",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_MINING_DRONE_DAMAGE
		},
		1: {
			"task": "Upgrade Platinum Mining Drone speed once.",
			"count": 1,
			"icon": preload("res://assets/graphics/platinum_drone.png"),
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.UPGRADE_PLATINUM_DRONE_SPEED
		},
		2: {
			"task": "Purchase one more drone.",
			"count": 1,
			"submission" : true,
			"submission max count": DroneManager.get_mining_drone_cost(), 
			"submission resource" : "Platinum",
			"icon": preload("res://assets/graphics/platinum_drone.png"),
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.PURCHASE_1_MORE_DRONE
		}
	},
	3: {
		0: {
			"task": "Purchase a Recon Scout.",
			"count": 1,
			"icon": null,
			"submission" : true,
			"submission max count": GameManager.recon_scout_platinum_cost, 
			"submission resource" : "Platinum",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.RECON_SCOUT_PURCHASED
		},
		1: {
			"task": "Destroy UFO.",
			"count": 1,
			"icon": preload("res://assets/graphics/UFO-Still.png"),
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.UFO_DESTROYED
		}
	},
	4: {
		0: {
			"task": "Purchase Ferrite Refinery.",
			"count": 1,
			"icon": preload("res://assets/graphics/refineryused.png"),
			"submission" : true,
			"submission max count": GameManager.ferrite_refinery_cost, 
			"submission resource" : "Ferrite",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.FERRITE_REFINERY_PURCHASED
		},
		1: {
			"task": "Purchase Plasma Generator",
			"count": 1,
			"icon":preload("res://assets/graphics/generator.png"),
			"submission" : true,
			"submission max count": GameManager.ferrite_bars_count, 
			"submission resource" : "Ferrite Bars",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.PLASMA_GENERATOR_PURCHASED
		},
		2: {
			"task": "Purchase a Mech Component",
			"count": 1,
			"icon": null,
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.MECH_COMPONENT_PURCHASED
		}
	},
	5: {
		0: {
			"task": "Complete your mech!",
			"count": 5,
			"icon": null,
			"submission" : false,
			"submission max count": 0, 
			"submission resource" : "",
			"mission index": GameManager.CHECK_LIST_INDICATOR_TOGGLES.COMPLETE_MECH
		}
	}
}
@onready var mission_completed_counter : Label = $MissionCompletedCounter

var mission_list_show : bool = false
var first_show_case_shown : bool = false
var can_toggle_panel : bool = false
var showing_new_phase = false
func _ready() -> void:
	SignalBus.increment_mission_completed_counted.connect(increment_mission_completed_count)
	SignalBus.increment_phase_mission_completed_count.connect(increment_phase_mission_completed_count)
	load_mission_phase_list()
	mission_completed_counter.text = str(current_total_mission_count)+"/"+str(TOTAL_MISSION_COUNT)
func _process(delta: float) -> void:
	pass

func load_mission_phase_list() -> void:
	clear_mission_list_container()
	current_phase_mission_completed_count = 0
	var mission_phase_list : Dictionary = missions_list[mission_phase]
	var sfx_index : int = 0
	for mission in mission_phase_list.keys():
		var wait_timer := get_tree().create_timer(1)
		await wait_timer.timeout
		sfx_player.stream = beep_sfx[sfx_index]
		sfx_player.play()
		sfx_index += 1
		var mission_list_item : MissionListItem = preload("res://src/scenes/MissionListItem.tscn").instantiate()
		var current_mission : Dictionary = mission_phase_list[mission]
		mission_list_item.mission_description.text = current_mission["task"]
		mission_list_item.max_count = current_mission["count"]
		mission_list_item.icon.texture = current_mission["icon"]
		mission_list_item.has_submission = current_mission["submission"]
		mission_list_item.sub_mission_max_count = current_mission["submission max count"]
		mission_list_item.submission_resource_name = current_mission["submission resource"]
		mission_list_item.mission_index = current_mission["mission index"]
		mission_list_item_container.add_child(mission_list_item)
		
		
	if not first_show_case_shown:
		var quick_timer := get_tree().create_timer(1.5)
		await quick_timer.timeout
		SignalBus.hide_mission_tracker_panel.emit()
		GameManager.can_traverse_panes = true
		can_toggle_panel = true
		first_show_case_shown = true
		
	if showing_new_phase:
		var quick_timer := get_tree().create_timer(1.5)
		await quick_timer.timeout
		SignalBus.hide_mission_tracker_panel.emit()
		showing_new_phase = false
		
func increment_mission_completed_count() -> void:
	current_total_mission_count += 1
	mission_completed_counter.text = str(current_total_mission_count)+"/"+str(TOTAL_MISSION_COUNT)

func increment_phase_mission_completed_count() -> void:
	current_phase_mission_completed_count += 1
	
	if current_phase_mission_completed_count == MISSION_PHASE_TOTAL_COUNT:
		SignalBus.issue_phase_compolete_notification.emit()
		sfx_player.stream = preload("res://assets/audio/SFX/UI/Misc/PhaseComplete.wav")
		sfx_player.play()
		mission_phase += 1
		if not mission_list_show:
			showing_new_phase = true
			SignalBus.show_mission_tracker_panel.emit()
		
		load_mission_phase_list()
	else:
		SignalBus.issue_mission_complete_notification.emit()

func clear_mission_list_container() -> void:
	for mission in mission_list_item_container.get_children():
		mission.queue_free()


func _on_open_panel_button_button_down():
	if can_toggle_panel:
		toggle_pannel()

func toggle_pannel() -> void:
	if not mission_list_show:
		SignalBus.show_mission_tracker_panel.emit()
	else:
		SignalBus.hide_mission_tracker_panel.emit()
	
	mission_list_show = !mission_list_show

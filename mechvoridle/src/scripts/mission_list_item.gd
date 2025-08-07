class_name MissionListItem extends ColorRect


@export var mission_description : Label
@export var check_box :TextureRect
@export var icon : TextureRect
@export var counter : Label
@export var mission_index : int
@onready var sub_mission_label : Label = $SubMissionLabel
@onready var submission_counter : Label = $SubmissionCounter
@onready var mission_complete_player : AudioStreamPlayer = $MissionCompletePlayer

var has_submission : bool = false
var submission_resource_name : String


var max_count : int
var current_count : int = 0 

var sub_mission_max_count : int
var sub_mission_current_count : int = 0

func _ready() -> void:
	if GameManager.get_mission_status(mission_index) == true:
		complete_mission()
		sub_mission_current_count = sub_mission_max_count
		check_box.show()


	counter.text = str(current_count)+"/"+str(max_count)
	check_box.hide()
	SignalBus.add_to_mission_counter.connect(increment_counter)
	SignalBus.add_to_submission_counter.connect(increment_sub_mission_count)
	

func increment_counter(amount : int, unique_indentifier : int) -> void:
	if GameManager.get_mission_status(mission_index) or mission_index != unique_indentifier :
		return
	
	current_count += amount
	
	if current_count >= max_count:
		complete_mission()
		return
		
	counter.text = str(current_count)+"/"+str(max_count)

func complete_mission() -> void:
	mission_complete_player.play()
	current_count == max_count
	counter.text = str(current_count)+"/"+str(max_count)
	SignalBus.increment_mission_completed_counted.emit()
	SignalBus.increment_phase_mission_completed_count.emit()
	#SignalBus.issue_mission_complete_notification.emit()
	GameManager.set_mission_status(mission_index, true)
	check_box.show()

func init_sub_mission_values() -> void:
	if GameManager.get_mission_status(mission_index):
		return
	sub_mission_label.show()
	submission_counter.show()
	sub_mission_label.text = submission_resource_name + "Aquired:"
	submission_counter.text = str(sub_mission_current_count)+"/"+str(sub_mission_max_count)

func increment_sub_mission_count(amount : int, unique_identifier : int) -> void:
	if GameManager.get_mission_status(mission_index) or mission_index != unique_identifier:
		return
	if sub_mission_current_count < sub_mission_max_count:
		sub_mission_current_count += amount
		submission_counter.text = str(sub_mission_current_count)+"/"+str(sub_mission_max_count)

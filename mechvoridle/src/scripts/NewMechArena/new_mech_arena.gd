class_name NewMechArena extends Node3D

@onready var basic_enemy_1: BasicEnemy1 = $BasicEnemy1
@export var player: Player
@export var room_enemy_cap : int
@onready var upgrade_crates: Node = $UpgradeCrates

@onready var timer: Timer = $Timer

@onready var health_bar: ProgressBar = $UI/HealthBar

@onready var weapon_key_card_count: Label = $UI/WeaponKeyCardCount
@onready var suit_key_card_count: Label = $UI/SuitKeyCardCount
@onready var key_cards: Node = $KeyCards
@onready var health_count: Label = $UI/HealthCount

var prev_spawn_point_number : int = 0

var max_crates_in_scene : int = 3

@onready var upgrade_spawn_points: Node = $UpgradeSpawnPoints

func _ready() -> void:
	health_bar.max_value = GameManager.total_health
	health_bar.value = GameManager.current_health
	health_count.text = "["+str(GameManager.current_health)+"/"+str(GameManager.total_health)+"]"
	randomize()
	weapon_key_card_count.text = str(GameManager.weapon_key_cards)
	weapon_key_card_count.text = str(GameManager.suit_key_cards)
	SignalBus.update_key_card_counts.connect(update_key_cards_count)
	SignalBus.update_player_health.connect(update_player_health)
	#SignalBus.check_for_more_crates.connect(check_for_remaining_crate)
	timer.start()
	
func _process(delta : float) -> void:
	pass


func _on_timer_timeout() -> void:
	var upgrade_spawn_point_list : Array = upgrade_spawn_points.get_children()
	var random_int : int = prev_spawn_point_number
	

	while upgrade_spawn_point_list[random_int].spot_occupied:
		random_int = randi_range(0,4)
	
	prev_spawn_point_number = random_int
	spawn_upgrade_crate(random_int)


func check_for_crate_at_pos(point_index : int) -> bool:
	var spawn_point : Marker3D= upgrade_spawn_points.get_child(point_index)
	
	for crate in upgrade_crates.get_children():
		var c : UpgradeCrate = crate
		if c.global_transform.origin == spawn_point.global_transform.origin:
			print("already a crate here")
			return true
	return false

func spawn_upgrade_crate(spawn_index : int) -> void:
	var upgrade_spawn_point_list : Array = upgrade_spawn_points.get_children()
	
	if upgrade_crates.get_children().size() >= max_crates_in_scene:
		print("max crates in scene already")
		return
	
	if upgrade_spawn_point_list[spawn_index].spot_occupied:
		return
	
	var crate : UpgradeCrate = preload("uid://cwgvtxn3cjgyq").instantiate()

	crate.global_transform.origin = upgrade_spawn_point_list[spawn_index].global_transform.origin
	crate.stored_locate_id = spawn_index
	upgrade_spawn_point_list[spawn_index].spot_occupied = true
	upgrade_crates.add_child(crate)
	print("crate was spawned at point " + str(spawn_index))
			

func update_player_health() -> void:
	health_count.text = "["+str(GameManager.current_health)+"/"+str(GameManager.total_health)+"]"
	health_bar.value = GameManager.current_health

func check_for_remaining_crate(crate : UpgradeCrate) -> void:
	if upgrade_crates.get_children().is_empty():
		disable_arrow_guide(crate)
		return
	
	for cur_crate in upgrade_crates.get_children():
		var c_crate : UpgradeCrate = cur_crate
		if c_crate.crate_type == crate.crate_type:
			match c_crate.crate_type:
				c_crate.CRATE_TYPES.WEAPON:
					SignalBus.init_weapon_upgrade_guide.emit(c_crate)
				c_crate.CRATE_TYPES.SUIT:
					SignalBus.init_suit_upgrade_guide.emit(c_crate)
			return
	
	disable_arrow_guide(crate)
	
func update_key_cards_count() -> void:
	weapon_key_card_count.text = str(GameManager.weapon_key_cards)
	suit_key_card_count.text = str(GameManager.suit_key_cards)


func disable_arrow_guide(crate : UpgradeCrate):
	match crate.crate_type:
		crate.CRATE_TYPES.WEAPON:
			SignalBus.disable_weapon_upgrade_guide.emit()
		crate.CRATE_TYPES.SUIT:
			SignalBus.disable_suit_upgrade_guide.emit()

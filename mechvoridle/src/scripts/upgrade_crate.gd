class_name UpgradeCrate extends Node3D

@onready var suit_upgrade_crate: Node3D = $Crates/SuitUpgradeCrate
@onready var weapon_upgrade_crate: Node3D = $Crates/WeaponUpgradeCrate
@onready var crates: Node3D = $Crates

enum CRATE_TYPES {WEAPON, SUIT}
var crate_type :int
var stored_locate_id : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_int : RandomNumberGenerator = RandomNumberGenerator.new()
	var chosen_number : int = random_int.randi_range(0,100)
	if chosen_number < 50:
		set_as_suit_upgrade()
	else:
		set_as_weapon_upgrade()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	crates.rotation.y += 0.01


func set_as_suit_upgrade() -> void:
	crate_type = CRATE_TYPES.SUIT
	SignalBus.init_suit_upgrade_guide.emit(self)
	weapon_upgrade_crate.hide()
	suit_upgrade_crate.show()

func set_as_weapon_upgrade() -> void:
	crate_type = CRATE_TYPES.WEAPON
	SignalBus.init_weapon_upgrade_guide.emit(self)
	weapon_upgrade_crate.show()
	suit_upgrade_crate.hide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		#handle upgrade logic
		if crate_type == CRATE_TYPES.WEAPON:
			if GameManager.weapon_key_cards <= 0:
				return
			SignalBus.check_once_for_weapon_crates.emit(self)
			GameManager.weapon_key_cards -= 1
		else:
			if GameManager.suit_key_cards <= 0:
				return
	
			SignalBus.check_once_for_suit_crates.emit(self)
			GameManager.suit_key_cards -= 1
		
		SignalBus.free_crate_spawn_location.emit(stored_locate_id)
		SignalBus.update_key_card_counts.emit()
		queue_free()

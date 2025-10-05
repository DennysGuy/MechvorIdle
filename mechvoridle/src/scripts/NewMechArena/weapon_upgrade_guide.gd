class_name WeaponUpgradeGuide extends Node3D

var crate_to_look_at : UpgradeCrate

var crates : Array[UpgradeCrate] = []

@onready var weapon_upgrade_guide: Sprite3D = $WeaponUpgradeGuide

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.init_weapon_upgrade_guide.connect(enable_guide)
	SignalBus.disable_weapon_upgrade_guide.connect(disable_guide)
	SignalBus.check_once_for_weapon_crates.connect(check_for_more_crates)
	weapon_upgrade_guide.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if crate_to_look_at:
		var direction = (crate_to_look_at.global_transform.origin - global_transform.origin).normalized()
		look_at(crate_to_look_at.global_transform.origin + direction, Vector3.UP)

func enable_guide(crate : UpgradeCrate) -> void:
	weapon_upgrade_guide.show()
	add_to_crate(crate)

func disable_guide() -> void:
	crate_to_look_at = null
	weapon_upgrade_guide.hide()

func check_for_more_crates(crate : UpgradeCrate) -> void:
	remove_crate(crate)

func add_to_crate(crate : UpgradeCrate) -> void:
	crate_to_look_at = crate
	crates.append(crate)

func remove_crate(crate : UpgradeCrate) -> void:
	for index in crates.size():
		if crates.get(index) == crate:
			crates.remove_at(index)
	
	if not crates.is_empty():
		crate_to_look_at = crates[0]
	else:
		disable_guide()

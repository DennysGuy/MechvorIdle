class_name WeaponIconHud extends Control

enum WEAPON_SLOT {WEAPON1, WEAPON2}
@export var weapon_slot : WEAPON_SLOT
@onready var weapon_icon: TextureRect = $WeaponIcon


@onready var cool_down_count: Label = $CoolDownCount
@onready var cool_down_wheel: TextureProgressBar = $CoolDownWheel

@onready var weapon_name_label: Label = $WeaponNameLabel

var on_cool_down : bool = false
var equipped_weapon : MechWeapon
var millisecond : float = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#GameManager.equip_rifle_left_sword_right()
	match weapon_slot:
		WEAPON_SLOT.WEAPON1:
			equipped_weapon = GameManager.get_right_weapon()
		WEAPON_SLOT.WEAPON2:
			equipped_weapon = GameManager.get_left_weapon()
	
	weapon_name_label.text = equipped_weapon.component_name
	cool_down_wheel.max_value = equipped_weapon.cool_down_time
	cool_down_wheel.value = 0
	
	cool_down_wheel.hide()
	cool_down_count.hide()
	set_weapon_icon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if on_cool_down:
		count_down_process(delta)
		

func set_weapon_icon() -> void:
	if not equipped_weapon:
		return
	
	match equipped_weapon.weapon_class:
		equipped_weapon.WEAPON_CLASS.SWORD:
			weapon_icon.texture = preload("uid://dsmjbfcm15wyv")
		equipped_weapon.WEAPON_CLASS.RIFLE:
			weapon_icon.texture = preload("uid://bnsom7grdtd0r")
		equipped_weapon.WEAPON_CLASS.ROCKETLAUNCHER:
			weapon_icon.texture = preload("uid://dbtpntjqa21i8")

func start_cool_down_timer() -> void:
	cool_down_count.show()
	millisecond = 60
	cool_down_wheel.value = cool_down_wheel.max_value
	on_cool_down = true

func count_down_process(_delta : float) -> void:
	millisecond -= 1 * _delta 
		
	if millisecond <= 0:
		cool_down_wheel.value -= 1
		millisecond = 60
		
	if cool_down_wheel.value <= 0:
		cool_down_count.hide()
		on_cool_down = false
	else:
		cool_down_count.text = str(int(cool_down_wheel.value))

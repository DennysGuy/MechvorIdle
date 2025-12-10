class_name WeaponIconHud extends Control

enum WEAPON_SLOT {WEAPON2, WEAPON1}
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
	SignalBus.issue_weapon_attack.connect(start_cool_down_timer)
	SignalBus.reduce_cooldown_value.connect(reduce_cooldown_value)
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
		#print(cool_down_wheel.value)
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

func start_cool_down_timer(weapon_hand : int) -> void:
	if weapon_hand != weapon_slot:
		return 
		
	cool_down_count.show()
	cool_down_wheel.show()
	millisecond = 60
	if GameManager.in_overdrive_mode:
		cool_down_wheel.value = int(cool_down_wheel.max_value * GameManager.overdrive_cooldown_bonus)
	else:
		cool_down_wheel.value = cool_down_wheel.max_value + GameManager.cooldown_affix
	on_cool_down = true

func count_down_process(_delta : float) -> void:


	
	millisecond -= 1
		
	if millisecond <= 0:
		cool_down_wheel.value -= 1
		millisecond = 60
		
	if cool_down_wheel.value <= 0:
		cool_down_count.hide()
		cool_down_wheel.hide()
		match weapon_slot:
			WEAPON_SLOT.WEAPON1:
				SfxManager.play_sfx(SfxManager.WEAPON_1_READY,3)
				GameManager.can_fire_weapon_1 = true
			WEAPON_SLOT.WEAPON2:
				SfxManager.play_sfx(SfxManager.WEAPON_2_READY,3)
				GameManager.can_fire_weapon_2 = true
				
		on_cool_down = false
	else:
		cool_down_count.text = str(int(cool_down_wheel.value))

func reduce_cooldown_value(value : int) -> void:
	if on_cool_down:
		cool_down_wheel.value -= value

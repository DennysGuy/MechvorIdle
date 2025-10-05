class_name KeyCardObject extends Node3D

enum KEY_CARD_TYPE {WEAPON, SUIT}

var card_type : int
@onready var graphic: Sprite3D = $Graphic


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_int : int = randi_range(0,100)
	if random_int < 50:
		card_type = KEY_CARD_TYPE.WEAPON
		graphic.texture = preload("uid://c1wd44ct4fyqh")
	else:
		card_type = KEY_CARD_TYPE.SUIT
		graphic.texture = preload("uid://ba8a5byr0ir4a")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	rotation.y += 0.03

func _on_area_3d_body_entered(body: Node3D) -> void:
	
	if not body is Player:
		return
	
	match card_type:
		KEY_CARD_TYPE.WEAPON:
			GameManager.weapon_key_cards += 1
		KEY_CARD_TYPE.SUIT:
			GameManager.suit_key_cards += 1
	
	SignalBus.update_key_card_counts.emit()
	
	queue_free()

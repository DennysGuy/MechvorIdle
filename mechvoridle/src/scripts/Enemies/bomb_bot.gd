class_name BombBot extends GridProjectile

@onready var sphere: MeshInstance3D = $BombBot/BombBot/sphere

const BOMB_BOT_BLACK = preload("uid://chpkcdtqne2f2")
const BOMB_BOT_RED = preload("uid://dpdi62vmt11so")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum BOMB_TYPE {BLACK,RED}
@export var type : BOMB_TYPE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		BOMB_TYPE.BLACK:
			sphere.material_override = BOMB_BOT_BLACK
		BOMB_TYPE.RED:
			sphere.material_override = BOMB_BOT_RED
	direction = Vector3(0,0,1)
	animation_player.play("bomb")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	global_translate(direction * speed * TimeManager.slow_time_factor * delta)

func _on_hit_box_area_entered(area: Area3D) -> void:
	impact_prjectile(area)

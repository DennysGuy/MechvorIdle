class_name SporadicEnemy extends GridEnemy
@export var row_limit : int = 2
@export var col_limit : int = 4

@onready var name_tag: Label = $EnemyNameTag/NameTag


var random_direction_list : Array[Vector2] = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]

@onready var laser_spout: Marker3D = $LaserSpout
@onready var timer: Timer = $Timer

var laser_count_down : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	SignalBus.heal_enemy.connect(heal)
	state_machine.init(self)
	name_tag.text = "LV.%s Sporadic Bot" % [level]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_label.text = str(health)+"/"+str(max_health)
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _enter_tree() -> void:
	print("SPORADIC ENEMY HAS ENTERED!")

func _exit_tree() -> void:
	GridManager.enemies.erase(self)
	GridManager.check_wave_status()

func play_shock_shot() -> void:
	var pitch_scale := 1.0
	if GameManager.in_overdrive_mode:
		pitch_scale = 0.6
	SfxManager.play_sfx(SfxManager.LIGHTNING_BLAST, -4,false, pitch_scale)

func fire_shock_wave() -> void:
	var shock_wave : ElectricalShock = weapon.projectile.instantiate()
	var tile_column = weapon.attack_pattern.scan_tiles_of_effect(self, tiles, 0, false)
	match level:
		1:
			shock_wave.speed = 30
		2:
			shock_wave.speed = 50
		3:
			shock_wave.speed = 70
			
	shock_wave.weapon_owner = self
	shock_wave.weapon_origin = weapon
	shock_wave.tiles = tiles
	shock_wave.tile_column = tile_column
	get_parent().add_child(shock_wave)
	 

class_name HeavyBoss extends GridBoss

enum PHASES {
	ATTACK_PHASE1,
	ATTACK_PHASE2,
	ATTACK_PHASE3
}

'''
list of random tile configs for mini rockets
[4,0],[4,1]
[4,0],[4,2]
[4,1],[4,2]

'''
var fall_configs := [
	[Vector2(4,0),Vector2(4,1)],
	[Vector2(4,0),Vector2(4,2)],
	[Vector2(4,1),Vector2(4,2)]
]




@export var row_limit : int = 2
@export var col_limit : int = 3

var current_phase : PHASES
var destined_tile : Tile
@onready var animation_player: AnimationPlayer = $HeavyBoss/AnimationPlayer
@onready var misc_animation_player: AnimationPlayer = $MiscAnimationPlayer


@onready var timer: Timer = $Timer
@onready var phase_timer: Timer = $PhaseTimer
@onready var rocket_launch_marker: Marker3D = $RocketLaunchMarker
var change_phase : bool = false
var random_direction_list : Array[Vector2] = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]
var idle_time : float = 2.0



@onready var shield: Shield = $Shield

@export var cannon_rifle : MechWeapon
@export var rocket_launc : MechWeapon

@onready var rocket_launch_timer: Timer = $RocketLaunchTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SignalBus.spawn_mini_wave.connect(spawn_mini_wave)
	health_label.text = "%s/%s"%[health,max_health]
	SignalBus.change_boss_phase.connect(change_boss_phase_on_start)
	can_hurt = false
	state_machine.init(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func shake_camera_on_taunt() -> void:
	SignalBus.shake_camera.emit(2.2)

func _exit_tree() -> void:
	GridManager.enemies.erase(self)

func _on_phase_timer_timeout() -> void:
	choose_new_phase()
	change_phase = true


func choose_new_phase() -> void:
	var prev_phase : PHASES = current_phase
	var new_phase : PHASES = current_phase
	
	while prev_phase == new_phase:
		var keys : Array[int] = [0,1,2]
		new_phase = keys.pick_random()
	
	current_phase = new_phase
	#change_phase = true

func show_shield() -> void:
	shield.show()

func hide_shield() -> void:
	shield.hide()

func fire_cannon() -> void:
	cannon_rifle.attack_pattern.issue_attack(self, tiles, cannon_rifle.damage)
	SfxManager.play_sfx(SfxManager.BOSS_CANNON_FIRE,3)
	SignalBus.shake_camera.emit(0.4)
	await get_tree().create_timer(0.5).timeout
	
func spawn_launching_mini_rocket() -> void:
	SfxManager.play_sfx(SfxManager.BOSS_ROCKET_LAUNCH)
	var mini_rocket : MiniRocket = preload("uid://ck5biy4g3ijgw").instantiate()
	mini_rocket.global_position = rocket_launch_marker.global_position
	get_parent().add_child(mini_rocket)

func change_boss_phase_on_start() -> void:
	change_phase = true
 

func _on_rocket_launch_timer_timeout() -> void:
	if change_phase:
		return
	
	var i := 0
	while i < 2:
		spawn_launching_mini_rocket()
		i += 1
		await get_tree().create_timer(0.5).timeout
	
	rockets_impact()
	rocket_launch_timer.start()

func play_boss_landing() -> void:
	SfxManager.play_sfx(SfxManager.BOSS_LAND,1)

func rockets_impact() -> void:
	var random_config : Array = fall_configs.pick_random()
	
	for coordinates in random_config:
		var selected_tile : Tile = GridManager.get_tile(tiles, coordinates)
		selected_tile.set_enemy_targeted_overlay()
	
	await get_tree().create_timer(0.5).timeout

	for coordinates in random_config:
		var selected_tile : Tile = GridManager.get_tile(tiles, coordinates)
		var mini_rocket : MiniRocket = preload("uid://ck5biy4g3ijgw").instantiate()
		
		mini_rocket.selected_tile = selected_tile
		mini_rocket.global_position = selected_tile.marker_3d.global_position
		mini_rocket.is_launching = false
	
		get_parent().add_child(mini_rocket)
		await get_tree().create_timer(0.5).timeout
	
func shake_camera_on_land() -> void:
	SignalBus.shake_camera.emit(2.0)

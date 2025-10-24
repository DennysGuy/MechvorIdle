class_name GridPlayer extends GridActor

@onready var animation_player: AnimationPlayer = $blockbench_export/AnimationPlayer
@onready var vlucan_1: Marker3D = $Vlucan1
@onready var vlucan_2: Marker3D = $Vlucan2

var can_shoot : bool = true
var firing : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left") and can_move:
		SignalBus.move_player.emit(Vector2.UP)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
		
	if Input.is_action_pressed("move_right") and can_move:
		SignalBus.move_player.emit(Vector2.DOWN)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
	
	if Input.is_action_pressed("move_up") and can_move:
		SignalBus.move_player.emit(Vector2.LEFT)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true
	
	if Input.is_action_pressed("move_down") and can_move:
		SignalBus.move_player.emit(Vector2.RIGHT)
		can_move = false
		await get_tree().create_timer(wait_time).timeout
		can_move = true

	if Input.is_action_pressed("fire_vulcans") and not firing:
		add_vulcan_flares()
		firing = true
	if Input.is_action_just_released("fire_vulcans") and firing:
		for flare in get_tree().get_nodes_in_group("VulcanFlares"):
			flare.queue_free()
		firing = false
	
	
	
func add_vulcan_flares() -> void:
	var muzzle_flare_1 = preload("uid://6wqyu6m4rjr5").instantiate()
	var muzzle_flare_2 = preload("uid://6wqyu6m4rjr5").instantiate()
	
	muzzle_flare_1.position = vlucan_1.position
	muzzle_flare_2.position = vlucan_2.position
	
	add_child(muzzle_flare_1)
	add_child(muzzle_flare_2)

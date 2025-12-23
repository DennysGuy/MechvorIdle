class_name WristRockets extends GridProjectile

@onready var wrist_rockets: Node3D = $WristRockets
@onready var animation_player: AnimationPlayer = $WristRockets/FlareLeft/AnimationPlayer
@onready var animation_player_l: AnimationPlayer = $WristRockets/FlareRight/AnimationPlayer

@onready var soar: AudioStreamPlayer = $Soar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Flare")
	animation_player_l.play("Flare")
	soar.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wrist_rockets.rotation.z += 0.05

func _physics_process(delta: float) -> void:
	if direction:
		global_translate(direction * speed * delta)

func _exit_tree() -> void:
	soar.stop()

func _on_timer_timeout() -> void:
	queue_free()


func _on_hit_box_area_entered(area: Area3D) -> void:
	

	impact_prjectile(area)

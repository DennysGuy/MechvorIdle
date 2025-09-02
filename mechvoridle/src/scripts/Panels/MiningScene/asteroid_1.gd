class_name Asteroid extends CharacterBody2D


@export var speed : float
@export var dir : Vector2
@export var mining_asteroid : Area2D
@export var health : int 
@export var damage : int
@export_enum("small" , "medium", "large") var asteroid_size : int
enum ASTEROID_SIZE{SMALL, MEDIUM, LARGE}
@onready var graphic: Sprite2D = $Graphic
@onready var sfx_player  : AudioStreamPlayer = $SfxPlayer
@onready var area_2d = $Area2D
@onready var asteroid_click_control  : Control = $AsteroidClickControl

var can_hit = true
@onready var guide_box_animation_player : AnimationPlayer = $GuideBoxAnimationPlayer

@onready var asteroid_animation_player: AnimationPlayer = $AsteroidAnimationPlayer
@onready var asteroid_hit_list : Array[AudioStream] = [SfxManager.MIN_CLICK_SPACE_01, SfxManager.MIN_CLICK_SPACE_02, SfxManager.MIN_CLICK_SPACE_03, SfxManager.MIN_CLICK_SPACE_04, SfxManager.MIN_CLICK_SPACE_05]
signal deliver_resources 
@onready var nine_patch_rect : NinePatchRect = $NinePatchRect

func _ready() -> void:
	guide_box_animation_player.play("blink")
	dir = mining_asteroid.position - position

func _process(delta : float) -> void:
	graphic.rotation += 0.02
	
func _physics_process(delta: float) -> void:
	
	if can_hit:
		velocity = dir.normalized() * speed
		move_and_slide()


func _on_delete_asteroid_timer_timeout() -> void:
	queue_free()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass

func damage_asteroid() -> void:
	play_asteroid_hit_sfx()
	asteroid_animation_player.play("hit_flash")
	health -= 1
	if health <= 0:
		deliver_resources.emit()
		spawn_explosion_and_destroy()

func spawn_explosion_and_destroy():
	
	if !GameManager.three_fly_by_drones_destroyed:
		SignalBus.add_to_mission_counter.emit(1, GameManager.CHECK_LIST_INDICATOR_TOGGLES.THREE_FLYBY_ASTEROIDS_DESTROYED)
	
	SignalBus.clear_tracked_hostile.emit(self)
	if is_instance_valid(self):
		can_hit = false
		graphic.hide()
		nine_patch_rect.queue_free()
		guide_box_animation_player.play("RESET")
		area_2d.get_child(0).disabled = true
		asteroid_click_control.hide()
		var explosion : Explosion = preload("res://src/scenes/Explosion.tscn").instantiate()
		match asteroid_size:
			ASTEROID_SIZE.SMALL:
				explosion.size_set = ASTEROID_SIZE.SMALL
				
			ASTEROID_SIZE.MEDIUM:
				explosion.size_set = ASTEROID_SIZE.MEDIUM
				
			ASTEROID_SIZE.LARGE:
				explosion.size_set = ASTEROID_SIZE.LARGE
		area_2d.get_child(0).disabled = true
		add_child(explosion)

func _on_asteroid_click_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and can_hit:
		#print("HIT!")
		damage_asteroid()

func play_asteroid_hit_sfx() -> void:
	sfx_player.stream = asteroid_hit_list.pick_random()
	sfx_player.play()

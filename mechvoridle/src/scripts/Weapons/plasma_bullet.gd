class_name PlasmaBullet extends GridProjectile


@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if direction:
		#velocity = direction * speed
		global_translate(direction * speed * delta)

func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		var enemy : Enemy = body
		enemy.damage(damage)
		queue_free()


func _on_hit_box_area_entered(area: Area3D) -> void:
	var parent = area.get_parent()
	print("Hi I hit something.")
	if area is TargetArea:
		print("were inside")
		var tile_parent : Tile = parent
		print(tile_parent.occupant)
		print(weapon_owner)
		if tile_parent.occupant and tile_parent.occupant != weapon_owner:
			weapon_origin.attack_enemy(weapon_owner, tiles)
			if !weapon_origin.attack_pattern.pass_through:
				print("WE HIT SOMETHING!!")
				queue_free() #will need to also add any sort of tile effects here.
		
		if tile_parent == tile:
			#tile effect
			print("WE MADE IT HERE BABY!")
			queue_free() # well, we might have to do something here.. but if the projectile reaches the destined tile it will queue free

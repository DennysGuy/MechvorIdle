class_name ElectricalShock extends GridProjectile

@onready var animation_player: AnimationPlayer = $ShockWave/AnimationPlayer

var tile_column : Array


var i : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Flail")
	move_shock_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move_shock_wave() -> void:

	var final_targeted_tile : Vector2 = weapon_origin.attack_pattern.get_destined_tile_coordinates(weapon_owner)

	for grid_tile in tile_column:

		var final_coordinates : Vector2 = final_targeted_tile + (weapon_origin.attack_pattern.direction * grid_tile)
		var selected_tile : Tile = GridManager.get_tile(tiles, final_coordinates)
		if selected_tile:
			selected_tile.set_enemy_targeted_overlay()
			global_position = selected_tile.marker_3d.global_position
			if selected_tile.occupant and selected_tile.occupant is GridPlayer:
				selected_tile.occupant.damage_actor(weapon_origin.damage)
		#we'll also scan for entities we can attack!
		i += 1
		
		await get_tree().create_timer(0.4).timeout
		selected_tile.clear_targeted_overlay()
		if final_coordinates.x == GridManager.MAX_ROWS-1:
			queue_free()
		
		

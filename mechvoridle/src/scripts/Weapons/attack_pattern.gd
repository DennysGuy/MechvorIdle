class_name AttackPattern extends Resource


@export_group("Coverage")

'''
target off is really just an offset from the player's position (this might be able to be altered with up/down key)
so for instance, if target offset is [0,1] and the actor 
is player and their cur position is [4,1] their direction is negative and so the targeted tile will be at [4,0]

'''

@export var target_offset : Vector2 = Vector2.ZERO

@export_enum("single","row", "column", "adjacent", "diagonal","sector","board", "enemy_column") var attack_pattern : int

@export_enum("player:-1", "enemy:1") var direction : int

enum ATTACK_PATTERNS {SINGLE, ROW, COLUMN, ADJACENT, DIAGONAL, SECTOR, BOARD, ENEMY_COLUMN}

@export var can_shift : bool

var patterns = {
	ATTACK_PATTERNS.SINGLE : [Vector2(0,0)],
	ATTACK_PATTERNS.ROW : [Vector2(0,0), Vector2(0,-1), Vector2(0,1)],
	ATTACK_PATTERNS.COLUMN : [Vector2(-3,0), Vector2(-2,0), Vector2(-1,0), Vector2(0,0)],
	ATTACK_PATTERNS.ADJACENT : [Vector2(0,0), Vector2(1,0), Vector2(0,-1), Vector2(-1,0),Vector2(0,1)],
	ATTACK_PATTERNS.DIAGONAL : [Vector2(0,0), Vector2(-1,-1), Vector2(-1,1), Vector2(1,-1), Vector2(1,1)],
	ATTACK_PATTERNS.SECTOR : [Vector2(0,0), Vector2(1,0), Vector2(0,-1), Vector2(-1,0),Vector2(0,1), Vector2(-1,-1), Vector2(-1,1), Vector2(1,-1), Vector2(1,1)],
	ATTACK_PATTERNS.ENEMY_COLUMN : [Vector2(-1,0),Vector2(-2,0),Vector2(-3,0), Vector2(-4,0), Vector2(-5,0)]
}


@export_group("Other")
@export var lock_on : bool = false
@export var pass_through : bool = false
@export_enum("hit_scan", "projectile","dash") var attack_type : int


func get_destined_tile_coordinates(actor : GridActor, new_target_offset : Vector2 = Vector2.ZERO) -> Vector2:
	
	var actor_tile : Tile = actor.current_tile
	var final_targeted_tile : Vector2
	if new_target_offset != Vector2.ZERO:
		final_targeted_tile = actor_tile.coordinates + (direction * new_target_offset)
	else:
		final_targeted_tile = actor_tile.coordinates + (direction * target_offset) 
	
	if actor is GridEnemy:
		final_targeted_tile.x = min(GridManager.MAX_ROWS-1,final_targeted_tile.x)
	elif actor is GridPlayer:
		final_targeted_tile.x = max(0,final_targeted_tile.x)
	
	return final_targeted_tile

func issue_attack(actor : GridActor, tiles : Node, damage : int, new_attack_pattern : Array = [], is_vulcan : bool = false) -> void:

	var final_targeted_tile : Vector2 = get_destined_tile_coordinates(actor)
	
	var offset_list : Array
	if !new_attack_pattern.is_empty():
		offset_list = new_attack_pattern
	else:
		offset_list = patterns[attack_pattern]
	
	for offset in offset_list:
		var final_offset : Vector2 = final_targeted_tile + (direction * offset)
		var selected_tile : Tile = GridManager.get_tile(tiles, final_offset)
		if selected_tile:
			GridManager.targeted_tiles.append(selected_tile)
			if actor is GridPlayer:
		
				selected_tile.set_targeted_overlay()
			elif actor is GridEnemy:
				selected_tile.set_enemy_targeted_overlay()
			
			if selected_tile.occupant:
				var enemy : GridActor = selected_tile.occupant
				if actor is GridPlayer and selected_tile.current_owner == selected_tile.OWNER.ENEMY: #may need to refactor later for different types of attacks
					if enemy is SwordBot and not enemy.in_stagger_state:
						var damage_label : GridDamageLabel = preload("uid://w3nvxv0mdub").instantiate()
						damage_label.label.text = "inv."
						damage_label.set_as_invincible()
						damage_label.position = enemy.damage_label_marker.position
						enemy.add_child(damage_label)
						break
					else:
						enemy.damage_actor(damage, is_vulcan)
					if !pass_through:
						break
						
				elif actor is GridEnemy and selected_tile.current_owner == selected_tile.OWNER.PLAYER:
					if enemy == GridManager.player and GridManager.player.shield_active:
						GameManager.current_shield_amount -= damage
						if GameManager.current_shield_amount <= 0:
							GridManager.player.can_use_shield = false
					else:
						enemy.damage_actor(damage)
					if !pass_through:
						break


func get_targeted_tile(coordinates : Vector2, tiles : Node) -> Tile:
	return GridManager.get_tile(tiles, coordinates)
	

				
func scan_tiles_of_effect(actor: GridActor, tiles: Node, off_set: int = 0, set_targeted_overlay : bool = true) -> Array:
	
	GridManager.clear_targeted_tiles()
	
	var final_targeted_tile: Vector2 = get_destined_tile_coordinates(actor)
	
	# Deep copy so we don't mutate the original pattern list
	var base_patterns = patterns[attack_pattern]
	var new_offset_list: Array = patterns[attack_pattern].duplicate(true)
	
	if can_shift:
		new_offset_list.clear()
		for pattern in base_patterns:
			new_offset_list.append(pattern + Vector2(off_set, 0))
	
	for offset in new_offset_list:
		var final_offset: Vector2 = final_targeted_tile + (direction * offset)
		var selected_tile: Tile = GridManager.get_tile(tiles, final_offset)
		
		if selected_tile:
			if set_targeted_overlay:
				GridManager.targeted_tiles.append(selected_tile)
				selected_tile.set_targeted_overlay()
			
			if selected_tile.occupant:
				if actor is GridPlayer and selected_tile.current_owner == selected_tile.OWNER.ENEMY:
					if !pass_through:
						break
				elif actor is GridEnemy and selected_tile.current_owner == selected_tile.OWNER.PLAYER:
					if !pass_through:
						break
	print(GridManager.targeted_tiles.size())
	return new_offset_list
	

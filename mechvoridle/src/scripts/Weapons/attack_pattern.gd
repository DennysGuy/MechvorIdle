class_name AttackPattern extends Resource


@export_group("Coverage")

'''
target off is really just an offset from the player's position (this might be able to be altered with up/down key)
so for instance, if target offset is [0,1] and the actor 
is player and their cur position is [4,1] their direction is negative and so the targeted tile will be at [4,0]

'''

@export var target_offset : Vector2 = Vector2.ZERO

@export_enum("single","row", "column", "adjacent", "diagonal","sector","board", ) var attack_pattern : int

enum ATTACK_PATTERNS {SINGLE, ROW, COLUMN, ADJACENT, DIAGONAL, SECTOR, BOARD}

var patterns = {
	ATTACK_PATTERNS.SINGLE : [Vector2(0,0)],
	ATTACK_PATTERNS.ROW : [Vector2(0,-1),Vector2(0,0), Vector2(0,1)],
	ATTACK_PATTERNS.COLUMN : [Vector2(-3,0), Vector2(-2,0), Vector2(-1,0), Vector2(0,0)],
	ATTACK_PATTERNS.ADJACENT : [Vector2(0,0), Vector2(1,0), Vector2(0,-1), Vector2(-1,0),Vector2(0,1)],
	ATTACK_PATTERNS.DIAGONAL : [Vector2(0,0), Vector2(-1,-1), Vector2(-1,1), Vector2(1,-1), Vector2(1,1)],
	ATTACK_PATTERNS.SECTOR : [Vector2(0,0), Vector2(1,0), Vector2(0,-1), Vector2(-1,0),Vector2(0,1), Vector2(-1,-1), Vector2(-1,1), Vector2(1,-1), Vector2(1,1)]
}


@export_group("Other")
@export var lock_on : bool = false
@export var pass_through : bool = false
@export_enum("hit_scan", "projectile","dash") var attack_type : int


func issue_attack(actor : GridActor, tiles : Node, direction : int, damage : int ) -> void:
	var actor_tile : Tile = actor.current_tile
	var final_targeted_tile = actor_tile.coordinates + (direction * target_offset) #dir should be -1 if player, +1 if enemy
	var offset_list : Array = patterns[attack_pattern]
	print(attack_pattern)
	for offset in offset_list:
		var final_offset : Vector2 = final_targeted_tile + (direction * offset)
		var selected_tile : Tile = GridManager.get_tile(tiles, final_offset)
		if selected_tile:
			print("attacking tile at coords : [%s,%s]" % [selected_tile.coordinates.x, selected_tile.coordinates.y])
			if selected_tile.occupant:
				var enemy : GridActor = selected_tile.occupant
				if  actor is GridPlayer and selected_tile.current_owner == selected_tile.OWNER.ENEMY and attack_type == 0: #may need to refactor later for different types of attacks
					enemy.damage_actor(damage)
					if !pass_through:
						break
				elif actor is GridEnemy and selected_tile.current_owner == selected_tile.OWNER.PLAYER and attack_type == 0:
					enemy.damage_actor(damage)
					if !pass_through:
						break
				

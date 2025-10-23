class_name CombatGrid extends Node3D

const MAX_ROWS = 5
const MAX_COLUMNS = 3

@onready var tiles: Node = $Tiles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_grid()
	spawn_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func init_grid() -> void:
	var x_pos : int = 0
	for row in range(MAX_ROWS):
		var new_position : Vector3 = Vector3.ZERO
		var y_pos : int = 0
		
		if row != 0: 
			x_pos += 3
		else: 
			x_pos = 0
		
		new_position.x = x_pos
		
		for col in range(MAX_COLUMNS):
			var new_tile : Tile = preload("uid://jgfdd71l3y54").instantiate()
			new_tile.coordinates = Vector2(row,col)
			if col != 0: 
				y_pos += 3
			else: 
				y_pos = 0
			
			if row == 4:
				new_tile.set_owner_as_player()
				print("wow")
			else:
				new_tile.set_owner_as_enemy()
				print("meme")
			
			new_tile.position = Vector3(y_pos, 0, x_pos)
			tiles.add_child(new_tile)

	print(tiles.get_children().size())

func get_tile(coordinates : Vector2) -> Tile:
	if tiles.get_children().is_empty():
		return null
	
	for tile in tiles.get_children():
		if tile is Tile and tile.coordinates == coordinates:
			return tile
			
	
	return null

func spawn_player() -> void:
	var player : GridPlayer = preload("uid://lam3j4dmw2xs").instantiate()
	var starting_tile : Tile = get_tile(Vector2(4,1))
	player.global_position = starting_tile.marker_3d.global_position
	add_child(player)

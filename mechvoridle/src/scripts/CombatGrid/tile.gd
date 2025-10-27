class_name Tile extends Node3D

@onready var marker_3d: Marker3D = $Marker3D
@export var occupant : Node3D
@export var coordinates : Vector2
@onready var tile: CSGBox3D = $Tile
@onready var target_marker: Marker3D = $TargetMarker

const ENEMY_TILE_TEXTURE = preload("uid://3nbu2ui1tyy3")
const PLAYER_TILE_TEXTURE = preload("uid://sv2tsq6a6wed")

enum OWNER {PLAYER, ENEMY}
var current_owner : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if current_owner == OWNER.PLAYER:
		tile.material = PLAYER_TILE_TEXTURE
	else:
		tile.material = ENEMY_TILE_TEXTURE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_owner_as_player() -> void:
	current_owner = OWNER.PLAYER

func set_owner_as_enemy() -> void:
	current_owner = OWNER.ENEMY

class_name ChallengeChest extends GridEnemy

var spawn_bomb_bots : bool = false
var spawn_timer : float = 0.35
@onready var misc_animation_player: AnimationPlayer = $MiscAnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.remove_challenge_chest.connect(remove_challenge_chest)
	SignalBus.open_challenge_chest.connect(open_challenge_chest)
	ChallengeWaveManager.start_challenge.connect(start_challenge)
	ChallengeWaveManager.end_challenge.connect(stop_challenge)
	
	misc_animation_player.play("SpawnIn")
	can_hurt = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if spawn_bomb_bots:
		bomb_bot_spawn(delta)

func spawn_bomb_bot(tile_coordinates : Vector2, bomb_bot_type : int) -> void:
	var tile : Tile = GridManager.get_tile(tiles, tile_coordinates)
	var destined_tile : Tile = GridManager.get_tile(tiles, Vector2(5,tile_coordinates.y))
	var bomb_bot : BombBot = preload("uid://y0jrc0sbpbn2").instantiate()
	bomb_bot.tile = destined_tile
	bomb_bot.tiles = tiles 
	bomb_bot.weapon_owner = self
	bomb_bot.weapon_origin = weapon
	match bomb_bot_type:
		0:
			bomb_bot.type = bomb_bot.BOMB_TYPE.BLACK
		1:
			bomb_bot.type = bomb_bot.BOMB_TYPE.RED
			
	bomb_bot.global_position = tile.marker_3d.global_position
	get_parent().add_child(bomb_bot)

func _on_timer_timeout() -> void:
	spawn_bomb_bots = true

func _exit_tree() -> void:
	GridManager.enemies.erase(self)
	

func bomb_bot_spawn(_delta : float) -> void:
	spawn_timer -= _delta
	if spawn_timer <= 0.0:
		var random_tile : Vector2 = Vector2(0, randi_range(0,2))
		var random_num : int = randi_range(0,1)
		spawn_bomb_bot(random_tile, random_num)
		spawn_timer = 0.35

func remove_challenge_chest() -> void:
	misc_animation_player.play("SpawnOut",-1.0,-1.0,true)

func start_challenge() -> void:
	match level:
		1:
			spawn_bomb_bots = true
		2:
			ChallengeWaveManager.spawn_challenge_targets.emit()

func stop_challenge() -> void:
	match level:
		1:
			spawn_bomb_bots = false
		2:
			pass

func open_challenge_chest() -> void:
	animation_player.play("Open")

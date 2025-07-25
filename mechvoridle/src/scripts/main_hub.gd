class_name MainHub extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalBus.move_to_mining_pane.connect(move_to_mining_pane)
	SignalBus.move_to_shop_pane.connect(move_to_shop_pane)
	SignalBus.move_to_central_hub_from_mining_page.connect(move_from_mining_pane_to_central_pane)
	SignalBus.move_to_central_hub_from_shop_pane.connect(move_from_shop_pane_to_central_pane)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_left"):
		if GameManager.on_shop_panel:
			move_from_shop_pane_to_central_pane()
		elif GameManager.on_central_panel:
			move_to_mining_pane()

	if Input.is_action_just_pressed("move_right"):
		if GameManager.on_mining_panel:
			move_from_mining_pane_to_central_pane()
		elif GameManager.on_central_panel:
			move_to_shop_pane()

func _process(delta : float) ->void:
	pass


func move_to_mining_pane() -> void:
	GameManager.on_mining_panel = true
	GameManager.on_shop_panel = false
	GameManager.on_central_panel = false
	animation_player.play("NavigateToMiningPage")

func move_to_shop_pane() -> void:
	GameManager.on_central_panel = false
	GameManager.on_mining_panel = false
	GameManager.on_shop_panel = true
	animation_player.play("NavigateToShopPane")

func move_from_mining_pane_to_central_pane() -> void:
	GameManager.on_mining_panel = false
	GameManager.on_shop_panel = false
	GameManager.on_central_panel = true
	animation_player.play("NavigateFromMiningPageToCentralHub")

func move_from_shop_pane_to_central_pane() -> void:
	GameManager.on_mining_panel = false
	GameManager.on_shop_panel = false
	GameManager.on_central_panel = true
	animation_player.play("NavigateFromShopToCentralHub")

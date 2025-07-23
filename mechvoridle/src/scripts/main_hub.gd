class_name MainHub extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalBus.move_to_mining_pane.connect(move_to_mining_pane)
	SignalBus.move_to_shop_pane.connect(move_to_shop_pane)
	SignalBus.move_to_central_hub_from_mining_page.connect(move_from_mining_pane_to_central_pane)
	SignalBus.move_to_central_hub_from_shop_pane.connect(move_from_shop_pane_to_central_pane)

func _process(delta : float) ->void:
	pass


func move_to_mining_pane() -> void:
	animation_player.play("NavigateToMiningPage")

func move_to_shop_pane() -> void:
	animation_player.play("NavigateToShopPane")

func move_from_mining_pane_to_central_pane() -> void:
	animation_player.play("NavigateFromMiningPageToCentralHub")

func move_from_shop_pane_to_central_pane() -> void:
	animation_player.play("NavigateFromShopToCentralHub")

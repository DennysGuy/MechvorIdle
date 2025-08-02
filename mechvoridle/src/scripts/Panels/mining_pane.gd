class_name MiningPane extends Control

@onready var animation_player = $AnimationPlayer
@onready var sub_viewport : SubViewport = $ColorRect/SubViewportContainer/SubViewport

func _ready() -> void:
	SignalBus.show_upgrade_panel.connect(show_upgrade_panel)
	SignalBus.hide_upgrade_panel.connect(hide_upgrade_panel)
	#sub_viewport.own_world_3d = false
func _process(_delta : float) -> void:
	pass

func _on_central_hub_navigation_button_up():
	SignalBus.move_to_central_hub_from_mining_page.emit()

func show_upgrade_panel() -> void:
	animation_player.play("ShowUpgradePanel")

func hide_upgrade_panel() -> void:
	animation_player.play("HideAnimationPanel")


func _on_area_2d_mouse_entered():
	print("bafangulo")


func _on_area_2d_mouse_shape_entered(shape_idx):
	print("blingo")

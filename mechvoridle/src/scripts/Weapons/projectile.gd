class_name GridProjectile extends Node3D

@export var damage : int
@export var speed : float = 20
@export var direction : Vector3
@export var tile : Tile
@export var tiles : Node
@export var weapon_origin : MechWeapon
@export var weapon_owner : Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func impact_prjectile(area : Area3D):
	var parent = area.get_parent()
	if area is TargetArea:
		var tile_parent : Tile = parent
		
		if is_instance_valid(weapon_owner) and weapon_owner is GridEnemy and is_instance_valid(tile_parent.occupant) and tile_parent.occupant is GridEnemy:
			return
		
		if tile_parent.occupant and tile_parent.occupant.is_dead:
			return
		
		
		if tile_parent.occupant and tile_parent.occupant != weapon_owner:
			if not is_instance_valid(weapon_owner):
				return
			
			if tile_parent.occupant is SwordBot and not tile_parent.occupant.in_stagger_state:
				var damage_label : GridDamageLabel = preload("uid://w3nvxv0mdub").instantiate()
				damage_label.label.text = "inv."
				damage_label.set_as_invincible()
				damage_label.position = tile_parent.occupant.damage_label_marker.position
				tile_parent.occupant.add_child(damage_label)
				queue_free()
				return
			
			if tile_parent.occupant == GridManager.player:
				var shake_amount : float = 0.0
				if GridManager.player.shield_active:
					GameManager.damage_shield(weapon_origin.damage)
					shake_amount = 0.5
				else:
					shake_amount = 1.2
					
				SignalBus.shake_camera.emit(shake_amount)
					
			if tile_parent.occupant.hit_flash_animation_player:
				tile_parent.occupant.hit_flash_animation_player.play("HitFlash")
			tile_parent.occupant.damage_actor(damage)
			if !weapon_origin.attack_pattern.pass_through:
				queue_free() #will need to also add any sort of tile effects here.
				tile.clear_targeted_overlay()
		
		if tile_parent == tile:
			#tile effect
			queue_free() # well, we might have to do something here.. but if the projectile reaches the destined tile it will queue free
			#weapon_origin.attack_enemy(weapon_owner, tiles)
			tile.clear_targeted_overlay()

class_name DroneCharge extends State 

@export var idle_state : State
@export var fire_state : State
func enter() -> void:
	parent.animation_player.play("idle")
	parent.progress_bar.show()
	print("Hey I'm in charge state")
func exit() -> void:
	parent.progress_bar.value = 0

func process_physics(delta: float) -> State:

	if !GameManager.can_fight_boss:
		if parent.tracked_hostile:
			parent.sprite_2d.look_at(parent.tracked_hostile.position)
			
			parent.progress_bar.value += parent.speed
			if parent.progress_bar.value >= parent.progress_bar.max_value:
				return fire_state
			
		else:
			return idle_state
	return null

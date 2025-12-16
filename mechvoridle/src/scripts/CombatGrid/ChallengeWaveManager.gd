extends Node

'''

DYNAMIC ARRAY ***THE WINNER OF THE DEC 2025 SOLUTION AWARD FOR TARGET CHALLENGE MODE THAT MIGHT NOT EVEN BE FUN!***

a dynamic array can work in a similar way to a doubly linked list.. in fact it might 
be just as fast as a linked list.

Solution:

We will assign targets a reference number. That reference number will then be paired with an index position in an array.
We will store a reference to the targets in the array in order (based on the reference number they are assigned).

All we need to do is check if the target that was destroyed holds its reference that matches the target's reference at 
pos 0. If so, we will delete the reference at POS 0 and the round continues.

If the target destroyed is not at pos 0, then we end the round and lose that round (move on to next).

Finally, win condition: if a target is being destroyed and the size of the list is '1' then we will consider this a win..
incrment the current_win_count variable and compare if the player has achieved the threshold (already made)
We will destroy the last target and move on to the next round

This will happen until the timer goes off. (Clear the existing targets and play outro animation)

There will not be lives here as success or fail is based off of completion. 

Winning and moving on to the next round will restock the target array and reshuffle the grid positions of each target being created
we will then take the newly created array and add the target objects to the scene (all targets must come down at the same time so that order isn't known before shown)

'''

var wave_time : int = 15
const MAX_CHANCES : int = 3
var chances_left : int = 3

var in_challenge_wave : bool = false
var challenge_mode_won : bool = false
var win_threshold_count : int = 0
var current_count : int = 0
var can_spawn_targets : bool = false
var target_list : Array[ChallengeTarget] = []

const CHALLENGE_CHEST = preload("uid://mutb6sqjaftb")

@warning_ignore("unused_signal")
signal start_challenge

@warning_ignore("unused_signal")
signal end_challenge

@warning_ignore("unused_signal")
signal spawn_challenge_targets

@warning_ignore("unused_signal")
signal reveal_target_order

@warning_ignore("unused_signal")
signal clear_targets

func _ready() -> void:
	challenge_mode_won = false
	in_challenge_wave = false

func increment_win_threshold() -> void:
	current_count += 1
	if current_count >= win_threshold_count:
		challenge_mode_won = true
	SignalBus.update_current_challenge_count.emit()

func decrement_chances() -> void:
	chances_left -= 1
	SignalBus.update_chances_left.emit()

func reset_wave_details() -> void:
	in_challenge_wave = false
	challenge_mode_won = false
	win_threshold_count = 0
	current_count = 0

func start_challenge_wave() -> void:
	in_challenge_wave = true

func end_challenge_wave() -> void:
	in_challenge_wave = false

var challenge_chests : Dictionary = {
	1:	
		{
			"enemy": CHALLENGE_CHEST.duplicate(true),
			"coordinates": Vector2(0,3),
			"is_slave": false,
			"is_boss": false,
			"level" : 1
		}	
	,
	2: 
		{
			"enemy": CHALLENGE_CHEST.duplicate(true),
			"coordinates": Vector2(0,3),
			"is_slave": false,
			"is_boss": false,
			"level" : 2
		}
}
var hit_pitch : float = 1.0
func check_order(index : int) -> void:
	if target_list.is_empty():
		return
	
	if target_list.size() == 1:
		increment_win_threshold()
		SfxManager.play_sfx(SfxManager.ROUND_WON)
		spawn_challenge_targets.emit()
		hit_pitch = 1.0
	else:
		if is_instance_valid(target_list.get(0)) and target_list.get(0).order_index == index:
			target_list.remove_at(0)
			SfxManager.play_sfx(SfxManager.PERFECT_SHIELD_BLOCK,0,false,hit_pitch)
			hit_pitch += 0.2
		else:
			SfxManager.play_sfx(SfxManager.ROUND_FAILED)
			clear_targets.emit()
			spawn_challenge_targets.emit()
			hit_pitch = 1.0

func create_target_list() -> void:
	var random_int : int = randi_range(1,4)
	var random_direction_list : Array = target_positions.get(random_int)
	target_list.clear()
	
	var i :int = 0
	for position in random_direction_list:
		var challenge_target : ChallengeTarget = preload("uid://bmiwjkdgt0q3s").instantiate()
		challenge_target.spawn_coordinates = position 
		challenge_target.order_index = i
		target_list.append(challenge_target)
		i+=1
	
var target_positions : Dictionary = {
	1: [Vector2(1,0),Vector2(1,1),Vector2(1,2),Vector2(1,3)],
	2: [Vector2(1,1),Vector2(1,0),Vector2(1,3),Vector2(1,2)],
	3: [Vector2(1,2),Vector2(1,3),Vector2(1,1),Vector2(1,0)],
	4: [Vector2(1,3),Vector2(1,2),Vector2(1,0),Vector2(1,1)]
}

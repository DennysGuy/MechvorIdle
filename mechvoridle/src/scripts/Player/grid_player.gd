class_name GridPlayer extends GridActor

@onready var animation_player: AnimationPlayer = $blockbench_export/AnimationPlayer
@onready var vlucan_1: Marker3D = $Vlucan1
@onready var vlucan_2: Marker3D = $Vlucan2

@onready var rifle_2_spout: Marker3D = $Rifle2Spout

@onready var mech_part_names : Array[String] = ["Head", "Torso", "Legs", "Arms"]
@onready var timer: Timer = $Timer

@onready var melee_head: Node3D = $blockbench_export/UpperBody/Head/MeleeHead
@onready var ranged_head: Node3D = $blockbench_export/UpperBody/Head/RangedHead
@onready var light_torso: Node3D = $blockbench_export/UpperBody/Torso/LightTorso
@onready var heavy_torso: Node3D = $blockbench_export/UpperBody/Torso/HeavyTorso
@onready var standard_torso: Node3D = $blockbench_export/UpperBody/Torso/StandardTorso

@onready var melee_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/MeleeHand
@onready var ranged_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/RangedHand


@onready var melee_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/MeleeForeArm
@onready var ranged_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/RangedForeArm
@onready var melee_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/MeleeBicep
@onready var ranged_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/RangedBicep
@onready var melee_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/MeleeShoulder
@onready var ranged_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/RangedShoulder
@onready var melee_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/MeleeHand2
@onready var ranged_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/RangedHand2


@onready var melee_back_guard_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/MeleeBackGuard2
@onready var ranged_back_guard_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/RangedBackGuard2
@onready var melee_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/MeleeBicep2
@onready var ranged_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/RangedBicep2
@onready var melee_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/MeleeShoulder2
@onready var ranged_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/RangedShoulder2
@onready var light_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/LightKneeBrace
@onready var standard_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/StandardKneeBrace
@onready var heavy_knee_brace: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/KneeGuard/HeavyKneeBrace
@onready var light_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/LightFoot
@onready var standard_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/StandardFoot
@onready var heavy_foot: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/Foot/HeavyFoot
@onready var light_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/LightLowerLegGuard
@onready var heavy_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/HeavyLowerLegGuard
@onready var standard_lower_leg_guard: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/Calf/StandardLowerLegGuard
@onready var light_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/LightUpperLeg
@onready var standard_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/StandardUpperLeg
@onready var heavy_upper_leg: Node3D = $blockbench_export/LowerBody/Leg/UpperLeg/HeavyUpperLeg
@onready var light_knee_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/LightKneeBrace2
@onready var standard_knee_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/StandardKneeBrace2
@onready var heavy_brace_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/KneeGuard2/HeavyBrace2
@onready var light_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/LightFoot2
@onready var standard_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/StandardFoot2
@onready var heavy_foot_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/Foot2/HeavyFoot2
@onready var light_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/LightCalf2
@onready var standard_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/StandardCalf2
@onready var heavy_calf_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/Calf2/HeavyCalf2
@onready var light_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/LightUpperLeg2
@onready var standard_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/StandardUpperLeg2
@onready var heavy_upper_leg_2: Node3D = $blockbench_export/LowerBody/Leg2/UpperLeg2/HeavyUpperLeg2


### WEAPONS ###
@onready var rocket_launcher_left_side: Node3D = $blockbench_export/UpperBody/Torso/RocketLauncherLeftSide
@onready var rocket_launcher_right_side: Node3D = $blockbench_export/UpperBody/Torso/RocketLauncherRightSide

@onready var standard_sword_left_side: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/StandardSwordLeftSide
@onready var standard_sword_right_side: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/StandardSwordRightSide

@onready var rifle_right_side: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/RifleRightSide
@onready var rifle_left_side: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/RifleLeftSide

var scanned_attack_pattern : Array

@onready var mech_components : Dictionary = {
	"Head": {
		#melee head
		0: [melee_head],
		#ranged head
		1: [ranged_head]
	},
	"Torso": {
		#light torso
		0: [light_torso],
		#standard torso
		1: [standard_torso],
		#heavy torso
		2: [heavy_torso]
	},
	"Arms": {
		#melee arms
		0: [melee_hand, 
			melee_fore_arm, 
			melee_bicep, 
			melee_shoulder, 
			melee_hand_2, 
			melee_back_guard_2, 
			melee_shoulder_2, 
			melee_bicep_2
		],
		#ranged arms
		1: [ranged_hand,
			ranged_fore_arm,
			ranged_bicep, 
			ranged_shoulder, 
			ranged_shoulder_2,
			ranged_hand_2,
			ranged_back_guard_2,
			ranged_bicep_2
		]
	},
	"Legs": {
		#melee legs
		0 : [
			light_knee_brace,
			light_foot,
			light_lower_leg_guard,
			light_upper_leg,
			light_upper_leg_2,
			light_knee_brace_2,
			
			light_foot_2,
			light_calf_2,
		],
		#standard legs
		1: [
			standard_knee_brace,
			standard_foot,
			standard_lower_leg_guard,
			standard_upper_leg,
			standard_knee_brace_2,
			standard_foot_2,
			standard_calf_2,
			standard_upper_leg_2
		],
		#heavy legs
		2: [
			heavy_knee_brace,
			heavy_foot,
			heavy_lower_leg_guard,
			heavy_upper_leg,
			heavy_brace_2,
			heavy_foot_2,
			heavy_calf_2,
			heavy_upper_leg_2
		]
		
	}
}


@onready var mech_weapons : Dictionary = {
	"LeftWeapon": {
		#sword
		0: standard_sword_left_side,
		#rifle
		1: rifle_left_side,
		#rocket launcher
		2: rocket_launcher_left_side
	},
	"RightWeapon": {
		#sword
		0: standard_sword_right_side,
		#rifle
		1: rifle_right_side,
		#rocket launcher
		2: rocket_launcher_right_side
	}
}



var mech_vulcan : MechWeapon = preload("uid://kcrfevws33d7")
var can_shoot : bool = true
var can_fire_vulcans : bool = true
var firing : bool = false



var true_wait_time : float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	GridManager.set_mech_as_light()
	SignalBus.apply_timer_consequences.connect(apply_time_consequences)
	true_wait_time = WAIT_TIME + GameManager.get_owned_mech_legs().movement_speed_modifier
	
	max_health = GameManager.calculate_current_total_health()
	health = max_health
	
	enable_mech_parts()
	enable_mech_weapons()
	state_machine.init(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left") and can_move:
		SignalBus.move_player.emit(Vector2.UP, false)
		can_move = false
		await get_tree().create_timer(true_wait_time).timeout
		can_move = true
		GridManager.clear_targeted_tiles()
		
	if Input.is_action_pressed("move_right") and can_move:
		SignalBus.move_player.emit(Vector2.DOWN, false)
		can_move = false
		await get_tree().create_timer(true_wait_time).timeout
		can_move = true
		GridManager.clear_targeted_tiles()
	
	#if Input.is_action_pressed("move_up") and can_move:
		#SignalBus.move_player.emit(Vector2.LEFT, false)
		#can_move = false
		#await get_tree().create_timer(true_wait_time).timeout
		#can_move = true
	#
	#if Input.is_action_pressed("move_down") and can_move:
		#SignalBus.move_player.emit(Vector2.RIGHT, false)
		#can_move = false
		#await get_tree().create_timer(true_wait_time).timeout
		#can_move = true

	if Input.is_action_pressed("fire_vulcans") and not firing and can_fire_vulcans:
		firing = true
		add_vulcan_flares()
		mech_vulcan.attack_enemy(self,tiles,[],true)
		await get_tree().create_timer(0.1).timeout
		for flare in get_tree().get_nodes_in_group("VulcanFlares"):
			flare.queue_free()
		await get_tree().create_timer(0.1).timeout
		firing = false
		
	if Input.is_action_just_released("fire_vulcans") and firing and can_fire_vulcans:
		for flare in get_tree().get_nodes_in_group("VulcanFlares"):
			flare.queue_free()
			
		GridManager.clear_targeted_tiles()
	

	
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func enable_mech_parts() -> void:
	for part in mech_components:
		var selected_part_index : int = GameManager.owned_mech_components[part].index
		var visuals : Array = mech_components[part][selected_part_index]
		for visual in visuals:
			visual.show()

func enable_mech_weapons() -> void:
	var left_weapon : MechWeapon = GameManager.get_left_weapon()
	var right_weapon : MechWeapon = GameManager.get_right_weapon()
	
	var equipped_left_weapon = mech_weapons["LeftWeapon"][left_weapon.index]
	var equipped_right_weapon = mech_weapons["RightWeapon"][right_weapon.index]
	
	equipped_left_weapon.show()
	equipped_right_weapon.show()

func add_vulcan_flares() -> void:
	var muzzle_flare_1 = preload("uid://6wqyu6m4rjr5").instantiate()
	var muzzle_flare_2 = preload("uid://6wqyu6m4rjr5").instantiate()
	
	muzzle_flare_1.position = vlucan_1.position
	muzzle_flare_2.position = vlucan_2.position
	
	add_child(muzzle_flare_1)
	add_child(muzzle_flare_2)

func fire_rifle_2() -> void:
	var rifle_2 : MechWeapon = GameManager.get_left_weapon()
	fire_projectile(rifle_2, rifle_2_spout)

func apply_time_consequences() -> void:
	damage_actor(int(health * 0.3))

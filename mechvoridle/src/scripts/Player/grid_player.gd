class_name GridPlayer extends GridActor

@onready var animation_player: AnimationPlayer = $blockbench_export/AnimationPlayer
@onready var vlucan_1: Marker3D = $Vlucan1
@onready var vlucan_2: Marker3D = $Vlucan2
@onready var shield_cool_down_timer: Timer = $ShieldCoolDownTimer

@onready var rifle_1_spout: Marker3D = $Rifle1Spout
@onready var rifle_2_spout: Marker3D = $Rifle2Spout

@onready var laser_sight_right: CSGCylinder3D = $LaserSightRight
@onready var laser_sight_left: CSGCylinder3D = $LaserSightLeft

@onready var mech_part_names : Array[String] = ["Head", "Torso", "Legs", "Arms"]
@onready var timer: Timer = $Timer

@onready var melee_head: Node3D = $blockbench_export/UpperBody/Head/MeleeHead
@onready var ranged_head: Node3D = $blockbench_export/UpperBody/Head/RangedHead
@onready var standard_head: Node3D = $blockbench_export/UpperBody/Head/StandardHead


@onready var light_torso: Node3D = $blockbench_export/UpperBody/Torso/LightTorso
@onready var heavy_torso: Node3D = $blockbench_export/UpperBody/Torso/HeavyTorso
@onready var standard_torso: Node3D = $blockbench_export/UpperBody/Torso/StandardTorso

@onready var melee_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/MeleeHand
@onready var ranged_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/RangedHand
@onready var standard_hand: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/StandardHand

@onready var melee_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/MeleeForeArm
@onready var ranged_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/RangedForeArm
@onready var standard_fore_arm: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/StandardForeArm


@onready var melee_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/MeleeBicep
@onready var ranged_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/RangedBicep
@onready var standard_bicep: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/StandardBicep


@onready var melee_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/MeleeShoulder
@onready var ranged_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/RangedShoulder
@onready var standard_shoulder: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/StandardShoulder


@onready var melee_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/MeleeHand2
@onready var ranged_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/RangedHand2
@onready var standard_hand_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/StandardHand2

@onready var melee_back_guard_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/MeleeBackGuard2
@onready var ranged_back_guard_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/RangedBackGuard2
@onready var standard_fore_arm_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/StandardForeArm2

@onready var melee_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/MeleeBicep2
@onready var ranged_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/RangedBicep2
@onready var standard_bicep_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/StandardBicep2

@onready var melee_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/MeleeShoulder2
@onready var ranged_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/RangedShoulder2
@onready var standard_shoulder_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/StandardShoulder2

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

@onready var thy_kingdom_come_left_side: Node3D = $blockbench_export/UpperBody/Torso/ThyKingdomComeLeftSide
@onready var thy_kingdom_come_right_side: Node3D = $blockbench_export/UpperBody/Torso/ThyKingdomComeRightSide

@onready var soulder_rocket_left: Node3D = $blockbench_export/UpperBody/Torso/SoulderRocketLeft
@onready var soulder_rocket_right: Node3D = $blockbench_export/UpperBody/Torso/SoulderRocketRight

@onready var arm_rocket_launcher: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/ArmRocketLauncher
@onready var arm_rocket_launcher_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/ArmRocketLauncher2

@onready var katanna: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/Katanna
@onready var katanna_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/Katanna2

@onready var heat_sword: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/HeatSword
@onready var heat_sword_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/HeatSword2

@onready var spear: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/Spear
@onready var spear_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/Spear2

@onready var sub_machine_gun: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/SubMachineGun
@onready var sub_machine_gun_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/SubMachineGun2

@onready var rifle: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/Rifle
@onready var rifle_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/Rifle2

@onready var sniper_rifle: Node3D = $blockbench_export/UpperBody/Arm1/Shoulder/Bicep/ForeArm/Hand/SniperRifle
@onready var sniper_rifle_2: Node3D = $blockbench_export/UpperBody/Arm2/Shoulder2/Bicep2/ForeArm2/Hand2/SniperRifle2

@onready var counter_guard_shine: MeshInstance3D = $CounterGuardShine
@onready var shine_material := counter_guard_shine.get_active_material(0)

var shield_disabled : bool = false

var shine_value := 0.0
const SHINE_DECAY := 3.0

var scanned_attack_pattern : Array
var current_weapon_scanning : MechWeapon

var can_use_shield : bool = true

var regen_started : bool = false

var target_location : Marker3D
var rotate_speed: float = 10.0  # higher = faster turn
var initial_player_rotation = Vector3.ZERO
var initial_head_rotation = Vector3.ZERO

@onready var delay_timer: Timer = $DelayTimer
@onready var charge_up_timer: Timer = $ChargeUpTimer

@onready var mech_components : Dictionary = {
	"Head": {
		#melee head
		0: [melee_head],
		#standard head
		1: [standard_head],
		#ranged head
		2: [ranged_head]
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
		1: [standard_hand,
			standard_fore_arm,
			standard_bicep, 
			standard_shoulder, 
			standard_shoulder_2,
			standard_hand_2,
			standard_fore_arm_2,
			standard_bicep_2
		],
		2: [ranged_hand,
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
		"Sword": [
			katanna_2,
			#sword_2
			heat_sword_2,
			#sword_3
			spear_2,	
		],
		"Rifle": [
			#rifle_1
			rifle_2,
			#rifle_2,
			sub_machine_gun_2,
			#rifle_3
			sniper_rifle_2,
		],
		"RocketLauncher": [
			#rocket_1
			soulder_rocket_left,
			#rocket_2
			arm_rocket_launcher_2,
			#rocket_3
			thy_kingdom_come_left_side
		]
	},
	"RightWeapon": {
		"Sword": [
			#sword_1
			katanna,
			#sword_2
			heat_sword,
			#sword_3
			spear
		],
		"Rifle": [
			#rifle_1
			rifle,
			#rifle_2
			sub_machine_gun,
			#rifle_3
			sniper_rifle,	
		],
		"RocketLauncher" : [
			#launcher_1
			soulder_rocket_right,
			#launcher_2
			arm_rocket_launcher,
			#launcher_3
			thy_kingdom_come_right_side
		]
	}
}

#weapon states
@onready var wide_sword_aim_right: WideSwordAimRight = $StateMachine/WideSwordAimRight
@onready var wide_sword_swing_right: WideSwordSwingRight = $StateMachine/WideSwordSwingRight
@onready var wide_sword_aim_left: WideSwordAimLeft = $StateMachine/WideSwordAimLeft
@onready var wide_sword_swing_left: WideSwordFireLeft = $StateMachine/WideSwordSwingLeft


@onready var rifle_aim_left: RifleAimLeft = $StateMachine/RifleAimLeft
@onready var rifle_fire_left: RifleFireLeft = $StateMachine/RifleFireLeft
@onready var rifle_aim_right: RifleAimRight = $StateMachine/RifleAimRight
@onready var rifle_fire_right: RifleFireRight = $StateMachine/RifleFireRight


@onready var sub_machine_gun_aim_left: SubMachineGunAimLeft = $StateMachine/SubMachineGunAimLeft
@onready var sub_machine_gun_fire_left: SubMachineGunFireLeft = $StateMachine/SubMachineGunFireLeft
@onready var sub_machine_gun_aim_right: SubMachineGunAimRight = $StateMachine/SubMachineGunAimRight
@onready var sub_machine_gun_fire_right: SubMachineGunFireRight = $StateMachine/SubMachineGunFireRight

@onready var sniper_rifle_aim_right: SniperRifleAimRight = $StateMachine/SniperRifleAimRight
@onready var sniper_rifle_fire_right: SniperRifleFireRight = $StateMachine/SniperRifleFireRight
@onready var sniper_rifle_aim_left: SniperRifleAimLeft = $StateMachine/SniperRifleAimLeft
@onready var sniper_rifle_fire_left: SniperRifleFireLeft = $StateMachine/SniperRifleFireLeft


@export var arm_rocket_aim: ArmRocketAim
@export var arm_rocket_fire: ArmRocketFire

@onready var left_weapon_states = {
	"Sword" : {
		0 : {
			"Aim": wide_sword_aim_left,
			"Fire": wide_sword_swing_left
		}
	},
	"Rifle":  {
		0 : {
			"Aim": rifle_aim_left,
			"Fire": rifle_fire_left
		},
		1 : {
			"Aim": sub_machine_gun_aim_left,
			"Fire": sub_machine_gun_fire_left
		},
		2 : {
			"Aim": sniper_rifle_aim_left,
			"Fire": sniper_rifle_fire_left
		}
	}
}

@onready var right_weapon_states = {
	"Sword" : {
		0 : {
			"Aim": wide_sword_aim_right,
			"Fire": wide_sword_swing_right
		}
	},
	"Rifle":  {
		0 : {
			"Aim": rifle_aim_right,
			"Fire": rifle_fire_right
		},
		1 : {
			"Aim": sub_machine_gun_aim_right,
			"Fire": sub_machine_gun_fire_right
		},
		2 : {
			"Aim": sniper_rifle_aim_right,
			"Fire": sniper_rifle_fire_right
		}
	}
}

var mech_vulcan : MechWeapon = preload("uid://kcrfevws33d7")
var can_shoot : bool = true
var can_fire_vulcans : bool = true
var shield_active : bool = false
var firing : bool = false
var rifle_charged_up : bool = false
var start_shield_cool_down : bool = false

@onready var shield_bonus_timer: Timer = $ShieldBonusTimer
@onready var shield: Shield = $Shield
@onready var idle: GridPlayerIdle = $StateMachine/Idle

var true_wait_time : float = 0
var shield_bonus_time : float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridManager.set_mech_as_light()
	SignalBus.apply_timer_consequences.connect(apply_time_consequences)
	SignalBus.set_move_speed_to_od.connect(set_move_speed_to_od_speed)
	SignalBus.revert_move_speed_to_norm.connect(revert_move_speed_to_normal)
	
	true_wait_time = WAIT_TIME + GameManager.get_owned_mech_legs().movement_speed_modifier
	can_move = false
	max_health = 500
	health = max_health
	
	initial_player_rotation = rotation
	initial_head_rotation = rotation
	
	enable_mech_parts()
	enable_mech_weapons()
	state_machine.init(self)

@onready var shield_hum: AudioStreamPlayer = $ShieldHum

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_move:
		if Input.is_action_pressed("move_left"):
			SignalBus.shake_camera.emit(0.2)
			SfxManager.play_sfx(SfxManager.get_player_step())
			SignalBus.move_player.emit(Vector2.UP, false)
			can_move = false
			
			var movement_time := true_wait_time + GameManager.movement_speed_affix
			
			await get_tree().create_timer(movement_time).timeout
			can_move = true
			GridManager.clear_targeted_tiles()
			
		if Input.is_action_pressed("move_right"):
			SignalBus.shake_camera.emit(0.2)
			SfxManager.play_sfx(SfxManager.get_player_step())
			SignalBus.move_player.emit(Vector2.DOWN, false)
			can_move = false
			
			var movement_time := true_wait_time + GameManager.movement_speed_affix
			
			await get_tree().create_timer(movement_time).timeout
			
			can_move = true
			GridManager.clear_targeted_tiles()
	
		if Input.is_action_pressed("fire_vulcans") and not firing and can_fire_vulcans:
			firing = true
			SignalBus.shake_camera.emit(0.1)
			SfxManager.play_sfx(SfxManager.get_vulcan_shot(), -4, false)
		
			add_vulcan_flares()
			mech_vulcan.attack_enemy(self,tiles,[],true)
			
			await get_tree().create_timer(GameManager.vulcan_damage_interval).timeout
			for flare in get_tree().get_nodes_in_group("VulcanFlares"):
				flare.queue_free()
			
			SignalBus.shake_camera.emit(0.1)
			SfxManager.play_sfx(SfxManager.get_vulcan_shot(), -4, false)
			await get_tree().create_timer(0.1).timeout
			firing = false

		elif Input.is_action_just_released("fire_vulcans") and firing and can_fire_vulcans:
			for flare in get_tree().get_nodes_in_group("VulcanFlares"):
				flare.queue_free()

			GridManager.clear_targeted_tiles()

		else:
			if !GameManager.over_heated and GameManager.current_heat_contained > 0:
				if GameManager.in_overdrive_mode:
					GameManager.current_heat_contained -= 3 * delta + GameManager.overdrive_heat_reduction_affix
				else:
					GameManager.current_heat_contained -= 3 * delta
				SignalBus.update_heat_level.emit()
		
		if Input.is_action_just_pressed("activate_shield") and !shield_disabled:
			SfxManager.play_sfx(SfxManager.COUNTER_GUARD,3)
			trigger_shine()
			
			#if Input.is_action_pressed("activate_shield") and can_use_shield:
	#
				#if !shield_hum.playing:
					#shield_hum.play()
				#
				#shield_bonus_time -= delta
				#if shield_bonus_time < 0:
					#shield_bonus_time = 0
				#
				#start_shield_cool_down = false
				#regen_started = false
				#shield_active = true
				#shield.show()
			#else:
				#if shield_hum.playing:
					#shield_hum.stop()
				#
				#shield_bonus_time = 1.0
				#shield_active = false
				#shield.hide()
			#
		if GameManager.current_shield_amount < GameManager.shield_amount:
			if not start_shield_cool_down:
				regen_started = true
				if can_use_shield:
					shield_cool_down_timer.wait_time = 3.0
				else:
					shield_cool_down_timer.wait_time = 5.4
				shield_cool_down_timer.start()
				start_shield_cool_down = true
				
		if shine_value <= 0.5:
			can_use_shield = true
		else:
			can_use_shield = false
			
	state_machine.process_frame(delta)

func trigger_shine() -> void:
	
	if !can_use_shield:
		return
	
	shine_value = 0.0
	shine_material.set_shader_parameter("shine_strength", 0.0)
	shine_value = 1.3
	shine_material.set_shader_parameter("shine_strength", 1.0)
	
	if start_shield_cool_down:
		if can_use_shield:
			shield_cool_down_timer.wait_time = 3.0
		start_shield_cool_down = false


func set_move_speed_to_od_speed() -> void:
	true_wait_time = WAIT_TIME + GameManager.get_owned_mech_legs().movement_speed_modifier - GameManager.overdrive_movement_speed_bonus

func revert_move_speed_to_normal() -> void:
	true_wait_time = WAIT_TIME + GameManager.get_owned_mech_legs().movement_speed_modifier

func _physics_process(delta: float) -> void:
	shine_value = max(shine_value - SHINE_DECAY * delta, 0.0)
	shine_material.set_shader_parameter("shine_strength", shine_value)
	
	rotate_player(delta)
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
	
	var equipped_left_weapon = mech_weapons["LeftWeapon"][left_weapon.get_weapon_class()][left_weapon.shop_index]
	var equipped_right_weapon = mech_weapons["RightWeapon"][right_weapon.get_weapon_class()][right_weapon.shop_index]
	
	init_weapon_states()
	
	equipped_left_weapon.show()
	equipped_right_weapon.show()

func add_vulcan_flares() -> void:
	var muzzle_flare_1 = preload("uid://6wqyu6m4rjr5").instantiate()
	var muzzle_flare_2 = preload("uid://6wqyu6m4rjr5").instantiate()
	
	muzzle_flare_1.position = vlucan_1.position
	muzzle_flare_2.position = vlucan_2.position
	
	add_child(muzzle_flare_1)
	add_child(muzzle_flare_2)

var locked_on_tile : Tile
		
func apply_time_consequences() -> void:
	if !GameManager.fight_on:
		damage_actor(int(health * 0.3))


func _on_shield_cool_down_timer_timeout() -> void:
	#start_shield_cool_down = false
	SignalBus.refil_shield_gauge.emit()
	
func init_weapon_states() -> void:
	var aim_state_right : WeaponState =  right_weapon_states[GameManager.get_right_weapon().get_weapon_class()][GameManager.get_right_weapon().shop_index]["Aim"]
	var fire_state_right : WeaponState = right_weapon_states[GameManager.get_right_weapon().get_weapon_class()][GameManager.get_right_weapon().shop_index]["Fire"]
	aim_state_right.set_position_as_right()
	aim_state_right.input_map = "mine_asteroid"
	fire_state_right.set_position_as_right()

	idle.weapon_1_aim = aim_state_right
	
	var aim_state_left : WeaponState =  left_weapon_states[GameManager.get_left_weapon().get_weapon_class()][GameManager.get_left_weapon().shop_index]["Aim"]
	var fire_state_left : WeaponState = left_weapon_states[GameManager.get_left_weapon().get_weapon_class()][GameManager.get_left_weapon().shop_index]["Fire"]
	aim_state_left.set_position_as_left()
	aim_state_left.input_map = "set_drone_destination"
	fire_state_left.set_position_as_left()
	
	idle.weapon_2_aim = aim_state_left

@onready var player_model: Node3D = $blockbench_export


func rotate_player(delta: float) -> void:
	if target_location:
		var target_pos = target_location.global_transform.origin
		var my_pos = global_transform.origin

		var to_target = target_pos - my_pos
		to_target.y = 0.0  # keep rotation on the horizontal plane

		# Correct yaw for Godot (facing -Z forward)
		var target_yaw = atan2(-to_target.x, -to_target.z)

		rotation.y = lerp_angle(rotation.y, target_yaw, delta * rotate_speed)

	else:
		rotation.y = lerp_angle(rotation.y, initial_player_rotation.y, delta * rotate_speed)



		

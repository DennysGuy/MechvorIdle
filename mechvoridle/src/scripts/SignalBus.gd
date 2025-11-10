extends Node

#navigation signals
@warning_ignore("unused_signal")
signal move_to_mining_pane
@warning_ignore("unused_signal")
signal move_to_shop_pane
@warning_ignore("unused_signal")
signal move_to_central_hub_from_mining_page
@warning_ignore("unused_signal")
signal move_to_central_hub_from_shop_pane
@warning_ignore("unused_signal")
signal start_fight
@warning_ignore("unused_signal")
signal stop_fight
@warning_ignore("unused_signal")
signal begin_round
@warning_ignore("unused_signal")
signal stop_ufo_spawn
@warning_ignore("unused_signal")
signal fade_out_alert
@warning_ignore("unused_signal")
signal issue_drone_down_alert
@warning_ignore("unused_signal")
signal show_specified_boss(index : int)
@warning_ignore("unused_signal")
signal fade_out_music
@warning_ignore("unused_signal")
signal remove_ufo_during_start_fight

@warning_ignore("unused_signal")
signal show_part(body_part : String, category : String)
@warning_ignore("unused_signal")
signal show_weapon(weapon_type : String, category : String, side : String)
@warning_ignore("unused_signal")
signal show_part_preview(component : MechComponent)
@warning_ignore("unused_signal")
signal update_parts_owned_on_previewer

@warning_ignore("unused_signal")
signal show_task_completed_indicator(index : int)
@warning_ignore("unused_signal")
signal show_check_list
@warning_ignore("unused_signal")
signal hide_check_list
@warning_ignore("unused_signal")
signal increment_phase_mission_completed_count

#settings panel
@warning_ignore("unused_signal")
signal show_audio_settings
@warning_ignore("unused_signal")
signal hide_audio_settings

#mining panel signals
@warning_ignore("unused_signal")
signal update_ferrite_count
@warning_ignore("unused_signal")
signal update_ferrite_bars_count
@warning_ignore("unused_signal")
signal update_platinum_count
@warning_ignore("unused_signal")
signal show_upgrade_panel
@warning_ignore("unused_signal")
signal hide_upgrade_panel
@warning_ignore("unused_signal")
signal add_drone(current_asteroid_scene)
@warning_ignore("unused_signal")
signal add_platinum_drone(current_asteroid_scene)
@warning_ignore("unused_signal")
signal add_turret_drone(current_asteroid_scene)
@warning_ignore("unused_signal")
signal update_plasma_count
@warning_ignore("unused_signal")
signal update_plasma_generator_speed
@warning_ignore("unused_signal")
signal update_fuel_consumption
@warning_ignore("unused_signal")
signal update_plasma_generator_output
@warning_ignore("unused_signal")
signal update_drone_cost
@warning_ignore("unused_signal")
signal update_drone_count
@warning_ignore("unused_signal")
signal update_platinum_drone_cost
@warning_ignore("unused_signal")
signal update_platinum_drone_count
@warning_ignore("unused_signal")
signal check_to_start_ufo_spawn
@warning_ignore("unused_signal")
signal play_ufo_escaped
@warning_ignore("unused_signal")
signal sound_ship_alarm
@warning_ignore("unused_signal")
signal silence_ship_alarm
@warning_ignore("unused_signal")
signal deselect_drone
@warning_ignore("unused_signal")
signal move_drone(selected_drone, drone_position : Vector2)
@warning_ignore("unused_signal")
signal clear_tracked_hostile(hostile)

@warning_ignore("unused_signal")
signal update_health_regen_time
@warning_ignore("unused_signal")
signal update_max_health

@warning_ignore("unused_signal")
signal update_mining_laser_speed
@warning_ignore("unused_signal")
signal update_owned_drones_count

@warning_ignore("unused_signal")
signal update_turret_drone_damage
@warning_ignore("unused_signal")
signal update_turret_drone_speed
@warning_ignore("unused_signal")
signal update_turret_drone_range


@warning_ignore("unused_signal")
signal update_drone_max_health
@warning_ignore("unused_signal")
signal update_drone_regen_time
@warning_ignore("unused_signal")
signal update_drone_regen_amount
@warning_ignore("unused_signal")
signal update_max_owned_drones

#drone details panel
@warning_ignore("unused_signal")
signal hide_drone_details
@warning_ignore("unused_signal")
signal show_drone_details(selected_drone)
@warning_ignore("unused_signal")
signal update_drone_details_while_selected(drone)
@warning_ignore("unused_signal")
signal heal_drone(selected_drone)
@warning_ignore("unused_signal")
signal clear_drone_details(selected_drone)
@warning_ignore("unused_signal")
signal update_drone_health_label(selected_drone)

#shop panel signals
@warning_ignore("unused_signal")
signal transfer_item_to_shop_panel(component : MechComponent)
@warning_ignore("unused_signal")
signal update_stats_panel(component : MechComponent)
@warning_ignore("unused_signal")
signal update_list_item_text(component_name : String)

#drone shop
@warning_ignore("unused_signal")
signal show_drone_panel

#main panel
@warning_ignore("unused_signal")
signal unlock_fight_button

#combat
@warning_ignore("unused_signal")
signal win_game #execute win procedure and go to win panel
@warning_ignore("unused_signal")
signal lose_game #execute loss procedure and go to lose panel
@warning_ignore("unused_signal")
signal update_player_health_bar
@warning_ignore("unused_signal")
signal update_opponent_health_bar
@warning_ignore("unused_signal")
signal fill_bar_on_start_up
@warning_ignore("unused_signal")
signal shake_camera(value : int)

#mission

@warning_ignore("unused_signal")
signal add_to_mission_counter(amount : int, unique_mission_identifier : int)
@warning_ignore("unused_signal")
signal add_to_submission_counter(amount : int, unique_mission_identifier : int)
@warning_ignore("unused_signal")
signal increment_mission_completed_counted
@warning_ignore("unused_signal")
signal show_mission_tracker_panel
@warning_ignore("unused_signal")
signal hide_mission_tracker_panel
@warning_ignore("unused_signal")
signal issue_mission_complete_notification
@warning_ignore("unused_signal")
signal issue_phase_compolete_notification


#mech stats panel
@warning_ignore("unused_signal")
signal update_mech_head_name(mech_head : MechHead)
@warning_ignore("unused_signal")
signal update_mech_torso_name(mech_torso : MechTorso)
@warning_ignore("unused_signal")
signal update_mech_arms_name(mech_arms : MechArms)
@warning_ignore("unused_signal")
signal update_mech_legs_name(mech_legs : MechLegs)
@warning_ignore("unused_signal")
signal update_mech_weapon_one_name(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_mech_weapon_two_name(mech_weapon : MechWeapon)

@warning_ignore("unused_signal")
signal update_total_armor_amount

@warning_ignore("unused_signal")
signal update_crit_stats_on_mech_head_purchased(mech_head : MechHead)
@warning_ignore("unused_signal")
signal update_accuracy_stats_on_mech_head_purchased(mech_head : MechHead)
@warning_ignore("unused_signal")
signal update_charge_speed_stats_on_mech_torso_purchased(mech_torso : MechTorso)
@warning_ignore("unused_signal")
signal update_crit_damage_stats_on_mech_arms_purchased(mech_arms : MechArms)
@warning_ignore("unused_signal")
signal update_max_hit_stats_on_mech_arms_purchased(mech_arms : MechArms)
@warning_ignore("unused_signal")
signal update_dodge_stats_on_mech_legs_purchased(mech_legs : MechLegs)
@warning_ignore("unused_signal")
signal update_stun_stats_on_mech_legs_purchased(mech_legs : MechLegs)


@warning_ignore("unused_signal")
signal update_weapon_1_name_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_1_crit_chance_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_1_charge_speed_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_1_accuracy_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_1_max_hit_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_1_stun_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_1_dpc_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_1_crit_damage_stats_on_purchased(mech_weapon : MechWeapon)

@warning_ignore("unused_signal")
signal update_weapon_2_name_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_2_crit_chance_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_2_charge_speed_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_2_accuracy_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_2_max_hit_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_2_stun_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_2_dpc_stats_on_purchased(mech_weapon : MechWeapon)
@warning_ignore("unused_signal")
signal update_weapon_2_crit_damage_stats_on_purchased(mech_weapon : MechWeapon)

@warning_ignore("unused_signal")
signal toggle_mech_stats_panels()
@warning_ignore("unused_signal")
signal hide_mech_stats_panels()
@warning_ignore("unused_signal")
signal toggle_filter(value : bool)

#Asteroid Field Map
@warning_ignore("unused_signal")
signal change_maps

#Drone Shop
@warning_ignore("unused_signal")
signal set_asteroid_data(asteroid_area : AsteroidArea, drone_manager : LocalDroneManager)
@warning_ignore("unused_signal")
signal clear_asteroid_data
@warning_ignore("unused_signal")
signal show_drone_shop

@warning_ignore("unused_signal")
signal unregister_mining_drone(mining_drone : MiningDrone)
@warning_ignore("unused_signal")
signal unregister_platinum_drone(platinum_drone : PlatinumMiningDrone)
@warning_ignore("unused_signal")
signal unregister_turret_drone(turret_drone : TurretDrone)

@warning_ignore("unused_signal")
signal update_asteroid_panel_data(asteroid_area : AsteroidArea, asteroid_index : int, is_purchased : bool)

@warning_ignore("unused_signal")
signal purchase_asteroid(asteroid_area : AsteroidArea)

@warning_ignore("unused_signal")
signal init_weapon_upgrade_guide(crate : UpgradeCrate)
@warning_ignore("unused_signal")
signal disable_weapon_upgrade_guide

@warning_ignore("unused_signal")
signal init_suit_upgrade_guide(crate : UpgradeCrate)
@warning_ignore("unused_signal")
signal disable_suit_upgrade_guide
@warning_ignore("unused_signal")
signal check_for_more_crates(crate : UpgradeCrate)

@warning_ignore("unused_signal")
signal check_once_for_weapon_crates(crate : UpgradeCrate)

@warning_ignore("unused_signal")
signal check_once_for_suit_crates(crate : UpgradeCrate)

@warning_ignore("unused_signal")
signal update_key_card_counts

@warning_ignore("unused_signal")
signal free_crate_spawn_location(id : int)
@warning_ignore("unused_signal")
signal update_player_health
@warning_ignore("unused_signal")
signal move_player(direction : Vector2, is_dash_attack : bool)
@warning_ignore("unused_signal")
signal move_enemy(enemy : GridEnemy, direction : Vector2, row_limit : int, col_limit : int)

@warning_ignore("unused_signal")
signal issue_weapon_attack(slot : int)
@warning_ignore("unused_signal")
signal move_actor_to_tile(actor : GridActor, tile : Tile)

@warning_ignore("unused_signal")
signal heal_enemy
@warning_ignore("unused_signal")
signal spawn_next_wave(on_time_out : bool)
@warning_ignore("unused_signal")
signal add_enemy_to_grid(enemy : GridEnemy)
@warning_ignore("unused_signal")
signal add_time(time : int)
@warning_ignore("unused_signal")
signal apply_timer_consequences
@warning_ignore("unused_signal")
signal enable_enemy_movement
@warning_ignore("unused_signal")
signal refil_shield_gauge

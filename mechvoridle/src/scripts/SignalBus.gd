extends Node

#navigation signals
signal move_to_mining_pane
signal move_to_shop_pane
signal move_to_central_hub_from_mining_page
signal move_to_central_hub_from_shop_pane
signal start_fight
signal stop_fight
signal begin_round
signal stop_ufo_spawn
signal fade_out_alert
signal issue_drone_down_alert
signal show_specified_boss(index : int)

signal remove_ufo_during_start_fight

signal show_part(body_part : String, category : String)
signal show_weapon(weapon_type : String, category : String, side : String)
signal show_part_preview(component : MechComponent)
signal update_parts_owned_on_previewer

signal show_task_completed_indicator(index : int)
signal show_check_list
signal hide_check_list
signal increment_phase_mission_completed_count
#settings panel
signal show_audio_settings
signal hide_audio_settings

#mining panel signals
signal update_ferrite_count
signal update_ferrite_bars_count
signal update_platinum_count
signal show_upgrade_panel
signal hide_upgrade_panel
signal add_drone
signal add_platinum_drone
signal update_plasma_count
signal update_plasma_generator_speed
signal update_fuel_consumption
signal update_plasma_generator_output
signal update_drone_cost
signal update_drone_count
signal update_platinum_drone_cost
signal update_platinum_drone_count
signal check_to_start_ufo_spawn
signal play_ufo_escaped
signal sound_ship_alarm
signal silence_ship_alarm

signal update_mining_laser_speed

#shop panel signals
signal transfer_item_to_shop_panel(component : MechComponent)

#main panel
signal unlock_fight_button

#combat
signal win_game #execute win procedure and go to win panel
signal lose_game #execute loss procedure and go to lose panel
signal update_player_health_bar
signal update_opponent_health_bar
signal fill_bar_on_start_up
signal shake_camera(value : int)

#mission

signal add_to_mission_counter(amount : int, unique_mission_identifier : int)
signal add_to_submission_counter(amount : int, unique_mission_identifier : int)
signal increment_mission_completed_counted
signal show_mission_tracker_panel
signal hide_mission_tracker_panel
signal issue_mission_complete_notification
signal issue_phase_compolete_notification

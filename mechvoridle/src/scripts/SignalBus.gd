extends Node

#navigation signals
signal move_to_mining_pane
signal move_to_shop_pane
signal move_to_central_hub_from_mining_page
signal move_to_central_hub_from_shop_pane
signal start_fight

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
signal shake_camera

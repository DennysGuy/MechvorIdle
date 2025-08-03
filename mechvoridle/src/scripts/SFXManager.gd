extends Node


var start_game : AudioStream

#UI Navigation
const UI_NAV_BUTTON_HOVER_01 : AudioStream = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_Button_Hover_01.ogg")
const UI_NAV_BUTTON_HOVER_02 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_Button_Hover_02.ogg")
const UI_NAV_BUTTON_HOVER_03 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_Button_Hover_03.ogg")
const UI_NAV_BUTTON_PRESS_01 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_Button_Press_01.ogg")
const UI_NAV_BUTTON_PRESS_02 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_Button_Press_02.ogg")
const UI_NAV_BUTTON_PRESS_03 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_Button_Press_03.ogg")
const UI_NAV_SWITCH_TAB_A_ENTER_HUB_01  : AudioStream = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_A_EnterHub_01.ogg")
const UI_NAV_SWITCH_TAB_A_EXIT_HUB_01 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_A_ExitHub_01.ogg")
const UI_NAV_SWITCH_TAB_B_HUB_01 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Hub_01.ogg")
const UI_NAV_SWITCH_TAB_B_HUB_02 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Hub_02.ogg")
const UI_NAV_SWITCH_TAB_B_HUB_03 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Hub_03.ogg")
const UI_NAV_SWITCH_TAB_B_MINING_01 : AudioStream = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Mining_01.ogg")
const UI_NAV_SWITCH_TAB_B_MINING_02 : AudioStream   = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Mining_02.ogg")
const UI_NAV_SWITCH_TAB_B_MINING_03  : AudioStream = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Mining_03.ogg")
const UI_NAV_SWITCH_TAB_B_MINING_04 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Mining_04.ogg")
const UI_NAV_SWITCH_TAB_B_SHOP_01 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Shop_01.ogg")
const UI_NAV_SWITCH_TAB_B_SHOP_02  : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Shop_02.ogg")
const UI_NAV_SWITCH_TAB_B_SHOP_03 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Shop_03.ogg")
const UI_NAV_SWITCH_TAB_B_SHOP_04  : AudioStream = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Shop_04.ogg")
const UI_NAV_SWITCH_TAB_B_SHOP_05 : AudioStream  = preload("res://assets/audio/SFX/UI/Navigation/UI_Nav_SwitchTab_B_Shop_05.ogg")

#Shop UI
const UI_SHOP_BUY_COMPLETE_01 : AudioStream  = preload("res://assets/audio/SFX/UI/Shop/UI_Shop_Buy_Complete_01.ogg")
const UI_SHOP_BUY_COMPLETE_02 : AudioStream  = preload("res://assets/audio/SFX/UI/Shop/UI_Shop_Buy_Complete_02.ogg")
const UI_SHOP_BUY_COMPLETE_03 : AudioStream  = preload("res://assets/audio/SFX/UI/Shop/UI_Shop_Buy_Complete_03.ogg")
const UI_SHOP_BUY_NO_CASH_01 : AudioStream  = preload("res://assets/audio/SFX/UI/Shop/UI_Shop_Buy_NoCash_01.ogg")
const UI_SHOP_BUY_NO_CASH_02 : AudioStream   = preload("res://assets/audio/SFX/UI/Shop/UI_Shop_Buy_NoCash_02.ogg")
const UI_SHOP_BUY_NO_CASH_03 : AudioStream  = preload("res://assets/audio/SFX/UI/Shop/UI_Shop_Buy_NoCash_03.ogg")

const MIN_UNIT_DRONE_DEPLOY_01 = preload("res://assets/audio/SFX/MINING/MIN_Unit_Drone_Deploy_01.ogg")
const MIN_UNIT_DRONE_DEPLOY_02 = preload("res://assets/audio/SFX/MINING/MIN_Unit_Drone_Deploy_02.ogg")
const MIN_UNIT_DRONE_DEPLOY_03 = preload("res://assets/audio/SFX/MINING/MIN_Unit_Drone_Deploy_03.ogg")
const MIN_UNIT_DRONE_DEPLOY_04 = preload("res://assets/audio/SFX/MINING/MIN_Unit_Drone_Deploy_04.ogg")
const MIN_UNIT_DRONE_DESTROY_01 = preload("res://assets/audio/SFX/MINING/MIN_Unit_Drone_Destroy_01.ogg")
const MIN_UNIT_DRONE_DESTROY_02 = preload("res://assets/audio/SFX/MINING/MIN_Unit_Drone_Destroy_02.ogg")
const MIN_UNIT_DRONE_DESTROY_03 = preload("res://assets/audio/SFX/MINING/MIN_Unit_Drone_Destroy_03.ogg")

#mining
const MIN_CLICK_ASTEROID_01 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_01.ogg")
const MIN_CLICK_ASTEROID_02 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_02.ogg")
const MIN_CLICK_ASTEROID_03 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_03.ogg")
const MIN_CLICK_ASTEROID_04 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_04.ogg")
const MIN_CLICK_ASTEROID_05 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_05.ogg")
const MIN_CLICK_ASTEROID_06 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_06.ogg")
const MIN_CLICK_ASTEROID_07 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_07.ogg")
const MIN_CLICK_ASTEROID_08 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Asteroid_08.ogg")
const MIN_CLICK_SPACE_01 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Space_01.ogg")
const MIN_CLICK_SPACE_02 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Space_02.ogg")
const MIN_CLICK_SPACE_03 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Space_03.ogg")
const MIN_CLICK_SPACE_04 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Space_04.ogg")
const MIN_CLICK_SPACE_05 : AudioStream = preload("res://assets/audio/SFX/MINING/Click/MIN_Click_Space_05.ogg")

const MIN_UNIT_UFO_APPEAR_01 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Appear_01.ogg")
const MIN_UNIT_UFO_APPEAR_02 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Appear_02.ogg")
const MIN_UNIT_UFO_APPEAR_03 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Appear_03.ogg")
const MIN_UNIT_UFO_APPEAR_04 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Appear_04.ogg")
const MIN_UNIT_UFO_DAMAGE_01 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_01.ogg")
const MIN_UNIT_UFO_DAMAGE_02 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_02.ogg")
const MIN_UNIT_UFO_DAMAGE_03 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_03.ogg")
const MIN_UNIT_UFO_DAMAGE_04 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_04.ogg")
const MIN_UNIT_UFO_DAMAGE_05 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_05.ogg")
const MIN_UNIT_UFO_DAMAGE_06 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_06.ogg")
const MIN_UNIT_UFO_DAMAGE_07 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_07.ogg")
const MIN_UNIT_UFO_DAMAGE_08 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_08.ogg")
const MIN_UNIT_UFO_DAMAGE_09 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_09.ogg")
const MIN_UNIT_UFO_DAMAGE_10 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_10.ogg")
const MIN_UNIT_UFO_DAMAGE_11 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Damage_11.ogg")
const MIN_UNIT_UFO_HOVER_01 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Hover_01.ogg")
const MIN_UNIT_UFO_HOVER_02 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Hover_02.ogg")
const MIN_UNIT_UFO_HOVER_03 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Hover_03.ogg")
const MIN_UNIT_UFO_HOVER_04 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Hover_04.ogg")
const MIN_UNIT_UFO_LASER_01 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Laser_01.ogg")
const MIN_UNIT_UFO_LASER_02 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Laser_02.ogg")
const MIN_UNIT_UFO_LASER_03 : AudioStream = preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Laser_03.ogg")
const MIN_UNIT_UFO_LASER_04 : AudioStream= preload("res://assets/audio/SFX/MINING/Unit/MIN_Unit_UFO_Laser_04.ogg")



const VOX_NOT_UFO_ESCAPED_01 : AudioStream = preload("res://assets/audio/SFX/VOX/VOX_Not_UFO_Escaped_01.ogg")

const UI_MINING_UPGRADE_MENU_CLOSE_01 : AudioStream = preload("res://assets/audio/SFX/UI/Mining/UI_Mining_Upgrade_MenuClose_01.ogg")
const UI_MINING_UPGRADE_MENU_OPEN_01 : AudioStream = preload("res://assets/audio/SFX/UI/Mining/UI_Mining_Upgrade_MenuOpen_01.ogg")

#Misc
const UI_MISC_TEXT_CRAWL_01 : AudioStream = preload("res://assets/audio/SFX/UI/Misc/UI_Misc_Text_Crawl_01.ogg")
const UI_MISC_TEXT_CRAWL_02 : AudioStream = preload("res://assets/audio/SFX/UI/Misc/UI_Misc_Text_Crawl_02.ogg")
const UI_MISC_TEXT_CRAWL_03 : AudioStream = preload("res://assets/audio/SFX/UI/Misc/UI_Misc_Text_Crawl_03.ogg")

#VOX
const VOX_ALARM_UFO_ALERT_01 : AudioStream = preload("res://assets/audio/SFX/VOX/VOX_Alarm_UFO_Alert_01.ogg")
const VOX_NOT_ARENA_ACCESS_01 : AudioStream = preload("res://assets/audio/SFX/VOX/VOX_Not_Arena_Access_01.ogg")
const VOX_NOT_UFO_DOWN_01 : AudioStream = preload("res://assets/audio/SFX/VOX/VOX_Not_UFO_Down_01.ogg")


func play_button_hover(audio_stream_player : AudioStreamPlayer) -> void:
	var hover_sfx_list = [UI_NAV_BUTTON_HOVER_01, UI_NAV_BUTTON_HOVER_02, UI_NAV_BUTTON_HOVER_03]
	audio_stream_player.stream = hover_sfx_list.pick_random()
	audio_stream_player.play()

func play_button_click(audio_stream_player : AudioStreamPlayer) -> void:
	var click_sfx_list = [UI_NAV_BUTTON_PRESS_01, UI_NAV_BUTTON_PRESS_02, UI_NAV_BUTTON_PRESS_03]		
	audio_stream_player.stream = click_sfx_list.pick_random()
	audio_stream_player.play()

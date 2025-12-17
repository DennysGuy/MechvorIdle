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

const COM_PLY_ATK_RIFLE_01 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Atk_Rifle_01.ogg")
const COM_PLY_ATK_ROCKET_01  : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Atk_Rocket_01.ogg")
const COM_PLY_ATK_SWORD_01  : AudioStream = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Atk_Sword_01.ogg")
const COM_PLY_CLICK_VUL_01 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_01.ogg")
const COM_PLY_CLICK_VUL_02 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_02.ogg")
const COM_PLY_CLICK_VUL_03 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_03.ogg")
const COM_PLY_CLICK_VUL_04 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_04.ogg")
const COM_PLY_CLICK_VUL_05 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_05.ogg")
const COM_PLY_CLICK_VUL_06  : AudioStream = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_06.ogg")
const COM_PLY_CLICK_VUL_07 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_07.ogg")
const COM_PLY_CLICK_VUL_08 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Click_Vul_08.ogg")
const COM_PLY_DAMAGE_01 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_01.ogg")
const COM_PLY_DAMAGE_02 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_02.ogg")
const COM_PLY_DAMAGE_03 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_03.ogg")
const COM_PLY_DAMAGE_04 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_04.ogg")
const COM_PLY_DAMAGE_05 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_05.ogg")
const COM_PLY_DAMAGE_06 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_06.ogg")
const COM_PLY_DAMAGE_07 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_07.ogg")
const COM_PLY_DAMAGE_08 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_08.ogg")
const COM_PLY_DAMAGE_09 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_09.ogg")
const COM_PLY_DAMAGE_10 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_10.ogg")
const COM_PLY_DAMAGE_11 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_11.ogg")
const COM_PLY_DAMAGE_12 : AudioStream  = preload("res://assets/audio/SFX/COMBAT/COM_Ply_Damage_12.ogg")

const VOX_COM_ENE_DAMAGE_01 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_01.ogg")
const VOX_COM_ENE_DAMAGE_02 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_02.ogg")
const VOX_COM_ENE_DAMAGE_03 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_03.ogg")
const VOX_COM_ENE_DAMAGE_04 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_04.ogg")
const VOX_COM_ENE_DAMAGE_05 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_05.ogg")
const VOX_COM_ENE_DAMAGE_06 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_06.ogg")
const VOX_COM_ENE_DAMAGE_07 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_07.ogg")
const VOX_COM_ENE_DAMAGE_08 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_08.ogg")
const VOX_COM_ENE_DAMAGE_09 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_09.ogg")
const VOX_COM_ENE_DAMAGE_10 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_10.ogg")
const VOX_COM_ENE_DAMAGE_11 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_11.ogg")
const VOX_COM_ENE_DAMAGE_12 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_12.ogg")
const VOX_COM_ENE_DAMAGE_13 = preload("res://assets/audio/SFX/VOX/Combat/Damage/VOX_Com_Ene_Damage_13.ogg")


const VOX_COM_ANN_READY_SET_FIGHT_01 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ann_ReadySetFight_01.ogg")
const VOX_COM_ENE_DEATH_01 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ene_Death_01.ogg")
const VOX_COM_ENE_TAUNT_ARROGANT_01 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ene_Taunt_Arrogant_01.ogg")
const VOX_COM_ENE_TAUNT_ARROGANT_02 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ene_Taunt_Arrogant_02.ogg")
const VOX_COM_ENE_TAUNT_HATEFUL_01 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ene_Taunt_Hateful_01.ogg")
const VOX_COM_ENE_TAUNT_HATEFUL_02 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ene_Taunt_Hateful_02.ogg")
const VOX_COM_ENE_TAUNT_POWERFUL_01 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ene_Taunt_Powerful_01.ogg")
const VOX_COM_ENE_TAUNT_POWERFUL_02 = preload("res://assets/audio/SFX/VOX/Combat/VOX_Com_Ene_Taunt_Powerful_02.ogg")
const SHIP_ALARM_1 = preload("uid://clj4tymrg47g4")

const VULCAN_BLAST_1 = preload("uid://bvx0p2o6vkgji")
const PLAYER_STEP = preload("uid://dartft1a11so0")
const STEP_2 = preload("uid://ff3uj2qdn7is")

const VULCAN_SHOT_1 = preload("uid://cmvqhmxqa87gs")
const VULCAN_SHOT_2 = preload("uid://7kio57edq6hp")
const VULCAN_SHOT_3 = preload("uid://crit4wosexl7q")
const VULCAN_SHOT_4 = preload("uid://d0t0ctj542xxe")
const VULCAN_SHOT_5 = preload("uid://vfewesgcolyn")

var vulcan_shots : Array[AudioStream] = [VULCAN_SHOT_1, VULCAN_SHOT_2, VULCAN_SHOT_3, VULCAN_SHOT_4, VULCAN_SHOT_5]
const BOSS_CANNON_FIRE = preload("uid://chmaxegdine1o")

const PLAYER_STEP_1 = preload("uid://da7p3hkbbepis")
const PLAYER_STEP_2 = preload("uid://q3or7hp583u1")
const PLAYER_STEP_3 = preload("uid://rqst1imayamd")

const TELEPORT_IN = preload("uid://cjlmwl5d6ykhv")

const ROCKET_LAUNCHER_FIRE = preload("uid://cskac8s8bk63y")
const FORCE_FIELD_IMPACT = preload("uid://brpp1l4cepj4l")
const LIGHTNING_BLAST = preload("uid://uoln6p5nh1nl")

const SWORD_BOT_SWING = preload("uid://gqwglqqsu2wd")
const SWORD_BOT_SWORD_IMPACT = preload("uid://bhf3cspij74io")
const SWORD_DEFLECT_OFF_SHIELD = preload("uid://bndwlr23vkddv")

const COMBAT_THEME = preload("uid://bsvvxjkhi4vt")

const SHIELD_POWER_DOWN = preload("uid://d3v1pgmfplvko")
const SHIELD_POWER_UP = preload("uid://cy31ecq6lsr4j")

const VULCAN_IMPACT_1 = preload("uid://c40tyf6t78qmn")
const VULCAN_IMPACT_2 = preload("uid://ds7pamcas4kod")
const VULCAN_IMPACT_3 = preload("uid://do6o6kmu78pe2")
const VULCAN_IMPACT_4 = preload("uid://c0ffb7leqcnyj")
const VULCAN_IMPACT_5 = preload("uid://du35eylgoa8jh")

const SMG_1 = preload("uid://bhopy8oluxwpw")
const SMG_2 = preload("uid://sdvpmb6rtxh")
const SMG_3 = preload("uid://b77jy3snsq1j")
const SMG_4 = preload("uid://bkwytsbuo3mud")
const SMG_5 = preload("uid://ctl4pu8snsg1p")

var smg_shots : Array[AudioStream] = [SMG_1,SMG_2,SMG_3,SMG_4,SMG_5]

var vulcan_impacts : Array[AudioStream] = [VULCAN_IMPACT_1,VULCAN_IMPACT_2, VULCAN_IMPACT_3, VULCAN_IMPACT_4, VULCAN_IMPACT_5]

const FIGHT = preload("uid://ljcggcf53d8r")
const READY = preload("uid://dv3qyudcoyjtp")

const VOX_ANNOUNCER_COUNT_DOWN__ONE_01 = preload("uid://bdxul8j4igeyd")
const VOX_ANNOUNCER_COUNT_DOWN__THREE_01 = preload("uid://ciowknm5ug5mp")
const VOX_ANNOUNCER_COUNT_DOWN__TWO_01 = preload("uid://bph00iu1j5x0o")

const ENEMY_WHOOSH_1 = preload("uid://ds7gnlsi63j0v")
const ENEMY_WHOOSH_2 = preload("uid://d03d6y40xmfqv")
const ENEMY_WHOOSH_3 = preload("uid://cb5dmof7miw4g")

const BOSS_ROCKET_IMPACT = preload("uid://ckfwm4o6qqjj4")
const BOSS_ROCKET_LAUNCH = preload("uid://c5rser8n5btav")
const BOSS_LAND = preload("uid://bf2thc83obbwu")

const HEAL = preload("uid://cgbmvklh58dro")
const WEAPON_2_READY = preload("uid://nciwhr7423ej")
const WEAPON_1_READY = preload("uid://cok5ea1s6mcvo")

const OD_MODE_ACTIVATE = preload("uid://bniwxfuy06te1")
const OD_POWER_DOWN = preload("uid://d3h2oaomsi7s1")

const SHIELD_IMPACT_1 = preload("uid://bnqvn2nvqss2d")
const SHIELD_IMPACT_2 = preload("uid://d2om5k7rdf6lw")
const SHIELD_IMPACT_3 = preload("uid://dxnohc3b7exj4")
const SHIELD_IMPACT_4 = preload("uid://0liq5qvbvgit")
const SHIELD_IMPACT_5 = preload("uid://d3vo7okrwioy1")
const SHIELD_IMPACT_6 = preload("uid://bxb1c7o8y4fj4")
const PERFECT_SHIELD_BLOCK = preload("uid://3gwdeqm1k1up")


const SWORD_SWING = preload("uid://b0m4dnadb7tow")

const ENEMY_HURT_1 = preload("uid://3xkitkmmbhhi")
const ENEMY_HURT_2 = preload("uid://d2byhq2fhq75r")
const ENEMY_HURT_3 = preload("uid://brc11rshc8p28")
const ENEMY_HURT_4 = preload("uid://bca5hwvv4eoa8")

const OVER_HEATED = preload("uid://gp8c4hhvp87w")
const MECH_STATUS_RECOVERED = preload("uid://dnqvv4r4hquu0")
const OVER_HEAT_WARNING = preload("uid://b566fx2vv7vfq")

const SHIFT_1 = preload("uid://bvrxjuxtiq1sr")

const SNIPER_2 = preload("uid://bhltg8qx42hb6")
const SNIPER_3 = preload("uid://c6heglmy5pm6m")
const SNIPER_4 = preload("uid://dq77ljuy1ly6t")
const SNIPER_SHOT_1 = preload("uid://csxeqtwmcsa4i")

const SNIPER_AIM = preload("uid://6vcgg07gc7h2")
const ROUND_FAILED = preload("uid://cuopvwi82prjp")
const ROUND_WON = preload("uid://ctk0jtxxc6gai")

const CHALLENGE_FAILED = preload("uid://n1axv35rt051")
const CHALLENGE_WON = preload("uid://21akavc5cnjy")

const BASIC_ENEMY_EXPLOSION = preload("uid://o3cdh2e8si7r")

const COUNTER_GUARD = preload("uid://jew5n876x2je")

const CHALLENGE_ALERT = preload("uid://cgp2cm1pueshn")


var sniper_shots : Array[AudioStream] = [SNIPER_SHOT_1, SNIPER_2, SNIPER_3, SNIPER_4]

var enemy_hurts : Array[AudioStream] = [ENEMY_HURT_1,ENEMY_HURT_2,ENEMY_HURT_3,ENEMY_HURT_4]

var shield_impacts : Array[AudioStream] = [SHIELD_IMPACT_1,SHIELD_IMPACT_2,SHIELD_IMPACT_3,SHIELD_IMPACT_4,SHIELD_IMPACT_5,SHIELD_IMPACT_6]

var enemy_whooshes : Array[AudioStream] = [ENEMY_WHOOSH_1, ENEMY_WHOOSH_2, ENEMY_WHOOSH_3]

func get_sniper_shot() -> AudioStream:
	return sniper_shots.pick_random()

func get_smg_shot() -> AudioStream:
	return smg_shots.pick_random()

func get_shield_impact() -> AudioStream:
	return shield_impacts.pick_random()

func get_enemy_hurt() -> AudioStream:
	return enemy_hurts.pick_random()

func get_enemy_movement_whoosh() -> AudioStream:
	return enemy_whooshes.pick_random()

func get_vulcan_impact() -> AudioStream:
	return vulcan_impacts.pick_random()

var player_steps : Array[AudioStream] = [PLAYER_STEP_1, PLAYER_STEP_2, PLAYER_STEP_3]

func get_vulcan_shot() -> AudioStream:
	return vulcan_shots.pick_random()

func get_player_step() -> AudioStream:
	return player_steps.pick_random()

func play_button_hover(audio_stream_player : AudioStreamPlayer) -> void:
	var hover_sfx_list = [UI_NAV_BUTTON_HOVER_01, UI_NAV_BUTTON_HOVER_02, UI_NAV_BUTTON_HOVER_03]
	audio_stream_player.stream = hover_sfx_list.pick_random()
	audio_stream_player.play()

func play_button_click(audio_stream_player : AudioStreamPlayer) -> void:
	var click_sfx_list = [UI_NAV_BUTTON_PRESS_01, UI_NAV_BUTTON_PRESS_02, UI_NAV_BUTTON_PRESS_03]		
	audio_stream_player.stream = click_sfx_list.pick_random()
	audio_stream_player.play()

func play_sfx(audio_stream : AudioStream, volume_db : float = 0.0, randomized_pitch : bool = false, pitch : float = 1.0) -> void:
	var asp : AudioStreamPlayer = AudioStreamPlayer.new()
	asp.stream = audio_stream
	asp.volume_db = volume_db
	asp.pitch_scale = pitch
	if randomized_pitch:
		asp.pitch_scale = randomize_pitch()
		
	asp.bus = "SFX"
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()


func randomize_pitch() -> float:
	return randf_range(0.5,0.7)	

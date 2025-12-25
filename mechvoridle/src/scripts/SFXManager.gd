extends Node


var start_game : AudioStream

#UI Navigation

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
const VOX_COM_ENE_DEATH_01 = preload("uid://bghgb472txumw")

const SWORD_BOT_SWING = preload("uid://gqwglqqsu2wd")
const SWORD_BOT_SWORD_IMPACT = preload("uid://bhf3cspij74io")
const SWORD_DEFLECT_OFF_SHIELD = preload("uid://bndwlr23vkddv")



const COMBAT_THEME = preload("uid://bsvvxjkhi4vt")

const SHIELD_POWER_DOWN = preload("uid://d3v1pgmfplvko")
const SHIELD_POWER_UP = preload("uid://cy31ecq6lsr4j")
const SHIP_ALARM_1  = preload("uid://drwxsxxpwa506")

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

const H_SABRE_DASH = preload("uid://bbf12kkh76vd1")
const H_SABRE_DASH_SPECIAL = preload("uid://cufbr83ynvahg")
const H_SABRE_SWING_1 = preload("uid://b1fq6ku37juic")
const H_SABRE_SWING_1_SPECIAL = preload("uid://di56j1bh1q70d")
const H_SABRE_SWING_2 = preload("uid://dosgfr4omg705")
const H_SABRE_SWING_2_SPECIAL = preload("uid://bpufatb8ymtcq")


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

const ARM_ROCKET_1 = preload("uid://b4p660dspolof")
const GROUND_FLARES = preload("uid://bc5yywis2igxe")


const ROUND_FAILED = preload("uid://cuopvwi82prjp")
const ROUND_WON = preload("uid://ctk0jtxxc6gai")

const CHALLENGE_FAILED = preload("uid://n1axv35rt051")
const CHALLENGE_WON = preload("uid://21akavc5cnjy")

const BASIC_ENEMY_EXPLOSION = preload("uid://o3cdh2e8si7r")

const COUNTER_GUARD = preload("uid://jew5n876x2je")

const CHALLENGE_ALERT = preload("uid://cgp2cm1pueshn")

const CHEST_OPEN = preload("uid://dlxokrrll2rn7")

const SPEAR_DASH = preload("uid://buq752fb57lwq")
const SPEAR_HIT = preload("uid://bdulg87nkrhmt")
const TILE_LOCKED_ON = preload("uid://gfb2e1dt05hu")


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

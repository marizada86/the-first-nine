extends Node2D

const VIEW := Vector2(1280, 720)
const CARAVAN_X := 190.0
const GROUND_Y := 555.0
const PLAYER_RADIUS := 19.0
const INTERACT_RADIUS := 56.0
# Lolth's measured half-body plus 4 px tolerance. Thornwake enemy widths come
# from the same current-frame outline and uniform scale used for drawing.
const MELEE_LOLTH_HALF_WIDTH := 44.0
const MELEE_VERTICAL_REACH := 70.0
# Retained only for prototype-region legacy melee; not Thornwake geometry.
const MELEE_ENEMY_HALF_WIDTHS := {"BRIAR HOUND": 42.0, "STAG OF MIRE": 52.0, "ANTLERED HUNGER": 73.0}
const MELEE_DEFAULT_ENEMY_HALF_WIDTH := 42.0
const MISS_FEEDBACK_RANGE := 220.0
const ATTACK_POSE_TIME := 0.28
const HURT_FLASH_TIME := 0.45
const ENEMY_HIT_FLASH_TIME := 0.16
const THORNWAKE_ENEMY_SIZES := {"BRIAR HOUND": 160.0, "STAG OF MIRE": 200.0, "ANTLERED HUNGER": 260.0}
const PORTAL_X := 1100.0
const GRAVITY := 1500.0
const JUMP_SPEED := 590.0
const DASH_SPEED := 620.0
const DAY_DURATION := 105.0
const NIGHT_DURATION := 75.0
const CARAVAN_SAFE_RADIUS := 235.0
const WAGON_ATTACK_DAMAGE_PER_SECOND := 2.8
const WAGON_STOCK_CAPACITY := 5
const PLAYER_FEET_OFFSET := 38.0
const PLAYER_SPRITE_HEIGHT := 200.0
const NIGHT_WAVE_INTERVAL := 3.0
const COMBO_WINDOW := 0.55
const COMBO_DAMAGE := [1, 1, 2]
const STAG_WAGON_HIT_DAMAGE := 10.0
const STAG_WAGON_HIT_COOLDOWN := 1.4
const LOLTH_ELF_RUNTIME := preload("res://assets/runtime_v2/characters/lolth/lolth-elf-core-sheet-v1.png")
const LOLTH_DROW_RUNTIME := preload("res://assets/runtime_v2/characters/lolth/lolth-drow-core-sheet-v1.png")
const LOLTH_TRANSFORMATIONS := preload("res://lolth_transformations.gd")
const BRIAR_HOUND_RUNTIME := preload("res://assets/runtime_v2/enemies/thornwake/briar-hound-core-v1.png")
const STAG_OF_MIRE_RUNTIME := preload("res://assets/runtime_v2/enemies/thornwake/stag-of-mire-core-v1.png")
const ANTLERED_HUNGER_RUNTIME := preload("res://assets/runtime_v2/enemies/thornwake/antlered-hunger-core-v1.png")
const STONEHOOK_THREATS_RUNTIME := preload("res://assets/runtime_v2/enemies/stonehook/stonehook-threats-core-v1.png")
const SALVAGE_PICKUPS_RUNTIME := preload("res://assets/runtime_v2/items/salvage-pickups-core-v1.png")
const WAGON_REPAIR_RUNTIME := preload("res://assets/runtime_v2/caravan/wagon-open-core-states-v1.png")
const SALVAGE_WORKSHOP_RUNTIME := preload("res://assets/runtime_v2/world/common/salvage-workshop-web-gates-v1.png")
const MARK_GATES_RUNTIME := preload("res://assets/runtime_v2/marks/shar-to-lolth-progression-v1.png")
const ASHEN_WAY_BACKDROP := preload("res://assets/art/environment/ashen-way-backdrop-runtime-v1.png")
const VEIL_RUINS_BACKDROP := preload("res://assets/runtime_v2/world/stonehook/stonehook-continuous-route-v1.png")
const LATER_REGION_ROUTE_ATLAS := preload("res://assets/runtime_v2/world/later-regions/continuous-route-atlas-v1.png")
const LATER_REGION_THREATS_RUNTIME := preload("res://assets/runtime_v2/enemies/later-regions/region-threats-and-bosses-v1.png")
const RUINS_FOREGROUND_OVERLAYS := preload("res://assets/art/environment/ruins-foreground-overlays-runtime-v1.png")
const ASHEN_WAY_FOREGROUND_OVERLAY := preload("res://assets/art/environment/ashen-way-foreground-overlay-runtime-v1.png")
const THORNWAKE_CONTINUOUS_GROUND := preload("res://assets/runtime_v2/world/thornwake/thornwake-continuous-ground-v1.png")
const ZONE_GROUND_BANDS_RUNTIME := preload("res://assets/art/environment/zone-ground-bands-runtime-sheet-v1.png")
const HUD_STATUS_ICONS := preload("res://assets/runtime_v2/ui/survival-and-mark-icons-v1.png")
const CAMP_STATUS_EMBLEMS := preload("res://assets/art/ui/camp-status-emblems-runtime-v1.png")
const ACTION_PROMPT_ICONS := preload("res://assets/art/ui/action-prompts-runtime-sheet-v1.png")
const MARK_PROGRESSION_SEALS := preload("res://assets/runtime_v2/ui/survival-and-mark-icons-v1.png")
const PASSIVE_MISSION_EMBLEMS := preload("res://assets/art/ui/passive-mission-emblems-runtime-v1.png")
const DREAM_GATE_RUNTIME := preload("res://assets/art/gates/dream-gate-runtime-v1.png")
const CAMP_PROPS := preload("res://assets/art/camp/last-camp-prop-sheet-v1.png")
const CARAVAN_FLAME_RUNTIME := preload("res://assets/art/camp/caravan-flame-runtime-states-v1.png")
const SHADOW_MARK_VFX := preload("res://assets/art/vfx/shadow-mark-effects-v1.png")
const SHADOW_ACTIONS_VFX := preload("res://assets/runtime_v2/vfx/shadow-web-actions-v1.png")
const SHADOW_CROWN_KEY_ART := preload("res://assets/concept-art/key-art/shadow-crown-drow-body-shadow-form-v1.png")
const LAST_CAMP_KEY_ART := preload("res://assets/concept-art/key-art/the-last-camp-elven-survivors-v2.png")
const THALESTRIEL_PLAGUED_RUNTIME := preload("res://assets/runtime_v2/characters/thalestriel/thalestriel-plagued-survivors-sheet-v1.png")
const THALESTRIEL_CURED_RUNTIME := preload("res://assets/runtime_v2/characters/thalestriel/thalestriel-cured-assists-sheet-v1.png")
const ZONE_NAMES := ["THORNWAKE FOREST", "STONEHOOK MOUNTAINS", "HOLLOWROOT CAVERNS"]
const ZONE_OBJECTIVES := ["Gather supplies, return them to the Wagon, and protect the cave camp.", "Recover metal. Install axle and brakes. Reach the mountain shrine.", "Defend the caravan, defeat Root Crown, and gather the third Mark."]
const DODGE_DURATION := 0.30
const DODGE_COOLDOWN := 0.65
const MAX_ACTIVE_POSTS := 2
const MARK_NAMES := ["", "FIRST THREAD", "VELVET VEIL", "BLACK PULSE", "GLOAM SPINE", "NIGHT CHOIR", "DEEP HUNGER", "SPIDER'S PROMISE", "HEART OF THE WEB", "SHADOW CROWN"]
const ECHO_THRESHOLDS := [0, 3, 4, 5, 6, 7, 8, 9, 999]
const THALESTRIEL := ["AELIRA", "VAELUN", "NIMARA", "THAVIEL", "ILYREN", "ORISYA", "SORETH", "LURAEN"]
const ALLY_POSTS := {
	"AELIRA": Vector2(485, 430),
	"VAELUN": Vector2(1010, 318),
	"NIMARA": Vector2(850, 365),
	"THAVIEL": Vector2(CARAVAN_X + 40, GROUND_Y - 70),
	"ILYREN": Vector2(CARAVAN_X - 30, GROUND_Y - 78),
	"ORISYA": Vector2(650, 365),
	"SORETH": Vector2(850, GROUND_Y - 45),
	"LURAEN": Vector2(930, 430),
}
const RECIPES := [
	{"name": "CATAPLASM", "ingredients": {"herb": 1, "water": 1}, "description": "Restore the group's condition."},
	{"name": "WHEEL KIT", "ingredients": {"wood": 1, "rope": 1, "salvage": 1}, "description": "Repair the wagon and reinforce its frame."},
	{"name": "BRAZIER", "ingredients": {"kindling": 1, "wood": 1, "salvage": 1}, "description": "Strengthen the wagon's night defense."},
	{"name": "AXLE & BRAKES", "ingredients": {"metal": 2, "rope": 1, "tool": 1}, "description": "Lets the Wagon hold the Stonehook descent."},
]
const MARK_STATS := [
	{"might": 6, "vigor": 6, "grace": 5, "shadow": 0, "web": 0},
	{"might": 6, "vigor": 6, "grace": 5, "shadow": 2, "web": 1},
	{"might": 6, "vigor": 6, "grace": 7, "shadow": 3, "web": 1},
	{"might": 6, "vigor": 6, "grace": 7, "shadow": 5, "web": 2},
	{"might": 6, "vigor": 8, "grace": 7, "shadow": 5, "web": 3},
	{"might": 6, "vigor": 8, "grace": 7, "shadow": 7, "web": 4},
	{"might": 8, "vigor": 9, "grace": 7, "shadow": 8, "web": 4},
	{"might": 8, "vigor": 9, "grace": 7, "shadow": 9, "web": 7},
	{"might": 8, "vigor": 10, "grace": 8, "shadow": 10, "web": 9},
	{"might": 10, "vigor": 10, "grace": 9, "shadow": 10, "web": 10},
]
const PASSIVE_MISSIONS := [
	{"name": "SEARCH THE BRUSH", "type": "provisions", "reward": "The group gains Provisions."},
	{"name": "TEND THE FLAME", "type": "flame", "reward": "The Caravan Flame burns brighter."},
	{"name": "RECOVER DEBRIS", "type": "route", "reward": "The wagon repair advances."},
]
# B-02 Thornwake tutorial. Timings, ranges, and speeds are playtest data, not canon.
const WHEEL_KIT_RECIPE := 1
const TUTORIAL_NIGHT_WAVES := 2
const DUSK_DURATION := 4.0
const STAG_CHARGE_RANGE := 215.0
const STAG_WINDUP := 0.9
const STAG_CHARGE_SPEED := 182.0
const STAG_CHARGE_TIME := 1.6
const HOUND_LUNGE_RANGE := 170.0
const HOUND_WINDUP := 0.55
const HOUND_LUNGE_SPEED := 300.0
const HOUND_LUNGE_TIME := 0.35
const HOUND_RECOVER := 0.7
const MIN_TELEGRAPH_TIME := 0.5
# B-03 first boss and Mark I. Values are playtest data, not canon.
# B-04 playtest tuning: health 8 -> 12 and recovery 1.0 -> 1.2 s, so the fight lasts
# about three full melee combos and each dodged lunge leaves a clearer punish window.
const ANTLERED_HUNGER_HEALTH := 12
const BOSS_LUNGE_RANGE := 190.0
const BOSS_WINDUP := 0.8
const BOSS_LUNGE_SPEED := 360.0
const BOSS_LUNGE_TIME := 0.45
const BOSS_RECOVER := 1.2
const BOSS_WAGON_WINDUP := 1.2
const BOSS_WAGON_CHARGE_SPEED := 260.0
const BOSS_WAGON_CHARGE_TIME := 3.5
const BOSS_WAGON_DAMAGE := 15.0
const FIRST_THREAD_RANGE := 150.0
const FIRST_THREAD_DAMAGE := 2
const FIRST_THREAD_COOLDOWN := 1.2
# B-04 playtest review kept FIRST THREAD at 150 px, 2 damage, and a 1.2 s cooldown.
# In Thornwake, progression stops at Mark I. Mark II and later belong to later batches.
const THORNWAKE_MARK_CAP := 1
# B-06 first on-foot expedition. One continuous floor-level corridor in world units;
# these spans are playtest data, not lore. The cave hub keeps Thornwake's 0-1280 span
# and its single Wagon anchor at CARAVAN_X. Lolth's displayed region never moves the hub.
const ROUTE_THORNWAKE_END_X := 1280.0
const ROUTE_TRANSITION_WIDTH := 480.0
const ROUTE_FOOTHILLS_WIDTH := 1280.0
const ROUTE_FOOTHILLS_START_X := ROUTE_THORNWAKE_END_X + ROUTE_TRANSITION_WIDTH
const ROUTE_END_X := ROUTE_FOOTHILLS_START_X + ROUTE_FOOTHILLS_WIDTH
const PLAYER_EDGE_MARGIN := 42.0
const ENEMY_EDGE_MARGIN := 70.0
# Wagon interaction is measured in world x, never in camera or screen x.
const WAGON_INTERACT_MAX_X := 305.0
# The view scrolls only when Lolth leaves this screen-space window, so the cave view
# keeps a zero offset. The glide covers gate changes without a visible jump.
const CAMERA_WINDOW_LEFT := 360.0
const CAMERA_WINDOW_RIGHT := 920.0
const CAMERA_GLIDE_SPEED := 2400.0
const ROUTE_OVERLAY_FADE_WIDTH := 160.0
# Spans (world x) where the existing frame overlays cover Lolth once the route is open:
# the Ashen Way edge tree with its seam fade, and the Stonehook ruins arch at the far limit.
const FOREGROUND_READABILITY_SPANS := [Vector2(980.0, 1460.0), Vector2(2700.0, ROUTE_END_X)]
const FOREGROUND_READABILITY_RAMP := 120.0
const FOREGROUND_READABILITY_ALPHA := 0.72
const ROUTE_ORE_ID := "stonehook_iron_ore_01"
# B-07 first Stonehook encounter: one finite Scree Crawler in the foothills. Numbers are
# playtest defaults, not lore. The source is the crawler's own upper-left artwork in the
# existing Stonehook atlas; the crop stops above the rope of the creature below it.
const SCREE_CRAWLER_ID := "stonehook_scree_crawler_01"
const SCREE_CRAWLER_SOURCE := Rect2(0, 0, 768, 480)
const SCREE_CRAWLER_HOME_X := 2520.0
# The foothill foreground overlay is nearly opaque over the floor band at x 1800-2200 and
# 2880-3040, and hides Lolth there too. The crawler patrols a clear span, set so that Lolth
# also stands in the clear whenever its lunge can be triggered from the left.
const SCREE_CRAWLER_PATROL := Vector2(2400.0, 2860.0)
const SCREE_CRAWLER_BODY_HEIGHT := 120.0
const SCREE_CRAWLER_HEALTH := 3
const SCREE_CRAWLER_SPEED := 48.0
const SCREE_CRAWLER_WINDUP := 0.7
const SCREE_CRAWLER_LUNGE_TIME := 0.25
const SCREE_CRAWLER_LUNGE_SPEED := 180.0
const SCREE_CRAWLER_RECOVER := 1.0
# B-08 Cliff Harrier: the upper-right bird of the same atlas, one finite foothill actor.
# Numbers are playtest defaults. Attack initiation is 170, not the proposed 180: body reach
# (44 + 69.1) plus the longest dive (220 * 0.3 = 66) cannot connect from 180.
const CLIFF_HARRIER_ID := "stonehook_cliff_harrier_01"
const CLIFF_HARRIER_SOURCE := Rect2(768, 0, 768, 497)
const CLIFF_HARRIER_ACTIVATION_X := 2600.0
const CLIFF_HARRIER_HOME_X := 2760.0
const CLIFF_HARRIER_PATROL := Vector2(2400.0, 2860.0)
const CLIFF_HARRIER_BODY_HEIGHT := 110.0
const CLIFF_HARRIER_HEALTH := 3
const CLIFF_HARRIER_HOVER := 30.0
const CLIFF_HARRIER_BOB := 6.0
const CLIFF_HARRIER_BOB_RATE := 2.4
const CLIFF_HARRIER_APPROACH_SPEED := 70.0
const CLIFF_HARRIER_RETREAT_SPEED := 45.0
const CLIFF_HARRIER_RETREAT_RANGE := 100.0
const CLIFF_HARRIER_ATTACK_RANGE := 170.0
const CLIFF_HARRIER_WINDUP := 0.8
const CLIFF_HARRIER_DIVE_TIME := 0.3
const CLIFF_HARRIER_DIVE_SPEED := 220.0
const CLIFF_HARRIER_DIVE_DIP := 18.0
const CLIFF_HARRIER_RECOVER := 1.2
const ROUTE_ORE_X := 2620.0
# H-01 and H-02 shells. Identifiers only: they are never displayed to the player.
# Final panels and dialogue require an approved English script and art admission.
const H01_SHELL_BEATS := ["h01_golden_city_council", "h01_families_depart", "h01_caravan_departs", "h01_journey_calamities", "h01_plague_strikes", "h01_cave_arrival"]
const H02_SHELL_BEATS := ["h02_beat_01", "h02_beat_02", "h02_beat_03", "h02_beat_04", "h02_beat_05", "h02_beat_06"]

var player := Vector2(330, GROUND_Y - 38)
var flame := 100.0
var provisions := 4.0
var clock_seconds := DAY_DURATION
var wagon_integrity := 100.0
var wagon_attack_notice := 0.0
var night_wave := 0
var night_wave_total := 0
var night_wave_pause := 0.0
var night_waves_complete := false
var first_night_complete := false
var wagon_stock: Array[Dictionary] = []
var selected_recipe := 0
var brazier_built := false
var crafted_recipes: Dictionary = {"cataplasm": 0, "wheel_kit": 0, "brazier": 0}
var zone := 0
var mark_level := 0
var awakened := 0
var shadow_echoes := 0
var cured_allies: Array[String] = []
var selected_cure := 0
var ally_assists_used: Dictionary = {}
var final_echo_phase := false
var wagon_repair := 0
var recovered_load: Array[Dictionary] = []
var selected_load := 0
var velocity := Vector2.ZERO
var on_floor := true
var health := 3.0
var hurt_cooldown := 0.0
var player_facing_left := false
var dodge_time := 0.0
var dodge_cooldown := 0.0
var combo_step := 0
var combo_time := 0.0
var combo_target := ""
var salvage: Array[Dictionary] = []
var shades: Array[Dictionary] = []
var platforms: Array[Rect2] = []
var mark_gates: Array[Dictionary] = []
var echo_sense_time := 0.0
var mark_vfx_time := 0.0
var mark_vfx_kind := ""
var mark_vfx_pos := Vector2.ZERO
# B-05: the most recent player action drives the pose; hurt visuals follow real damage only.
var player_action := ""
var player_action_time := 0.0
var player_action_duration := 0.0
var player_animation_pose := "idle"
var player_animation_time := 0.0
var lolth_transform_time := 0.0
var hurt_flash_time := 0.0
var ui_management
var ui_gameplay_requests: Array[String] = []
var ui_enemy_bounds: Dictionary = {}
var ui_enemy_bounds_scans := 0
var ui_enemy_bounds_startup_usec := 0
# Encounter-specific source crops, prepared once at startup like the 22 atlas cells above.
var ui_encounter_bounds: Dictionary = {}
var ui_encounter_bounds_scans := 0
# B-08: the Harrier crop shares the encounter cache but keeps its own scan counter, so the
# B-07 crawler-crop count (1) keeps its meaning.
var ui_harrier_bounds_scans := 0
var message := "THE LAST CAMP — Keep them alive."
var message_time := 5.0
var state := "journey" # opening, journey, shar_shell, cure, victory, defeat
var opening_beat := 0
var tutorial_phase := "day_salvage" # day_salvage, dusk, night_defense, safe_camp, boss_encounter
var dusk_time := 0.0
# Set only by run_self_test() so it can exercise prototype later-region logic.
var self_test_travel_bypass := false
var shar_beat := 0
var antlered_hunger_defeated := false
var first_thread_cooldown := 0.0
# B-04 safe-wagon state: an in-memory operational snapshot, never written to disk.
var camp_secured := false
var safe_wagon_state: Dictionary = {}
var was_at_safe_wagon := false
# B-06 view offset along the route. Gameplay always uses world coordinates.
var camera_x := 0.0
var route_closed_notice := 0.0
# B-07 encounter. The live actor is transient world state; the three flags are operational
# progress saved with the safe-wagon snapshot. It never joins the cave's shades.
var scree_crawler: Dictionary = {}
var crawler_activated := false
var crawler_defeated := false
var crawler_reward_paid := false
# B-08 Cliff Harrier: an independent actor and independent flags, saved like the crawler's.
var cliff_harrier: Dictionary = {}
var harrier_activated := false
var harrier_defeated := false
var harrier_reward_paid := false
var passive_mission: Dictionary = {}
var mission_selected := 0
var posted_allies: Array[String] = []
var downed_drows: Array[String] = []
var selected_post_ally := 0
var zone_hazards: Array[Dictionary] = []
var rope_routes: Array[Dictionary] = []
var hazard_cooldown := 0.0
var axle_brakes_installed := false
var stonehook_boss_defeated := false
var stonehook_shar_ready := false
var hollowroot_boss_defeated := false
var hollowroot_mark_ready := false
var hollowroot_web_anchor_open := false
var pulse := 0.0
var playtester_active := false
var playtester_snapshot: Dictionary = {}
var playtester_panel: PanelContainer
var playtester_status: Label
var playtester_mark_down: Button
var playtester_mark_up: Button
var playtester_restore_button: Button
var playtester_toggle_button: Button
var playtester_resume_guard := false
var checkpoint := {"mark": 0, "zone": 0, "flame": 100.0, "provisions": 4.0, "awakened": 0, "final_echo_phase": false, "wagon_repair": 0, "load": [], "stock": [], "wagon_integrity": 100.0, "clock": DAY_DURATION, "echoes": 0, "cured": [], "posts": [], "downed": [], "first_night": false, "axle_brakes": false, "stonehook_boss": false, "stonehook_shar": false, "brazier": false, "crafted": {}}

func _ready() -> void:
	setup_input_actions()
	prepare_enemy_frame_bounds()
	prepare_encounter_bounds()
	ui_management = preload("res://wagon_inventory_ui.gd").new()
	add_child(ui_management)
	ui_management.setup(self)
	start_new_run()
	setup_playtester_panel()
	queue_redraw()
	if "--self-test" in OS.get_cmdline_user_args():
		call_deferred("run_self_test")

func setup_input_actions() -> void:
	for action in ["primary", "attack", "jump", "shadow_action", "camp_menu", "inventory", "skip", "camp_action", "shadow_strike"]:
		ensure_action(action)
		InputMap.action_erase_events(action)
	add_joy_motion_action("move_left", JOY_AXIS_LEFT_X, -1.0)
	add_joy_button_action("move_left", JOY_BUTTON_DPAD_LEFT)
	add_joy_motion_action("move_right", JOY_AXIS_LEFT_X, 1.0)
	add_joy_button_action("move_right", JOY_BUTTON_DPAD_RIGHT)
	add_key_action("primary", KEY_E)
	add_joy_button_action("primary", JOY_BUTTON_Y)
	add_key_action("attack", KEY_J)
	add_mouse_action("attack", MOUSE_BUTTON_LEFT)
	add_joy_button_action("attack", JOY_BUTTON_X)
	add_key_action("jump", KEY_SPACE)
	add_joy_button_action("jump", JOY_BUTTON_A)
	add_key_action("shadow_action", KEY_SHIFT)
	add_joy_motion_action("shadow_action", JOY_AXIS_TRIGGER_RIGHT, 1.0)
	add_key_action("inventory", KEY_I)
	add_key_action("camp_menu", KEY_M)
	add_joy_button_action("camp_menu", JOY_BUTTON_BACK)
	for retired in ["post_cycle", "post_toggle"]:
		if InputMap.has_action(retired):
			InputMap.erase_action(retired)
	add_key_action("skip", KEY_ESCAPE)
	add_joy_button_action("skip", JOY_BUTTON_START)
	add_key_action("camp_action", KEY_F)
	add_joy_button_action("camp_action", JOY_BUTTON_LEFT_SHOULDER)
	add_key_action("shadow_strike", KEY_C)
	add_joy_button_action("shadow_strike", JOY_BUTTON_B)
	if playtester_available():
		add_key_action("playtester_toggle", KEY_F4)

# These overrides are inspection tools, not ordinary narrative progression.
func playtester_available() -> bool:
	return OS.is_debug_build()

func setup_playtester_panel() -> void:
	if not playtester_available():
		return
	var layer := CanvasLayer.new()
	layer.layer = 10
	add_child(layer)
	var toggle := Button.new()
	toggle.text = "Playtester [F4]"
	toggle.position = Vector2(1060, 132)
	toggle.size = Vector2(196, 36)
	toggle.focus_mode = Control.FOCUS_NONE
	toggle.pressed.connect(toggle_playtester_panel)
	playtester_toggle_button = toggle
	layer.add_child(toggle)
	playtester_panel = PanelContainer.new()
	playtester_panel.position = Vector2(804, 178)
	playtester_panel.custom_minimum_size = Vector2(452, 0)
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color("11131f")
	panel_style.border_color = Color("8c7850")
	panel_style.set_border_width_all(1)
	panel_style.set_corner_radius_all(6)
	playtester_panel.add_theme_stylebox_override("panel", panel_style)
	layer.add_child(playtester_panel)
	var margin := MarginContainer.new()
	for edge in ["left", "top", "right", "bottom"]:
		margin.add_theme_constant_override("margin_" + edge, 16)
	playtester_panel.add_child(margin)
	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 12)
	margin.add_child(content)
	var heading := Label.new()
	heading.text = "PLAYTESTER"
	heading.add_theme_font_size_override("font_size", 22)
	content.add_child(heading)
	playtester_status = Label.new()
	playtester_status.custom_minimum_size.x = 420
	playtester_status.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	content.add_child(playtester_status)
	var marks := HBoxContainer.new()
	content.add_child(marks)
	playtester_mark_down = add_playtester_button(marks, "Mark -", playtester_change_mark.bind(-1))
	playtester_mark_up = add_playtester_button(marks, "Mark +", playtester_change_mark.bind(1))
	var time_buttons := HBoxContainer.new()
	content.add_child(time_buttons)
	add_playtester_button(time_buttons, "Next day", playtester_set_time.bind(false))
	add_playtester_button(time_buttons, "Next night", playtester_set_time.bind(true))
	playtester_restore_button = add_playtester_button(content, "Exit playtest and restore previous state", restore_playtester_session)
	add_playtester_button(content, "Close panel / resume [F4]", toggle_playtester_panel)
	playtester_panel.hide()
	refresh_playtester_panel()

func add_playtester_button(parent: Control, title: String, callback: Callable) -> Button:
	var button := Button.new()
	button.text = title
	button.custom_minimum_size.y = 36
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.focus_mode = Control.FOCUS_NONE
	button.pressed.connect(callback)
	parent.add_child(button)
	return button

func _input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if playtester_available() and event.is_action_pressed("playtester_toggle"):
		toggle_playtester_panel()
		get_viewport().set_input_as_handled()
	elif is_instance_valid(playtester_panel) and playtester_panel.visible and event.is_action_pressed("skip"):
		toggle_playtester_panel()
		get_viewport().set_input_as_handled()
	elif state == "journey" and event.is_action_pressed("inventory"):
		ui_management.toggle_inventory()
		get_viewport().set_input_as_handled()
	elif state == "journey" and event.is_action_pressed("camp_menu"):
		if event is InputEventJoypadButton and not at_wagon():
			ui_management.toggle_inventory()
		else:
			open_camp_menu()
		get_viewport().set_input_as_handled()
	elif ui_management.is_open():
		ui_management.handle_event(event)

# GUI widgets consume their clicks before any action can be queued in the world.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo() or state != "journey" or ui_management.is_open() or (is_instance_valid(playtester_panel) and playtester_panel.visible) or playtester_resume_guard:
		return
	for action in ["attack", "primary", "shadow_action", "shadow_strike", "camp_action"]:
		if event.is_action_pressed(action):
			ui_gameplay_requests.append(action)
			get_viewport().set_input_as_handled()
			return

func toggle_playtester_panel() -> void:
	if not playtester_available() or not is_instance_valid(playtester_panel):
		return
	ui_management.close_window()
	ui_gameplay_requests.clear()
	playtester_panel.visible = not playtester_panel.visible
	playtester_resume_guard = true
	refresh_playtester_panel()

func refresh_playtester_panel() -> void:
	if not is_instance_valid(playtester_status):
		return
	var mark_name := "UNMARKED" if mark_level == 0 else String(MARK_NAMES[mark_level])
	playtester_status.text = "Mark %d/9: %s\nTime: %s | State: %s\n%s\nWorld paused while this panel is open.\nMarks only: cure choices are unchanged. Levels 2-9 inspect existing prototype states." % [mark_level, mark_name, clock_label(), state, "Overrides active. Restore to return to your previous run." if playtester_active else "Your current run is preserved before the first override."]
	playtester_mark_down.disabled = mark_level <= 0
	playtester_mark_up.disabled = mark_level >= MARK_NAMES.size() - 1
	playtester_restore_button.disabled = not playtester_active
	playtester_toggle_button.text = "Playtest active [F4]" if playtester_active else "Playtester [F4]"

# Capture script-owned runtime variables, including checkpoints and mutable arrays.
# Tool variables are excluded so restoring gameplay never replaces scene objects.
func begin_playtester_session() -> void:
	if playtester_active:
		return
	playtester_snapshot.clear()
	for property in get_property_list():
		var property_name := String(property.name)
		if (int(property.usage) & PROPERTY_USAGE_SCRIPT_VARIABLE) == 0 or property_name.begins_with("playtester_") or property_name.begins_with("ui_"):
			continue
		var value: Variant = get(property_name)
		if value is Array or value is Dictionary:
			value = value.duplicate(true)
		playtester_snapshot[property_name] = value
	playtester_active = true

func prepare_playtester_override() -> void:
	begin_playtester_session()
	clear_combat_visuals()
	state = "journey"
	# Injected states cannot reuse an ordinary safe save from another Mark or time.
	camp_secured = false
	safe_wagon_state.clear()
	was_at_safe_wagon = false

func playtester_change_mark(amount: int) -> void:
	if not playtester_available():
		return
	var target_mark := clampi(mark_level + amount, 0, MARK_NAMES.size() - 1)
	if target_mark == mark_level:
		return
	var previous_mark := mark_level
	prepare_playtester_override()
	mark_level = target_mark
	begin_lolth_transformation(previous_mark)
	shadow_echoes = 0
	health = max_health()
	first_thread_cooldown = 0.0
	mark_vfx_time = 0.0
	# Returning to Mark 0 must not strand the clock in a marked-only phase.
	if zone == 0 and mark_level == 0:
		tutorial_phase = "night_defense" if is_night() else "day_salvage"
	create_checkpoint()
	message = "PLAYTEST: Mark set to %d. Cure choices unchanged." % mark_level
	message_time = 4.0
	refresh_playtester_panel()
	queue_redraw()

func playtester_set_time(night: bool) -> void:
	if not playtester_available():
		return
	prepare_playtester_override()
	dusk_time = 0.0
	# Use the real boundary handler for wave spawning and dawn cleanup.
	clock_seconds = DAY_DURATION - 0.01 if night else DAY_DURATION + NIGHT_DURATION - 0.01
	if zone == 0:
		tutorial_phase = "night_defense" if night and mark_level == 0 else "safe_camp"
	update_clock(0.02)
	create_checkpoint()
	message = "PLAYTEST: Next night started." if night else "PLAYTEST: Next day started."
	message_time = 4.0
	refresh_playtester_panel()
	queue_redraw()

func restore_playtester_session() -> void:
	if not playtester_available() or not playtester_active:
		return
	for property_name in playtester_snapshot:
		var value: Variant = playtester_snapshot[property_name]
		if value is Array or value is Dictionary:
			value = value.duplicate(true)
		set(property_name, value)
	playtester_snapshot.clear()
	playtester_active = false
	if is_instance_valid(playtester_panel):
		playtester_panel.hide()
	playtester_resume_guard = true
	refresh_playtester_panel()
	queue_redraw()

func ensure_action(action: String) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)

func add_key_action(action: String, keycode: Key) -> void:
	ensure_action(action)
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	InputMap.action_add_event(action, event)

func add_mouse_action(action: String, button: MouseButton) -> void:
	ensure_action(action)
	var event := InputEventMouseButton.new()
	event.button_index = button
	InputMap.action_add_event(action, event)

func add_joy_button_action(action: String, button: JoyButton) -> void:
	ensure_action(action)
	var event := InputEventJoypadButton.new()
	event.button_index = button
	InputMap.action_add_event(action, event)

func add_joy_motion_action(action: String, axis: JoyAxis, axis_value: float) -> void:
	ensure_action(action)
	var event := InputEventJoypadMotion.new()
	event.axis = axis
	event.axis_value = axis_value
	InputMap.action_add_event(action, event)

func run_self_test() -> void:
	var controls_bound := InputMap.action_get_events("move_left").size() >= 4 and InputMap.action_get_events("move_right").size() >= 4 and InputMap.action_get_events("primary").size() == 2 and InputMap.action_get_events("attack").size() == 3 and InputMap.action_get_events("inventory").size() == 1 and InputMap.action_get_events("jump").size() >= 2 and InputMap.action_get_events("shadow_action").size() == 2 and not InputMap.has_action("post_cycle") and not InputMap.has_action("post_toggle") and InputMap.action_get_events("skip").size() >= 2 and InputMap.action_get_events("camp_action").size() >= 2 and InputMap.action_get_events("shadow_strike").size() >= 2
	var opening_cave_ready := run_opening_cave_self_test()
	var thornwake_tutorial_ready := run_thornwake_tutorial_self_test()
	var first_boss_ready := run_first_boss_self_test()
	var stabilization_ready := run_mark_one_stabilization_self_test()
	var combat_readability_ready := run_combat_readability_self_test()
	var expedition_ready := run_stonehook_expedition_self_test()
	var encounter_ready := run_stonehook_encounter_self_test()
	var harrier_ready := run_cliff_harrier_self_test()
	if not run_playtester_self_test():
		get_tree().quit(1)
		return
	reset_to_prologue()
	player = Vector2(VIEW.x - 60.0, GROUND_Y - PLAYER_FEET_OFFSET)
	clock_seconds = DAY_DURATION + 1.0
	shades.clear()
	spawn_enemy("STAG OF MIRE", Vector2(CARAVAN_X + 12.0, GROUND_Y - 34), 2, 1)
	wagon_integrity = 1.0
	update_enemies(0.1)
	var wagon_hit_telegraphed := state == "journey" and String(shades[0].attack_state) == "windup"
	for _step in 20:
		update_enemies(0.1)
	var wagon_failure := wagon_hit_telegraphed and state == "defeat"
	reset_to_prologue()
	clock_seconds = DAY_DURATION - 0.01
	update_clock(0.02)
	var first_wave_ready := night_wave == 1 and night_wave_total == 2 and not shades.is_empty() and String(shades[0].name) == "BRIAR HOUND"
	for enemy in shades:
		enemy.defeated = true
	update_night_waves(0.0)
	update_night_waves(NIGHT_WAVE_INTERVAL)
	var second_wave_ready := night_wave == 2 and not shades.is_empty() and String(shades[0].name) == "STAG OF MIRE"
	spawn_enemy("COMBO TARGET", Vector2(330, GROUND_Y - 34), 10, 0)
	player = Vector2(330, GROUND_Y - 38)
	handle_attack()
	handle_attack()
	handle_attack()
	var combo_works := int(shades.back().health) == 6
	reset_to_prologue()
	for item in [{"name": "HERB", "type": "herb", "slots": 1}, {"name": "WATER", "type": "water", "slots": 1}, {"name": "WOOD", "type": "wood", "slots": 1}, {"name": "ROPE", "type": "rope", "slots": 1}, {"name": "SALVAGE", "type": "salvage", "slots": 1}]:
		wagon_stock.append(item)
	var stock_capacity := wagon_stock.size() == WAGON_STOCK_CAPACITY
	selected_recipe = 0
	craft_selected_recipe()
	var cataplasm_works := provisions > 4.0
	wagon_stock = [{"name": "WOOD", "type": "wood", "slots": 1}, {"name": "ROPE", "type": "rope", "slots": 1}, {"name": "SALVAGE", "type": "salvage", "slots": 1}]
	selected_recipe = 1
	craft_selected_recipe()
	var wheel_kit_works := wagon_repair == 1 and wagon_integrity > 80.0
	wagon_stock = [{"name": "WOOD", "type": "wood", "slots": 1}, {"name": "KINDLING", "type": "kindling", "slots": 1}, {"name": "SALVAGE", "type": "salvage", "slots": 1}]
	selected_recipe = 2
	craft_selected_recipe()
	var brazier_works := brazier_built
	perform_dodge(1.0)
	var dodge_works := dodge_time > 0.0 and hurt_cooldown > 0.0
	apply_mark_one()
	var cure_prompted := state == "cure" and mark_level == 1
	cure_selected_ally()
	var provisions_before_aelira := provisions
	# Prototype post regression only. Thornwake posts are unavailable in this slice.
	posted_allies = ["AELIRA"]
	player = ALLY_POSTS["AELIRA"]
	add_to_load({"name": "TEST HERB", "type": "herb", "slots": 1})
	var chosen_ally_helps := cured_allies.size() == 1 and awakened == 1 and provisions > provisions_before_aelira and state == "journey"
	downed_drows = ["AELIRA"]
	restore_drows_at_dawn()
	var drow_returns := downed_drows.is_empty()
	create_checkpoint()
	wagon_integrity = 0.0
	fail_run("test")
	restart_from_checkpoint()
	var checkpoint_restored := wagon_integrity > 0.0 and cured_allies.size() == 1 and state == "journey"
	reset_to_prologue()
	first_night_complete = true
	crafted_recipes.cataplasm = 1
	crafted_recipes.wheel_kit = 1
	brazier_built = true
	wagon_repair = 1
	try_advance_from_camp()
	var tutorial_never_starts_shar := state == "journey" and mark_level == 0
	# Prototype later-region regression only. The real hand-off is tested in run_first_boss_self_test().
	apply_mark_one()
	cure_selected_ally()
	var first_cure_stays_at_cave := state == "journey" and zone == 0 and mark_level == 1 and wagon_travel_locked()
	advance_to_stonehook()
	var first_cure_travel_blocked := zone == 0 and state == "journey"
	try_advance_from_camp()
	var first_mark_not_repeated := state == "journey" and mark_level == 1
	enter_stonehook()
	var direct_entry_blocked := zone == 0 and state == "journey"
	self_test_travel_bypass = true
	enter_stonehook()
	self_test_travel_bypass = false
	spawn_stonehook_night_enemies()
	var mountain_enemies_ready := shades.size() == 2
	shades.clear()
	player = zone_hazards[0].rect.get_center()
	hazard_cooldown = 0.0
	update_zone_hazards()
	var scree_works := absf(velocity.x) > 0.0
	wagon_stock = [{"name": "IRON ORE", "type": "metal", "slots": 1}, {"name": "IRON ORE", "type": "metal", "slots": 1}, {"name": "CLIMBING ROPE", "type": "rope", "slots": 1}, {"name": "BRAKE TOOL", "type": "tool", "slots": 1}]
	selected_recipe = 3
	craft_selected_recipe()
	var axle_brakes_work := axle_brakes_installed
	spawn_stonehook_night_enemies()
	var stone_maw_ready := shades.size() == 3
	shades.clear()
	player = rope_routes[0].from
	var rope_route_works := use_rope_route()
	stonehook_boss_defeated = true
	shadow_echoes = int(ECHO_THRESHOLDS[mark_level])
	open_stonehook_mark()
	var second_cure_prompted := state == "cure" and mark_level == 2
	cure_selected_ally()
	var hollowroot_ready := state == "stonehook_complete"
	advance_to_hollowroot()
	clock_seconds = DAY_DURATION + 1.0
	shades.clear()
	spawn_hollowroot_night_enemies()
	var hollowroot_enemies_ready := shades.size() == 3 and String(shades[0].name) == "ROOT WRAITH" and String(shades[2].name) == "ROOT CROWN"
	shades.clear()
	hollowroot_boss_defeated = true
	try_advance_from_camp()
	collect_echo(int(ECHO_THRESHOLDS[mark_level]))
	var third_cure_prompted := state == "cure" and mark_level == 3
	cure_selected_ally()
	player = mark_gates[0].pos
	handle_primary()
	var web_anchor_works := bool(mark_gates[0].opened) and hollowroot_boss_defeated and hollowroot_mark_ready and state == "journey"
	create_checkpoint()
	fail_run("hollowroot test")
	restart_from_checkpoint()
	var hollowroot_checkpoint := zone == 2 and mark_level == 3 and hollowroot_boss_defeated and hollowroot_web_anchor_open
	if controls_bound and opening_cave_ready and thornwake_tutorial_ready and first_boss_ready and stabilization_ready and combat_readability_ready and expedition_ready and encounter_ready and harrier_ready and wagon_failure and first_wave_ready and second_wave_ready and combo_works and stock_capacity and cataplasm_works and wheel_kit_works and brazier_works and dodge_works and cure_prompted and chosen_ally_helps and drow_returns and checkpoint_restored and tutorial_never_starts_shar and first_cure_stays_at_cave and first_cure_travel_blocked and first_mark_not_repeated and direct_entry_blocked and mountain_enemies_ready and scree_works and axle_brakes_work and stone_maw_ready and rope_route_works and second_cure_prompted and hollowroot_ready and hollowroot_enemies_ready and third_cure_prompted and web_anchor_works and hollowroot_checkpoint:
		print("SELF_TEST_PASS: Thornwake, Stonehook, and Hollowroot combat, cures, web crossing, checkpoints, and chapter transitions are ready")
		get_tree().quit(0)
	else:
		push_error("SELF_TEST_FAIL: Thornwake foundation did not complete")
		get_tree().quit(1)

# B-01 checks: opening shell to cave camp, eight plagued allies, damaged and travel-locked wagon.
func run_opening_cave_self_test() -> bool:
	start_new_run()
	var opens_first := state == "opening" and opening_beat == 0
	for _beat in H01_SHELL_BEATS.size() - 1:
		advance_opening()
	var holds_last_beat := state == "opening" and opening_beat == H01_SHELL_BEATS.size() - 1
	advance_opening()
	var advance_reaches_cave := is_cave_camp_start()
	start_new_run()
	advance_opening()
	skip_opening()
	var skip_reaches_cave := is_cave_camp_start()
	var camp := cave_camp_state()
	var allies: Array = camp.allies
	var eight_plagued := allies.size() == 8
	for ally in allies:
		eight_plagued = eight_plagued and String(ally.condition) == "plagued" and not bool(ally.controllable)
	var only_lolth_controllable: bool = camp.controllable == ["NOLF"]
	var wagon: Dictionary = camp.wagon
	var wagon_damaged_and_locked := bool(wagon.open) and not bool(wagon.horse) and not bool(wagon.beds) and not bool(wagon.enclosed_rooms) and String(wagon.condition) == "cave_damaged" and String(wagon.travel) == "travel_locked" and int(wagon.repair) == 0
	var relics_protected := bool(camp.relics.present) and bool(camp.relics.protected)
	advance_to_stonehook()
	var new_run_travel_blocked := zone == 0 and state == "journey" and is_cave_camp_start()
	var lolth_is_elf := String(camp.lolth_form) == "elf"
	wagon_integrity = 0.0
	fail_run("opening test")
	restart_from_checkpoint()
	var failure_restores_cave := is_cave_camp_start()
	var no_reference_board := not res_has_reference_board("res://")
	var passed := opens_first and holds_last_beat and advance_reaches_cave and skip_reaches_cave and eight_plagued and only_lolth_controllable and wagon_damaged_and_locked and relics_protected and new_run_travel_blocked and lolth_is_elf and failure_restores_cave and no_reference_board
	if passed:
		print("SELF_TEST_B01_PASS: opening shell reaches the day-start cave camp with eight plagued allies and a damaged, travel-locked wagon")
	else:
		push_error("SELF_TEST_B01_FAIL: opening=%s/%s/%s/%s allies=%s/%s wagon=%s relics=%s travel=%s elf=%s failure=%s boards=%s" % [opens_first, holds_last_beat, advance_reaches_cave, skip_reaches_cave, eight_plagued, only_lolth_controllable, wagon_damaged_and_locked, relics_protected, new_run_travel_blocked, lolth_is_elf, failure_restores_cave, no_reference_board])
	return passed

# B-02 checks: day salvage loop, Wheel Kit repair, nightfall, telegraphed defense, safe camp, and failure resets.
func run_thornwake_tutorial_self_test() -> bool:
	reset_to_prologue()
	advance_world_clock(DAY_DURATION * 3.0)
	var day_holds := is_cave_camp_start()
	var wagon_spot := Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	var gathered := 0
	for item_name in ["WOOD", "ROPE", "WHEEL SALVAGE"]:
		for item in salvage:
			if String(item.name) == item_name:
				player = item.pos
				handle_primary()
				gathered += 1 if bool(item.taken) else 0
		if load_used() >= load_capacity() or item_name == "WHEEL SALVAGE":
			player = wagon_spot
			while not recovered_load.is_empty():
				handle_primary()
	var loop_done := gathered == 3 and recovered_load.is_empty() and stock_count("wood") == 1 and stock_count("rope") == 1 and stock_count("salvage") == 1
	var recipe_shown := String(RECIPES[WHEEL_KIT_RECIPE].name) == "WHEEL KIT" and recipe_label(RECIPES[WHEEL_KIT_RECIPE]) == "1 WOOD, 1 ROPE, 1 SALVAGE" and current_objective() == "Stand at the Wagon and craft the WHEEL KIT."
	open_camp_menu()
	var recipe_locked := selected_recipe == WHEEL_KIT_RECIPE
	ui_management.close_window()
	wagon_stock.append({"name": "HERBS", "type": "herb", "slots": 1})
	var stock_before := wagon_stock.size()
	player = wagon_spot
	handle_primary()
	var inputs_consumed := wagon_stock.size() == stock_before - 3 and stock_count("herb") == 1
	var wagon_stationed := wagon_condition() == "stationed" and wagon_travel_locked() and tutorial_phase == "dusk" and not is_night()
	advance_to_stonehook()
	var still_no_travel: bool = zone == 0 and state == "journey" and mark_level == 0 and cave_camp_state().wagon.travel == "travel_locked"
	advance_world_clock(DUSK_DURATION * 0.5)
	var dusk_holds := tutorial_phase == "dusk" and shades.is_empty()
	advance_world_clock(DUSK_DURATION)
	var night_begins := tutorial_phase == "night_defense" and is_night() and night_wave == 1
	if not (day_holds and night_begins) or shades.is_empty():
		push_error("SELF_TEST_B02_FAIL: day=%s night=%s; the Wheel Kit repair must lead to the tutorial night" % [day_holds, night_begins])
		return false
	var seen_enemies: Array[String] = []
	for shade in shades:
		seen_enemies.append(String(shade.name))
	var hound: Dictionary = shades[0]
	player = Vector2(float(hound.pos.x) - 120.0, GROUND_Y - PLAYER_FEET_OFFSET)
	var health_before := health
	update_enemies(0.016)
	var hound_telegraphs := String(hound.attack_state) == "windup" and health == health_before and HOUND_WINDUP >= MIN_TELEGRAPH_TIME
	player = hound.pos
	handle_attack()
	update_night_waves(0.0)
	update_night_waves(NIGHT_WAVE_INTERVAL)
	for shade in shades:
		seen_enemies.append(String(shade.name))
	if shades.is_empty():
		push_error("SELF_TEST_B02_FAIL: the second tutorial wave did not spawn")
		return false
	var stag: Dictionary = shades[0]
	stag.pos.x = CARAVAN_X + 30.0
	player = Vector2(VIEW.x - 60.0, GROUND_Y - PLAYER_FEET_OFFSET)
	var integrity_before := wagon_integrity
	update_enemies(0.05)
	var stag_telegraphs := String(stag.attack_state) == "windup" and wagon_integrity == integrity_before and STAG_WINDUP >= MIN_TELEGRAPH_TIME
	var time_to_hit := 0.05
	while wagon_integrity == integrity_before and time_to_hit < 5.0:
		update_enemies(0.05)
		time_to_hit += 0.05
	var stag_hit_after_windup := wagon_integrity < integrity_before and time_to_hit >= MIN_TELEGRAPH_TIME and state == "journey"
	player = stag.pos
	handle_attack()
	handle_attack()
	update_night_waves(0.0)
	var only_tutorial_enemies := seen_enemies == ["BRIAR HOUND", "STAG OF MIRE"]
	var no_rewards := shadow_echoes == 0 and mark_level == 0 and cured_allies.is_empty() and state == "journey"
	var safe_camp := tutorial_phase == "safe_camp" and not is_night() and shades.is_empty() and zone == 0 and wagon_condition() == "stationed" and wagon_travel_locked()
	advance_world_clock(DAY_DURATION * 3.0)
	var safe_camp_holds := tutorial_phase == "safe_camp" and not is_night() and shades.is_empty()
	var resets: Array[bool] = []
	for failure in ["lolth", "wagon", "ally"]:
		reset_to_prologue()
		begin_dusk()
		update_thornwake_tutorial(DUSK_DURATION)
		match failure:
			"lolth":
				for _hit in 5:
					hurt_lolth()
			"wagon":
				wagon_integrity = 1.0
				damage_wagon(STAG_WAGON_HIT_DAMAGE, "STAG OF MIRE")
			"ally":
				provisions = 0.0
				check_survival_failures()
		var failed := state == "defeat"
		restart_from_checkpoint()
		resets.append(failed and is_cave_camp_start())
	var failures_reset := resets == [true, true, true]
	var passed := day_holds and loop_done and recipe_shown and recipe_locked and inputs_consumed and wagon_stationed and still_no_travel and dusk_holds and night_begins and hound_telegraphs and stag_telegraphs and stag_hit_after_windup and only_tutorial_enemies and no_rewards and safe_camp and safe_camp_holds and failures_reset
	if passed:
		print("SELF_TEST_B02_PASS: day salvage, Wheel Kit repair, nightfall, telegraphed defense, safe camp, and pre-Mark-I resets are ready")
	else:
		push_error("SELF_TEST_B02_FAIL: day=%s loop=%s recipe=%s/%s consumed=%s stationed=%s travel=%s dusk=%s night=%s telegraph=%s/%s/%s enemies=%s rewards=%s safe=%s/%s resets=%s" % [day_holds, loop_done, recipe_shown, recipe_locked, inputs_consumed, wagon_stationed, still_no_travel, dusk_holds, night_begins, hound_telegraphs, stag_telegraphs, stag_hit_after_windup, seen_enemies, no_rewards, safe_camp, safe_camp_holds, resets])
	return passed

# Drives the real B-02 tutorial functions from a fresh cave start to the safe camp.
func reach_safe_camp_for_test() -> void:
	reset_to_prologue()
	wagon_stock = [{"name": "WOOD", "type": "wood", "slots": 1}, {"name": "ROPE", "type": "rope", "slots": 1}, {"name": "WHEEL SALVAGE", "type": "salvage", "slots": 1}]
	player = Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	handle_primary()
	advance_world_clock(DUSK_DURATION)
	for _wave in TUTORIAL_NIGHT_WAVES:
		for enemy in shades:
			enemy.defeated = true
		update_night_waves(0.0)
		update_night_waves(NIGHT_WAVE_INTERVAL)

func defeat_boss_for_test() -> int:
	var hits := 0
	while not shades.is_empty() and not shades[0].defeated and hits < 40:
		player = shades[0].pos
		combo_time = 0.0
		health = max_health()
		handle_attack()
		hits += 1
	return hits

# B-03 checks: camp action, Antlered Hunger telegraphs, failure reset, Shar shell, Mark I, one cure, Echo cap, travel lock.
func run_first_boss_self_test() -> bool:
	reset_to_prologue()
	player = Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	use_camp_action()
	var no_boss_before_safe_camp := tutorial_phase == "day_salvage" and shades.is_empty()
	reach_safe_camp_for_test()
	var safe_camp_reached := tutorial_phase == "safe_camp" and state == "journey" and mark_level == 0
	advance_world_clock(DAY_DURATION * 3.0)
	var boss_not_automatic := tutorial_phase == "safe_camp" and shades.is_empty() and not is_night()
	player = Vector2(700.0, GROUND_Y - PLAYER_FEET_OFFSET)
	use_camp_action()
	var needs_wagon := tutorial_phase == "safe_camp" and shades.is_empty()
	player = Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	use_camp_action()
	var boss_started: bool = tutorial_phase == "boss_encounter" and shades.size() == 1 and String(shades[0].name) == "ANTLERED HUNGER" and is_night() and state == "journey"
	if not boss_started:
		push_error("SELF_TEST_B03_FAIL: before=%s safe=%s auto=%s wagon=%s started=%s" % [no_boss_before_safe_camp, safe_camp_reached, boss_not_automatic, needs_wagon, boss_started])
		return false
	var boss: Dictionary = shades[0]
	var only_boss := shades.size() == 1
	player = Vector2(float(boss.pos.x) - 150.0, GROUND_Y - PLAYER_FEET_OFFSET)
	var health_before := health
	update_enemies(0.016)
	var lunge_telegraphed: bool = String(boss.attack_state) == "windup" and String(boss.attack_target) == "lolth" and health == health_before
	var lunge_time := 0.016
	while health == health_before and lunge_time < 3.0:
		update_enemies(0.016)
		check_enemy_contact()
		lunge_time += 0.016
	var lunge_hits_after_windup := health < health_before and lunge_time >= MIN_TELEGRAPH_TIME and BOSS_WINDUP >= MIN_TELEGRAPH_TIME
	boss.attack_state = "approach"
	boss.attack_count = 2
	boss.pos.x = 900.0
	player = Vector2(700.0, GROUND_Y - PLAYER_FEET_OFFSET)
	hurt_cooldown = 99.0
	var integrity_before := wagon_integrity
	update_enemies(0.016)
	var wagon_charge_telegraphed: bool = String(boss.attack_state) == "windup" and String(boss.attack_target) == "wagon" and wagon_integrity == integrity_before
	var windup_x := float(boss.pos.x)
	update_enemies(MIN_TELEGRAPH_TIME - 0.05)
	wagon_charge_telegraphed = wagon_charge_telegraphed and String(boss.attack_state) == "windup" and float(boss.pos.x) == windup_x and BOSS_WAGON_WINDUP >= MIN_TELEGRAPH_TIME
	var charge_time := MIN_TELEGRAPH_TIME - 0.034
	while wagon_integrity == integrity_before and charge_time < 6.0:
		update_enemies(0.016)
		charge_time += 0.016
	var charge_hits_after_windup := wagon_integrity < integrity_before and charge_time >= BOSS_WAGON_WINDUP and state == "journey"
	hurt_cooldown = 0.0
	for _hit in 6:
		hurt_lolth()
	var boss_failure_reset := state == "defeat"
	restart_from_checkpoint()
	boss_failure_reset = boss_failure_reset and is_cave_camp_start() and not antlered_hunger_defeated
	reach_safe_camp_for_test()
	player = Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	use_camp_action()
	var hits := defeat_boss_for_test()
	var boss_defeated_by_melee := hits > 1 and antlered_hunger_defeated and state == "shar_shell" and mark_level == 0 and shadow_echoes == 0 and shades.is_empty()
	advance_shar_shell()
	var shell_advances := state == "shar_shell" and shar_beat == 1
	skip_shar_shell()
	var shell_skipped := state == "cure" and mark_level == 1
	defeat_antlered_hunger()
	apply_mark_one()
	var mark_once := state == "cure" and mark_level == 1
	var lolth_drow := lolth_form() == "drow"
	var eight_choices := available_allies().size() == 8 and available_allies() == THALESTRIEL
	var echoes_zero_before_cure := shadow_echoes == 0
	collect_echo(2)
	var no_echo_before_cure := shadow_echoes == 0
	select_next_cure()
	select_next_cure()
	cure_selected_ally()
	var chosen := String(THALESTRIEL[2])
	var records := ally_records()
	var cured_count := 0
	var plagued_count := 0
	for record in records:
		if String(record.condition) == "cured":
			cured_count += 1
		elif String(record.condition) == "plagued" and String(record.form) == "elf":
			plagued_count += 1
	var one_cure := cured_allies == [chosen] and cured_count == 1 and plagued_count == 7 and String(records[2].form) == "drow" and not bool(records[2].controllable) and state == "journey" and posted_allies.is_empty()
	cure_selected_ally()
	var no_second_cure := cured_allies.size() == 1
	var wagon_held := wagon_condition() == "stationed" and wagon_travel_locked()
	advance_to_stonehook()
	enter_stonehook()
	var travel_blocked := zone == 0 and state == "journey"
	spawn_enemy("BRIAR HOUND", Vector2(player.x + 40.0, GROUND_Y - 34), 1, 1)
	player = shades.back().pos
	combo_time = 0.0
	handle_attack()
	var echoes_after_cure := shadow_echoes == 1
	collect_echo(10)
	var echoes_capped := shadow_echoes == int(ECHO_THRESHOLDS[1]) and mark_level == 1 and state == "journey"
	player = Vector2(500.0, GROUND_Y - PLAYER_FEET_OFFSET)
	spawn_enemy("BRIAR HOUND", Vector2(600.0, GROUND_Y - 34), 5, 1)
	first_thread_cooldown = 0.0
	use_first_thread()
	var thread_hits := int(shades.back().health) == 3 and first_thread_cooldown > 0.0
	use_first_thread()
	var thread_cooldown := int(shades.back().health) == 3
	player = shades.back().pos
	combo_time = 0.0
	handle_attack()
	var melee_still_works := int(shades.back().health) == 2
	dodge_cooldown = 0.0
	perform_dodge(1.0)
	var dodge_still_works := dodge_time > 0.0
	shades.clear()
	wagon_integrity = 0.0
	fail_run("first boss test")
	restart_from_checkpoint()
	var marked_restore := mark_level == 1 and cured_allies == [chosen] and zone == 0 and wagon_condition() == "stationed" and wagon_travel_locked() and state == "journey"
	reset_to_prologue()
	player = Vector2(500.0, GROUND_Y - PLAYER_FEET_OFFSET)
	spawn_enemy("BRIAR HOUND", Vector2(560.0, GROUND_Y - 34), 5, 1)
	use_first_thread()
	var no_thread_before_mark := mark_level == 0 and lolth_form() == "elf" and int(shades.back().health) == 5
	shades.clear()
	reach_safe_camp_for_test()
	player = Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	use_camp_action()
	defeat_boss_for_test()
	var new_run_reaches_shell := state == "shar_shell" and mark_level == 0
	for _beat in H02_SHELL_BEATS.size():
		advance_shar_shell()
	var full_shell_applies_mark := state == "cure" and mark_level == 1 and shar_beat == 0
	var passed := no_boss_before_safe_camp and safe_camp_reached and boss_not_automatic and needs_wagon and only_boss and lunge_telegraphed and lunge_hits_after_windup and wagon_charge_telegraphed and charge_hits_after_windup and boss_failure_reset and boss_defeated_by_melee and shell_advances and shell_skipped and mark_once and lolth_drow and eight_choices and echoes_zero_before_cure and no_echo_before_cure and one_cure and no_second_cure and wagon_held and travel_blocked and echoes_after_cure and echoes_capped and thread_hits and thread_cooldown and melee_still_works and dodge_still_works and marked_restore and no_thread_before_mark and new_run_reaches_shell and full_shell_applies_mark
	if passed:
		print("SELF_TEST_B03_PASS: camp action starts a telegraphed Antlered Hunger; victory reaches the Xiar shell, Mark I, and exactly one cure with capped Echoes and a locked wagon (%d melee hits)" % hits)
	else:
		push_error("SELF_TEST_B03_FAIL: start=%s/%s/%s/%s boss=%s lunge=%s/%s charge=%s/%s reset=%s victory=%s shell=%s/%s mark=%s/%s choices=%s echoes=%s/%s cure=%s/%s wagon=%s travel=%s echo=%s/%s thread=%s/%s melee=%s dodge=%s restore=%s premark=%s replay=%s/%s" % [no_boss_before_safe_camp, safe_camp_reached, boss_not_automatic, needs_wagon, only_boss, lunge_telegraphed, lunge_hits_after_windup, wagon_charge_telegraphed, charge_hits_after_windup, boss_failure_reset, boss_defeated_by_melee, shell_advances, shell_skipped, mark_once, lolth_drow, eight_choices, echoes_zero_before_cure, no_echo_before_cure, one_cure, no_second_cure, wagon_held, travel_blocked, echoes_after_cure, echoes_capped, thread_hits, thread_cooldown, melee_still_works, dodge_still_works, marked_restore, no_thread_before_mark, new_run_reaches_shell, full_shell_applies_mark])
	return passed

# B-04 checks: safe-wagon capture, post-Mark-I restore, preserved Mark I and cure, Echo gate and cap, travel lock.
func run_mark_one_stabilization_self_test() -> bool:
	var wagon_spot := Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	var field_spot := Vector2(700.0, GROUND_Y - PLAYER_FEET_OFFSET)
	reset_to_prologue()
	wagon_integrity = 0.0
	fail_run("pre-mark test")
	restart_from_checkpoint()
	var pre_mark_reset := is_cave_camp_start() and not camp_secured and safe_wagon_state.is_empty()
	reach_safe_camp_for_test()
	player = wagon_spot
	use_camp_action()
	defeat_boss_for_test()
	skip_shar_shell()
	collect_echo(2)
	var no_early_echoes := state == "cure" and shadow_echoes == 0
	for _step in 4:
		select_next_cure()
	cure_selected_ally()
	var chosen := String(THALESTRIEL[4])
	var first_cure := cured_allies == [chosen] and mark_level == 1 and state == "journey"
	var return_objective := current_objective() == "Return to the Wagon to secure the camp." and not camp_secured
	player = field_spot
	update_safe_wagon()
	var no_capture_away := not camp_secured and safe_wagon_state.is_empty()
	var cure_stock := wagon_stock.size()
	wagon_stock.append({"name": "LOST HERBS", "type": "herb", "slots": 1})
	wagon_integrity = 0.0
	fail_run("before safe return")
	restart_from_checkpoint()
	var cure_fallback := state == "journey" and mark_level == 1 and cured_allies == [chosen] and not camp_secured and wagon_stock.size() == cure_stock and wagon_integrity > 0.0
	player = field_spot
	update_safe_wagon()
	wagon_stock.append({"name": "SAFE ROPE", "type": "rope", "slots": 1})
	spawn_enemy("BRIAR HOUND", Vector2(CARAVAN_X + 60.0, GROUND_Y - 34), 1, 1)
	player = wagon_spot
	update_safe_wagon()
	var no_unsafe_capture := not camp_secured
	shades.clear()
	update_safe_wagon()
	var captured := camp_secured and not safe_wagon_state.is_empty() and message.begins_with("CAMP SECURED")
	var secure_objective := current_objective() == "The Wagon is secure. Gather Shadow Echoes in Thornwake: 0/3."
	var saved_integrity := wagon_integrity
	var saved_stock := wagon_stock.size()
	var saved_provisions := provisions
	player = field_spot
	update_safe_wagon()
	wagon_stock.append({"name": "SPENT WOOD", "type": "wood", "slots": 1})
	wagon_integrity = 35.0
	collect_echo(1)
	provisions = 0.0
	check_survival_failures()
	var failed_after_safe_return := state == "defeat"
	restart_from_checkpoint()
	var restored := state == "journey" and zone == 0 and wagon_integrity == saved_integrity and wagon_stock.size() == saved_stock and saved_stock == cure_stock + 1 and provisions == saved_provisions and shadow_echoes == 0 and camp_secured
	var narrative_kept := mark_level == 1 and cured_allies == [chosen] and awakened == 1 and lolth_form() == "drow" and antlered_hunger_defeated
	var wagon_kept := wagon_condition() == "stationed" and wagon_travel_locked()
	player = field_spot
	update_safe_wagon()
	wagon_stock.append({"name": "DRY WOOD", "type": "wood", "slots": 1})
	collect_echo(2)
	player = wagon_spot
	update_safe_wagon()
	var latest_stock := wagon_stock.size()
	var latest_objective := current_objective() == "The Wagon is secure. Gather Shadow Echoes in Thornwake: 2/3."
	player = field_spot
	update_safe_wagon()
	wagon_stock.clear()
	collect_echo(1)
	health = 0.0
	hurt_cooldown = 0.0
	hurt_lolth()
	restart_from_checkpoint()
	var latest_restored := wagon_stock.size() == latest_stock and shadow_echoes == 2 and mark_level == 1 and cured_allies == [chosen]
	var terminal_kept_snapshot := true
	for terminal in ["flame", "provisions"]:
		var valid_snapshot := safe_wagon_state.duplicate(true)
		player = field_spot
		update_safe_wagon()
		wagon_stock.append({"name": "DOOMED WOOD", "type": "wood", "slots": 1})
		if terminal == "flame":
			flame = 0.0
		else:
			provisions = 0.0
		player = wagon_spot
		update_safe_wagon()
		var snapshot_unchanged := safe_wagon_state == valid_snapshot
		check_survival_failures()
		var failed := state == "defeat"
		restart_from_checkpoint()
		var restored_valid := state == "journey" and flame > 0.0 and provisions > 0.0 and wagon_stock.size() == latest_stock and shadow_echoes == 2 and mark_level == 1 and cured_allies == [chosen]
		check_survival_failures()
		terminal_kept_snapshot = terminal_kept_snapshot and snapshot_unchanged and failed and restored_valid and state == "journey"
	collect_echo(10)
	var capped := shadow_echoes == int(ECHO_THRESHOLDS[1]) and mark_level == 1 and state == "journey" and cured_allies.size() == 1
	var cap_objective := current_objective() == "The Wagon is secure. No deeper Mark can awaken in Thornwake."
	advance_to_stonehook()
	enter_stonehook()
	var travel_locked := zone == 0 and state == "journey" and wagon_travel_locked() and wagon_condition() == "stationed"
	reset_to_prologue()
	var new_run_clears := not camp_secured and safe_wagon_state.is_empty() and is_cave_camp_start()
	var passed := pre_mark_reset and no_early_echoes and first_cure and return_objective and no_capture_away and cure_fallback and no_unsafe_capture and captured and secure_objective and failed_after_safe_return and restored and narrative_kept and wagon_kept and latest_objective and latest_restored and terminal_kept_snapshot and capped and cap_objective and travel_locked and new_run_clears
	if passed:
		print("SELF_TEST_B04_PASS: safe-wagon capture, post-Mark-I restore, preserved Mark I and cure, Echo gate and cap, and travel lock are ready")
	else:
		push_error("SELF_TEST_B04_FAIL: premark=%s early=%s cure=%s/%s away=%s fallback=%s unsafe=%s capture=%s/%s fail=%s restore=%s narrative=%s wagon=%s latest=%s/%s terminal=%s cap=%s/%s travel=%s newrun=%s" % [pre_mark_reset, no_early_echoes, first_cure, return_objective, no_capture_away, cure_fallback, no_unsafe_capture, captured, secure_objective, failed_after_safe_return, restored, narrative_kept, wagon_kept, latest_objective, latest_restored, terminal_kept_snapshot, capped, cap_objective, travel_locked, new_run_clears])
	return passed

# B-05 checks: melee reach matches visible contact, misses are distinct, and attack, dodge,
# and hurt visuals follow the real game state.
func run_combat_readability_self_test() -> bool:
	reset_to_prologue()
	var floor_y := GROUND_Y - PLAYER_FEET_OFFSET
	var enemy_y := GROUND_Y - 34
	player = Vector2(500.0, floor_y)
	spawn_enemy("BRIAR HOUND", Vector2(580.0, enemy_y), 3, 1)
	var hound: Dictionary = shades.back()
	player_facing_left = true
	handle_attack()
	var contact_hit := int(hound.health) == 2 and player_pose() == "strike" and mark_vfx_kind == "strike" and float(hound.hit_flash) > 0.0 and not player_facing_left and shadow_echoes == 0
	shades.clear()
	combo_time = 0.0
	spawn_enemy("BRIAR HOUND", Vector2(630.0, enemy_y), 3, 1)
	hound = shades.back()
	player_action_time = 0.0
	handle_attack()
	var beyond_reach_misses := int(hound.health) == 3 and player_pose() == "strike" and mark_vfx_kind == "swing" and float(hound.hit_flash) == 0.0 and message.begins_with("Out of reach")
	shades.clear()
	spawn_enemy("BRIAR HOUND", Vector2(420.0, enemy_y), 3, 1)
	spawn_enemy("STAG OF MIRE", Vector2(575.0, enemy_y), 3, 1)
	var left_hound: Dictionary = shades[0]
	var right_stag: Dictionary = shades[1]
	combo_time = 0.0
	handle_attack()
	var nearest_and_facing := int(right_stag.health) == 2 and int(left_hound.health) == 3 and not player_facing_left
	shades.clear()
	combo_time = 0.0
	spawn_enemy("COMBO TARGET", Vector2(560.0, enemy_y), 10, 0)
	handle_attack()
	handle_attack()
	handle_attack()
	var combo_kept := int(shades.back().health) == 6
	shades.clear()
	health = max_health()
	hurt_cooldown = 0.0
	hurt_flash_time = 0.0
	player_action_time = 0.0
	dodge_cooldown = 0.0
	var dodge_health := health
	perform_dodge(1.0)
	var dodge_visual := player_pose() == "dodge" and not player_hurt_visible() and mark_vfx_kind == "dash" and health == dodge_health and hurt_cooldown > 0.0
	hurt_lolth()
	var dodge_blocks := health == dodge_health and player_pose() == "dodge" and not player_hurt_visible()
	dodge_time = 0.0
	hurt_cooldown = 0.0
	player_action_time = 0.0
	hurt_lolth()
	var real_hurt := health == dodge_health - 1.0 and player_pose() == "hurt" and player_hurt_visible()
	hurt_cooldown = 0.0
	hurt_flash_time = 0.0
	player_action_time = 0.0
	health = max_health()
	combo_time = 0.0
	spawn_enemy("BRIAR HOUND", Vector2(570.0, enemy_y), 3, 1)
	hound = shades.back()
	var overlap_lolth := health
	handle_attack()
	hound.pos = player
	check_enemy_contact()
	var overlap_readable := int(hound.health) == 2 and health == overlap_lolth - 1.0 and player_pose() == "hurt" and player_hurt_visible() and float(hound.hit_flash) > 0.0
	reset_to_prologue()
	clock_seconds = DAY_DURATION - 0.01
	update_clock(0.02)
	var wave_hound: Dictionary = shades[0]
	player = Vector2(float(wave_hound.pos.x) - 80.0, floor_y)
	handle_attack()
	update_night_waves(0.0)
	update_night_waves(NIGHT_WAVE_INTERVAL)
	var hound_defeated_wave_advances := bool(wave_hound.defeated) and night_wave == 2 and not shades.is_empty() and String(shades[0].name) == "STAG OF MIRE" and shadow_echoes == 0
	reset_to_prologue()
	apply_mark_one()
	cure_selected_ally()
	create_checkpoint()
	hurt_lolth()
	fail_run("generic restore visuals")
	restart_from_checkpoint()
	var restore_visuals_clean := not player_hurt_visible() and player_action_time == 0.0 and mark_vfx_time == 0.0 and dodge_time == 0.0
	reset_to_prologue()
	var passed := restore_visuals_clean and contact_hit and beyond_reach_misses and nearest_and_facing and combo_kept and dodge_visual and dodge_blocks and real_hurt and overlap_readable and hound_defeated_wave_advances
	if passed:
		print("SELF_TEST_B05_PASS: melee lands at visible contact, misses are distinct, and attack, dodge, and hurt visuals follow real damage")
	else:
		push_error("SELF_TEST_B05_FAIL: hit=%s miss=%s nearest=%s combo=%s dodge=%s/%s hurt=%s overlap=%s wave=%s" % [contact_hit, beyond_reach_misses, nearest_and_facing, combo_kept, dodge_visual, dodge_blocks, real_hurt, overlap_readable, hound_defeated_wave_advances])
	return passed

# B-06 test fixture: the legitimate first-cure path, then a safe return to the Wagon.
# B-06 corridor fixtures run with the B-07 encounter already resolved (flagged defeated before
# the safe capture, without paying its Echo), so their assertions keep their pre-B-07 meaning.
# B-07 checks pass with_encounter = true and exercise the crawler explicitly.
# B-07 suites pass with_encounter (live crawler); B-08 suites also pass with_harrier. Each
# encounter left out is marked already resolved (activated and defeated, no Echo paid), so
# B-06 and B-07 suites keep their original meaning beside the new actor.
func reach_expedition_ready_for_test(with_encounter := false, with_harrier := false) -> void:
	reach_safe_camp_for_test()
	player = Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	use_camp_action()
	defeat_boss_for_test()
	skip_shar_shell()
	cure_selected_ally()
	player = Vector2(CARAVAN_X + 20.0, GROUND_Y - PLAYER_FEET_OFFSET)
	if not with_encounter:
		crawler_activated = true
		crawler_defeated = true
	if not with_harrier:
		harrier_activated = true
		harrier_defeated = true
	was_at_safe_wagon = false
	update_safe_wagon()
	snap_camera()

# Real movement physics frame by frame (velocity, gated clamp, camera and arrival capture),
# without input devices. It stops at the target or when the route blocks Lolth.
func walk_route_for_test(target_x: float, max_frames := 2400) -> Dictionary:
	var dt := 1.0 / 60.0
	var result := {"max_step": 0.0, "camera_step": 0.0, "camera_at_cave": 0.0, "regions": [], "frames": 0}
	while absf(player.x - target_x) > 4.0 and int(result.frames) < max_frames:
		var previous_x := player.x
		var previous_camera := camera_x
		velocity = Vector2(signf(target_x - player.x) * 290.0, 0.0)
		move_player(dt)
		update_camera(dt)
		update_safe_wagon()
		result.max_step = maxf(float(result.max_step), absf(player.x - previous_x))
		result.camera_step = maxf(float(result.camera_step), absf(camera_x - previous_camera))
		if player.x <= CAMERA_WINDOW_RIGHT:
			result.camera_at_cave = maxf(float(result.camera_at_cave), camera_x)
		if result.regions.is_empty() or String(result.regions.back()) != lolth_region():
			result.regions.append(lolth_region())
		result.frames = int(result.frames) + 1
		if is_equal_approx(player.x, previous_x):
			break
	velocity = Vector2.ZERO
	result.x = player.x
	return result

func simulate_frames_for_test(frames: int) -> void:
	for _frame in frames:
		_process(1.0 / 60.0)

func load_has_pickup(pickup_id: String, items: Array) -> int:
	var count := 0
	for item in items:
		if String(item.get("id", "")) == pickup_id:
			count += 1
	return count

# B-06 checks. Each entry is a named assertion so faulty test subclasses can be identified.
func stonehook_expedition_checks() -> Dictionary:
	var checks := {}
	var floor_y := GROUND_Y - PLAYER_FEET_OFFSET
	var wagon_spot := Vector2(CARAVAN_X + 20.0, floor_y)
	var thornwake_limit := VIEW.x - PLAYER_EDGE_MARGIN
	var dt := 1.0 / 60.0
	# A new run keeps Lolth inside Thornwake with the original zero view offset.
	reset_to_prologue()
	var ore := route_ore_state()
	checks.new_run_ore_ready = not ore.is_empty() and not bool(ore.taken) and not bool(ore.renewable) and String(ore.type) == "metal" and int(ore.slots) == 1 and float(ore.pos.x) > ROUTE_FOOTHILLS_START_X and is_equal_approx(float(ore.pos.y), GROUND_Y - 34.0) and pickup_copies(ROUTE_ORE_ID) == 1
	player = Vector2(1000, floor_y)
	var walk := walk_route_for_test(ROUTE_END_X)
	checks.new_run_blocked = not expedition_departure_allowed() and float(walk.x) <= thornwake_limit and camera_x == 0.0
	reach_safe_camp_for_test()
	player = Vector2(1000, floor_y)
	walk = walk_route_for_test(ROUTE_END_X)
	checks.pre_boss_blocked = mark_level == 0 and float(walk.x) <= thornwake_limit and camera_x == 0.0
	player = wagon_spot
	use_camp_action()
	defeat_boss_for_test()
	skip_shar_shell()
	var uncured := state == "cure" and mark_level == 1 and not expedition_departure_allowed()
	# Walk as if the cure prompt were bypassed: Mark I alone still cannot open the route.
	state = "journey"
	player = Vector2(1000, floor_y)
	walk = walk_route_for_test(ROUTE_END_X)
	checks.uncured_mark_blocked = uncured and float(walk.x) <= thornwake_limit and camera_x == 0.0
	state = "cure"
	cure_selected_ally()
	player = Vector2(1000, floor_y)
	walk = walk_route_for_test(ROUTE_END_X)
	checks.unsecured_blocked = cured_allies.size() == 1 and not camp_secured and float(walk.x) <= thornwake_limit
	checks.debug_mark_blocked = true
	if playtester_available():
		reset_to_prologue()
		playtester_change_mark(1)
		player = Vector2(1000, floor_y)
		walk = walk_route_for_test(ROUTE_END_X)
		var debug_blocked := mark_level == 1 and not expedition_departure_allowed() and float(walk.x) <= thornwake_limit and camera_x == 0.0
		restore_playtester_session()
		checks.debug_mark_blocked = debug_blocked and mark_level == 0 and not playtester_active
	# Legitimate first cure plus a safe return opens the on-foot route only.
	reach_expedition_ready_for_test()
	var chosen: Array[String] = cured_allies.duplicate()
	var hub_before := cave_camp_state()
	hub_before.erase("lolth_region")
	var secured_snapshot := safe_wagon_state.duplicate(true)
	checks.legit_departure_allowed = expedition_departure_allowed() and camp_secured and wagon_travel_locked() and camera_x == 0.0 and lolth_region() == "thornwake"
	walk = walk_route_for_test(ROUTE_END_X)
	var max_walk_step := 290.0 * dt + 0.01
	checks.full_route_outward = absf(float(walk.x) - (ROUTE_END_X - PLAYER_EDGE_MARGIN)) < 0.5 and float(walk.max_step) <= max_walk_step and float(walk.camera_step) <= max_walk_step and float(walk.camera_at_cave) == 0.0 and is_equal_approx(camera_x, ROUTE_END_X - VIEW.x) and walk.regions == ["thornwake", "stonehook_approach", "stonehook_foothills"] and zone == 0 and state == "journey" and player.y == floor_y
	var hub_after := cave_camp_state()
	hub_after.erase("lolth_region")
	checks.hub_fixed = hub_after == hub_before and float(hub_after.anchor_x) == CARAVAN_X and wagon_travel_locked() and wagon_condition() == "stationed" and safe_wagon_state == secured_snapshot and cured_allies == chosen
	# Remote Wagon access is impossible from the foothills, whatever the view shows.
	player.x = ROUTE_FOOTHILLS_START_X + 40.0
	var stock_before := wagon_stock.duplicate(true)
	var crafted_before := crafted_recipes.duplicate(true)
	recovered_load.assign([{"name": "TEST HERB", "type": "herb", "slots": 1}])
	handle_primary()
	var no_store := recovered_load.size() == 1 and wagon_stock == stock_before
	recovered_load.clear()
	wagon_stock.assign([{"name": "WOOD", "type": "wood", "slots": 1}, {"name": "ROPE", "type": "rope", "slots": 1}, {"name": "SALVAGE", "type": "salvage", "slots": 1}])
	selected_recipe = WHEEL_KIT_RECIPE
	handle_primary()
	var no_craft := crafted_recipes == crafted_before and wagon_stock.size() == 3
	open_camp_menu()
	var menu_closed: bool = not ui_management.is_open()
	ui_management.open_window("wagon")
	menu_closed = menu_closed and not ui_management.is_open()
	recovered_load.assign([{"name": "TEST HERB", "type": "herb", "slots": 1}])
	ui_management.mode = "wagon"
	ui_management.store_load()
	ui_management.craft_recipe()
	ui_management.manage_ally(chosen[0])
	ui_management.select_mission(1)
	ui_management.mode = ""
	var callbacks_blocked := recovered_load.size() == 1 and wagon_stock.size() == 3 and crafted_recipes == crafted_before and posted_allies.is_empty() and passive_mission.is_empty()
	recovered_load.clear()
	wagon_stock = stock_before.duplicate(true)
	checks.remote_wagon_blocked = no_store and no_craft and menu_closed and callbacks_blocked and not at_wagon()
	was_at_safe_wagon = false
	update_safe_wagon()
	checks.remote_no_capture = safe_wagon_state == secured_snapshot
	ui_management.open_window("inventory")
	checks.remote_inventory_opens = ui_management.is_open() and ui_management.mode == "inventory"
	ui_management.close_window()
	# The single ore respects carried capacity and is collected once.
	player.x = ROUTE_ORE_X
	recovered_load.assign([{"name": "TEST WOOD", "type": "wood", "slots": 1}, {"name": "TEST ROPE", "type": "rope", "slots": 1}])
	handle_primary()
	checks.ore_full_load_retained = not bool(route_ore_state().taken) and recovered_load.size() == 2 and message.begins_with("RECOVERED LOAD is full")
	recovered_load.clear()
	handle_primary()
	var collected := bool(route_ore_state().taken) and load_has_pickup(ROUTE_ORE_ID, recovered_load) == 1
	handle_primary()
	checks.ore_collected_once = collected and recovered_load.size() == 1 and pickup_copies(ROUTE_ORE_ID) == 1
	# Border oscillation never respawns loot or enemies, or refills survival.
	var pickup_count := salvage.size()
	var enemy_count := shades.size()
	var flame_before := flame
	var provisions_before := provisions
	for _crossing in 3:
		walk_route_for_test(ROUTE_THORNWAKE_END_X - 100.0)
		walk_route_for_test(ROUTE_FOOTHILLS_START_X + 100.0)
	checks.border_no_respawn = salvage.size() == pickup_count and shades.size() == enemy_count and bool(route_ore_state().taken) and pickup_copies(ROUTE_ORE_ID) == 1 and flame <= flame_before and provisions <= provisions_before and safe_wagon_state == secured_snapshot
	# A terminal failure in the foothills rolls the unsaved ore back to the cave snapshot.
	walk_route_for_test(ROUTE_ORE_X)
	provisions = 0.0
	check_survival_failures()
	var failed_away := state == "defeat"
	restart_from_checkpoint()
	checks.foothill_rollback = failed_away and state == "journey" and zone == 0 and player.x == 330.0 and camera_x == 0.0 and not bool(route_ore_state().taken) and load_has_pickup(ROUTE_ORE_ID, recovered_load) == 0 and pickup_copies(ROUTE_ORE_ID) == 1 and provisions > 0.0 and mark_level == 1 and cured_allies == chosen and camp_secured and expedition_departure_allowed()
	# Carry the ore back. Arrival captures a consistent snapshot; deposit keeps one copy.
	walk_route_for_test(ROUTE_ORE_X)
	handle_primary()
	walk = walk_route_for_test(wagon_spot.x)
	var saved_taken: Dictionary = safe_wagon_state.get("pickup_taken", {})
	checks.return_captures = at_wagon() and camera_x == 0.0 and float(walk.max_step) <= max_walk_step and camp_secured and bool(saved_taken.get(ROUTE_ORE_ID, false)) and load_has_pickup(ROUTE_ORE_ID, safe_wagon_state.load) == 1 and load_has_pickup(ROUTE_ORE_ID, safe_wagon_state.stock) == 0
	var stock_saved := wagon_stock.duplicate(true)
	wagon_stock.clear()
	for index in WAGON_STOCK_CAPACITY:
		wagon_stock.append({"name": "FULL %d" % index, "type": "wood", "slots": 1})
	handle_primary()
	checks.full_stock_retains_ore = load_has_pickup(ROUTE_ORE_ID, recovered_load) == 1 and wagon_stock.size() == WAGON_STOCK_CAPACITY and message.begins_with("WAGON STOCK is full")
	wagon_stock = stock_saved
	handle_primary()
	checks.ore_deposited_once = load_has_pickup(ROUTE_ORE_ID, wagon_stock) == 1 and load_has_pickup(ROUTE_ORE_ID, recovered_load) == 0 and pickup_copies(ROUTE_ORE_ID) == 1
	walk_route_for_test(700.0)
	walk_route_for_test(wagon_spot.x)
	saved_taken = safe_wagon_state.get("pickup_taken", {})
	checks.recapture_consistent = bool(saved_taken.get(ROUTE_ORE_ID, false)) and load_has_pickup(ROUTE_ORE_ID, safe_wagon_state.stock) == 1 and load_has_pickup(ROUTE_ORE_ID, safe_wagon_state.load) == 0
	flame = 0.0
	check_survival_failures()
	restart_from_checkpoint()
	checks.deposit_survives_restore = state == "journey" and load_has_pickup(ROUTE_ORE_ID, wagon_stock) == 1 and bool(route_ore_state().taken) and pickup_copies(ROUTE_ORE_ID) == 1 and flame > 0.0
	# The camp keeps living while Lolth is away: clock, survival, waves and a real Stag.
	walk_route_for_test(ROUTE_FOOTHILLS_START_X + 600.0)
	var away_x := player.x
	var away_camera := camera_x
	var health_before := health
	clock_seconds = DAY_DURATION - 0.05
	flame_before = flame
	provisions_before = provisions
	var clock_before := clock_seconds
	simulate_frames_for_test(30)
	checks.offscreen_clock_runs = is_night() and clock_seconds > clock_before and flame < flame_before and provisions < provisions_before and night_wave == 1 and shades.size() == 1 and String(shades[0].name) == "BRIAR HOUND"
	simulate_frames_for_test(600)
	checks.enemy_keeps_origin = not shades.is_empty() and float(shades[0].pos.x) <= ROUTE_THORNWAKE_END_X - ENEMY_EDGE_MARGIN and int(shades[0].get("origin_zone", -1)) == 0 and health == health_before and player.x == away_x and state == "journey"
	shades.clear()
	spawn_enemy("STAG OF MIRE", Vector2(CARAVAN_X + 300.0, GROUND_Y - 34), 2, 1)
	var integrity_before := wagon_integrity
	var saw_windup := false
	for _frame in 600:
		_process(dt)
		saw_windup = saw_windup or (not shades.is_empty() and String(shades[0].attack_state) == "windup")
		if wagon_integrity < integrity_before:
			break
	checks.offscreen_stag_damage = saw_windup and wagon_integrity < integrity_before and player.x == away_x and camera_x == away_camera and state == "journey"
	wagon_integrity = 1.0
	for _frame in 600:
		_process(dt)
		if state != "journey":
			break
	var destroyed := state == "defeat"
	restart_from_checkpoint()
	checks.offscreen_terminal_restore = destroyed and state == "journey" and player.x == 330.0 and camera_x == 0.0 and mark_level == 1 and cured_allies == chosen and wagon_integrity > 0.0 and not is_night() and load_has_pickup(ROUTE_ORE_ID, wagon_stock) == 1 and pickup_copies(ROUTE_ORE_ID) == 1
	# F4 overrides cannot open the route but never trap Lolth, and restore is exact.
	checks.f4_override_gate = true
	checks.f4_exact_restore = true
	if playtester_available():
		walk_route_for_test(2200.0)
		var before := {"player": player, "camera": camera_x, "salvage": salvage.duplicate(true), "load": recovered_load.duplicate(true), "stock": wagon_stock.duplicate(true), "safe": safe_wagon_state.duplicate(true), "secured": camp_secured, "clock": clock_seconds}
		playtester_change_mark(1)
		var override_blocks := not expedition_departure_allowed() and safe_wagon_state.is_empty()
		walk_route_for_test(player.x - 200.0)
		var returned_x := player.x
		walk_route_for_test(ROUTE_END_X)
		checks.f4_override_gate = override_blocks and returned_x < float(before.player.x) - 150.0 and player.x == returned_x
		restore_playtester_session()
		checks.f4_exact_restore = player == before.player and camera_x == before.camera and salvage == before.salvage and recovered_load == before.load and wagon_stock == before.stock and safe_wagon_state == before.safe and camp_secured == before.secured and clock_seconds == before.clock and mark_level == 1 and expedition_departure_allowed()
	# The far route end, capped Echoes and old controls unlock nothing.
	walk_route_for_test(ROUTE_END_X)
	collect_echo(10)
	try_advance_from_camp()
	handle_primary()
	advance_to_stonehook()
	enter_stonehook()
	use_camp_action()
	checks.no_progression_unlock = zone == 0 and mark_level == 1 and shadow_echoes == int(ECHO_THRESHOLDS[1]) and state == "journey" and cured_allies == chosen and posted_allies.is_empty() and passive_mission.is_empty() and wagon_travel_locked() and not axle_brakes_installed and not stonehook_boss_defeated and not stonehook_shar_ready and mark_gates.is_empty() and ui_management.recipe_locked(3)
	# Combat still uses world positions under a nonzero view offset.
	walk_route_for_test(300.0)
	walk_route_for_test(1150.0)
	var offset := camera_x
	shades.clear()
	spawn_enemy("BRIAR HOUND", Vector2(player.x + 60.0, GROUND_Y - 34), 3, 1)
	hurt_cooldown = 99.0
	handle_attack()
	var melee_hit := int(shades[0].health) == 2
	first_thread_cooldown = 0.0
	use_first_thread()
	checks.camera_offset_combat = offset > 0.0 and is_equal_approx(offset, player.x - CAMERA_WINDOW_RIGHT) and melee_hit and bool(shades[0].defeated)
	shades.clear()
	# A new run clears every expedition field and closes the route again.
	reset_to_prologue()
	var reset_ok := camera_x == 0.0 and player.x == 330.0 and not bool(route_ore_state().taken) and pickup_copies(ROUTE_ORE_ID) == 1 and not camp_secured and safe_wagon_state.is_empty() and wagon_stock.is_empty() and recovered_load.is_empty() and not expedition_departure_allowed()
	player = Vector2(1000, floor_y)
	walk = walk_route_for_test(ROUTE_END_X)
	checks.new_run_resets = reset_ok and float(walk.x) <= thornwake_limit and camera_x == 0.0
	reset_to_prologue()
	return checks

func run_stonehook_expedition_self_test() -> bool:
	var checks := stonehook_expedition_checks()
	var failed: Array[String] = []
	for check_name in checks:
		if not bool(checks[check_name]):
			failed.append(String(check_name))
	if failed.is_empty():
		print("SELF_TEST_B06_PASS: legitimate on-foot departure, continuous route, fixed cave Wagon, single ore, offscreen camp, restore and new-run reset are ready (%d checks)" % checks.size())
	else:
		push_error("SELF_TEST_B06_FAIL: %s" % ", ".join(failed))
	return failed.is_empty()

# B-07 test fixtures. Encounter frames run the crawler with Lolth's own combat timers.
func encounter_frames_for_test(frames: int, dt: float = 1.0 / 60.0) -> void:
	for _frame in frames:
		hurt_cooldown = maxf(0.0, hurt_cooldown - dt)
		dodge_time = maxf(0.0, dodge_time - dt)
		update_foothill_encounter(dt)

func enter_foothills_for_test(x: float = ROUTE_FOOTHILLS_START_X + 140.0) -> void:
	player = Vector2(x, GROUND_Y - PLAYER_FEET_OFFSET)
	velocity = Vector2.ZERO
	encounter_frames_for_test(1)

# Re-establishes a live crawler when an earlier section lost it, so that a fault fails its
# named assertion instead of crashing later sections. Baseline runs never need the re-setup.
func ensure_crawler_for_test(checks: Dictionary) -> bool:
	if scree_crawler.is_empty():
		reach_expedition_ready_for_test(true)
		enter_foothills_for_test()
		checks.section_fixtures_ready = false
	return not scree_crawler.is_empty()

# Holds the crawler still (a long recovery) so attacks can be measured at exact gaps.
func hold_crawler_for_test(health_value: int, x: float = SCREE_CRAWLER_HOME_X) -> void:
	if scree_crawler.is_empty():
		return
	scree_crawler.health = health_value
	scree_crawler.pos = Vector2(x, GROUND_Y - 34)
	scree_crawler.attack_state = "recover"
	scree_crawler.attack_time = 99.0
	scree_crawler.hit_flash = 0.0

func arm_crawler_for_test(x: float = SCREE_CRAWLER_HOME_X) -> void:
	if scree_crawler.is_empty():
		return
	scree_crawler.health = 10
	scree_crawler.pos = Vector2(x, GROUND_Y - 34)
	scree_crawler.attack_state = "approach"
	scree_crawler.attack_time = 0.0
	scree_crawler.strike_spent = false

# B-07 checks. Each entry is a named assertion so faulty test subclasses can be identified.
func stonehook_encounter_checks() -> Dictionary:
	var checks := {"section_fixtures_ready": true}
	var floor_y := GROUND_Y - PLAYER_FEET_OFFSET
	var scans_before := ui_enemy_bounds_scans
	# Only legitimate foothill entry creates the crawler. Lolth is placed past closed gates
	# here on purpose, to prove the spawn guard itself rather than the route clamp.
	reset_to_prologue()
	enter_foothills_for_test()
	encounter_frames_for_test(30)
	var new_run_locked := scree_crawler.is_empty() and not crawler_activated
	reach_safe_camp_for_test()
	enter_foothills_for_test()
	var tutorial_locked := scree_crawler.is_empty() and not crawler_activated
	reach_safe_camp_for_test()
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	use_camp_action()
	defeat_boss_for_test()
	skip_shar_shell()
	cure_selected_ally()
	enter_foothills_for_test()
	var unsecured_locked := scree_crawler.is_empty() and not crawler_activated
	var debug_locked := true
	if playtester_available():
		reset_to_prologue()
		playtester_change_mark(1)
		enter_foothills_for_test()
		debug_locked = scree_crawler.is_empty() and not crawler_activated
		restore_playtester_session()
	checks.locked_contexts_no_crawler = new_run_locked and tutorial_locked and unsecured_locked and debug_locked
	reach_expedition_ready_for_test(true)
	var cave_clear := scree_crawler.is_empty() and not crawler_activated
	player = Vector2(ROUTE_FOOTHILLS_START_X - 40.0, floor_y)
	encounter_frames_for_test(10)
	var band_clear := scree_crawler.is_empty()
	enter_foothills_for_test()
	checks.legit_entry_spawns_one = cave_clear and band_clear and not scree_crawler.is_empty() and String(scree_crawler.encounter_id) == SCREE_CRAWLER_ID and String(scree_crawler.region) == "stonehook_foothills" and int(scree_crawler.health) == SCREE_CRAWLER_HEALTH and float(scree_crawler.pos.x) == SCREE_CRAWLER_HOME_X and live_scree_crawler_count() == 1 and crawler_activated and shades.is_empty() and zone == 0
	# Border oscillation, nightfall and dawn keep the same live actor and its health.
	var actor := scree_crawler
	scree_crawler.health = 2
	for _crossing in 3:
		player.x = ROUTE_FOOTHILLS_START_X - 260.0
		encounter_frames_for_test(20)
		player.x = ROUTE_FOOTHILLS_START_X + 140.0
		encounter_frames_for_test(20)
	clock_seconds = DAY_DURATION - 0.01
	update_clock(0.02)
	var night_kept := is_same(scree_crawler, actor) and is_night() and night_wave == 1
	clock_seconds = DAY_DURATION + NIGHT_DURATION - 0.01
	update_clock(0.02)
	checks.oscillation_and_days_keep_actor = night_kept and is_same(scree_crawler, actor) and not is_night() and int(scree_crawler.health) == 2 and live_scree_crawler_count() == 1
	# Geometry: the crawler's own crop, native aspect, grounded feet, a 120 px visible body.
	if not ensure_crawler_for_test(checks):
		return checks
	hold_crawler_for_test(10)
	var geometry := enemy_draw_geometry(scree_crawler)
	var source: Rect2 = geometry.source
	var destination: Rect2 = geometry.destination
	var body: Rect2 = geometry.body
	var cached := enemy_frame_bounds(STONEHOOK_THREATS_RUNTIME, source)
	var uniform := is_equal_approx(destination.size.x / source.size.x, destination.size.y / source.size.y)
	checks.geometry_crawler_crop = source == Rect2(0, 0, 768, 480) and source.end.y < 484.0 and source.end.x <= 768.0 and cached == Rect2i(84, 59, 622, 414) and uniform and absf(body.size.y - SCREE_CRAWLER_BODY_HEIGHT) < 0.01 and is_equal_approx(body.end.y, GROUND_Y) and is_equal_approx(body.get_center().x, float(scree_crawler.pos.x))
	var reach := melee_reach(scree_crawler)
	checks.reach_matches_body = is_equal_approx(reach, MELEE_LOLTH_HALF_WIDTH + body.size.x / 2.0) and body.size.x / 2.0 > 60.0
	# Melee and FIRST THREAD hit inside the visible reach and miss outside it.
	var crawler_x := float(scree_crawler.pos.x)
	player = Vector2(crawler_x - (reach - 2.0), floor_y)
	combo_time = 0.0
	hurt_flash_time = 0.0
	handle_attack()
	var melee_hit := int(scree_crawler.health) == 9 and player_pose() == "strike" and not player_hurt_visible()
	player.x = crawler_x - (reach + 2.0)
	combo_time = 0.0
	handle_attack()
	var melee_miss := int(scree_crawler.health) == 9 and message.begins_with("Out of reach") and not player_hurt_visible()
	player.y = floor_y - (MELEE_VERTICAL_REACH + 8.0)
	player.x = crawler_x - (reach - 2.0)
	combo_time = 0.0
	handle_attack()
	var vertical_miss := int(scree_crawler.health) == 9
	player.y = floor_y
	checks.melee_hit_and_miss = melee_hit and melee_miss and vertical_miss
	var thread_reach := maxf(FIRST_THREAD_RANGE, reach)
	player.x = crawler_x - (thread_reach - 2.0)
	first_thread_cooldown = 0.0
	use_first_thread()
	var thread_hit := int(scree_crawler.health) == 7 and first_thread_cooldown > 0.0
	player.x = crawler_x - (thread_reach + 2.0)
	first_thread_cooldown = 0.0
	use_first_thread()
	checks.first_thread_hit_and_miss = thread_hit and int(scree_crawler.health) == 7 and message.begins_with("FIRST THREAD finds no target")
	# Windup precedes every strike, keeps a visible warning and locks the lunge direction.
	arm_crawler_for_test()
	health = max_health()
	hurt_cooldown = 0.0
	dodge_time = 0.0
	player = Vector2(float(scree_crawler.pos.x) - (scree_crawler_strike_range() - 4.0), floor_y)
	encounter_frames_for_test(1)
	var windup_started := String(scree_crawler.attack_state) == "windup" and scree_crawler_warning_visible()
	var locked_dir := float(scree_crawler.attack_dir)
	var windup_frames := 1
	var warning_throughout := true
	player.x = float(scree_crawler.pos.x) + 60.0
	while String(scree_crawler.attack_state) == "windup" and windup_frames < 200:
		warning_throughout = warning_throughout and scree_crawler_warning_visible()
		encounter_frames_for_test(1)
		windup_frames += 1
	var windup_seconds := float(windup_frames) / 60.0
	var lunge_from := float(scree_crawler.pos.x)
	encounter_frames_for_test(5)
	checks.windup_precedes_strike = windup_started and warning_throughout and windup_seconds >= MIN_TELEGRAPH_TIME and absf(windup_seconds - SCREE_CRAWLER_WINDUP) <= 2.0 / 60.0 and locked_dir < 0.0 and float(scree_crawler.attack_dir) == locked_dir and float(scree_crawler.pos.x) < lunge_from
	# One strike wounds Lolth at most once, even with no hurt cooldown left to protect her.
	# Armed clear of the patrol bound so the full lunge can travel.
	arm_crawler_for_test(SCREE_CRAWLER_HOME_X + 120.0)
	health = max_health()
	var health_before_strike := health
	player = Vector2(float(scree_crawler.pos.x) - (scree_crawler_strike_range() - 4.0), floor_y)
	var strike_frames := 0
	while strike_frames < 200 and String(scree_crawler.attack_state) != "recover":
		hurt_cooldown = 0.0
		encounter_frames_for_test(1)
		strike_frames += 1
	var hit_at_60 := health == health_before_strike - 1.0 and bool(scree_crawler.strike_spent) and state == "journey"
	# The same unavoided lunge at 16 frames per second (four exact 0.0625 s lunge frames)
	# still connects exactly once; contact is tested after each frame's motion.
	arm_crawler_for_test(SCREE_CRAWLER_HOME_X + 120.0)
	health = max_health()
	player = Vector2(float(scree_crawler.pos.x) - (scree_crawler_strike_range() - 4.0), floor_y)
	strike_frames = 0
	while strike_frames < 100 and String(scree_crawler.attack_state) != "recover":
		hurt_cooldown = 0.0
		encounter_frames_for_test(1, 1.0 / 16.0)
		strike_frames += 1
	checks.single_hit_per_strike = hit_at_60 and health == max_health() - 1.0 and bool(scree_crawler.strike_spent) and state == "journey"
	# Dash invulnerability avoids the lunge, which is then spent.
	arm_crawler_for_test(SCREE_CRAWLER_HOME_X + 120.0)
	health = max_health()
	hurt_cooldown = 0.0
	player = Vector2(float(scree_crawler.pos.x) - (scree_crawler_strike_range() - 4.0), floor_y)
	while String(scree_crawler.attack_state) != "strike":
		encounter_frames_for_test(1)
	dodge_time = DODGE_DURATION
	while String(scree_crawler.attack_state) == "strike":
		encounter_frames_for_test(1)
	checks.dash_avoids_strike = health == max_health() and bool(scree_crawler.strike_spent)
	# Retreat out of the foothills cancels a pending strike; the crawler never follows or hits.
	arm_crawler_for_test(scree_crawler_limits().x)
	health = max_health()
	hurt_cooldown = 0.0
	player = Vector2(float(scree_crawler.pos.x) - (scree_crawler_strike_range() - 4.0), floor_y)
	encounter_frames_for_test(2)
	var pending := String(scree_crawler.attack_state) == "windup"
	player.x = ROUTE_FOOTHILLS_START_X - 6.0
	encounter_frames_for_test(1)
	var cancelled := String(scree_crawler.attack_state) == "approach"
	var held_x := float(scree_crawler.pos.x)
	var integrity_before := wagon_integrity
	for _frame in 900:
		encounter_frames_for_test(1)
	checks.retreat_cancels_pending_strike = pending and cancelled and health == max_health() and float(scree_crawler.pos.x) == held_x and wagon_integrity == integrity_before and String(scree_crawler.attack_state) == "approach"
	# With Lolth just inside the border, approach and lunges stop at the patrol bound.
	player.x = ROUTE_FOOTHILLS_START_X + 6.0
	hurt_cooldown = 99.0
	var min_body_x := INF
	for _frame in 900:
		hurt_cooldown = 99.0
		encounter_frames_for_test(1)
		min_body_x = minf(min_body_x, enemy_draw_geometry(scree_crawler).body.position.x)
	checks.crawler_stays_in_foothills = min_body_x >= ROUTE_FOOTHILLS_START_X - 0.01 and min_body_x >= SCREE_CRAWLER_PATROL.x - 0.01 and is_equal_approx(float(scree_crawler.pos.x), scree_crawler_limits().x) and wagon_integrity == integrity_before
	# Cave waves, wave completion, dawn and real Stag damage coexist with a live crawler.
	reach_expedition_ready_for_test(true)
	enter_foothills_for_test(ROUTE_END_X - PLAYER_EDGE_MARGIN)
	var coexisting := scree_crawler
	scree_crawler.health = 2
	clock_seconds = DAY_DURATION - 0.05
	simulate_frames_for_test(30)
	var night_with_crawler := is_night() and night_wave == 1 and shades.size() == 1 and is_same(scree_crawler, coexisting) and int(scree_crawler.health) == 2
	for _wave in TUTORIAL_NIGHT_WAVES:
		for enemy in shades:
			enemy.defeated = true
		update_night_waves(0.0)
		update_night_waves(NIGHT_WAVE_INTERVAL)
	checks.crawler_does_not_stall_waves = night_with_crawler and night_waves_complete and live_scree_crawler_count() == 1 and is_same(scree_crawler, coexisting)
	shades.clear()
	spawn_enemy("STAG OF MIRE", Vector2(CARAVAN_X + 300.0, GROUND_Y - 34), 2, 1)
	var wagon_before := wagon_integrity
	for _frame in 600:
		_process(1.0 / 60.0)
		if wagon_integrity < wagon_before:
			break
	checks.offscreen_stag_with_crawler = wagon_integrity < wagon_before and state == "journey" and live_scree_crawler_count() == 1 and is_same(scree_crawler, coexisting)
	shades.clear()
	clock_seconds = DAY_DURATION + NIGHT_DURATION - 0.01
	update_clock(0.02)
	var dawn_kept := is_same(scree_crawler, coexisting) and not is_night()
	# A live foothill crawler neither blocks a valid cave capture nor makes an unsafe cave safe.
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	was_at_safe_wagon = false
	var captured_before := safe_wagon_state.duplicate(true)
	spawn_enemy("BRIAR HOUND", Vector2(CARAVAN_X + 90.0, GROUND_Y - 34), 1, 1)
	update_safe_wagon()
	var unsafe_kept := safe_wagon_state == captured_before
	shades.clear()
	was_at_safe_wagon = false
	update_safe_wagon()
	var saved_crawler: Dictionary = safe_wagon_state.get("crawler", {})
	checks.safe_capture_with_live_crawler = dawn_kept and unsafe_kept and safe_wagon_state != captured_before and bool(saved_crawler.get("activated", false)) and not bool(saved_crawler.get("defeated", true)) and live_scree_crawler_count() == 1
	# The ore and the deposit loop do not require defeating the crawler.
	player = Vector2(ROUTE_ORE_X, floor_y)
	recovered_load.clear()
	handle_primary()
	var ore_carried := load_has_pickup(ROUTE_ORE_ID, recovered_load) == 1
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	handle_primary()
	checks.ore_independent_of_crawler = ore_carried and load_has_pickup(ROUTE_ORE_ID, wagon_stock) == 1 and pickup_copies(ROUTE_ORE_ID) == 1 and not crawler_defeated and live_scree_crawler_count() == 1
	# One defeat pays at most one Echo; nothing beyond the capped Echo unlocks.
	reach_expedition_ready_for_test(true)
	enter_foothills_for_test()
	var echoes_before := shadow_echoes
	hold_crawler_for_test(1)
	player.x = float(scree_crawler.pos.x) - (melee_reach(scree_crawler) - 4.0)
	combo_time = 0.0
	handle_attack()
	var paid_once := crawler_defeated and crawler_reward_paid and shadow_echoes == echoes_before + 1
	defeat_enemy(scree_crawler)
	encounter_frames_for_test(5)
	var no_second_pay := shadow_echoes == echoes_before + 1 and scree_crawler_spawn_allowed() == false and live_scree_crawler_count() == 0
	crawler_defeated = false
	crawler_reward_paid = false
	scree_crawler = {}
	shadow_echoes = int(ECHO_THRESHOLDS[1])
	enter_foothills_for_test()
	hold_crawler_for_test(1)
	player.x = float(scree_crawler.pos.x) - (melee_reach(scree_crawler) - 4.0)
	combo_time = 0.0
	handle_attack()
	var capped := shadow_echoes == int(ECHO_THRESHOLDS[1]) and crawler_defeated
	advance_to_stonehook()
	enter_stonehook()
	try_advance_from_camp()
	checks.reward_once_within_cap = paid_once and no_second_pay and capped and mark_level == 1 and cured_allies.size() == 1 and state == "journey" and zone == 0 and wagon_travel_locked() and not stonehook_boss_defeated and not stonehook_shar_ready and mark_gates.is_empty() and ui_management.recipe_locked(3)
	# Failure rolls back an unsaved defeat, its Echo and the ore together.
	reach_expedition_ready_for_test(true)
	enter_foothills_for_test()
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	was_at_safe_wagon = false
	update_safe_wagon()
	var saved_echoes := shadow_echoes
	enter_foothills_for_test()
	hold_crawler_for_test(1)
	player.x = float(scree_crawler.pos.x) - (melee_reach(scree_crawler) - 4.0)
	combo_time = 0.0
	handle_attack()
	player = Vector2(ROUTE_ORE_X, floor_y)
	handle_primary()
	var unsaved := crawler_defeated and shadow_echoes == saved_echoes + 1 and bool(route_ore_state().taken)
	provisions = 0.0
	check_survival_failures()
	restart_from_checkpoint()
	var rolled_back := unsaved and state == "journey" and not crawler_defeated and not crawler_reward_paid and crawler_activated and shadow_echoes == saved_echoes and not bool(route_ore_state().taken) and scree_crawler.is_empty() and mark_level == 1
	enter_foothills_for_test()
	var recreated_fresh := not scree_crawler.is_empty() and int(scree_crawler.health) == SCREE_CRAWLER_HEALTH and float(scree_crawler.pos.x) == SCREE_CRAWLER_HOME_X
	var recreated := scree_crawler
	encounter_frames_for_test(5)
	player.x = ROUTE_FOOTHILLS_START_X - 200.0
	encounter_frames_for_test(5)
	enter_foothills_for_test()
	checks.failure_rolls_back_together = rolled_back
	checks.undefeated_recreated_once = rolled_back and recreated_fresh and live_scree_crawler_count() == 1 and is_same(scree_crawler, recreated)
	# A safe-saved defeat stays defeated after a later failure.
	if not ensure_crawler_for_test(checks):
		return checks
	hold_crawler_for_test(1)
	player.x = float(scree_crawler.pos.x) - (melee_reach(scree_crawler) - 4.0)
	combo_time = 0.0
	handle_attack()
	var defeated_echoes := shadow_echoes
	player = Vector2(ROUTE_FOOTHILLS_START_X + 600.0, floor_y)
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	was_at_safe_wagon = false
	update_safe_wagon()
	flame = 0.0
	check_survival_failures()
	restart_from_checkpoint()
	enter_foothills_for_test()
	encounter_frames_for_test(5)
	checks.saved_defeat_stays_defeated = crawler_defeated and crawler_reward_paid and shadow_echoes == defeated_echoes and scree_crawler.is_empty() and live_scree_crawler_count() == 0
	# F4 restores the live actor, its timers and the flags exactly.
	checks.f4_exact_restore = true
	if playtester_available():
		reach_expedition_ready_for_test(true)
		enter_foothills_for_test()
		scree_crawler.health = 2
		scree_crawler.pos = Vector2(2600.0, GROUND_Y - 34)
		scree_crawler.attack_state = "windup"
		scree_crawler.attack_time = 0.31
		scree_crawler.attack_dir = -1.0
		scree_crawler.facing_left = true
		var actor_before := scree_crawler.duplicate(true)
		var flags_before := scree_crawler_state()
		playtester_change_mark(1)
		scree_crawler.health = 1
		scree_crawler.pos = Vector2(2700.0, GROUND_Y - 34)
		scree_crawler.attack_state = "recover"
		crawler_defeated = true
		restore_playtester_session()
		checks.f4_exact_restore = scree_crawler == actor_before and scree_crawler_state() == flags_before and mark_level == 1
	# A new run clears every encounter field and the gate closes again.
	reset_to_prologue()
	var reset_clear := scree_crawler.is_empty() and not crawler_activated and not crawler_defeated and not crawler_reward_paid
	enter_foothills_for_test()
	checks.new_run_resets_encounter = reset_clear and scree_crawler.is_empty()
	# Startup prepared the crop once; nothing above rescanned pixels.
	checks.bounds_prepared_once = ui_encounter_bounds_scans == 1 and ui_enemy_bounds_scans == scans_before and ui_enemy_bounds_scans == 22 and ui_enemy_bounds.size() == 22
	reset_to_prologue()
	return checks

func run_stonehook_encounter_self_test() -> bool:
	var checks := stonehook_encounter_checks()
	var failed: Array[String] = []
	for check_name in checks:
		if not bool(checks[check_name]):
			failed.append(String(check_name))
	if failed.is_empty():
		print("SELF_TEST_B07_PASS: one legitimate Scree Crawler with its own crop, telegraphed single-hit lunges, foothill bounds, cave coexistence, capped reward and consistent restoration (%d checks)" % checks.size())
	else:
		push_error("SELF_TEST_B07_FAIL: %s" % ", ".join(failed))
	return failed.is_empty()

# B-08 test fixtures. They place state only; behavior runs through the production update.
func ensure_harrier_for_test(checks: Dictionary) -> bool:
	if cliff_harrier.is_empty():
		reach_expedition_ready_for_test(true, true)
		enter_foothills_for_test(CLIFF_HARRIER_ACTIVATION_X + 20.0)
		checks.section_fixtures_ready = false
	return not cliff_harrier.is_empty()

func hold_harrier_for_test(health_value: int, x: float = CLIFF_HARRIER_HOME_X) -> void:
	if cliff_harrier.is_empty():
		return
	cliff_harrier.health = health_value
	cliff_harrier.pos = Vector2(x, cliff_harrier_anchor_y(CLIFF_HARRIER_HOVER))
	cliff_harrier.attack_state = "recover"
	cliff_harrier.attack_time = 99.0
	cliff_harrier.bob_time = 0.0
	cliff_harrier.hit_flash = 0.0

func arm_harrier_for_test(x: float = CLIFF_HARRIER_HOME_X) -> void:
	if cliff_harrier.is_empty():
		return
	cliff_harrier.health = 10
	cliff_harrier.pos = Vector2(x, cliff_harrier_anchor_y(CLIFF_HARRIER_HOVER))
	cliff_harrier.attack_state = "approach"
	cliff_harrier.attack_time = 0.0
	cliff_harrier.bob_time = 0.0
	cliff_harrier.strike_spent = false

# Holds the crawler out of the way (recovering at its own left bound) so Harrier-only
# measurements are not affected by it; it stays a live, separate actor.
func park_crawler_for_test(far := false) -> void:
	if not scree_crawler.is_empty():
		# far: out past its bound, only for sections that run no frames (nothing clamps it).
		hold_crawler_for_test(SCREE_CRAWLER_HEALTH, 2200.0 if far else scree_crawler_limits().x)

func harrier_altitude_for_test() -> float:
	return GROUND_Y - 34.0 - float(cliff_harrier.pos.y)

# Runs frames until the Harrier leaves the given state, forcing no hurt cooldown when asked.
func run_harrier_state_for_test(state_name: String, limit: int, clear_cooldown := false, dt: float = 1.0 / 60.0) -> int:
	var frames := 0
	while frames < limit and String(cliff_harrier.attack_state) == state_name:
		if clear_cooldown:
			hurt_cooldown = 0.0
		encounter_frames_for_test(1, dt)
		frames += 1
	return frames

# B-08 checks. Each entry is a named assertion so faulty test subclasses can be identified.
func cliff_harrier_checks() -> Dictionary:
	var checks := {"section_fixtures_ready": true}
	var floor_y := GROUND_Y - PLAYER_FEET_OFFSET
	var crawler_scans_before := ui_encounter_bounds_scans
	var atlas_scans_before := ui_enemy_bounds_scans
	var harrier_scans_before := ui_harrier_bounds_scans
	var harrier_key := STONEHOOK_THREATS_RUNTIME.resource_path + str(cliff_harrier_source())
	# Locked contexts: a new run, the tutorial, an unsecured camp and an F4 Mark override.
	reset_to_prologue()
	enter_foothills_for_test(2650.0)
	encounter_frames_for_test(30)
	var new_run_locked := cliff_harrier.is_empty() and not harrier_activated
	reach_safe_camp_for_test()
	enter_foothills_for_test(2650.0)
	var tutorial_locked := cliff_harrier.is_empty() and not harrier_activated
	reach_safe_camp_for_test()
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	use_camp_action()
	defeat_boss_for_test()
	skip_shar_shell()
	cure_selected_ally()
	enter_foothills_for_test(2650.0)
	var unsecured_locked := cliff_harrier.is_empty() and not harrier_activated
	var debug_locked := true
	if playtester_available():
		reset_to_prologue()
		playtester_change_mark(1)
		enter_foothills_for_test(2650.0)
		debug_locked = cliff_harrier.is_empty() and not harrier_activated
		restore_playtester_session()
	checks.harrier_locked_contexts = new_run_locked and tutorial_locked and unsecured_locked and debug_locked
	# Legitimate access: the crawler appears at the foothill border, the Harrier only at x>=2600.
	reach_expedition_ready_for_test(true, true)
	enter_foothills_for_test(CLIFF_HARRIER_ACTIVATION_X - 10.0)
	encounter_frames_for_test(20)
	var below_threshold := cliff_harrier.is_empty() and not harrier_activated and live_scree_crawler_count() == 1
	enter_foothills_for_test(CLIFF_HARRIER_ACTIVATION_X)
	checks.harrier_activation_at_2600 = below_threshold and not cliff_harrier.is_empty() and String(cliff_harrier.encounter_id) == CLIFF_HARRIER_ID and String(cliff_harrier.region) == "stonehook_foothills" and int(cliff_harrier.health) == CLIFF_HARRIER_HEALTH and float(cliff_harrier.pos.x) == CLIFF_HARRIER_HOME_X and live_cliff_harrier_count() == 1 and live_scree_crawler_count() == 1 and harrier_activated and shades.is_empty() and zone == 0
	# Border and threshold oscillation, nightfall and dawn keep both actors and their health.
	var harrier_actor := cliff_harrier
	var crawler_actor := scree_crawler
	cliff_harrier.health = 2
	scree_crawler.health = 2
	hurt_cooldown = 99.0
	for _crossing in 3:
		player.x = ROUTE_FOOTHILLS_START_X - 260.0
		encounter_frames_for_test(20)
		player.x = CLIFF_HARRIER_ACTIVATION_X - 120.0
		encounter_frames_for_test(10)
		player.x = CLIFF_HARRIER_ACTIVATION_X + 40.0
		hurt_cooldown = 99.0
		encounter_frames_for_test(10)
	clock_seconds = DAY_DURATION - 0.01
	update_clock(0.02)
	var night_kept := is_same(cliff_harrier, harrier_actor) and is_same(scree_crawler, crawler_actor) and is_night()
	clock_seconds = DAY_DURATION + NIGHT_DURATION - 0.01
	update_clock(0.02)
	checks.both_actors_persist_oscillation_days = night_kept and is_same(cliff_harrier, harrier_actor) and is_same(scree_crawler, crawler_actor) and int(cliff_harrier.health) == 2 and int(scree_crawler.health) == 2 and live_cliff_harrier_count() == 1 and live_scree_crawler_count() == 1
	# Geometry: the bird's own crop, native aspect, a 110 px body whose claws hover 30 px up.
	if not ensure_harrier_for_test(checks):
		return checks
	park_crawler_for_test()
	hold_harrier_for_test(10)
	var geometry := enemy_draw_geometry(cliff_harrier)
	var source: Rect2 = geometry.source
	var destination: Rect2 = geometry.destination
	var body: Rect2 = geometry.body
	var cached := enemy_frame_bounds(STONEHOOK_THREATS_RUNTIME, source)
	var uniform := is_equal_approx(destination.size.x / source.size.x, destination.size.y / source.size.y)
	checks.harrier_geometry_crop = source == Rect2(768, 0, 768, 497) and cached == Rect2i(37, 8, 613, 488) and uniform and absf(body.size.y - CLIFF_HARRIER_BODY_HEIGHT) < 0.01 and is_equal_approx(body.end.y, GROUND_Y - CLIFF_HARRIER_HOVER) and is_equal_approx(body.get_center().x, float(cliff_harrier.pos.x)) and absf(body.size.x / body.size.y - 613.0 / 488.0) < 0.001
	# Hover and bob limits over several seconds; the dive dips but never touches the floor.
	park_crawler_for_test()
	var min_alt := INF
	var max_alt := -INF
	cliff_harrier.attack_state = "approach"
	player.x = ROUTE_FOOTHILLS_START_X - 60.0
	# At every bob phase of the live flight, a grounded melee strike and First Thread reach it.
	var live_hits := 0
	var live_tries := 0
	for frame in 360:
		encounter_frames_for_test(1)
		min_alt = minf(min_alt, harrier_altitude_for_test())
		max_alt = maxf(max_alt, harrier_altitude_for_test())
		if frame % 45 == 0:
			var outside_x := player.x
			var live_health := int(cliff_harrier.health)
			player = Vector2(float(cliff_harrier.pos.x) - (melee_reach(cliff_harrier) - 3.0), floor_y)
			on_floor = true
			combo_time = 0.0
			hurt_cooldown = 99.0
			handle_attack()
			first_thread_cooldown = 0.0
			use_first_thread()
			live_tries += 1
			if int(cliff_harrier.health) == live_health - 1 - FIRST_THREAD_DAMAGE:
				live_hits += 1
			cliff_harrier.health = live_health
			player = Vector2(outside_x, floor_y)
	checks.harrier_reachable_in_live_flight = live_tries == 8 and live_hits == live_tries
	var bob_ok := min_alt >= CLIFF_HARRIER_HOVER - CLIFF_HARRIER_BOB - 0.01 and max_alt <= CLIFF_HARRIER_HOVER + CLIFF_HARRIER_BOB + 0.01 and max_alt - min_alt > CLIFF_HARRIER_BOB
	arm_harrier_for_test()
	player = Vector2(CLIFF_HARRIER_HOME_X - 150.0, floor_y)
	hurt_cooldown = 99.0
	encounter_frames_for_test(1)
	run_harrier_state_for_test("windup", 200)
	var dive_min_alt := INF
	var dive_min_claw := INF
	while String(cliff_harrier.attack_state) == "dive":
		encounter_frames_for_test(1)
		dive_min_alt = minf(dive_min_alt, harrier_altitude_for_test())
	checks.harrier_hover_and_bob = bob_ok and dive_min_alt >= CLIFF_HARRIER_HOVER - CLIFF_HARRIER_DIVE_DIP - 0.01 and dive_min_alt > 0.0
	park_crawler_for_test(true)
	# Melee reach follows the visible body, without a global reach change.
	hold_harrier_for_test(10)
	body = enemy_draw_geometry(cliff_harrier).body
	var reach := melee_reach(cliff_harrier)
	checks.harrier_reach_matches_body = is_equal_approx(reach, MELEE_LOLTH_HALF_WIDTH + body.size.x / 2.0) and MELEE_VERTICAL_REACH == 70.0 and FIRST_THREAD_RANGE == 150.0 and FIRST_THREAD_DAMAGE == 2 and FIRST_THREAD_COOLDOWN == 1.2
	# Grounded melee hits inside the visible reach and misses outside it, with no hurt pose.
	var hx := float(cliff_harrier.pos.x)
	player = Vector2(hx - (reach - 2.0), floor_y)
	on_floor = true
	combo_time = 0.0
	hurt_flash_time = 0.0
	hurt_cooldown = 99.0
	handle_attack()
	var grounded_hit := int(cliff_harrier.health) == 9 and player_pose() == "strike" and not player_hurt_visible()
	player.x = hx - (reach + 2.0)
	combo_time = 0.0
	handle_attack()
	checks.harrier_grounded_melee_hit_miss = grounded_hit and int(cliff_harrier.health) == 9 and message.begins_with("Out of reach") and not player_hurt_visible()
	var thread_reach := maxf(FIRST_THREAD_RANGE, reach)
	player.x = hx - (thread_reach - 2.0)
	first_thread_cooldown = 0.0
	use_first_thread()
	var thread_hit := int(cliff_harrier.health) == 7 and first_thread_cooldown > 0.0
	player.x = hx - (thread_reach + 2.0)
	first_thread_cooldown = 0.0
	use_first_thread()
	checks.harrier_first_thread_hit_miss = thread_hit and int(cliff_harrier.health) == 7 and message.begins_with("FIRST THREAD finds no target")
	# Vertical reach follows the displayed bird: raised out of reach, neither ability lands.
	player.x = hx - 40.0
	cliff_harrier.pos.y = cliff_harrier_anchor_y(120.0)
	combo_time = 0.0
	handle_attack()
	first_thread_cooldown = 0.0
	use_first_thread()
	var high_missed := int(cliff_harrier.health) == 7
	var high_body_end: float = enemy_draw_geometry(cliff_harrier).body.end.y
	hold_harrier_for_test(7)
	combo_time = 0.0
	handle_attack()
	checks.harrier_vertical_reach_follows_display = high_missed and is_equal_approx(high_body_end, GROUND_Y - 120.0) and int(cliff_harrier.health) == 6
	# Nearest eligible target: with both actors in reach the closer one is struck; a defeated or
	# out-of-reach nearer actor is skipped.
	hold_harrier_for_test(10, 2700.0)
	hold_crawler_for_test(10, 2520.0)
	player.x = 2600.0
	combo_time = 0.0
	handle_attack()
	var nearer_crawler := int(scree_crawler.health) == 9 and int(cliff_harrier.health) == 10
	player.x = 2625.0
	combo_time = 0.0
	handle_attack()
	var nearer_harrier := int(cliff_harrier.health) == 9 and int(scree_crawler.health) == 9
	cliff_harrier.pos.y = cliff_harrier_anchor_y(120.0)
	combo_time = 0.0
	handle_attack()
	var skips_unreachable := int(scree_crawler.health) == 8 and int(cliff_harrier.health) == 9
	hold_harrier_for_test(9, 2700.0)
	first_thread_cooldown = 0.0
	use_first_thread()
	checks.nearest_eligible_target = nearer_crawler and nearer_harrier and skips_unreachable and int(cliff_harrier.health) == 7 and int(scree_crawler.health) == 8
	# Facing toward Lolth on either side; the reflected body stays centered on the anchor.
	hold_crawler_for_test(10, 2520.0)
	arm_harrier_for_test(2650.0)
	hurt_cooldown = 99.0
	player.x = 2400.0
	encounter_frames_for_test(2)
	var faces_left := enemy_facing_left(cliff_harrier)
	cliff_harrier.attack_state = "approach"
	player.x = 3000.0
	encounter_frames_for_test(2)
	var faces_right := not enemy_facing_left(cliff_harrier)
	var centered := is_equal_approx(enemy_draw_geometry(cliff_harrier).body.get_center().x, float(cliff_harrier.pos.x))
	checks.harrier_facings = faces_left and faces_right and centered
	park_crawler_for_test()
	# Approach from afar at 70 and back off at 45 inside 100.
	arm_harrier_for_test(2700.0)
	player.x = 2300.0
	encounter_frames_for_test(60)
	var approached := absf((2700.0 - float(cliff_harrier.pos.x)) - CLIFF_HARRIER_APPROACH_SPEED) < 0.5
	arm_harrier_for_test(2700.0)
	player.x = 2660.0
	encounter_frames_for_test(60)
	checks.harrier_approach_and_retreat = approached and absf((float(cliff_harrier.pos.x) - 2700.0) - CLIFF_HARRIER_RETREAT_SPEED) < 0.5 and String(cliff_harrier.attack_state) == "approach"
	park_crawler_for_test()
	# Windup: a visible warning, then a dive toward the target locked at windup start, never
	# retargeting when Lolth crosses over, moving continuously and never past the target.
	arm_harrier_for_test()
	health = max_health()
	hurt_cooldown = 0.0
	dodge_time = 0.0
	player = Vector2(CLIFF_HARRIER_HOME_X - 150.0, floor_y)
	encounter_frames_for_test(1)
	var windup_started := String(cliff_harrier.attack_state) == "windup" and cliff_harrier_warning_visible()
	var locked_target := float(cliff_harrier.target_x)
	var locked_dir := float(cliff_harrier.attack_dir)
	player.x = CLIFF_HARRIER_HOME_X + 140.0
	var warning_throughout := true
	var lock_held := true
	var windup_frames := 1
	while String(cliff_harrier.attack_state) == "windup" and windup_frames < 200:
		warning_throughout = warning_throughout and cliff_harrier_warning_visible()
		lock_held = lock_held and float(cliff_harrier.target_x) == locked_target and float(cliff_harrier.attack_dir) == locked_dir
		encounter_frames_for_test(1)
		windup_frames += 1
	var dive_start := float(cliff_harrier.pos.x)
	var last_x := dive_start
	var continuous := true
	var never_past := true
	while String(cliff_harrier.attack_state) == "dive":
		lock_held = lock_held and float(cliff_harrier.target_x) == locked_target
		encounter_frames_for_test(1)
		continuous = continuous and absf(float(cliff_harrier.pos.x) - last_x) <= CLIFF_HARRIER_DIVE_SPEED / 60.0 + 0.001
		never_past = never_past and float(cliff_harrier.pos.x) >= locked_target - 0.001
		last_x = float(cliff_harrier.pos.x)
	var windup_seconds := float(windup_frames) / 60.0
	checks.harrier_windup_locks_target = windup_started and warning_throughout and lock_held and locked_target == CLIFF_HARRIER_HOME_X - 150.0 and locked_dir < 0.0 and absf(windup_seconds - CLIFF_HARRIER_WINDUP) <= 2.0 / 60.0 and windup_seconds >= MIN_TELEGRAPH_TIME and continuous and never_past and float(cliff_harrier.pos.x) < dive_start and dive_start - float(cliff_harrier.pos.x) <= CLIFF_HARRIER_DIVE_SPEED * CLIFF_HARRIER_DIVE_TIME + 0.01 and health == max_health()
	park_crawler_for_test()
	# One dive wounds at most once, at 60 and at 16 frames per second, with no cooldown left.
	arm_harrier_for_test()
	health = max_health()
	player = Vector2(CLIFF_HARRIER_HOME_X - (CLIFF_HARRIER_ATTACK_RANGE - 2.0), floor_y)
	encounter_frames_for_test(1)
	run_harrier_state_for_test("windup", 200, true)
	run_harrier_state_for_test("dive", 200, true)
	var hit_at_60 := health == max_health() - 1.0 and bool(cliff_harrier.strike_spent)
	arm_harrier_for_test()
	health = max_health()
	player = Vector2(CLIFF_HARRIER_HOME_X - (CLIFF_HARRIER_ATTACK_RANGE - 2.0), floor_y)
	encounter_frames_for_test(1)
	run_harrier_state_for_test("windup", 200, true, 1.0 / 16.0)
	run_harrier_state_for_test("dive", 200, true, 1.0 / 16.0)
	checks.harrier_single_hit_per_dive = hit_at_60 and health == max_health() - 1.0 and bool(cliff_harrier.strike_spent) and state == "journey"
	park_crawler_for_test()
	# Dash invulnerability avoids the dive, which is then spent.
	arm_harrier_for_test()
	health = max_health()
	hurt_cooldown = 0.0
	player = Vector2(CLIFF_HARRIER_HOME_X - 150.0, floor_y)
	encounter_frames_for_test(1)
	run_harrier_state_for_test("windup", 200)
	dodge_time = DODGE_DURATION
	run_harrier_state_for_test("dive", 200)
	checks.harrier_dash_avoids_dive = health == max_health() and bool(cliff_harrier.strike_spent)
	park_crawler_for_test()
	# No idle contact: overlapping a recovering or hovering bird never hurts.
	health = max_health()
	dodge_time = 0.0
	hold_harrier_for_test(10)
	player.x = CLIFF_HARRIER_HOME_X
	for _frame in 300:
		hurt_cooldown = 0.0
		encounter_frames_for_test(1)
	var recover_safe := health == max_health()
	arm_harrier_for_test()
	player.x = CLIFF_HARRIER_HOME_X
	for _frame in 60:
		hurt_cooldown = 0.0
		encounter_frames_for_test(1)
	checks.harrier_no_idle_contact = recover_safe and health == max_health() and String(cliff_harrier.attack_state) == "approach"
	park_crawler_for_test()
	# Leaving the foothills cancels a windup and stops a dive without contact.
	arm_harrier_for_test(cliff_harrier_limits().x)
	health = max_health()
	hurt_cooldown = 0.0
	player = Vector2(float(cliff_harrier.pos.x) - 150.0, floor_y)
	encounter_frames_for_test(2)
	var pending := String(cliff_harrier.attack_state) == "windup"
	player.x = ROUTE_FOOTHILLS_START_X - 6.0
	encounter_frames_for_test(1)
	var windup_cancelled := String(cliff_harrier.attack_state) == "approach"
	arm_harrier_for_test(cliff_harrier_limits().x)
	player.x = float(cliff_harrier.pos.x) - 150.0
	encounter_frames_for_test(1)
	run_harrier_state_for_test("windup", 200)
	player.x = ROUTE_FOOTHILLS_START_X - 6.0
	encounter_frames_for_test(1)
	var integrity_before := wagon_integrity
	var held_x := float(cliff_harrier.pos.x)
	for _frame in 600:
		hurt_cooldown = 0.0
		encounter_frames_for_test(1)
	checks.harrier_cancels_outside_foothills = pending and windup_cancelled and health == max_health() and String(cliff_harrier.attack_state) == "approach" and is_equal_approx(float(cliff_harrier.pos.x), held_x) and wagon_integrity == integrity_before
	park_crawler_for_test()
	# Body, dives and warning stay within the clear patrol and the foothills.
	var min_body := INF
	var max_body := -INF
	var warning_inside := true
	for side in [ROUTE_FOOTHILLS_START_X + 6.0, ROUTE_END_X - PLAYER_EDGE_MARGIN]:
		player.x = side
		for _frame in 900:
			hurt_cooldown = 99.0
			encounter_frames_for_test(1)
			var b: Rect2 = enemy_draw_geometry(cliff_harrier).body
			min_body = minf(min_body, b.position.x)
			max_body = maxf(max_body, b.end.x)
			if cliff_harrier_warning_visible():
				var to_x := clampf(float(cliff_harrier.target_x) + float(cliff_harrier.attack_dir) * MELEE_LOLTH_HALF_WIDTH, ROUTE_FOOTHILLS_START_X, ROUTE_END_X)
				warning_inside = warning_inside and to_x >= ROUTE_FOOTHILLS_START_X and to_x <= ROUTE_END_X
	checks.harrier_stays_in_bounds = min_body >= CLIFF_HARRIER_PATROL.x - 0.01 and max_body <= CLIFF_HARRIER_PATROL.y + 0.01 and warning_inside
	# Simultaneous combat: both actors strike in the same exchange; each lands once only.
	reach_expedition_ready_for_test(true, true)
	enter_foothills_for_test(2600.0)
	if not ensure_harrier_for_test(checks) or scree_crawler.is_empty():
		checks.section_fixtures_ready = false
		return checks
	health = max_health()
	scree_crawler.pos = Vector2(2600.0 - (scree_crawler_strike_range() - 6.0), GROUND_Y - 34)
	scree_crawler.attack_state = "approach"
	scree_crawler.strike_spent = false
	arm_harrier_for_test(2600.0 + 160.0)
	var frames_run := 0
	while frames_run < 240 and not (bool(scree_crawler.strike_spent) and bool(cliff_harrier.strike_spent) and String(scree_crawler.attack_state) == "recover" and String(cliff_harrier.attack_state) == "recover"):
		hurt_cooldown = 0.0
		encounter_frames_for_test(1)
		frames_run += 1
	checks.simultaneous_combat_single_hits = health == max_health() - 2.0 and bool(scree_crawler.strike_spent) and bool(cliff_harrier.strike_spent) and state == "journey"
	# Independent defeat and reward: killing one never alters the other.
	health = max_health()
	var echoes_before := shadow_echoes
	hold_crawler_for_test(1, 2520.0)
	hold_harrier_for_test(2, 2700.0)
	player.x = 2520.0 - 40.0
	combo_time = 0.0
	handle_attack()
	var crawler_only := crawler_defeated and crawler_reward_paid and not harrier_defeated and not harrier_reward_paid and int(cliff_harrier.health) == 2 and not bool(cliff_harrier.defeated) and shadow_echoes == echoes_before + 1 and live_cliff_harrier_count() == 1
	encounter_frames_for_test(5)
	defeat_enemy(cliff_harrier)
	var harrier_paid := harrier_defeated and harrier_reward_paid and shadow_echoes == echoes_before + 2 and crawler_defeated
	defeat_enemy(cliff_harrier)
	defeat_enemy(scree_crawler)
	encounter_frames_for_test(10)
	var independent_first := crawler_only and harrier_paid and shadow_echoes == echoes_before + 2 and live_cliff_harrier_count() == 0 and live_scree_crawler_count() == 0 and not cliff_harrier_spawn_allowed() and not scree_crawler_spawn_allowed()
	# The mirror order: a Harrier-first kill leaves the live crawler and its flags untouched.
	reach_expedition_ready_for_test(true, true)
	enter_foothills_for_test(2650.0)
	var echoes_mirror := shadow_echoes
	hold_crawler_for_test(2, 2520.0)
	hold_harrier_for_test(1, 2700.0)
	player.x = 2700.0 - 40.0
	combo_time = 0.0
	handle_attack()
	var harrier_only := harrier_defeated and harrier_reward_paid and not crawler_defeated and not crawler_reward_paid and int(scree_crawler.health) == 2 and not bool(scree_crawler.defeated) and shadow_echoes == echoes_mirror + 1 and live_scree_crawler_count() == 1
	encounter_frames_for_test(5)
	harrier_only = harrier_only and live_scree_crawler_count() == 1 and not crawler_defeated
	checks.independent_defeat_and_reward = independent_first and harrier_only
	# The unchanged 3/3 cap: with one Echo to go, only the first kill pays.
	reach_expedition_ready_for_test(true, true)
	enter_foothills_for_test(2650.0)
	shadow_echoes = int(ECHO_THRESHOLDS[1]) - 1
	defeat_enemy(cliff_harrier)
	defeat_enemy(scree_crawler)
	var capped := shadow_echoes == int(ECHO_THRESHOLDS[1]) and harrier_reward_paid and crawler_reward_paid
	try_advance_from_camp()
	checks.two_rewards_within_cap = capped and mark_level == 1 and cured_allies.size() == 1 and zone == 0 and wagon_travel_locked() and not stonehook_boss_defeated and mark_gates.is_empty() and ui_management.recipe_locked(3)
	# Cave waves, wave completion, dawn and real Stag damage coexist with both live actors.
	reach_expedition_ready_for_test(true, true)
	enter_foothills_for_test(2650.0)
	var harrier_live := cliff_harrier
	var crawler_live := scree_crawler
	clock_seconds = DAY_DURATION - 0.05
	hurt_cooldown = 99.0
	simulate_frames_for_test(30)
	var night_with_both := is_night() and night_wave == 1 and is_same(cliff_harrier, harrier_live) and is_same(scree_crawler, crawler_live)
	for _wave in TUTORIAL_NIGHT_WAVES:
		for enemy in shades:
			enemy.defeated = true
		update_night_waves(0.0)
		update_night_waves(NIGHT_WAVE_INTERVAL)
	var waves_done := night_waves_complete and live_cliff_harrier_count() == 1 and live_scree_crawler_count() == 1
	shades.clear()
	spawn_enemy("STAG OF MIRE", Vector2(CARAVAN_X + 300.0, GROUND_Y - 34), 2, 1)
	var wagon_before := wagon_integrity
	player.x = ROUTE_FOOTHILLS_START_X - 300.0
	for _frame in 600:
		_process(1.0 / 60.0)
		if wagon_integrity < wagon_before:
			break
	checks.cave_waves_keep_both = night_with_both and waves_done and wagon_integrity < wagon_before and state == "journey" and is_same(cliff_harrier, harrier_live) and is_same(scree_crawler, crawler_live)
	shades.clear()
	clock_seconds = DAY_DURATION + NIGHT_DURATION - 0.01
	update_clock(0.02)
	# Valid cave capture with both alive; an unsafe cave stays unsafe.
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	was_at_safe_wagon = false
	var captured_before := safe_wagon_state.duplicate(true)
	spawn_enemy("BRIAR HOUND", Vector2(CARAVAN_X + 90.0, GROUND_Y - 34), 1, 1)
	update_safe_wagon()
	var unsafe_kept := safe_wagon_state == captured_before
	shades.clear()
	was_at_safe_wagon = false
	update_safe_wagon()
	var saved_harrier: Dictionary = safe_wagon_state.get("harrier", {})
	var saved_crawler: Dictionary = safe_wagon_state.get("crawler", {})
	checks.safe_capture_with_both_live = unsafe_kept and safe_wagon_state != captured_before and bool(saved_harrier.get("activated", false)) and not bool(saved_harrier.get("defeated", true)) and bool(saved_crawler.get("activated", false)) and live_cliff_harrier_count() == 1 and live_scree_crawler_count() == 1
	# Ore pickup and deposit with both actors alive.
	player = Vector2(ROUTE_ORE_X, floor_y)
	recovered_load.clear()
	handle_primary()
	var ore_carried := load_has_pickup(ROUTE_ORE_ID, recovered_load) == 1
	player = Vector2(CARAVAN_X + 20.0, floor_y)
	handle_primary()
	checks.ore_independent_of_both = ore_carried and load_has_pickup(ROUTE_ORE_ID, wagon_stock) == 1 and pickup_copies(ROUTE_ORE_ID) == 1 and not crawler_defeated and not harrier_defeated and live_cliff_harrier_count() == 1 and live_scree_crawler_count() == 1
	# The four saved combinations: saved defeats survive failure, unsaved ones roll back, and
	# each undefeated actor is recreated once at initial health on its own legitimate entry.
	for combo in [[false, false], [true, false], [false, true], [true, true]]:
		var label := "save_combo_%s" % ("both" if combo[0] and combo[1] else "crawler_only" if combo[0] else "harrier_only" if combo[1] else "neither")
		reach_expedition_ready_for_test(true, true)
		enter_foothills_for_test(2650.0)
		if bool(combo[0]):
			defeat_enemy(scree_crawler)
		if bool(combo[1]):
			defeat_enemy(cliff_harrier)
		player = Vector2(CARAVAN_X + 20.0, floor_y)
		was_at_safe_wagon = false
		update_safe_wagon()
		var echoes_saved := shadow_echoes
		enter_foothills_for_test(2650.0)
		if not bool(combo[0]) and not scree_crawler.is_empty():
			defeat_enemy(scree_crawler)
		if not bool(combo[1]) and not cliff_harrier.is_empty():
			defeat_enemy(cliff_harrier)
		var all_down := crawler_defeated and harrier_defeated
		provisions = 0.0
		check_survival_failures()
		restart_from_checkpoint()
		var flags_ok := crawler_defeated == bool(combo[0]) and crawler_reward_paid == bool(combo[0]) and harrier_defeated == bool(combo[1]) and harrier_reward_paid == bool(combo[1]) and crawler_activated and harrier_activated and shadow_echoes == echoes_saved
		var cleared := scree_crawler.is_empty() and cliff_harrier.is_empty() and state == "journey"
		enter_foothills_for_test(ROUTE_FOOTHILLS_START_X + 140.0)
		var crawler_ok := scree_crawler.is_empty() if bool(combo[0]) else (not scree_crawler.is_empty() and int(scree_crawler.health) == SCREE_CRAWLER_HEALTH)
		var harrier_waits := cliff_harrier.is_empty()
		enter_foothills_for_test(2650.0)
		var harrier_ok := cliff_harrier.is_empty() if bool(combo[1]) else (not cliff_harrier.is_empty() and int(cliff_harrier.health) == CLIFF_HARRIER_HEALTH and float(cliff_harrier.pos.x) == CLIFF_HARRIER_HOME_X)
		var first_harrier := cliff_harrier
		var first_crawler := scree_crawler
		hurt_cooldown = 99.0
		player.x = ROUTE_FOOTHILLS_START_X - 200.0
		encounter_frames_for_test(5)
		enter_foothills_for_test(2650.0)
		var once := is_same(cliff_harrier, first_harrier) and is_same(scree_crawler, first_crawler) and live_scree_crawler_count() == (0 if bool(combo[0]) else 1) and live_cliff_harrier_count() == (0 if bool(combo[1]) else 1)
		checks[label] = all_down and flags_ok and cleared and crawler_ok and harrier_waits and harrier_ok and once
	# F4 deep-restores both live actors, their timers, positions and flags exactly.
	checks.f4_restores_both_exactly = true
	if playtester_available():
		reach_expedition_ready_for_test(true, true)
		enter_foothills_for_test(2650.0)
		cliff_harrier.health = 2
		cliff_harrier.pos = Vector2(2700.0, cliff_harrier_anchor_y(33.0))
		cliff_harrier.attack_state = "windup"
		cliff_harrier.attack_time = 0.41
		cliff_harrier.target_x = 2620.0
		cliff_harrier.attack_dir = -1.0
		cliff_harrier.bob_time = 1.7
		cliff_harrier.facing_left = true
		scree_crawler.health = 1
		scree_crawler.attack_state = "recover"
		scree_crawler.attack_time = 0.6
		crawler_defeated = false
		var harrier_before := cliff_harrier.duplicate(true)
		var crawler_before := scree_crawler.duplicate(true)
		var flags_before := [scree_crawler_state(), cliff_harrier_state()]
		playtester_change_mark(1)
		cliff_harrier.health = 1
		cliff_harrier.pos = Vector2(2500.0, cliff_harrier_anchor_y(30.0))
		cliff_harrier.attack_state = "dive"
		scree_crawler.health = 3
		harrier_defeated = true
		crawler_reward_paid = true
		restore_playtester_session()
		checks.f4_restores_both_exactly = cliff_harrier == harrier_before and scree_crawler == crawler_before and [scree_crawler_state(), cliff_harrier_state()] == flags_before and mark_level == 1
	# A new run clears every added field.
	reset_to_prologue()
	var reset_clear := cliff_harrier.is_empty() and not harrier_activated and not harrier_defeated and not harrier_reward_paid and scree_crawler.is_empty() and not crawler_activated
	enter_foothills_for_test(2650.0)
	checks.new_run_resets_both = reset_clear and cliff_harrier.is_empty()
	# Startup prepared both crops once; nothing above rescanned pixels.
	checks.harrier_bounds_prepared_once = ui_harrier_bounds_scans == 1 and harrier_scans_before == 1 and ui_encounter_bounds.has(harrier_key) and ui_encounter_bounds_scans == crawler_scans_before and ui_encounter_bounds_scans == 1 and ui_enemy_bounds_scans == atlas_scans_before and ui_enemy_bounds_scans == 22 and ui_enemy_bounds.size() == 22
	reset_to_prologue()
	return checks

func run_cliff_harrier_self_test() -> bool:
	var checks := cliff_harrier_checks()
	var failed: Array[String] = []
	for check_name in checks:
		if not bool(checks[check_name]):
			failed.append(String(check_name))
	if failed.is_empty():
		print("SELF_TEST_B08_PASS: one legitimate Cliff Harrier beside the Scree Crawler with its own crop, grounded reach, locked-target single-hit dives, bounds, independent rewards and four-way restoration (%d checks)" % checks.size())
	else:
		push_error("SELF_TEST_B08_FAIL: %s" % ", ".join(failed))
	return failed.is_empty()

func run_playtester_self_test() -> bool:
	if not playtester_available():
		print("SELF_TEST_PLAYTESTER_SKIP: debug tools unavailable in release")
		return true
	reset_to_prologue()
	# Opening the panel alone must never advance time or alter the run.
	var original_clock := clock_seconds
	var original_health := health
	toggle_playtester_panel()
	_process(2.0)
	var panel_pauses := playtester_panel.visible and clock_seconds == original_clock and health == original_health and not playtester_active
	# Exercise the actual button signal rather than only the gameplay helper.
	playtester_mark_up.pressed.emit()
	var mark_up := mark_level == 1 and lolth_form() == "drow" and cured_allies.is_empty() and playtester_active and playtester_snapshot.has("checkpoint")
	playtester_mark_down.pressed.emit()
	var mark_down := mark_level == 0 and lolth_form() == "elf"
	playtester_change_mark(99)
	var upper_bound := mark_level == 9 and playtester_mark_up.disabled and current_objective().begins_with("PLAYTEST:")
	playtester_change_mark(-99)
	var lower_bound := mark_level == 0 and playtester_mark_down.disabled
	playtester_set_time(true)
	var forced_night := is_night() and shades.size() == 1 and String(shades[0].name) == "BRIAR HOUND" and tutorial_phase == "night_defense" and wagon_repair == 0
	playtester_set_time(true)
	var repeat_night := shades.size() == 1 and night_wave == 1
	playtester_set_time(false)
	var forced_day := not is_night() and shades.is_empty() and night_wave_total == 0
	# Mutating nested data in the sandbox must not touch the original run.
	wagon_stock.append({"name": "DEBUG WOOD", "type": "wood", "slots": 1})
	cured_allies.append("AELIRA")
	checkpoint.stock.append({"name": "DEBUG STOCK", "type": "wood", "slots": 1})
	playtester_restore_button.pressed.emit()
	var restored: bool = not playtester_active and not playtester_panel.visible and is_cave_camp_start() and wagon_stock.is_empty() and checkpoint.stock.is_empty() and health == original_health and clock_seconds == original_clock
	# Closing the panel consumes the input frame so its click cannot also attack.
	var restored_pulse := pulse
	_process(0.1)
	var no_click_leak := pulse == restored_pulse and not playtester_resume_guard
	# Restore an already-secured marked run, not only an empty prologue.
	apply_mark_one()
	cure_selected_ally()
	player = Vector2(CARAVAN_X, GROUND_Y - PLAYER_FEET_OFFSET)
	update_safe_wagon()
	var original_safe := safe_wagon_state.duplicate(true)
	var original_checkpoint := checkpoint.duplicate(true)
	playtester_change_mark(8)
	playtester_set_time(true)
	var high_mark_night := mark_level == 9 and is_night() and wagon_travel_locked()
	restore_playtester_session()
	var marked_restored := mark_level == 1 and cured_allies == ["AELIRA"] and camp_secured and safe_wagon_state == original_safe and checkpoint == original_checkpoint and not is_night()
	# The tools also work from an opening without permanently skipping its shell.
	start_new_run()
	playtester_set_time(true)
	var opening_override := state == "journey" and is_night() and not shades.is_empty()
	restore_playtester_session()
	var opening_restored := state == "opening" and opening_beat == 0 and mark_level == 0
	reset_to_prologue()
	playtester_resume_guard = false
	var passed: bool = panel_pauses and mark_up and mark_down and upper_bound and lower_bound and forced_night and repeat_night and forced_day and restored and no_click_leak and high_mark_night and marked_restored and opening_override and opening_restored
	if passed:
		print("SELF_TEST_PLAYTESTER_PASS: panel pause, Mark bounds, night waves, dawn cleanup, input isolation, and exact run restoration")
	else:
		push_error("SELF_TEST_PLAYTESTER_FAIL: pause=%s marks=%s/%s bounds=%s/%s night=%s/%s day=%s restore=%s input=%s high=%s marked=%s opening=%s/%s" % [panel_pauses, mark_up, mark_down, upper_bound, lower_bound, forced_night, repeat_night, forced_day, restored, no_click_leak, high_mark_night, marked_restored, opening_override, opening_restored])
	return passed

func is_cave_camp_start() -> bool:
	return state == "journey" and zone == 0 and mark_level == 0 and cured_allies.is_empty() and wagon_repair == 0 and wagon_condition() == "cave_damaged" and wagon_travel_locked() and lolth_form() == "elf" and not is_night() and shades.is_empty() and night_wave_total == 0 and tutorial_phase == "day_salvage"

# H-01 through H-03 boards are reference-only and must never be admitted into res://.
func res_has_reference_board(path: String) -> bool:
	var dir := DirAccess.open(path)
	if dir == null:
		return false
	for file_name in dir.get_files():
		var lower := file_name.to_lower()
		if lower.contains("hq-narrative") or lower.begins_with("h-01") or lower.begins_with("h-02") or lower.begins_with("h-03"):
			return true
	for sub_dir in dir.get_directories():
		if sub_dir.begins_with("."):
			continue
		if res_has_reference_board(path.path_join(sub_dir)):
			return true
	return false

func start_new_run() -> void:
	reset_to_prologue()
	state = "opening"
	opening_beat = 0

func advance_opening() -> void:
	if state != "opening":
		return
	opening_beat += 1
	if opening_beat >= H01_SHELL_BEATS.size():
		finish_opening()

func skip_opening() -> void:
	if state != "opening":
		return
	finish_opening()

func finish_opening() -> void:
	opening_beat = 0
	reset_to_prologue()

func lolth_form() -> String:
	return "elf" if mark_level == 0 else "drow"

# The Wheel Kit repair stations the wagon. It never unlocks travel.
func wagon_condition() -> String:
	return "stationed" if int(crafted_recipes.get("wheel_kit", 0)) >= 1 else "cave_damaged"

# Travel requires Mark IV, four cures, a repaired wagon, and an assigned puller.
# No runtime path unlocks it yet, so the wagon stays at the cave camp.
func wagon_travel_locked() -> bool:
	return true

func ally_records() -> Array[Dictionary]:
	var records: Array[Dictionary] = []
	for ally in THALESTRIEL:
		records.append({"name": ally, "condition": "cured" if cured_allies.has(ally) else "plagued", "form": "drow" if cured_allies.has(ally) else "elf", "controllable": false})
	return records

func cave_camp_state() -> Dictionary:
	return {
		"location": "thornwake_cave",
		"lolth_form": lolth_form(),
		"controllable": ["NOLF"],
		"wagon": {"open": true, "horse": false, "beds": false, "enclosed_rooms": false, "condition": wagon_condition(), "travel": "travel_locked" if wagon_travel_locked() else "travel_ready", "repair": wagon_repair, "integrity": wagon_integrity},
		"relics": {"present": true, "protected": true},
		"fire": flame,
		"stock": wagon_stock.size(),
		"allies": ally_records(),
		"anchor_x": CARAVAN_X,
		"lolth_region": lolth_region(),
	}

# B-06: the Wagon and family stay at one cave anchor. Wagon interaction uses world x,
# so a camera offset or the displayed region can never create a second camp.
func at_wagon() -> bool:
	return player.x < WAGON_INTERACT_MAX_X

# Lolth's displayed region along the route. The hub context (zone) stays Thornwake.
func lolth_region() -> String:
	if zone != 0 or player.x < ROUTE_THORNWAKE_END_X:
		return ["thornwake", "stonehook", "hollowroot"][zone]
	if player.x < ROUTE_FOOTHILLS_START_X:
		return "stonehook_approach"
	return "stonehook_foothills"

func displayed_region_name() -> String:
	match lolth_region():
		"stonehook_approach":
			return "STONEHOOK APPROACH"
		"stonehook_foothills":
			return "STONEHOOK FOOTHILLS"
	return ZONE_NAMES[zone]

func is_away_from_cave() -> bool:
	return zone == 0 and player.x >= ROUTE_THORNWAKE_END_X

# Departure needs the legitimate first-cure milestones and a survivable saved camp:
# the real Antlered Hunger defeat, Mark I, exactly one cure, the repaired Wagon and a
# captured safe-wagon state. Playtester overrides and the self-test travel bypass never
# grant it. Only departure is gated; walking back is always allowed.
func expedition_departure_allowed() -> bool:
	return state == "journey" and zone == 0 and not playtester_active and antlered_hunger_defeated and mark_level == THORNWAKE_MARK_CAP and cured_allies.size() == 1 and wagon_condition() == "stationed" and camp_secured and not safe_wagon_state.is_empty()

func route_east_limit_x() -> float:
	if zone == 0 and expedition_departure_allowed():
		return ROUTE_END_X - PLAYER_EDGE_MARGIN
	return VIEW.x - PLAYER_EDGE_MARGIN

func camera_limit_x() -> float:
	if zone != 0:
		return 0.0
	if expedition_departure_allowed() or player.x > VIEW.x - PLAYER_EDGE_MARGIN:
		return ROUTE_END_X - VIEW.x
	return 0.0

func camera_target_x() -> float:
	var target := camera_x
	var screen_x := player.x - camera_x
	if screen_x > CAMERA_WINDOW_RIGHT:
		target = player.x - CAMERA_WINDOW_RIGHT
	elif screen_x < CAMERA_WINDOW_LEFT:
		target = player.x - CAMERA_WINDOW_LEFT
	return clampf(target, 0.0, camera_limit_x())

func update_camera(delta: float) -> void:
	camera_x = move_toward(camera_x, camera_target_x(), CAMERA_GLIDE_SPEED * delta)

func snap_camera() -> void:
	camera_x = 0.0
	camera_x = camera_target_x()

# The world-to-view translation. HUD and interfaces never use it.
func world_draw_origin() -> Vector2:
	return Vector2(-roundf(camera_x), 0.0)

func route_ore_state() -> Dictionary:
	for item in salvage:
		if String(item.get("id", "")) == ROUTE_ORE_ID:
			return item
	return {}

# Counts every copy of an identified pickup across the world, Lolth's load and Wagon stock.
func pickup_copies(pickup_id: String) -> int:
	var copies := 0
	for item in salvage:
		if String(item.get("id", "")) == pickup_id and not bool(item.taken):
			copies += 1
	for collection in [recovered_load, wagon_stock]:
		for item in collection:
			if String(item.get("id", "")) == pickup_id:
				copies += 1
	return copies

func spawn_zone() -> void:
	player = Vector2(330, GROUND_Y - 38)
	velocity = Vector2.ZERO
	on_floor = true
	ally_assists_used.clear()
	salvage.clear()
	shades.clear()
	# The foothill actors are transient like the cave threats; their saved flags decide re-creation.
	scree_crawler = {}
	cliff_harrier = {}
	mark_gates.clear()
	zone_hazards.clear()
	rope_routes.clear()
	platforms = [Rect2(410, 470, 160, 18), Rect2(650, 400, 175, 18), Rect2(930, 455, 170, 18)]
	if zone == 1:
		platforms = [Rect2(365, 490, 135, 18), Rect2(550, 430, 125, 18), Rect2(730, 365, 115, 18), Rect2(910, 425, 125, 18), Rect2(1080, 350, 105, 18)]
		zone_hazards = [{"rect": Rect2(675, GROUND_Y - 68, 115, 68), "kind": "scree", "direction": 1.0}, {"rect": Rect2(1005, GROUND_Y - 68, 120, 68), "kind": "scree", "direction": -1.0}]
		rope_routes = [{"from": Vector2(485, 450), "to": Vector2(740, 330), "used": false}, {"from": Vector2(850, 445), "to": Vector2(1090, 315), "used": false}]
	elif zone == 2:
		platforms.clear()
		mark_gates.append({"pos": Vector2(1080, GROUND_Y - 48), "mark": 3, "name": "WEB ANCHOR", "opened": hollowroot_web_anchor_open})
	if zone == 0:
		salvage.append({"id": "thornwake_herbs", "pos": Vector2(470, 432), "name": "HERBS", "type": "herb", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"id": "thornwake_water", "pos": Vector2(610, 362), "name": "WATER", "type": "water", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"id": "thornwake_wood", "pos": Vector2(760, 362), "name": "WOOD", "type": "wood", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"id": "thornwake_dry_branches", "pos": Vector2(835, 420), "name": "DRY BRANCHES", "type": "wood", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"id": "thornwake_rope", "pos": Vector2(920, 417), "name": "ROPE", "type": "rope", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"id": "thornwake_wheel_salvage", "pos": Vector2(1060, 417), "name": "WHEEL SALVAGE", "type": "salvage", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"id": "thornwake_brazier_salvage", "pos": Vector2(1105, 417), "name": "BRAZIER SALVAGE", "type": "salvage", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"id": "thornwake_kindling", "pos": Vector2(1110, GROUND_Y - 34), "name": "KINDLING", "type": "kindling", "slots": 1, "taken": false, "renewable": true})
		# B-06: one finite foothill ore on the floor. It never renews and has a stable identity.
		salvage.append({"id": ROUTE_ORE_ID, "pos": Vector2(ROUTE_ORE_X, GROUND_Y - 34), "name": "IRON ORE", "type": "metal", "slots": 1, "taken": false, "renewable": false})
		if is_night():
			spawn_thornwake_night_enemies()
	elif zone == 1:
		salvage.append({"pos": Vector2(455, 452), "name": "IRON ORE", "type": "metal", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(620, 390), "name": "IRON ORE", "type": "metal", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(800, 325), "name": "CLIMBING ROPE", "type": "rope", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(970, 385), "name": "BRAKE TOOL", "type": "tool", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(1135, 310), "name": "MOUNTAIN KINDLING", "type": "kindling", "slots": 1, "taken": false, "renewable": true})
		if is_night():
			spawn_stonehook_night_enemies()
	elif zone == 2:
		salvage.append({"pos": Vector2(670, 372), "name": "PROVISIONS", "type": "provisions", "slots": 1, "taken": false})
		salvage.append({"pos": Vector2(850, GROUND_Y - 34), "name": "KINDLING", "type": "kindling", "slots": 1, "taken": false})
		salvage.append({"pos": Vector2(1030, 392), "name": "SALVAGE", "type": "salvage", "slots": 2, "taken": false})
		if is_night():
			spawn_hollowroot_night_enemies()
	message = "%s — %s" % [ZONE_NAMES[zone], ZONE_OBJECTIVES[zone]]
	message_time = 4.0
	route_closed_notice = 0.0
	snap_camera()

func _process(delta: float) -> void:
	if ui_management.is_open():
		return
	if is_instance_valid(playtester_panel) and playtester_panel.visible:
		refresh_playtester_panel()
		return
	if playtester_resume_guard:
		playtester_resume_guard = false
		ui_gameplay_requests.clear()
		return
	pulse += delta
	update_lolth_presentation(delta)
	message_time = maxf(0.0, message_time - delta)
	if state == "opening":
		if Input.is_action_just_pressed("skip"):
			skip_opening()
		elif Input.is_action_just_pressed("primary"):
			advance_opening()
		queue_redraw()
		return
	if state == "shar_shell":
		if Input.is_action_just_pressed("skip"):
			skip_shar_shell()
		elif Input.is_action_just_pressed("primary"):
			advance_shar_shell()
		queue_redraw()
		return
	if state == "cure":
		process_cure_selection()
		queue_redraw()
		return
	if state == "thornwake_complete":
		if Input.is_action_just_pressed("primary"):
			advance_to_stonehook()
		queue_redraw()
		return
	if state == "stonehook_complete":
		if Input.is_action_just_pressed("primary"):
			advance_to_hollowroot()
		queue_redraw()
		return
	if state != "journey":
		if Input.is_action_just_pressed("primary"):
			restart_from_checkpoint()
		queue_redraw()
		return

	advance_world_clock(delta)
	flame = maxf(0.0, flame - delta * 0.10)
	provisions = maxf(0.0, provisions - delta * 0.006)
	var direction := Input.get_axis("move_left", "move_right")
	if absf(direction) > 0.1:
		player_facing_left = direction < 0.0
	velocity.x = move_toward(velocity.x, direction * 290.0, 2100.0 * delta)
	if Input.is_action_just_pressed("jump") and on_floor:
		velocity.y = -JUMP_SPEED
		on_floor = false
	velocity.y += GRAVITY * delta
	move_player(delta)
	update_camera(delta)
	hurt_cooldown = maxf(0.0, hurt_cooldown - delta)
	hazard_cooldown = maxf(0.0, hazard_cooldown - delta)
	dodge_time = maxf(0.0, dodge_time - delta)
	dodge_cooldown = maxf(0.0, dodge_cooldown - delta)
	combo_time = maxf(0.0, combo_time - delta)
	first_thread_cooldown = maxf(0.0, first_thread_cooldown - delta)
	if combo_time <= 0.0:
		combo_step = 0
		combo_target = ""
	echo_sense_time = maxf(0.0, echo_sense_time - delta)
	mark_vfx_time = maxf(0.0, mark_vfx_time - delta)
	player_action_time = maxf(0.0, player_action_time - delta)
	hurt_flash_time = maxf(0.0, hurt_flash_time - delta)
	for shade in combat_targets():
		shade.hit_flash = maxf(0.0, float(shade.get("hit_flash", 0.0)) - delta)
	var requests := ui_gameplay_requests.duplicate()
	ui_gameplay_requests.clear()
	if "attack" in requests:
		handle_attack()
	if "primary" in requests:
		handle_primary()
	if "shadow_action" in requests:
		use_shadow_action(direction)
	if "shadow_strike" in requests:
		use_first_thread()
	if "camp_action" in requests:
		use_camp_action()
	update_wagon_threat(delta)
	update_enemies(delta)
	update_foothill_encounter(delta)
	update_night_waves(delta)
	update_zone_hazards()
	check_enemy_contact()
	update_safe_wagon()
	check_survival_failures()
	queue_redraw()

# Before Mark I, Thornwake time follows the tutorial instead of the day/night timer.
func advance_world_clock(delta: float) -> void:
	if zone == 0 and mark_level == 0:
		update_thornwake_tutorial(delta)
	else:
		update_clock(delta)

func check_enemy_contact() -> void:
	for shade in shades:
		if not shade.defeated and hurt_cooldown <= 0.0 and player.distance_to(shade.pos) < PLAYER_RADIUS + 16.0:
			hurt_lolth()
			break

func check_survival_failures() -> void:
	if flame <= 0.0:
		fail_run("The Caravan Flame went out.")
	elif provisions <= 0.0:
		fail_run("One of the Nine could not endure.")

func move_player(delta: float) -> void:
	# Departure is gated; once away, the current position is always a valid east limit.
	var east_limit := maxf(route_east_limit_x(), player.x)
	var desired_x := player.x + velocity.x * delta
	player.x = clampf(desired_x, PLAYER_EDGE_MARGIN, east_limit)
	route_closed_notice = maxf(0.0, route_closed_notice - delta)
	if zone == 0 and mark_level >= 1 and desired_x > east_limit and east_limit < ROUTE_THORNWAKE_END_X and route_closed_notice <= 0.0:
		route_closed_notice = 3.0
		message = "The eastern path opens only after the first cure and a secured camp."
		message_time = 2.5
	player.y += velocity.y * delta
	on_floor = false
	var floor_y := GROUND_Y - 38.0
	if player.y >= floor_y:
		player.y = floor_y
		velocity.y = 0.0
		on_floor = true
	if player.y > VIEW.y + 80.0:
		fail_run("Nolf fell into the ruins.")

func hurt_lolth() -> void:
	if dodge_time > 0.0:
		return
	if ally_is_near("ORISYA") and not bool(ally_assists_used.get("orisya", false)):
		ally_assists_used.orisya = true
		message = "ORISYA's blessing turns aside the blow."
		message_time = 1.8
		return
	health = maxf(0.0, health - 1.0)
	hurt_cooldown = 1.0
	hurt_flash_time = HURT_FLASH_TIME
	set_player_action("hurt", HURT_FLASH_TIME)
	message = "Nolf is wounded."
	message_time = 1.5
	if health <= 0.0:
		fail_run("Nolf could not return to the Caravan.")

func use_shadow_action(direction: float) -> void:
	perform_dodge(direction)

func perform_dodge(direction: float) -> void:
	if dodge_cooldown > 0.0:
		message = "Nolf needs a moment before dodging again."
		message_time = 0.7
		return
	var dodge_direction := direction if absf(direction) > 0.1 else -1.0 if player_facing_left else 1.0
	player_facing_left = dodge_direction < 0.0
	velocity.x = dodge_direction * DASH_SPEED * 0.78
	dodge_time = DODGE_DURATION
	dodge_cooldown = DODGE_COOLDOWN
	hurt_cooldown = DODGE_DURATION
	trigger_mark_vfx("dash", player + Vector2(0, -72))
	set_player_action("dodge", DODGE_DURATION)
	message = "NOLF DODGES"
	message_time = 0.7

func clear_combat_visuals() -> void:
	player_action = ""
	player_action_time = 0.0
	player_action_duration = 0.0
	player_animation_pose = "idle"
	player_animation_time = 0.0
	lolth_transform_time = 0.0
	hurt_flash_time = 0.0
	dodge_time = 0.0
	dodge_cooldown = 0.0
	hurt_cooldown = 0.0
	mark_vfx_time = 0.0
	ui_gameplay_requests.clear()
	if is_instance_valid(ui_management):
		ui_management.close_window()

func handle_attack() -> void:
	var melee_target := find_melee_target()
	if not melee_target.is_empty():
		var shade := melee_target
		player_facing_left = float(shade.pos.x) < player.x
		set_player_action("strike", ATTACK_POSE_TIME)
		shade.hit_flash = ENEMY_HIT_FLASH_TIME
		var target_name := String(shade.name)
		if combo_time > 0.0 and combo_target == target_name:
			combo_step = mini(combo_step + 1, COMBO_DAMAGE.size())
		else:
			combo_step = 1
		combo_target = target_name
		combo_time = COMBO_WINDOW
		var strike_power := int(COMBO_DAMAGE[combo_step - 1])
		if ally_is_near("NIMARA") and not bool(ally_assists_used.get("nimara", false)):
			strike_power += 1
			ally_assists_used.nimara = true
			message = "NIMARA exposes a weak point."
		if ally_is_near("SORETH") and not bool(ally_assists_used.get("soreth", false)):
			strike_power += 1
			ally_assists_used.soreth = true
			message = "SORETH pins the enemy in place."
		shade.health = int(shade.health) - strike_power
		trigger_mark_vfx("strike", shade.pos + Vector2(0, -32))
		if int(shade.health) <= 0:
			combo_step = 0
			combo_target = ""
			defeat_enemy(shade)
		else:
			message = "%s is staggered. STRIKE %d/3." % [shade.name, combo_step]
		message_time = 1.2
		return
	var nearby := nearest_live_enemy(MISS_FEEDBACK_RANGE)
	if not nearby.is_empty():
		player_facing_left = float(nearby.pos.x) < player.x
	set_player_action("strike", ATTACK_POSE_TIME)
	trigger_mark_vfx("swing", player + Vector2(-58.0 if player_facing_left else 58.0, -70.0))
	combo_step = 0
	combo_time = 0.0
	combo_target = ""
	message = "Out of reach — step closer to strike the %s." % nearby.name if not nearby.is_empty() else "Nolf swings. No enemy in reach."
	message_time = 1.2

# Interaction cannot damage an enemy, even when it overlaps a pickup.
func handle_primary() -> void:
	if zone == 2 and mark_level == 9 and absf(player.x - PORTAL_X) < 90.0:
		state = "victory"
		message = "Their old memories are gone. Nolf leaves Xiar's kiss with the First Nine."
		return
	if use_rope_route():
		return
	for gate in mark_gates:
		if not gate.opened and player.distance_to(gate.pos) < INTERACT_RADIUS:
			if mark_level < int(gate.mark):
				message = "%s requires %s." % [gate.name, MARK_NAMES[int(gate.mark)]]
				message_time = 2.5
				return
			gate.opened = true
			if String(gate.name) == "WEB ANCHOR":
				hollowroot_web_anchor_open = true
				trigger_mark_vfx("gate", gate.pos)
				message = "Nolf binds a solid web floor across the Web Anchor."
			else:
				message = "%s yields to Nolf's Mark." % gate.name
			message_time = 2.5
			return
	if at_wagon():
		if not recovered_load.is_empty():
			store_selected_load()
		else:
			craft_selected_recipe()
			message_time = 2.0
		return
	for item in salvage:
		if not item.taken and player.distance_to(item.pos) < INTERACT_RADIUS:
			if add_to_load(item):
				item.taken = true
				trigger_mark_vfx("collect", item.pos)
				set_player_action("collect", ATTACK_POSE_TIME)
				message = "%s secured in RECOVERED LOAD." % item.name
				message_time = 2.5
			return
	message = "Stand near a resource or the Wagon and press E to interact."
	message_time = 2.0

func melee_reach(shade: Dictionary) -> float:
	if is_scree_crawler(shade) or is_cliff_harrier(shade) or (zone == 0 and THORNWAKE_ENEMY_SIZES.has(String(shade.name))):
		return MELEE_LOLTH_HALF_WIDTH + enemy_draw_geometry(shade).body.size.x / 2.0
	var old_size := 160.0 if String(shade.name) == "ANTLERED HUNGER" else 96.0
	return MELEE_LOLTH_HALF_WIDTH + float(MELEE_ENEMY_HALF_WIDTHS.get(String(shade.name), MELEE_DEFAULT_ENEMY_HALF_WIDTH)) * enemy_visual_size(shade) / old_size

func enemy_visual_size(shade: Dictionary) -> float:
	if is_scree_crawler(shade):
		return SCREE_CRAWLER_BODY_HEIGHT
	if is_cliff_harrier(shade):
		return CLIFF_HARRIER_BODY_HEIGHT
	return float(THORNWAKE_ENEMY_SIZES.get(String(shade.name), 96.0)) if zone == 0 else 96.0

# The nearest live enemy whose drawn body touches Lolth's.
func find_melee_target() -> Dictionary:
	var target: Dictionary = {}
	var best := INF
	for shade in combat_targets():
		if shade.defeated:
			continue
		var gap := absf(float(shade.pos.x) - player.x)
		if gap <= melee_reach(shade) and absf(float(shade.pos.y) - player.y) <= MELEE_VERTICAL_REACH and gap < best:
			target = shade
			best = gap
	return target

func nearest_live_enemy(range_limit: float) -> Dictionary:
	var target: Dictionary = {}
	var best := range_limit
	for shade in combat_targets():
		var gap := player.distance_to(shade.pos)
		if not shade.defeated and gap <= best:
			target = shade
			best = gap
	return target

func set_player_action(action: String, duration: float) -> void:
	player_action = action
	player_action_time = duration
	player_action_duration = duration
	player_animation_pose = action
	player_animation_time = 0.0

func begin_lolth_transformation(previous_mark: int) -> void:
	var new_stage := LOLTH_TRANSFORMATIONS.stage_for_mark(mark_level)
	if new_stage > LOLTH_TRANSFORMATIONS.stage_for_mark(previous_mark):
		lolth_transform_time = LOLTH_TRANSFORMATIONS.TRANSFORM_DURATION

func update_lolth_presentation(delta: float) -> void:
	lolth_transform_time = maxf(0.0, lolth_transform_time - delta)
	var pose := player_pose()
	if pose != player_animation_pose:
		player_animation_pose = pose
		player_animation_time = 0.0
	else:
		player_animation_time += delta

func player_pose() -> String:
	if player_action_time > 0.0 and player_action != "":
		return player_action
	if not on_floor:
		return "air"
	if absf(velocity.x) > 40.0:
		return "walk"
	return "idle"

func player_hurt_visible() -> bool:
	return hurt_flash_time > 0.0

func defeat_enemy(shade: Dictionary) -> void:
	shade.defeated = true
	shade.defeated_at = pulse
	if is_scree_crawler(shade):
		defeat_scree_crawler()
		return
	if is_cliff_harrier(shade):
		defeat_cliff_harrier()
		return
	if mark_level > 0:
		collect_echo(int(shade.echoes))
	message = "%s falls. Nolf absorbs its shadow." % shade.name
	message_time = 1.2
	if String(shade.name) == "STONE MAW":
		stonehook_boss_defeated = true
		try_advance_from_camp()
	elif String(shade.name) == "ROOT CROWN":
		hollowroot_boss_defeated = true
		try_advance_from_camp()
	elif String(shade.name) == "ANTLERED HUNGER":
		defeat_antlered_hunger()

# FIRST THREAD: a short-range shadow strike that supplements melee and dodge.
func use_first_thread() -> void:
	if mark_level < 1:
		message = "Nolf has no shadow strike yet."
		message_time = 1.5
		return
	if first_thread_cooldown > 0.0:
		return
	var target: Dictionary = {}
	var best_distance := INF
	for shade in combat_targets():
		var distance := player.distance_to(shade.pos)
		if not shade.defeated and first_thread_reaches(shade) and distance <= best_distance:
			target = shade
			best_distance = distance
	if target.is_empty():
		message = "FIRST THREAD finds no target in range."
		message_time = 1.2
		return
	first_thread_cooldown = FIRST_THREAD_COOLDOWN
	player_facing_left = float(target.pos.x) < player.x
	set_player_action("strike", ATTACK_POSE_TIME)
	target.hit_flash = ENEMY_HIT_FLASH_TIME
	target.health = int(target.health) - FIRST_THREAD_DAMAGE
	trigger_mark_vfx("strike", target.pos + Vector2(0, -32))
	if int(target.health) <= 0:
		defeat_enemy(target)
	else:
		message = "FIRST THREAD strikes %s." % target.name
		message_time = 1.2

func load_capacity() -> int:
	var might := int(current_stats().might)
	if might >= 10:
		return 4
	if might >= 8:
		return 3
	return 2

func current_stats() -> Dictionary:
	return MARK_STATS[mark_level]

func max_health() -> float:
	var vigor := int(current_stats().vigor)
	if vigor >= 10:
		return 5.0
	if vigor >= 8:
		return 4.0
	return 3.0

func load_used() -> int:
	var used := 0
	for item in recovered_load:
		used += int(item.slots)
	return used

func add_to_load(item: Dictionary) -> bool:
	var item_slots := int(item.slots)
	if ally_is_near("VAELUN") and item_slots > 1 and not bool(ally_assists_used.get("vaelun", false)):
		item_slots -= 1
		ally_assists_used.vaelun = true
		message = "VAELUN braces the load. It takes one less slot."
	if load_used() + item_slots > load_capacity():
		message = "RECOVERED LOAD is full. Return to the Caravan or choose another item."
		message_time = 3.0
		return false
	var carried_item := item.duplicate()
	carried_item.slots = item_slots
	recovered_load.append(carried_item)
	selected_load = recovered_load.size() - 1
	if ally_is_near("AELIRA") and String(item.type) in ["herb", "water", "food"] and not bool(ally_assists_used.get("aelira", false)):
		ally_assists_used.aelira = true
		provisions = minf(8.0, provisions + 1.0)
		message = "AELIRA finds enough for the group while Nolf gathers supplies."
		message_time = 2.5
	return true

func store_selected_load() -> void:
	if wagon_stock.size() >= WAGON_STOCK_CAPACITY:
		message = "WAGON STOCK is full. Craft or use supplies before storing more."
		message_time = 2.5
		return
	selected_load = clampi(selected_load, 0, recovered_load.size() - 1)
	var item: Dictionary = recovered_load[selected_load]
	recovered_load.remove_at(selected_load)
	selected_load = maxi(0, selected_load - 1)
	wagon_stock.append(item)
	message = "%s stored in the Wagon (%d/%d)." % [item.name, wagon_stock.size(), WAGON_STOCK_CAPACITY]
	message_time = 3.0

func open_camp_menu() -> void:
	if not at_wagon():
		message = "Return to the Wagon to manage supplies and crafting."
		message_time = 2.0
		return
	if zone == 0 and mark_level == 0 and tutorial_phase == "day_salvage":
		selected_recipe = WHEEL_KIT_RECIPE
	ui_management.toggle_wagon()

func try_advance_from_camp() -> void:
	if zone == 0:
		# The first boss, Shar, and the Mark I hand-off belong to B-03. The tutorial never starts them.
		return
	if zone == 1:
		if not axle_brakes_installed:
			message = "Forge AXLE & BRAKES with 2 metal, rope, and a brake tool."
			message_time = 3.0
			return
		if not stonehook_boss_defeated:
			message = "The STONE MAW guards the mountain shrine at night."
			message_time = 3.0
			if is_night():
				spawn_stonehook_night_enemies()
			return
		open_stonehook_mark()
		return
	if zone == 2:
		if not hollowroot_boss_defeated:
			message = "ROOT CROWN holds the cavern route. Defend the Wagon through the night."
			message_time = 3.0
			if is_night():
				spawn_hollowroot_night_enemies()
			return
		hollowroot_mark_ready = true
		if state == "cure":
			return
		message = "The third Mark has opened the Web Anchor. Cure a Thalestriel, then bind the crossing."
		message_time = 3.5

func advance_to_stonehook() -> void:
	enter_stonehook()

# Prototype later-region entry. The travel lock holds unless the self-test bypass is set.
func enter_stonehook() -> void:
	if wagon_travel_locked() and not self_test_travel_bypass:
		message = "The Wagon cannot leave the cave camp yet."
		message_time = 3.0
		return
	zone = 1
	state = "journey"
	stonehook_boss_defeated = false
	stonehook_shar_ready = false
	spawn_zone()
	message = "STONEHOOK MOUNTAINS — Recover metal for axle and brakes."
	message_time = 5.0

func advance_to_hollowroot() -> void:
	zone = 2
	state = "journey"
	hollowroot_boss_defeated = false
	hollowroot_mark_ready = false
	hollowroot_web_anchor_open = false
	spawn_zone()
	message = "HOLLOWROOT CAVERNS — The route narrows beneath living roots. Hold the Wagon through the night."
	message_time = 5.0

func open_stonehook_mark() -> void:
	if stonehook_shar_ready:
		return
	var threshold: int = int(ECHO_THRESHOLDS[mark_level])
	if shadow_echoes < threshold:
		message = "The shrine needs %d more Shadow Echoes." % (threshold - shadow_echoes)
		message_time = 3.0
		return
	stonehook_shar_ready = true
	shadow_echoes -= threshold
	advance_mark()

func advance_to_next_zone() -> void:
	var mission_result := resolve_mission()
	zone = 2
	final_echo_phase = false
	spawn_zone()
	if not mission_result.is_empty():
		message = mission_result
		message_time = 4.0

func all_shades_defeated() -> bool:
	for shade in shades:
		if not shade.defeated:
			return false
	return true

func start_shar_shell() -> void:
	state = "shar_shell"
	shar_beat = 0

func advance_shar_shell() -> void:
	if state != "shar_shell":
		return
	shar_beat += 1
	if shar_beat >= H02_SHELL_BEATS.size():
		finish_shar_shell()

func skip_shar_shell() -> void:
	if state != "shar_shell":
		return
	finish_shar_shell()

func finish_shar_shell() -> void:
	shar_beat = 0
	apply_mark_one()

# Mark I applies once: Lolth becomes drow, gains FIRST THREAD, and chooses one cure.
func apply_mark_one() -> void:
	if mark_level >= 1:
		return
	mark_level = 1
	shadow_echoes = 0
	health = max_health()
	state = "cure"
	selected_cure = 0
	message = "FIRST THREAD — Choose one Thalestriel to cure."
	message_time = 5.0

func collect_echo(amount := 1) -> void:
	if mark_level <= 0 or mark_level >= 9:
		return
	var threshold: int = int(ECHO_THRESHOLDS[mark_level])
	if zone == 0:
		# Echoes begin only after the first cure and stop at the next Mark threshold.
		if cured_allies.is_empty():
			return
		if mark_level >= THORNWAKE_MARK_CAP:
			shadow_echoes = mini(shadow_echoes + amount, threshold)
			message = "SHADOW ECHOES %d/%d." % [shadow_echoes, threshold]
			message_time = 1.6
			return
	shadow_echoes += amount
	if zone == 1 and mark_level == 1 and not stonehook_shar_ready:
		if shadow_echoes >= threshold:
			message = "The Echoes gather around the Stonehook shrine. Finish axle and brakes."
		else:
			message = "Shadow Echoes: %d/%d. The mountain answers." % [shadow_echoes, threshold]
		message_time = 2.2
		return
	if shadow_echoes >= threshold:
		shadow_echoes -= threshold
		advance_mark()
	else:
		message = "Shadow Echoes: %d/%d." % [shadow_echoes, threshold]
		message_time = 1.6

func trigger_mark_vfx(kind: String, position: Vector2) -> void:
	mark_vfx_kind = kind
	mark_vfx_pos = position
	mark_vfx_time = 0.42

func advance_mark() -> void:
	var previous_mark := mark_level
	mark_level += 1
	begin_lolth_transformation(previous_mark)
	health = max_health()
	if mark_level <= 8:
		state = "cure"
		selected_cure = 0
		message = "%s — Choose a Thalestriel to cure." % MARK_NAMES[mark_level]
	else:
		message = "SHADOW CROWN — Xiar takes the First Drows' memories as Nolf becomes a vast shadow spider."
	create_checkpoint()
	message_time = 4.5

func create_checkpoint() -> void:
	checkpoint = {"mark": mark_level, "zone": zone, "flame": flame, "provisions": provisions, "awakened": awakened, "final_echo_phase": final_echo_phase, "wagon_repair": wagon_repair, "load": recovered_load.duplicate(true), "stock": wagon_stock.duplicate(true), "wagon_integrity": wagon_integrity, "clock": clock_seconds, "echoes": shadow_echoes, "cured": cured_allies.duplicate(), "posts": posted_allies.duplicate(), "downed": downed_drows.duplicate(), "first_night": first_night_complete, "axle_brakes": axle_brakes_installed, "stonehook_boss": stonehook_boss_defeated, "stonehook_shar": stonehook_shar_ready, "hollowroot_boss": hollowroot_boss_defeated, "hollowroot_mark": hollowroot_mark_ready, "hollowroot_web": hollowroot_web_anchor_open, "brazier": brazier_built, "crafted": crafted_recipes.duplicate(true), "crawler": scree_crawler_state(), "harrier": cliff_harrier_state()}

func fail_run(reason: String) -> void:
	if state != "journey":
		return
	state = "defeat"
	message = "%s Checkpoint: %s." % [reason, checkpoint_label()]

func checkpoint_label() -> String:
	if int(checkpoint.mark) == 0:
		return "PROLOGUE"
	if zone == 0 and camp_secured and not safe_wagon_state.is_empty():
		return "SAFE WAGON"
	return MARK_NAMES[int(checkpoint.mark)]

# Lolth is at the safe Wagon when she stands in the Wagon interaction area with no living
# enemy, no unfinished night defense, and a survivable camp. A terminal Flame, Provisions,
# health, or Wagon state is never captured, so the previous valid snapshot stays the fallback.
func is_at_safe_wagon() -> bool:
	if state != "journey" or zone != 0 or mark_level < 1 or cured_allies.is_empty() or not at_wagon():
		return false
	if flame <= 0.0 or provisions <= 0.0 or health <= 0.0 or wagon_integrity <= 0.0:
		return false
	for shade in shades:
		if not shade.defeated:
			return false
	return not is_night() or night_waves_complete

# Captures the safe-wagon state each time Lolth arrives at the safe Wagon after the first cure.
func update_safe_wagon() -> void:
	var at_safe_wagon := is_at_safe_wagon()
	if at_safe_wagon and not was_at_safe_wagon:
		capture_safe_wagon_state()
	was_at_safe_wagon = at_safe_wagon

# Operational data only. Mark I and the chosen cure are narrative progression and are never
# overwritten by a restore.
func capture_safe_wagon_state() -> void:
	var taken: Array[bool] = []
	# B-06: identified pickups (including the finite foothill ore) restore by identity.
	var taken_by_id: Dictionary = {}
	for item in salvage:
		taken.append(bool(item.taken))
		if item.has("id"):
			taken_by_id[String(item.id)] = bool(item.taken)
	safe_wagon_state = {"health": health, "flame": flame, "provisions": provisions, "wagon_integrity": wagon_integrity, "clock": clock_seconds, "load": recovered_load.duplicate(true), "stock": wagon_stock.duplicate(true), "wagon_repair": wagon_repair, "crafted": crafted_recipes.duplicate(true), "brazier": brazier_built, "echoes": shadow_echoes, "first_night": first_night_complete, "tutorial_phase": tutorial_phase, "night_wave": night_wave, "night_wave_total": night_wave_total, "night_waves_complete": night_waves_complete, "salvage_taken": taken, "pickup_taken": taken_by_id, "crawler": scree_crawler_state(), "harrier": cliff_harrier_state()}
	camp_secured = true
	message = "CAMP SECURED — If Nolf falls, she returns to this moment at the Wagon."
	message_time = 4.0

func restore_safe_wagon_state() -> void:
	clear_combat_visuals()
	var saved := safe_wagon_state
	health = float(saved.health)
	flame = float(saved.flame)
	provisions = float(saved.provisions)
	wagon_integrity = float(saved.wagon_integrity)
	clock_seconds = float(saved.clock)
	recovered_load = saved.load.duplicate(true)
	wagon_stock = saved.stock.duplicate(true)
	wagon_repair = int(saved.wagon_repair)
	crafted_recipes = saved.crafted.duplicate(true)
	brazier_built = bool(saved.brazier)
	shadow_echoes = int(saved.echoes)
	first_night_complete = bool(saved.first_night)
	tutorial_phase = String(saved.tutorial_phase)
	night_wave = int(saved.night_wave)
	night_wave_total = int(saved.night_wave_total)
	night_waves_complete = bool(saved.night_waves_complete)
	night_wave_pause = 0.0
	selected_load = 0
	hurt_cooldown = 0.0
	dodge_time = 0.0
	dodge_cooldown = 0.0
	first_thread_cooldown = 0.0
	player_action = ""
	player_action_time = 0.0
	hurt_flash_time = 0.0
	combo_step = 0
	combo_time = 0.0
	combo_target = ""
	state = "journey"
	spawn_zone()
	var taken: Array = saved.salvage_taken
	var taken_by_id: Dictionary = saved.get("pickup_taken", {})
	for index in salvage.size():
		var pickup_id := String(salvage[index].get("id", ""))
		if taken_by_id.has(pickup_id):
			salvage[index].taken = bool(taken_by_id[pickup_id])
		elif index < taken.size():
			salvage[index].taken = bool(taken[index])
	# spawn_zone() returned Lolth to the cave camp and the view to its zero offset, and cleared
	# the transient crawler. Its saved flags roll back together with the saved Echoes and ore.
	apply_scree_crawler_state(saved.get("crawler", {}))
	apply_cliff_harrier_state(saved.get("harrier", {}))
	was_at_safe_wagon = false
	message = "Restored at the safe Wagon. Mark I and %s's cure remain." % ", ".join(cured_allies)
	message_time = 4.0

func restart_from_checkpoint() -> void:
	clear_combat_visuals()
	if int(checkpoint.mark) == 0:
		reset_to_prologue()
		return
	if zone == 0 and mark_level >= 1 and camp_secured and not safe_wagon_state.is_empty():
		restore_safe_wagon_state()
		return
	mark_level = int(checkpoint.mark)
	awakened = int(checkpoint.awakened)
	zone = int(checkpoint.zone)
	flame = float(checkpoint.flame)
	provisions = float(checkpoint.provisions)
	final_echo_phase = bool(checkpoint.final_echo_phase)
	wagon_repair = int(checkpoint.wagon_repair)
	wagon_integrity = float(checkpoint.wagon_integrity)
	clock_seconds = float(checkpoint.clock)
	shadow_echoes = int(checkpoint.echoes)
	recovered_load = checkpoint.load.duplicate(true)
	wagon_stock = checkpoint.stock.duplicate(true)
	cured_allies = checkpoint.cured.duplicate()
	posted_allies = checkpoint.posts.duplicate()
	downed_drows = checkpoint.downed.duplicate()
	first_night_complete = bool(checkpoint.first_night)
	axle_brakes_installed = bool(checkpoint.axle_brakes)
	stonehook_boss_defeated = bool(checkpoint.stonehook_boss)
	stonehook_shar_ready = bool(checkpoint.stonehook_shar)
	hollowroot_boss_defeated = bool(checkpoint.get("hollowroot_boss", false))
	hollowroot_mark_ready = bool(checkpoint.get("hollowroot_mark", false))
	hollowroot_web_anchor_open = bool(checkpoint.get("hollowroot_web", false))
	brazier_built = bool(checkpoint.brazier)
	crafted_recipes = checkpoint.crafted.duplicate(true)
	selected_load = 0
	health = max_health()
	hurt_cooldown = 0.0
	night_wave = 0
	night_wave_total = 0
	night_wave_pause = 0.0
	night_waves_complete = false
	combo_step = 0
	combo_time = 0.0
	combo_target = ""
	passive_mission.clear()
	state = "journey"
	spawn_zone()
	apply_scree_crawler_state(checkpoint.get("crawler", {}))
	apply_cliff_harrier_state(checkpoint.get("harrier", {}))
	message = "Restored at %s. The Wagon holds." % checkpoint_label()
	message_time = 4.0

func reset_to_prologue() -> void:
	clear_combat_visuals()
	state = "journey"
	zone = 0
	mark_level = 0
	awakened = 0
	shadow_echoes = 0
	cured_allies.clear()
	posted_allies.clear()
	downed_drows.clear()
	selected_post_ally = 0
	selected_cure = 0
	flame = 100.0
	provisions = 4.0
	wagon_integrity = 100.0
	wagon_repair = 0
	wagon_stock.clear()
	recovered_load.clear()
	selected_load = 0
	selected_recipe = WHEEL_KIT_RECIPE
	tutorial_phase = "day_salvage"
	dusk_time = 0.0
	antlered_hunger_defeated = false
	first_thread_cooldown = 0.0
	camp_secured = false
	safe_wagon_state = {}
	was_at_safe_wagon = false
	crawler_activated = false
	crawler_defeated = false
	crawler_reward_paid = false
	harrier_activated = false
	harrier_defeated = false
	harrier_reward_paid = false
	player_action = ""
	player_action_time = 0.0
	hurt_flash_time = 0.0
	dodge_time = 0.0
	dodge_cooldown = 0.0
	brazier_built = false
	crafted_recipes = {"cataplasm": 0, "wheel_kit": 0, "brazier": 0, "axle_brakes": 0}
	clock_seconds = 0.0
	first_night_complete = false
	night_wave = 0
	night_wave_total = 0
	night_wave_pause = 0.0
	night_waves_complete = false
	axle_brakes_installed = false
	stonehook_boss_defeated = false
	stonehook_shar_ready = false
	hollowroot_boss_defeated = false
	hollowroot_mark_ready = false
	hollowroot_web_anchor_open = false
	health = max_health()
	combo_step = 0
	combo_time = 0.0
	combo_target = ""
	checkpoint = {"mark": 0, "zone": 0, "flame": flame, "provisions": provisions, "awakened": 0, "final_echo_phase": false, "wagon_repair": 0, "load": [], "stock": [], "wagon_integrity": wagon_integrity, "clock": clock_seconds, "echoes": 0, "cured": [], "posts": [], "downed": [], "first_night": false, "axle_brakes": false, "stonehook_boss": false, "stonehook_shar": false, "brazier": false, "crafted": {}}
	spawn_zone()
	message = "THORNWAKE CAVE CAMP — The damaged Wagon rests in the cave."
	message_time = 5.0

func is_night() -> bool:
	return clock_seconds >= DAY_DURATION

func clock_label() -> String:
	return "NIGHT" if is_night() else "DAY"

func update_clock(delta: float) -> void:
	var was_night := is_night()
	clock_seconds += delta
	if clock_seconds >= DAY_DURATION + NIGHT_DURATION:
		clock_seconds = 0.0
	var became_day := was_night and not is_night()
	var became_night := not was_night and is_night()
	if became_day and zone == 0 and tutorial_phase == "night_defense":
		complete_tutorial_defense()
		return
	if became_day:
		first_night_complete = true
		night_wave = 0
		night_wave_total = 0
		night_wave_pause = 0.0
		night_waves_complete = false
		shades.clear()
		restore_drows_at_dawn()
		renew_thornwake_resources()
		message = "DAWN — The Forest opens. Gather supplies for the Wagon."
		message_time = 4.0
		for shade in shades:
			shade.defeated = true
	elif became_night:
		message = "NIGHTFALL — Monsters are moving toward the Wagon."
		message_time = 4.0
		if zone == 0:
			start_thornwake_night()
		elif zone == 1:
			spawn_stonehook_night_enemies()
		elif zone == 2:
			spawn_hollowroot_night_enemies()

func update_wagon_threat(delta: float) -> void:
	wagon_attack_notice = maxf(0.0, wagon_attack_notice - delta)
	if not is_night() or zone != 0:
		return
	var stag_active := false
	for enemy in shades:
		stag_active = stag_active or (not enemy.defeated and String(enemy.get("behavior", "")) == "charge")
	if stag_active and wagon_attack_notice <= 0.0:
		message = "WAGON UNDER ATTACK — Return before it breaks."
		message_time = 1.5
		wagon_attack_notice = 2.5
	if wagon_integrity <= 0.0:
		fail_run("The Wagon was destroyed.")

func wagon_defense() -> float:
	var thaviel_bonus := 0.12 if cured_allies.has("THAVIEL") else 0.0
	return minf(0.60, float(cured_allies.size()) * 0.08 + thaviel_bonus + (0.18 if brazier_built else 0.0))

func damage_wagon(amount: float, source: String) -> void:
	wagon_integrity = maxf(0.0, wagon_integrity - amount * (1.0 - wagon_defense()))
	message = "%s strikes the Wagon. Integrity: %d%%." % [source, int(ceili(wagon_integrity))]
	message_time = 1.5
	if wagon_integrity <= 0.0:
		fail_run("The Wagon was destroyed.")

func start_thornwake_night() -> void:
	if zone != 0:
		return
	shades.clear()
	night_wave = 0
	# Only Briar Hounds and Stags of Mire. The Antlered Hunger wave belongs to B-03.
	night_wave_total = TUTORIAL_NIGHT_WAVES
	night_wave_pause = 0.0
	night_waves_complete = false
	spawn_next_thornwake_wave()

func spawn_next_thornwake_wave() -> void:
	if zone != 0 or night_wave >= night_wave_total:
		return
	shades.clear()
	night_wave += 1
	match night_wave:
		1:
			spawn_enemy("BRIAR HOUND", Vector2(780, GROUND_Y - 34), 1, 1)
		2:
			spawn_enemy("STAG OF MIRE", Vector2(1080, GROUND_Y - 34), 2, 1)
		3:
			spawn_enemy("ANTLERED HUNGER", Vector2(1060, GROUND_Y - 34), 4, 3)
	message = "WAVE %d/%d - %s." % [night_wave, night_wave_total, String(shades[0].name)]
	message_time = 2.5

func update_night_waves(delta: float) -> void:
	if zone != 0 or not is_night() or night_wave_total == 0 or night_waves_complete:
		return
	if night_wave_pause > 0.0:
		night_wave_pause = maxf(0.0, night_wave_pause - delta)
		if night_wave_pause <= 0.0:
			spawn_next_thornwake_wave()
		return
	for enemy in shades:
		if not enemy.defeated:
			return
	if night_wave >= night_wave_total:
		night_waves_complete = true
		message = "THE WAGON HOLDS - Dawn will come."
		message_time = 2.5
		if tutorial_phase == "night_defense":
			complete_tutorial_defense()
		return
	night_wave_pause = NIGHT_WAVE_INTERVAL
	message = "WAVE %d/%d CLEARED - Next threat in %d." % [night_wave, night_wave_total, int(NIGHT_WAVE_INTERVAL)]
	message_time = 2.5

func spawn_thornwake_night_enemies() -> void:
	if zone != 0 or night_wave_total > 0:
		return
	start_thornwake_night()

func spawn_stonehook_night_enemies() -> void:
	if zone != 1 or not shades.is_empty():
		return
	spawn_enemy("SCREE CRAWLER", Vector2(620, GROUND_Y - 34), 2, 1)
	spawn_enemy("CLIFF HARRIER", Vector2(890, GROUND_Y - 34), 2, 1)
	if axle_brakes_installed:
		spawn_enemy("STONE MAW", Vector2(1110, GROUND_Y - 34), 5, 3)

func spawn_hollowroot_night_enemies() -> void:
	if zone != 2 or not shades.is_empty():
		return
	spawn_enemy("ROOT WRAITH", Vector2(620, GROUND_Y - 34), 2, 1)
	spawn_enemy("ROOT WRAITH", Vector2(820, GROUND_Y - 34), 2, 1)
	if not hollowroot_boss_defeated:
		spawn_enemy("ROOT CROWN", Vector2(1080, GROUND_Y - 34), 5, 2)

func spawn_enemy(enemy_name: String, position: Vector2, enemy_health: int, echoes: int) -> void:
	var behavior := "stalk"
	match enemy_name:
		"BRIAR HOUND":
			behavior = "pounce"
		"STAG OF MIRE":
			behavior = "charge"
		"ANTLERED HUNGER":
			behavior = "relentless"
		"SCREE CRAWLER":
			behavior = "burrow"
		"CLIFF HARRIER":
			behavior = "harry"
		"STONE MAW":
			behavior = "crush"
		"ROOT WRAITH":
			behavior = "entangle"
		"ROOT CROWN":
			behavior = "crush"
	var initial_target_x := CARAVAN_X if zone == 0 and behavior == "charge" else player.x
	shades.append({"pos": position, "name": enemy_name, "health": enemy_health, "max_health": enemy_health, "echoes": echoes, "behavior": behavior, "wagon_hit_cooldown": 0.0, "attack_state": "approach", "attack_time": 0.0, "attack_dir": 0.0, "attack_count": 0, "attack_target": "lolth", "hit_flash": 0.0, "defeated": false, "defeated_at": -1.0, "facing_left": initial_target_x < position.x, "origin_zone": zone})

# B-06: an enemy keeps its originating region. Thornwake attackers stay inside the cave
# span even while Lolth walks the route, so they never follow her into Stonehook.
func enemy_region_limits(enemy: Dictionary) -> Vector2:
	var origin := int(enemy.get("origin_zone", zone))
	var region_end := ROUTE_THORNWAKE_END_X if origin == 0 else VIEW.x
	return Vector2(ENEMY_EDGE_MARGIN, region_end - ENEMY_EDGE_MARGIN)

# --- B-07 first Stonehook encounter -------------------------------------------------------
func is_scree_crawler(shade: Dictionary) -> bool:
	return String(shade.get("encounter_id", "")) == SCREE_CRAWLER_ID

func scree_crawler_source() -> Rect2:
	return SCREE_CRAWLER_SOURCE

# Every actor Lolth can strike: the current cave threats plus the foothill encounters.
func combat_targets() -> Array[Dictionary]:
	var targets: Array[Dictionary] = shades.duplicate()
	if not scree_crawler.is_empty():
		targets.append(scree_crawler)
	if not cliff_harrier.is_empty():
		targets.append(cliff_harrier)
	return targets

# FIRST THREAD keeps its range, damage and cooldown. For the crawler the range is measured on
# the same floor band as melee, and never shorter than melee reach on its visible body.
func first_thread_reaches(shade: Dictionary) -> bool:
	if is_scree_crawler(shade) or is_cliff_harrier(shade):
		var gap := absf(float(shade.pos.x) - player.x)
		return gap <= maxf(FIRST_THREAD_RANGE, melee_reach(shade)) and absf(float(shade.pos.y) - player.y) <= MELEE_VERTICAL_REACH
	return player.distance_to(shade.pos) <= FIRST_THREAD_RANGE

func scree_crawler_body_half_width() -> float:
	return enemy_draw_geometry({"encounter_id": SCREE_CRAWLER_ID, "pos": Vector2.ZERO}).body.size.x / 2.0

# The full visible body stays inside the foothill span 1760-3040, within its clear patrol.
func scree_crawler_limits() -> Vector2:
	var half := scree_crawler_body_half_width()
	return Vector2(maxf(ROUTE_FOOTHILLS_START_X, SCREE_CRAWLER_PATROL.x) + half, minf(ROUTE_END_X, SCREE_CRAWLER_PATROL.y) - half)

# The crawler reacts to Lolth only while she is inside its own foothill region.
func lolth_in_crawler_region() -> bool:
	return player.x >= ROUTE_FOOTHILLS_START_X

func scree_crawler_windup_time() -> float:
	return SCREE_CRAWLER_WINDUP

# Lunge contact uses the same body as Lolth's melee; the windup starts one lunge further out.
func scree_crawler_strike_range() -> float:
	return melee_reach({"encounter_id": SCREE_CRAWLER_ID, "pos": Vector2.ZERO}) + SCREE_CRAWLER_LUNGE_SPEED * SCREE_CRAWLER_LUNGE_TIME

func live_scree_crawler_count() -> int:
	var count := 0
	for shade in combat_targets():
		if is_scree_crawler(shade) and not bool(shade.defeated):
			count += 1
	return count

func scree_crawler_warning_visible() -> bool:
	return not scree_crawler.is_empty() and not bool(scree_crawler.defeated) and String(scree_crawler.attack_state) == "windup"

# Only legitimate foothill entry creates the crawler: the B-06 departure gate (real first
# cure, safe camp, no playtester override) plus Lolth's world position. A saved defeat or an
# existing actor prevents another copy.
func scree_crawler_spawn_allowed() -> bool:
	return zone == 0 and scree_crawler.is_empty() and not crawler_defeated and player.x >= ROUTE_FOOTHILLS_START_X and expedition_departure_allowed()

func spawn_scree_crawler() -> void:
	scree_crawler = {"encounter_id": SCREE_CRAWLER_ID, "region": "stonehook_foothills", "name": "SCREE CRAWLER", "pos": Vector2(SCREE_CRAWLER_HOME_X, GROUND_Y - 34), "health": SCREE_CRAWLER_HEALTH, "max_health": SCREE_CRAWLER_HEALTH, "echoes": 1, "behavior": "scree_lunge", "attack_state": "approach", "attack_time": 0.0, "attack_dir": 0.0, "strike_spent": false, "hit_flash": 0.0, "defeated": false, "defeated_at": -1.0, "facing_left": player.x < SCREE_CRAWLER_HOME_X}
	crawler_activated = true
	message = "A SCREE CRAWLER stirs in the foothill scree."
	message_time = 2.5

func update_foothill_encounter(delta: float) -> void:
	if zone != 0:
		return
	update_cliff_harrier_encounter(delta)
	if scree_crawler.is_empty():
		if scree_crawler_spawn_allowed():
			spawn_scree_crawler()
		return
	if not bool(scree_crawler.defeated):
		update_scree_crawler(scree_crawler, delta)

# Approach, a locked-direction windup, a short lunge that can hit once, then recovery.
# It never targets the Wagon, never leaves the foothills and never strikes across the border.
func update_scree_crawler(crawler: Dictionary, delta: float) -> void:
	var lolth_in_region := lolth_in_crawler_region()
	var dx := player.x - float(crawler.pos.x)
	var motion := 0.0
	var lunging := String(crawler.attack_state) == "strike"
	crawler.attack_time = maxf(0.0, float(crawler.attack_time) - delta)
	match String(crawler.attack_state):
		"approach":
			if lolth_in_region:
				if absf(dx) > scree_crawler_strike_range():
					motion = signf(dx) * SCREE_CRAWLER_SPEED * delta
				elif absf(player.y - float(crawler.pos.y)) <= MELEE_VERTICAL_REACH:
					crawler.attack_state = "windup"
					crawler.attack_time = scree_crawler_windup_time()
					crawler.attack_dir = signf(dx) if not is_zero_approx(dx) else (-1.0 if bool(crawler.facing_left) else 1.0)
					crawler.strike_spent = false
		"windup":
			if not lolth_in_region:
				# Retreat out of the foothills cancels the pending strike.
				crawler.attack_state = "approach"
				crawler.attack_time = 0.0
			elif float(crawler.attack_time) <= 0.0:
				crawler.attack_state = "strike"
				crawler.attack_time = SCREE_CRAWLER_LUNGE_TIME
		"strike":
			motion = float(crawler.attack_dir) * SCREE_CRAWLER_LUNGE_SPEED * delta
			if float(crawler.attack_time) <= 0.0:
				crawler.attack_state = "recover"
				crawler.attack_time = SCREE_CRAWLER_RECOVER
		"recover":
			if float(crawler.attack_time) <= 0.0:
				crawler.attack_state = "approach"
	var limits := scree_crawler_limits()
	var previous_x := float(crawler.pos.x)
	crawler.pos.x = clampf(previous_x + motion, limits.x, limits.y)
	# Contact is tested after this frame's lunge motion, so the full lunge distance counts at
	# any frame rate, including the final frame that ends the strike.
	if lunging and not bool(crawler.strike_spent) and lolth_in_region and absf(player.x - float(crawler.pos.x)) <= melee_reach(crawler) and absf(player.y - float(crawler.pos.y)) <= MELEE_VERTICAL_REACH:
		scree_crawler_strike_lands(crawler)
	if String(crawler.attack_state) in ["windup", "strike"]:
		update_enemy_facing(crawler, float(crawler.attack_dir))
	else:
		update_enemy_facing(crawler, float(crawler.pos.x) - previous_x)

# A strike is spent on first contact, whether it wounds Lolth or she dashes through it.
func scree_crawler_strike_lands(crawler: Dictionary) -> void:
	crawler.strike_spent = true
	if dodge_time > 0.0:
		message = "Nolf dashes through the SCREE CRAWLER's lunge."
		message_time = 1.2
		return
	if hurt_cooldown > 0.0:
		return
	hurt_lolth()

# One credited defeat pays at most one Shadow Echo, still under the unchanged Thornwake cap.
func defeat_scree_crawler() -> void:
	crawler_defeated = true
	if not crawler_reward_paid:
		crawler_reward_paid = true
		if mark_level > 0:
			collect_echo(1)
	message = "SCREE CRAWLER falls. Nolf absorbs its shadow."
	message_time = 1.2

func scree_crawler_state() -> Dictionary:
	return {"activated": crawler_activated, "defeated": crawler_defeated, "reward_paid": crawler_reward_paid}

func apply_scree_crawler_state(saved: Dictionary) -> void:
	crawler_activated = bool(saved.get("activated", false))
	crawler_defeated = bool(saved.get("defeated", false))
	crawler_reward_paid = bool(saved.get("reward_paid", false))

# --- B-08 Cliff Harrier ------------------------------------------------------------------
func is_cliff_harrier(shade: Dictionary) -> bool:
	return String(shade.get("encounter_id", "")) == CLIFF_HARRIER_ID

func cliff_harrier_source() -> Rect2:
	return CLIFF_HARRIER_SOURCE

func prepare_harrier_bounds(atlas: Image) -> void:
	ui_harrier_bounds_scans = 0
	var source := cliff_harrier_source()
	ui_encounter_bounds[STONEHOOK_THREATS_RUNTIME.resource_path + str(source)] = scan_alpha_bounds(source, atlas)
	ui_harrier_bounds_scans += 1

func cliff_harrier_body_half_width() -> float:
	return enemy_draw_geometry({"encounter_id": CLIFF_HARRIER_ID, "pos": Vector2.ZERO}).body.size.x / 2.0

# The full visible body (wings included) stays inside the clear foothill patrol span.
func cliff_harrier_limits() -> Vector2:
	var half := cliff_harrier_body_half_width()
	return Vector2(maxf(ROUTE_FOOTHILLS_START_X, CLIFF_HARRIER_PATROL.x) + half, minf(ROUTE_END_X, CLIFF_HARRIER_PATROL.y) - half)

# The world anchor follows the displayed bird: a ground actor's anchor raised by its altitude.
func cliff_harrier_anchor_y(altitude: float) -> float:
	return GROUND_Y - 34.0 - altitude

func cliff_harrier_altitude(harrier: Dictionary) -> float:
	if String(harrier.attack_state) == "dive":
		var progress := clampf(1.0 - float(harrier.attack_time) / CLIFF_HARRIER_DIVE_TIME, 0.0, 1.0)
		return CLIFF_HARRIER_HOVER - CLIFF_HARRIER_DIVE_DIP * sin(PI * progress)
	return CLIFF_HARRIER_HOVER + CLIFF_HARRIER_BOB * sin(float(harrier.bob_time) * CLIFF_HARRIER_BOB_RATE)

func cliff_harrier_windup_time() -> float:
	return CLIFF_HARRIER_WINDUP

func live_cliff_harrier_count() -> int:
	var count := 0
	for shade in combat_targets():
		if is_cliff_harrier(shade) and not bool(shade.defeated):
			count += 1
	return count

func cliff_harrier_warning_visible() -> bool:
	return not cliff_harrier.is_empty() and not bool(cliff_harrier.defeated) and String(cliff_harrier.attack_state) == "windup"

# Legitimate expedition access (the B-06 departure gate) and Lolth's first arrival at x>=2600.
func cliff_harrier_spawn_allowed() -> bool:
	return zone == 0 and cliff_harrier.is_empty() and not harrier_defeated and player.x >= CLIFF_HARRIER_ACTIVATION_X and expedition_departure_allowed()

func spawn_cliff_harrier() -> void:
	cliff_harrier = {"encounter_id": CLIFF_HARRIER_ID, "region": "stonehook_foothills", "name": "CLIFF HARRIER", "pos": Vector2(CLIFF_HARRIER_HOME_X, cliff_harrier_anchor_y(CLIFF_HARRIER_HOVER)), "health": CLIFF_HARRIER_HEALTH, "max_health": CLIFF_HARRIER_HEALTH, "echoes": 1, "behavior": "harrier_dive", "attack_state": "approach", "attack_time": 0.0, "attack_dir": 0.0, "target_x": CLIFF_HARRIER_HOME_X, "strike_spent": false, "bob_time": 0.0, "hit_flash": 0.0, "defeated": false, "defeated_at": -1.0, "facing_left": player.x < CLIFF_HARRIER_HOME_X}
	harrier_activated = true
	message = "A CLIFF HARRIER drops from the crags."
	message_time = 2.5

func update_cliff_harrier_encounter(delta: float) -> void:
	if cliff_harrier.is_empty():
		if cliff_harrier_spawn_allowed():
			spawn_cliff_harrier()
		return
	if not bool(cliff_harrier.defeated):
		update_cliff_harrier(cliff_harrier, delta)

# Hover, approach or back off, then a windup that locks the target point and direction, a
# short continuous dive toward that point (never past it) and recovery. Only the dive can
# hurt, at most once; nothing reaches past the foothills, the cave or the Wagon.
func update_cliff_harrier(harrier: Dictionary, delta: float) -> void:
	var lolth_in_region := lolth_in_crawler_region()
	var dx := player.x - float(harrier.pos.x)
	var motion := 0.0
	var diving := String(harrier.attack_state) == "dive"
	# The dive moves for the time actually left, so its travel never exceeds speed * duration
	# whatever the frame rate or float remainder.
	var time_before := float(harrier.attack_time)
	harrier.attack_time = maxf(0.0, float(harrier.attack_time) - delta)
	harrier.bob_time = float(harrier.bob_time) + delta
	match String(harrier.attack_state):
		"approach":
			if lolth_in_region:
				var away := -signf(dx) if not is_zero_approx(dx) else (1.0 if bool(harrier.facing_left) else -1.0)
				if absf(dx) < CLIFF_HARRIER_RETREAT_RANGE:
					motion = away * CLIFF_HARRIER_RETREAT_SPEED * delta
				elif absf(dx) > CLIFF_HARRIER_ATTACK_RANGE:
					motion = signf(dx) * CLIFF_HARRIER_APPROACH_SPEED * delta
				elif absf(player.y - float(harrier.pos.y)) <= MELEE_VERTICAL_REACH:
					harrier.attack_state = "windup"
					harrier.attack_time = cliff_harrier_windup_time()
					harrier.target_x = player.x
					harrier.attack_dir = signf(dx)
					harrier.strike_spent = false
		"windup":
			if not lolth_in_region:
				# Retreat out of the foothills cancels the pending dive.
				harrier.attack_state = "approach"
				harrier.attack_time = 0.0
			elif float(harrier.attack_time) <= 0.0:
				harrier.attack_state = "dive"
				harrier.attack_time = CLIFF_HARRIER_DIVE_TIME
		"dive":
			if not lolth_in_region:
				harrier.attack_state = "recover"
				harrier.attack_time = CLIFF_HARRIER_RECOVER
			else:
				var remaining := float(harrier.target_x) - float(harrier.pos.x)
				if signf(remaining) == float(harrier.attack_dir):
					motion = float(harrier.attack_dir) * minf(absf(remaining), CLIFF_HARRIER_DIVE_SPEED * minf(delta, time_before))
				if float(harrier.attack_time) <= 0.0:
					harrier.attack_state = "recover"
					harrier.attack_time = CLIFF_HARRIER_RECOVER
		"recover":
			if float(harrier.attack_time) <= 0.0:
				harrier.attack_state = "approach"
	var limits := cliff_harrier_limits()
	var previous_x := float(harrier.pos.x)
	harrier.pos = Vector2(clampf(previous_x + motion, limits.x, limits.y), cliff_harrier_anchor_y(cliff_harrier_altitude(harrier)))
	# As with the crawler, contact is tested after this frame's motion.
	if diving and lolth_in_region and not bool(harrier.strike_spent) and absf(player.x - float(harrier.pos.x)) <= melee_reach(harrier) and absf(player.y - float(harrier.pos.y)) <= MELEE_VERTICAL_REACH:
		cliff_harrier_strike_lands(harrier)
	if String(harrier.attack_state) in ["windup", "dive"]:
		update_enemy_facing(harrier, float(harrier.attack_dir))
	elif lolth_in_region:
		update_enemy_facing(harrier, dx)
	else:
		update_enemy_facing(harrier, float(harrier.pos.x) - previous_x)

# A dive is spent on first contact, whether it wounds Lolth or she dashes through it.
func cliff_harrier_strike_lands(harrier: Dictionary) -> void:
	harrier.strike_spent = true
	if dodge_time > 0.0:
		message = "Nolf dashes under the CLIFF HARRIER's dive."
		message_time = 1.2
		return
	if hurt_cooldown > 0.0:
		return
	hurt_lolth()

func defeat_cliff_harrier() -> void:
	harrier_defeated = true
	if not harrier_reward_paid:
		harrier_reward_paid = true
		if mark_level > 0:
			collect_echo(1)
	message = "CLIFF HARRIER falls. Nolf absorbs its shadow."
	message_time = 1.2

func cliff_harrier_state() -> Dictionary:
	return {"activated": harrier_activated, "defeated": harrier_defeated, "reward_paid": harrier_reward_paid}

func apply_cliff_harrier_state(saved: Dictionary) -> void:
	harrier_activated = bool(saved.get("activated", false))
	harrier_defeated = bool(saved.get("defeated", false))
	harrier_reward_paid = bool(saved.get("reward_paid", false))

func update_enemy_facing(enemy: Dictionary, horizontal_motion: float) -> void:
	if not is_zero_approx(horizontal_motion):
		enemy.facing_left = horizontal_motion < 0.0

func enemy_facing_left(enemy: Dictionary) -> bool:
	# Older snapshots/test dictionaries may predate persistent facing.
	if enemy.has("facing_left"):
		return bool(enemy.facing_left)
	if String(enemy.get("attack_state", "")) in ["windup", "strike"] and not is_zero_approx(float(enemy.get("attack_dir", 0.0))):
		return float(enemy.attack_dir) < 0.0
	var target_x := CARAVAN_X if zone == 0 and String(enemy.get("behavior", "")) == "charge" else player.x
	return target_x < float(enemy.pos.x)

func update_enemies(delta: float) -> void:
	for enemy in shades:
		if enemy.defeated:
			continue
		if zone == 0 and String(enemy.get("behavior", "")) in ["pounce", "charge", "relentless"]:
			update_thornwake_attacker(enemy, delta)
			continue
		var target := player
		var targets_wagon := zone == 0 and is_night() and String(enemy.get("behavior", "")) == "charge"
		if targets_wagon:
			target = Vector2(CARAVAN_X, GROUND_Y - 38)
		var distance := target.distance_to(enemy.pos)
		var direction := signf(target.x - float(enemy.pos.x))
		var speed := 36.0
		match String(enemy.get("behavior", "stalk")):
			"pounce":
				speed = 128.0 if distance < 280.0 else 56.0
			"charge":
				speed = 182.0 if distance < 215.0 else 24.0
			"relentless":
				speed = 72.0
			"burrow":
				speed = 96.0 if distance < 230.0 else 32.0
			"harry":
				speed = 145.0 if distance > 110.0 else -58.0
			"crush":
				speed = 58.0 if distance > 155.0 else 138.0
			"entangle":
				speed = 72.0 if distance < 210.0 else 34.0
		var previous_x := float(enemy.pos.x)
		var limits := enemy_region_limits(enemy)
		enemy.pos.x = clampf(previous_x + direction * speed * delta, limits.x, limits.y)
		update_enemy_facing(enemy, float(enemy.pos.x) - previous_x)
		if targets_wagon:
			enemy.wagon_hit_cooldown = maxf(0.0, float(enemy.wagon_hit_cooldown) - delta)
			if absf(float(enemy.pos.x) - CARAVAN_X) < 46.0 and float(enemy.wagon_hit_cooldown) <= 0.0:
				enemy.wagon_hit_cooldown = STAG_WAGON_HIT_COOLDOWN
				damage_wagon(STAG_WAGON_HIT_DAMAGE, String(enemy.name))

# Thornwake attackers telegraph every strike: approach, wind up, strike, recover.
# Stags of Mire charge the Wagon; Briar Hounds lunge at Lolth. The Antlered Hunger
# lunges at Lolth and makes every third attack a long-telegraphed charge at the Wagon.
func attack_profile(enemy: Dictionary) -> Dictionary:
	match String(enemy.behavior):
		"charge":
			return {"wagon": true, "approach": 24.0, "range": STAG_CHARGE_RANGE, "windup": STAG_WINDUP, "speed": STAG_CHARGE_SPEED, "strike": STAG_CHARGE_TIME, "recover": STAG_WAGON_HIT_COOLDOWN, "damage": STAG_WAGON_HIT_DAMAGE}
		"relentless":
			if int(enemy.get("attack_count", 0)) % 3 == 2:
				return {"wagon": true, "approach": 0.0, "range": VIEW.x, "windup": BOSS_WAGON_WINDUP, "speed": BOSS_WAGON_CHARGE_SPEED, "strike": BOSS_WAGON_CHARGE_TIME, "recover": BOSS_RECOVER, "damage": BOSS_WAGON_DAMAGE}
			return {"wagon": false, "approach": 72.0, "range": BOSS_LUNGE_RANGE, "windup": BOSS_WINDUP, "speed": BOSS_LUNGE_SPEED, "strike": BOSS_LUNGE_TIME, "recover": BOSS_RECOVER, "damage": 0.0}
	return {"wagon": false, "approach": 56.0, "range": HOUND_LUNGE_RANGE, "windup": HOUND_WINDUP, "speed": HOUND_LUNGE_SPEED, "strike": HOUND_LUNGE_TIME, "recover": HOUND_RECOVER, "damage": 0.0}

func update_thornwake_attacker(enemy: Dictionary, delta: float) -> void:
	if String(enemy.attack_state) == "approach":
		enemy.attack_target = "wagon" if bool(attack_profile(enemy).wagon) else "lolth"
	var profile := attack_profile(enemy)
	var charges_wagon := String(enemy.get("attack_target", "lolth")) == "wagon"
	var target_x := CARAVAN_X if charges_wagon else player.x
	var distance := absf(target_x - float(enemy.pos.x))
	var direction := signf(target_x - float(enemy.pos.x))
	var speed := 0.0
	enemy.attack_time = maxf(0.0, float(enemy.attack_time) - delta)
	match String(enemy.attack_state):
		"approach":
			speed = float(profile.approach)
			if distance < float(profile.range):
				enemy.attack_state = "windup"
				enemy.attack_time = float(profile.windup)
				enemy.attack_dir = direction if direction != 0.0 else -1.0
				if charges_wagon:
					message = "%s lowers its antlers at the Wagon!" % enemy.name
					message_time = 1.2
		"windup":
			if float(enemy.attack_time) <= 0.0:
				enemy.attack_state = "strike"
				enemy.attack_time = float(profile.strike)
		"strike":
			speed = float(profile.speed)
			direction = float(enemy.attack_dir)
			if charges_wagon and distance < 46.0:
				speed = 0.0
				damage_wagon(float(profile.damage), String(enemy.name))
				enemy.attack_state = "recover"
				enemy.attack_time = float(profile.recover)
			elif float(enemy.attack_time) <= 0.0:
				enemy.attack_state = "recover"
				enemy.attack_time = float(profile.recover)
		"recover":
			if float(enemy.attack_time) <= 0.0:
				enemy.attack_state = "approach"
				enemy.attack_count = int(enemy.get("attack_count", 0)) + 1
	var previous_x := float(enemy.pos.x)
	var limits := enemy_region_limits(enemy)
	enemy.pos.x = clampf(previous_x + direction * speed * delta, limits.x, limits.y)
	if String(enemy.attack_state) in ["windup", "strike"]:
		update_enemy_facing(enemy, float(enemy.attack_dir))
	else:
		update_enemy_facing(enemy, float(enemy.pos.x) - previous_x)

func update_zone_hazards() -> void:
	if zone != 1 or hazard_cooldown > 0.0:
		return
	for hazard in zone_hazards:
		var hazard_rect: Rect2 = hazard.rect
		if hazard_rect.has_point(player):
			velocity.x = float(hazard.direction) * 420.0
			hazard_cooldown = 0.8
			message = "SCREE SLIDE — Use the rope route or regain your footing."
			message_time = 1.8
			return

func use_rope_route() -> bool:
	if zone != 1:
		return false
	for route in rope_routes:
		if not bool(route.used) and player.distance_to(route.from) < INTERACT_RADIUS:
			route.used = true
			player = route.to
			velocity = Vector2.ZERO
			on_floor = false
			trigger_mark_vfx("sense", route.to + Vector2(0, -54))
			message = "Nolf climbs the rope route above the scree."
			message_time = 2.0
			return true
	return false

func renew_thornwake_resources() -> void:
	if zone != 0:
		return
	for index in salvage.size():
		var item: Dictionary = salvage[index]
		if bool(item.get("renewable", false)):
			item.taken = false
			salvage[index] = item

func restore_drows_at_dawn() -> void:
	if downed_drows.is_empty():
		return
	downed_drows.clear()
	message = "DAWN — The fallen drows return to the Wagon."
	message_time = 3.0

func recipe_has_ingredients(recipe: Dictionary) -> bool:
	var needed: Dictionary = recipe.ingredients
	for ingredient in needed:
		var found := 0
		for item in wagon_stock:
			if String(item.type) == String(ingredient):
				found += 1
		if found < int(needed[ingredient]):
			return false
	return true

func consume_ingredients(recipe: Dictionary) -> void:
	var needed: Dictionary = recipe.ingredients.duplicate()
	for index in range(wagon_stock.size() - 1, -1, -1):
		var item: Dictionary = wagon_stock[index]
		var item_type := String(item.type)
		if needed.has(item_type) and int(needed[item_type]) > 0:
			wagon_stock.remove_at(index)
			needed[item_type] = int(needed[item_type]) - 1

func recipe_label(recipe: Dictionary) -> String:
	var parts: Array[String] = []
	for ingredient in recipe.ingredients:
		parts.append("%d %s" % [int(recipe.ingredients[ingredient]), String(ingredient).to_upper()])
	return ", ".join(parts)

func stock_count(item_type: String) -> int:
	var count := 0
	for item in wagon_stock:
		if String(item.type) == item_type:
			count += 1
	return count

func update_thornwake_tutorial(delta: float) -> void:
	match tutorial_phase:
		"dusk":
			dusk_time = maxf(0.0, dusk_time - delta)
			if dusk_time <= 0.0:
				begin_tutorial_night()
		"night_defense":
			update_clock(delta)

func begin_dusk() -> void:
	tutorial_phase = "dusk"
	dusk_time = DUSK_DURATION
	message = "The Wagon is repaired and stationed, but it cannot travel. Night is coming."
	message_time = DUSK_DURATION

func begin_tutorial_night() -> void:
	tutorial_phase = "night_defense"
	clock_seconds = DAY_DURATION
	start_thornwake_night()

func complete_tutorial_defense() -> void:
	tutorial_phase = "safe_camp"
	clock_seconds = 0.0
	first_night_complete = true
	night_wave = 0
	night_wave_total = 0
	night_wave_pause = 0.0
	night_waves_complete = false
	shades.clear()
	health = max_health()
	hurt_cooldown = 0.0
	restore_drows_at_dawn()
	renew_thornwake_resources()
	message = "DAWN — The Wagon holds. The cave camp is safe."
	message_time = 5.0

func use_camp_action() -> void:
	if zone != 0 or mark_level != 0 or tutorial_phase != "safe_camp":
		return
	if not at_wagon():
		message = "Return to the Wagon to face the Antlered Hunger."
		message_time = 2.0
		return
	begin_boss_encounter()

func begin_boss_encounter() -> void:
	tutorial_phase = "boss_encounter"
	clock_seconds = DAY_DURATION
	shades.clear()
	spawn_enemy("ANTLERED HUNGER", Vector2(1060, GROUND_Y - 34), ANTLERED_HUNGER_HEALTH, 3)
	message = "THE ANTLERED HUNGER — Watch its warnings and dodge its strikes."
	message_time = 4.0

func defeat_antlered_hunger() -> void:
	if antlered_hunger_defeated:
		return
	antlered_hunger_defeated = true
	shades.clear()
	clock_seconds = 0.0
	tutorial_phase = "safe_camp"
	start_shar_shell()

func current_objective() -> String:
	if playtester_active:
		return "PLAYTEST: Mark %d. Use F4 to change Mark/time or restore your run." % mark_level
	if is_away_from_cave():
		var ore := route_ore_state()
		if not ore.is_empty() and not bool(ore.taken):
			return "Recover the IRON ORE in the Stonehook foothills, then return to the Wagon."
		for item in recovered_load:
			if String(item.get("id", "")) == ROUTE_ORE_ID:
				return "Carry the IRON ORE back to the Wagon in the cave."
		return "Return to the Wagon in the cave."
	if zone == 0 and mark_level >= 1 and not cured_allies.is_empty():
		if not camp_secured:
			return "Return to the Wagon to secure the camp."
		var threshold := int(ECHO_THRESHOLDS[mark_level])
		if shadow_echoes >= threshold:
			return "The Wagon is secure. No deeper Mark can awaken in Thornwake."
		return "The Wagon is secure. Gather Shadow Echoes in Thornwake: %d/%d." % [shadow_echoes, threshold]
	if zone != 0 or mark_level != 0:
		return ZONE_OBJECTIVES[zone]
	match tutorial_phase:
		"dusk":
			return "Night is coming. Return to the Wagon."
		"night_defense":
			return "Defend the cave camp and the Wagon until the threat passes."
		"safe_camp":
			return "The cave camp is safe. Face the Antlered Hunger from the Wagon."
		"boss_encounter":
			return "Defeat the Antlered Hunger. Dodge when it winds up."
	if recipe_has_ingredients(RECIPES[WHEEL_KIT_RECIPE]):
		return "Stand at the Wagon and craft the WHEEL KIT."
	return "Gather WOOD, ROPE, and SALVAGE, then store them in the Wagon."

func craft_selected_recipe() -> void:
	var recipe: Dictionary = RECIPES[selected_recipe]
	if not recipe_has_ingredients(recipe):
		message = "%s needs %s in Wagon stock." % [recipe.name, recipe_label(recipe)]
		message_time = 2.5
		return
	consume_ingredients(recipe)
	match selected_recipe:
		0:
			provisions = minf(8.0, provisions + 3.0)
			crafted_recipes.cataplasm = int(crafted_recipes.cataplasm) + 1
			message = "CATAPLASM prepared. The group can endure longer."
		1:
			wagon_repair = mini(3, wagon_repair + 1)
			var repair_bonus := 15.0 if ally_is_near("ILYREN") else 0.0
			wagon_integrity = minf(100.0, wagon_integrity + 35.0 + repair_bonus)
			crafted_recipes.wheel_kit = int(crafted_recipes.wheel_kit) + 1
			message = "WHEEL KIT installed. The Wagon is stronger."
			if zone == 0 and mark_level == 0 and tutorial_phase == "day_salvage":
				begin_dusk()
		2:
			brazier_built = true
			crafted_recipes.brazier = int(crafted_recipes.brazier) + 1
			flame = minf(100.0, flame + 25.0)
			message = "BRAZIER built. Night attacks lose force."
		3:
			axle_brakes_installed = true
			wagon_repair = mini(3, wagon_repair + 1)
			crafted_recipes.axle_brakes = int(crafted_recipes.get("axle_brakes", 0)) + 1
			wagon_integrity = minf(100.0, wagon_integrity + 30.0)
			message = "AXLE & BRAKES installed. The Wagon can hold Stonehook."
	message_time = 3.0
	try_advance_from_camp()

func process_cure_selection() -> void:
	if Input.is_action_just_pressed("move_left"):
		select_previous_cure()
	elif Input.is_action_just_pressed("move_right"):
		select_next_cure()
	if Input.is_action_just_pressed("primary"):
		cure_selected_ally()

func available_allies() -> Array[String]:
	var available: Array[String] = []
	for ally in THALESTRIEL:
		if not cured_allies.has(ally):
			available.append(ally)
	return available

func ally_is_near(ally: String, radius := 125.0) -> bool:
	if not posted_allies.has(ally) or downed_drows.has(ally) or not ALLY_POSTS.has(ally):
		return false
	return player.distance_to(ALLY_POSTS[ally]) <= radius

func select_previous_cure() -> void:
	var available := available_allies()
	if available.is_empty():
		return
	selected_cure = posmod(selected_cure - 1, available.size())
	message = "Cure: %s. Press primary action to awaken them." % available[selected_cure]
	message_time = 2.0

func select_next_cure() -> void:
	var available := available_allies()
	if available.is_empty():
		return
	selected_cure = (selected_cure + 1) % available.size()
	message = "Cure: %s. Press primary action to awaken them." % available[selected_cure]
	message_time = 2.0

func cure_selected_ally() -> void:
	if state != "cure":
		return
	var available := available_allies()
	if available.is_empty():
		return
	selected_cure = clampi(selected_cure, 0, available.size() - 1)
	var ally := available[selected_cure]
	cured_allies.append(ally)
	if zone != 0 and posted_allies.size() < MAX_ACTIVE_POSTS:
		posted_allies.append(ally)
	awakened = cured_allies.size()
	ally_assists_used.clear()
	state = "journey"
	create_checkpoint()
	if zone == 0 and mark_level == 1:
		camp_secured = false
		safe_wagon_state = {}
		was_at_safe_wagon = false
		message = "%s wakes as a drow. Return to the Wagon to secure the camp." % ally
	elif zone == 1 and mark_level == 2:
		state = "stonehook_complete"
		message = "%s wakes. The Wagon holds the mountain; Hollowroot waits below." % ally
	elif zone == 2 and mark_level == 3:
		message = "%s wakes. Hollowroot's Web Anchor can now become solid ground." % ally
	else:
		message = "%s wakes as drow and joins the Wagon's defense." % ally
	message_time = 4.0

func cycle_post_ally() -> void:
	if zone == 0:
		message = "Ally posts are not available at the cave camp."
		message_time = 2.0
		return
	if not at_wagon():
		message = "Return to the Wagon to manage ally posts."
		message_time = 2.0
		return
	if cured_allies.is_empty():
		message = "Wake a Thalestriel before assigning a post."
		message_time = 2.0
		return
	selected_post_ally = (selected_post_ally + 1) % cured_allies.size()
	message = "Post choice: %s. Press R / shoulder to assign or recall." % cured_allies[selected_post_ally]
	message_time = 2.5

func toggle_selected_post() -> void:
	if zone == 0:
		message = "Ally posts are not available at the cave camp."
		message_time = 2.0
		return
	if not at_wagon() or cured_allies.is_empty():
		message = "Manage ally posts beside the Wagon."
		message_time = 2.0
		return
	selected_post_ally = clampi(selected_post_ally, 0, cured_allies.size() - 1)
	var ally: String = cured_allies[selected_post_ally]
	if posted_allies.has(ally):
		posted_allies.erase(ally)
		message = "%s returns to the Wagon's reserve." % ally
	elif posted_allies.size() >= MAX_ACTIVE_POSTS:
		message = "Only two ally posts can be active in this map."
	else:
		posted_allies.append(ally)
		message = "%s takes a contextual post." % ally
	message_time = 2.5

func select_mission() -> void:
	if zone == 0:
		message = "Missions are not available at the cave camp."
		message_time = 2.0
		return
	if not at_wagon():
		message = "Choose a camp mission beside the Caravan."
		message_time = 2.0
		return
	if awakened == 0:
		message = "Wake a Thalestriel before choosing a camp mission."
		message_time = 2.0
		return
	mission_selected = (mission_selected + 1) % PASSIVE_MISSIONS.size()
	message = "Mission selected: %s. Press E at the Caravan to assign it." % PASSIVE_MISSIONS[mission_selected].name
	message_time = 3.5

func assign_mission() -> void:
	if zone == 0 or not at_wagon() or cured_allies.is_empty():
		message = "Missions require an eligible ally and a later-region wagon camp."
		message_time = 2.5
		return
	if not passive_mission.is_empty():
		message = "%s is already underway. Return after the next path." % passive_mission.name
		message_time = 2.5
		return
	passive_mission = PASSIVE_MISSIONS[mission_selected].duplicate()
	message = "%s assigned. It resolves after the next path." % passive_mission.name
	message_time = 3.5

func resolve_mission() -> String:
	if passive_mission.is_empty():
		return ""
	var result: String = "Passive mission complete: %s" % passive_mission.reward
	match passive_mission.type:
		"provisions":
			provisions = minf(8.0, provisions + 1.5)
		"flame":
			flame = minf(100.0, flame + 20.0)
		"route":
			wagon_repair = mini(3, wagon_repair + 1)
	passive_mission.clear()
	return result

func _draw() -> void:
	if state == "opening":
		draw_opening()
		return
	var backgrounds: Array[Color] = [Color("17132e"), Color("20213a"), Color("19172b")]
	draw_rect(Rect2(Vector2.ZERO, VIEW), backgrounds[zone])
	# World layers share one horizontal translation; the HUD and every overlay below stay in screen space.
	draw_set_transform(world_draw_origin(), 0.0, Vector2.ONE)
	draw_background()
	draw_ground()
	draw_zone_traversal()
	draw_shades()
	draw_mark_gates()
	draw_caravan()
	draw_attack_telegraphs()
	draw_ally_posts()
	draw_salvage()
	draw_portal()
	draw_player()
	draw_foreground_overlay()
	draw_foreground_readability()
	# B-07: the crawler's lunge warning sits in front of the foothill frame overlay.
	if scree_crawler_warning_visible():
		draw_scree_crawler_warning(scree_crawler)
	# B-08: the Harrier's dive warning, likewise above the foreground.
	if cliff_harrier_warning_visible():
		draw_cliff_harrier_warning(cliff_harrier)
	draw_route_markers()
	draw_mark_vfx()
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	draw_hud()
	if state == "shar_shell":
		draw_shar_shell()
	elif state == "cure":
		draw_cure_menu()
	elif zone == 0 and mark_level == 0 and tutorial_phase == "dusk":
		draw_nightfall_banner()
	elif zone == 0 and mark_level == 0 and tutorial_phase == "day_salvage" and state == "journey":
		draw_wheel_kit_recipe()
	elif zone == 0 and mark_level == 0 and tutorial_phase == "safe_camp" and state == "journey":
		draw_boss_camp_action()
	elif state == "victory":
		draw_end_card(true)
	elif state == "defeat":
		draw_end_card(false)
	elif state == "thornwake_complete":
		draw_thornwake_complete()
	elif state == "stonehook_complete":
		draw_stonehook_complete()

func draw_background() -> void:
	if zone == 0:
		draw_texture_rect(ASHEN_WAY_BACKDROP, Rect2(Vector2.ZERO, VIEW), false)
		draw_route_blend(ASHEN_WAY_BACKDROP, full_source(VEIL_RUINS_BACKDROP), VEIL_RUINS_BACKDROP, 0.0, VIEW.y, ROUTE_TRANSITION_WIDTH, true)
		draw_texture_rect(VEIL_RUINS_BACKDROP, Rect2(ROUTE_FOOTHILLS_START_X, 0, ROUTE_FOOTHILLS_WIDTH, VIEW.y), false)
		var night_alpha := 0.56 if is_night() else 0.08
		if tutorial_phase == "dusk" and mark_level == 0:
			night_alpha = lerpf(0.08, 0.56, 1.0 - dusk_time / DUSK_DURATION)
		# The time-of-day tint covers the visible view wherever the camera is.
		draw_rect(Rect2(Vector2(-world_draw_origin().x, 0.0), VIEW), Color(0.035, 0.07, 0.16, night_alpha))
		return
	if zone == 1:
		draw_texture_rect(VEIL_RUINS_BACKDROP, Rect2(Vector2.ZERO, VIEW), false)
		return
	if zone == 2:
		var region_panel_width := LATER_REGION_ROUTE_ATLAS.get_width() / 3.0
		var hollowroot_source := Rect2(0, 0, region_panel_width, LATER_REGION_ROUTE_ATLAS.get_height())
		draw_texture_rect_region(LATER_REGION_ROUTE_ATLAS, Rect2(Vector2.ZERO, VIEW), hollowroot_source)
		return
	var sky := Color("20172f") if zone == 0 else Color("20213a")
	draw_rect(Rect2(0, 0, VIEW.x, GROUND_Y), sky)
	for i in 10:
		var x := float((i * 157 + zone * 53) % 1280)
		var y := 115.0 + float((i * 71) % 210)
		draw_circle(Vector2(x, y), 2.0 + sin(pulse + i) * 0.7, Color("f8d77a"))
	if zone == 0:
		draw_circle(Vector2(1040, 155), 92, Color("6d4f81"))
		draw_circle(Vector2(1018, 142), 80, Color("d4b86d"))
		return
	var moon := Vector2(1030, 145)
	draw_circle(moon, 64, Color("e8c96d"))
	draw_circle(moon + Vector2(-18, -8), 53, Color("fff1b8"))
	for i in 7:
		var x := 390.0 + i * 138.0
		var h := 75.0 + float((i * 29 + zone * 17) % 120)
		draw_rect(Rect2(x, GROUND_Y - h, 55, h), Color("312649"))
		draw_line(Vector2(x + 8, GROUND_Y - h), Vector2(x + 30, GROUND_Y - h - 35), Color("6c4f78"), 5.0)

func draw_ground() -> void:
	var world_width := ROUTE_END_X if zone == 0 else VIEW.x
	draw_rect(Rect2(0, GROUND_Y, world_width, VIEW.y - GROUND_Y), Color("0c1123"))
	var ground_panel_width := ZONE_GROUND_BANDS_RUNTIME.get_width() / 3.0
	if zone == 0:
		draw_texture_rect(THORNWAKE_CONTINUOUS_GROUND, Rect2(0, GROUND_Y - 4, VIEW.x, VIEW.y - GROUND_Y + 4), false)
		# B-06: the same floor continues; Thornwake ground thins into the Stonehook band.
		var stone_ground := Rect2(ground_panel_width, 350, ground_panel_width, 443)
		draw_route_blend(THORNWAKE_CONTINUOUS_GROUND, stone_ground, ZONE_GROUND_BANDS_RUNTIME, GROUND_Y - 4, VIEW.y - GROUND_Y + 4, ROUTE_TRANSITION_WIDTH, true)
		draw_texture_rect_region(ZONE_GROUND_BANDS_RUNTIME, Rect2(ROUTE_FOOTHILLS_START_X, GROUND_Y - 4, ROUTE_FOOTHILLS_WIDTH, VIEW.y - GROUND_Y + 4), stone_ground)
	else:
		var ground_source := Rect2(ground_panel_width * float(zone), 350, ground_panel_width, 443)
		draw_texture_rect_region(ZONE_GROUND_BANDS_RUNTIME, Rect2(0, GROUND_Y, VIEW.x, VIEW.y - GROUND_Y), ground_source)
	draw_line(Vector2(0, GROUND_Y), Vector2(world_width, GROUND_Y), Color("b79857"), 2.0)
	for i in int(ceilf(world_width / 48.0)) + 3:
		var x := float(i * 48)
		draw_line(Vector2(x, GROUND_Y + 28), Vector2(x + 22, GROUND_Y + 35), Color("272846"), 2.0)

func full_source(texture: Texture2D) -> Rect2:
	return Rect2(Vector2.ZERO, texture.get_size())

# B-06 spatial blend across the transition band, not a temporal dissolve. Each side is
# mirrored at its own seam, so the Thornwake art meets x=1280 and the Stonehook art meets
# x=1760 without a cut. Opaque backdrops and ground cross the whole band; the frame-like
# foreground overlays fade within a shorter width so their edge trees do not double up.
func draw_route_blend(thornwake: Texture2D, stone_source: Rect2, stonehook: Texture2D, top: float, height: float, fade_width: float, opaque_base: bool) -> void:
	var fade_share := fade_width / VIEW.x
	var forest_source := Rect2(thornwake.get_width() * (1.0 - fade_share), 0, thornwake.get_width() * fade_share, thornwake.get_height())
	var stone_width := ROUTE_TRANSITION_WIDTH if opaque_base else fade_width
	var stone_band := Rect2(stone_source.position, Vector2(stone_source.size.x * stone_width / VIEW.x, stone_source.size.y))
	draw_route_band(stonehook, stone_band, Rect2(ROUTE_FOOTHILLS_START_X - stone_width, top, stone_width, height), 1.0 if opaque_base else 0.0, 1.0, true)
	draw_route_band(thornwake, forest_source, Rect2(ROUTE_THORNWAKE_END_X, top, fade_width, height), 1.0, 0.0, true)

func draw_route_band(texture: Texture2D, source: Rect2, span: Rect2, alpha_left: float, alpha_right: float, mirrored: bool) -> void:
	var texture_size := texture.get_size()
	var uv_left := source.position.x / texture_size.x
	var uv_right := source.end.x / texture_size.x
	if mirrored:
		var swap := uv_left
		uv_left = uv_right
		uv_right = swap
	var uv_top := source.position.y / texture_size.y
	var uv_bottom := source.end.y / texture_size.y
	var points := PackedVector2Array([span.position, Vector2(span.end.x, span.position.y), span.end, Vector2(span.position.x, span.end.y)])
	var left := Color(1, 1, 1, alpha_left)
	var right := Color(1, 1, 1, alpha_right)
	var colors := PackedColorArray([left, right, right, left])
	var uvs := PackedVector2Array([Vector2(uv_left, uv_top), Vector2(uv_right, uv_top), Vector2(uv_right, uv_bottom), Vector2(uv_left, uv_bottom)])
	draw_polygon(points, colors, uvs, texture)

# Route signs appear only once the eastern path is open or Lolth is already away. They sit
# above the pickup labels and in front of the frame overlays so they stay readable.
func draw_route_markers() -> void:
	if zone != 0 or camera_limit_x() <= 0.0:
		return
	var sign_color := Color("f2d59a")
	var post_color := Color("6c5238")
	var east_post := Vector2(ROUTE_THORNWAKE_END_X - 30.0, GROUND_Y)
	draw_line(east_post, east_post + Vector2(0, -255), post_color, 5.0)
	draw_string(ThemeDB.fallback_font, east_post + Vector2(-240, -259), "STONEHOOK FOOTHILLS  >", HORIZONTAL_ALIGNMENT_RIGHT, 230, 15, sign_color)
	draw_string(ThemeDB.fallback_font, east_post + Vector2(-240, -241), "On foot. The Wagon stays in the cave.", HORIZONTAL_ALIGNMENT_RIGHT, 230, 12, Color("e5d9bd"))
	var west_post := Vector2(ROUTE_FOOTHILLS_START_X + 40.0, GROUND_Y)
	draw_line(west_post, west_post + Vector2(0, -255), post_color, 5.0)
	draw_string(ThemeDB.fallback_font, west_post + Vector2(10, -259), "<  THE CAVE CAMP", HORIZONTAL_ALIGNMENT_LEFT, -1, 15, sign_color)

func draw_zone_traversal() -> void:
	if zone != 1:
		return
	for hazard in zone_hazards:
		var rect: Rect2 = hazard.rect
		draw_rect(rect, Color("9c784c", 0.35))
		draw_line(rect.position + Vector2(4, 12), rect.end - Vector2(8, 8), Color("d4ad63", 0.75), 3.0)
		draw_string(ThemeDB.fallback_font, rect.position + Vector2(0, -8), "SCREE", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 12, Color("f3d59a"))
	for route in rope_routes:
		var rope_color := Color("6e5542", 0.35) if bool(route.used) else Color("ddc585", 0.95)
		draw_line(route.from, route.to, rope_color, 4.0)
		draw_circle(route.from, 12, rope_color)
		if not bool(route.used):
			draw_string(ThemeDB.fallback_font, route.from + Vector2(-46, -18), "ROPE ROUTE", HORIZONTAL_ALIGNMENT_CENTER, 92, 11, Color("f6de9b"))

func enemy_source_cell(sheet: Texture2D, column: int, row: int) -> Rect2:
	# Integer edges cover odd atlas dimensions without sampling half a neighbor row.
	var start := Vector2i(int(sheet.get_width() * column / 2.0), int(sheet.get_height() * row / 2.0))
	var end := Vector2i(int(sheet.get_width() * (column + 1) / 2.0), int(sheet.get_height() * (row + 1) / 2.0))
	return Rect2(start, end - start)

func enemy_sprite_frame(shade: Dictionary) -> Dictionary:
	# B-07: selected by the actor's stable identity, never by Lolth's region or by name case.
	if is_scree_crawler(shade):
		return {"sheet": STONEHOOK_THREATS_RUNTIME, "source": scree_crawler_source()}
	if is_cliff_harrier(shade):
		return {"sheet": STONEHOOK_THREATS_RUNTIME, "source": cliff_harrier_source()}
	var sheet: Texture2D = BRIAR_HOUND_RUNTIME
	if zone == 1:
		sheet = STONEHOOK_THREATS_RUNTIME
	elif zone == 2:
		sheet = LATER_REGION_THREATS_RUNTIME
	elif String(shade.name) == "STAG OF MIRE":
		sheet = STAG_OF_MIRE_RUNTIME
	elif String(shade.name) == "ANTLERED HUNGER":
		sheet = ANTLERED_HUNGER_RUNTIME
	var column := 0
	var row := 0
	if shade.defeated:
		column = 1
		row = 1
	elif zone == 1:
		var index := 0 if String(shade.name) == "Scree Crawler" else 1 if String(shade.name) == "Cliff Harrier" else 3
		column = index % 2
		row = int(index / 2)
	elif zone == 2:
		var index := 3 if String(shade.name) == "ROOT CROWN" else 0
		column = index % 3
		row = int(index / 3)
	elif player.distance_to(shade.pos) < 150.0:
		row = 1
	else:
		column = int(floor(pulse * 4.0)) % 2
	var source: Rect2
	if zone == 0:
		source = enemy_source_cell(sheet, column, row)
	else:
		# Prototype-region sampling/placement is deliberately unchanged in B-05.
		var cell := Vector2(sheet.get_width() / (3.0 if zone == 2 else 2.0), sheet.get_height() / 2.0)
		source = Rect2(cell * Vector2(column, row), cell)
	return {"sheet": sheet, "source": source}

func enemy_draw_geometry(shade: Dictionary) -> Dictionary:
	var frame := enemy_sprite_frame(shade)
	var sheet: Texture2D = frame.sheet
	var source: Rect2 = frame.source
	var bounds := enemy_frame_bounds(sheet, source)
	var size := enemy_visual_size(shade)
	var draw_size := source.size * (size / source.size.y) if zone == 0 else Vector2(size, size)
	if is_scree_crawler(shade):
		# Uniform scale so the visible alpha body, not the padded crop, is 120 px tall.
		draw_size = source.size * (SCREE_CRAWLER_BODY_HEIGHT / float(bounds.size.y))
	elif is_cliff_harrier(shade):
		# B-08: the same uniform rule; the body's lower edge (claws) sits at pos.y + 34, so the
		# displayed bird follows its world position, altitude included.
		draw_size = source.size * (CLIFF_HARRIER_BODY_HEIGHT / float(bounds.size.y))
	var scale_factor := draw_size / source.size
	var p: Vector2 = shade.pos
	var destination := Rect2(p.x - (float(bounds.position.x) + float(bounds.size.x) / 2.0) * scale_factor.x, p.y + 34.0 - float(bounds.end.y) * scale_factor.y, draw_size.x, draw_size.y)
	var body := Rect2(destination.position + Vector2(bounds.position) * scale_factor, Vector2(bounds.size) * scale_factor)
	return {"sheet": sheet, "source": source, "destination": destination, "body": body}

func draw_shades() -> void:
	# B-07: the foothill crawler is drawn with the same sprite, label and health-bar path.
	for shade in combat_targets():
		if shade.defeated and pulse - shade.defeated_at > 0.42:
			continue
		var p: Vector2 = shade.pos
		var geometry := enemy_draw_geometry(shade)
		var tint := Color(2.2, 1.8, 1.8) if float(shade.get("hit_flash", 0.0)) > 0.0 else Color.WHITE
		var size := enemy_visual_size(shade)
		draw_enemy_sprite(shade, geometry, tint)
		if not shade.defeated:
			var top: float = geometry.body.position.y
			var label_width := maxf(160.0, size)
			draw_string(ThemeDB.fallback_font, Vector2(p.x - label_width / 2.0, top - 26.0), String(shade.name), HORIZONTAL_ALIGNMENT_CENTER, label_width, 13, Color("dfb8f4"))
			if String(shade.get("behavior", "")) == "charge" and is_night() and zone == 0:
				draw_string(ThemeDB.fallback_font, Vector2(p.x - 60, top - 41.0), "WAGON RUNNER", HORIZONTAL_ALIGNMENT_CENTER, 120, 10, Color("f3bc75"))
			var enemy_health := float(int(shade.health)) / float(int(shade.get("max_health", shade.health))) * 100.0
			draw_rect(Rect2(p.x - 45, top - 16.0, 90, 6), Color("27182e"))
			draw_rect(Rect2(p.x - 45, top - 16.0, 90 * enemy_health / 100.0, 6), Color("db7587"))

func draw_enemy_sprite(shade: Dictionary, geometry: Dictionary, tint: Color) -> void:
	var origin := world_draw_origin()
	if enemy_facing_left(shade):
		# Reflect around the visible body's world center, not the atlas-cell center,
		# then apply the same world-to-view translation as every other world layer.
		draw_set_transform(Vector2(float(shade.pos.x) * 2.0, 0.0) + origin, 0.0, Vector2(-1.0, 1.0))
	draw_texture_rect_region(geometry.sheet, geometry.destination, geometry.source, tint)
	# Do not reflect labels, health bars or subsequent scene drawing.
	draw_set_transform(origin, 0.0, Vector2.ONE)

func prepare_enemy_frame_bounds() -> void:
	var started := Time.get_ticks_usec()
	ui_enemy_bounds.clear()
	ui_enemy_bounds_scans = 0
	# Warm all runtime sheets before the first gameplay frame. Prototype geometry stays
	# unchanged; prewarming it only removes the former first-draw scan cost.
	var sheets := [BRIAR_HOUND_RUNTIME, STAG_OF_MIRE_RUNTIME, ANTLERED_HUNGER_RUNTIME, STONEHOOK_THREATS_RUNTIME, LATER_REGION_THREATS_RUNTIME]
	for index in sheets.size():
		var sheet: Texture2D = sheets[index]
		var pixels := sheet.get_image()
		var columns := 3 if index == 4 else 2
		for row in 2:
			for column in columns:
				var cell := Vector2(sheet.get_width() / float(columns), sheet.get_height() / 2.0)
				var source := enemy_source_cell(sheet, column, row) if index < 3 else Rect2(cell * Vector2(column, row), cell)
				cache_enemy_frame_bounds(sheet, source, pixels)
	ui_enemy_bounds_startup_usec = Time.get_ticks_usec() - started

func cache_enemy_frame_bounds(sheet: Texture2D, source: Rect2, atlas: Image) -> void:
	ui_enemy_bounds[sheet.resource_path + str(source)] = scan_alpha_bounds(source, atlas)
	ui_enemy_bounds_scans += 1

func scan_alpha_bounds(source: Rect2, atlas: Image) -> Rect2i:
	var pixels := atlas.get_region(Rect2i(source))
	var used := pixels.get_used_rect()
	var minimum := pixels.get_size()
	var maximum := Vector2i(-1, -1)
	# Ignore nearly transparent atlas noise. This scan is startup-only.
	for y in range(used.position.y, used.end.y):
		for x in range(used.position.x, used.end.x):
			if pixels.get_pixel(x, y).a >= 0.25:
				minimum.x = mini(minimum.x, x)
				minimum.y = mini(minimum.y, y)
				maximum.x = maxi(maximum.x, x)
				maximum.y = maxi(maximum.y, y)
	return Rect2i(minimum, maximum - minimum + Vector2i.ONE) if maximum.x >= 0 else Rect2i(Vector2i.ZERO, Vector2i(source.size))

# B-07: the crawler's exact crop is scanned once here, before the first gameplay frame, with
# the same alpha rule. It is kept apart from the 22 atlas cells so their cache is unchanged.
func prepare_encounter_bounds() -> void:
	ui_encounter_bounds.clear()
	ui_encounter_bounds_scans = 0
	var source := scree_crawler_source()
	var atlas := STONEHOOK_THREATS_RUNTIME.get_image()
	ui_encounter_bounds[STONEHOOK_THREATS_RUNTIME.resource_path + str(source)] = scan_alpha_bounds(source, atlas)
	ui_encounter_bounds_scans += 1
	# B-08: the Harrier crop, scanned with the same alpha rule before the first frame.
	prepare_harrier_bounds(atlas)

func enemy_frame_bounds(sheet: Texture2D, source: Rect2) -> Rect2i:
	var key := sheet.resource_path + str(source)
	if ui_encounter_bounds.has(key):
		return ui_encounter_bounds[key]
	if not ui_enemy_bounds.has(key):
		push_error("Enemy frame was not prepared before gameplay: " + key)
		return Rect2i(Vector2i.ZERO, Vector2i(source.size))
	return ui_enemy_bounds[key]

# Drawn above the camp so a charge toward the Wagon stays readable.
func draw_attack_telegraphs() -> void:
	if zone != 0:
		return
	for shade in shades:
		if not shade.defeated and String(shade.get("attack_state", "")) == "windup":
			draw_attack_telegraph(shade)

# B-07 ground warning: the strip the lunge will cross, in its locked direction, with a label.
# Drawn after the foreground overlay so the frame art cannot hide it.
func draw_scree_crawler_warning(crawler: Dictionary) -> void:
	var geometry := enemy_draw_geometry(crawler)
	var body: Rect2 = geometry.body
	var direction := float(crawler.attack_dir)
	var warning := Color(1.0, 0.42, 0.25, 0.7 + 0.3 * sin(pulse * 18.0))
	var front_x := body.end.x if direction > 0.0 else body.position.x
	var tip_x := front_x + direction * (SCREE_CRAWLER_LUNGE_SPEED * SCREE_CRAWLER_LUNGE_TIME + MELEE_LOLTH_HALF_WIDTH)
	draw_rect(Rect2(minf(front_x, tip_x), GROUND_Y - 8.0, absf(tip_x - front_x), 12.0), Color(warning.r, warning.g, warning.b, 0.35))
	draw_line(Vector2(front_x, GROUND_Y - 2.0), Vector2(tip_x, GROUND_Y - 2.0), warning, 4.0)
	draw_line(Vector2(tip_x, GROUND_Y - 2.0), Vector2(tip_x - direction * 16.0, GROUND_Y - 12.0), warning, 4.0)
	draw_line(Vector2(tip_x, GROUND_Y - 2.0), Vector2(tip_x - direction * 16.0, GROUND_Y + 8.0), warning, 4.0)
	var p: Vector2 = crawler.pos
	draw_string(ThemeDB.fallback_font, Vector2(p.x - 60.0, body.position.y - 44.0), "LUNGE!", HORIZONTAL_ALIGNMENT_CENTER, 120, 16, warning)

# B-08 dive warning: a ground strip from below the bird to the locked target, a target mark
# and a label. The strip is clamped to the foothill span. Drawn above the foreground overlay.
func draw_cliff_harrier_warning(harrier: Dictionary) -> void:
	var body: Rect2 = enemy_draw_geometry(harrier).body
	var direction := float(harrier.attack_dir)
	var warning := Color(1.0, 0.42, 0.25, 0.7 + 0.3 * sin(pulse * 18.0))
	var from_x := float(harrier.pos.x)
	var to_x := clampf(float(harrier.target_x) + direction * MELEE_LOLTH_HALF_WIDTH, ROUTE_FOOTHILLS_START_X, ROUTE_END_X)
	draw_rect(Rect2(minf(from_x, to_x), GROUND_Y - 8.0, absf(to_x - from_x), 12.0), Color(warning.r, warning.g, warning.b, 0.35))
	draw_line(Vector2(from_x, GROUND_Y - 2.0), Vector2(to_x, GROUND_Y - 2.0), warning, 4.0)
	var target := Vector2(float(harrier.target_x), GROUND_Y - 2.0)
	draw_arc(target, 14.0, 0.0, TAU, 24, warning, 3.0)
	draw_line(target + Vector2(-10, -10), target + Vector2(10, 10), warning, 3.0)
	draw_line(target + Vector2(-10, 10), target + Vector2(10, -10), warning, 3.0)
	draw_line(Vector2(from_x, body.end.y), Vector2(from_x, GROUND_Y - 6.0), Color(warning.r, warning.g, warning.b, 0.6), 2.0)
	draw_string(ThemeDB.fallback_font, Vector2(from_x - 60.0, body.position.y - 44.0), "DIVE!", HORIZONTAL_ALIGNMENT_CENTER, 120, 16, warning)

func draw_attack_telegraph(shade: Dictionary) -> void:
	var p: Vector2 = shade.pos
	var warning := Color(1.0, 0.42, 0.25, 0.7 + 0.3 * sin(pulse * 18.0))
	var height := enemy_visual_size(shade)
	if String(shade.get("attack_target", "lolth")) == "wagon":
		draw_line(p + Vector2(0, -20), Vector2(CARAVAN_X, GROUND_Y - 40), warning, 4.0)
		draw_string(ThemeDB.fallback_font, p + Vector2(-50, 10.0 - height), "CHARGE!", HORIZONTAL_ALIGNMENT_CENTER, 100, 16, warning)
	else:
		draw_string(ThemeDB.fallback_font, p + Vector2(-50, 10.0 - height), "!", HORIZONTAL_ALIGNMENT_CENTER, 100, 24, warning)
	draw_arc(p + Vector2(0, -40), height * 0.28, 0.0, TAU, 32, warning, 3.0)

func draw_mark_gates() -> void:
	for gate in mark_gates:
		if gate.opened:
			continue
		var p: Vector2 = gate.pos
		var revealed := echo_sense_time > 0.0 or mark_level >= int(gate.mark)
		var color := Color("d4b2ff") if revealed else Color("3d3153")
		var gate_index := 0
		match int(gate.mark):
			5:
				gate_index = 4
			6:
				gate_index = 6
			7:
				gate_index = 8
		var source_width := MARK_GATES_RUNTIME.get_width() / 3.0
		var source_height := MARK_GATES_RUNTIME.get_height() / 3.0
		var source := Rect2(source_width * (gate_index % 3), source_height * int(gate_index / 3), source_width, source_height)
		draw_texture_rect_region(MARK_GATES_RUNTIME, Rect2(p - Vector2(50, 92), Vector2(100, 100)), source, color)
		draw_line(p + Vector2(-22, 0), p + Vector2(22, 0), Color("ead8a6"), 3.0)
		if revealed:
			draw_string(ThemeDB.fallback_font, p + Vector2(-54, -68), gate.name, HORIZONTAL_ALIGNMENT_CENTER, 108, 12, color)

func draw_caravan() -> void:
	var base := Vector2(CARAVAN_X, GROUND_Y - 35)
	draw_survivors(base)
	var repair_index := clampi(wagon_repair, 0, 2)
	if zone == 0:
		repair_index = 2 if wagon_condition() == "stationed" else 0
	var wagon_source_width := WAGON_REPAIR_RUNTIME.get_width() / 3.0
	var wagon_source := Rect2(wagon_source_width * repair_index, 0, wagon_source_width, WAGON_REPAIR_RUNTIME.get_height())
	draw_texture_rect_region(WAGON_REPAIR_RUNTIME, Rect2(base.x - 118, GROUND_Y - 150, 250, 150), wagon_source)
	var prop_cell_width := SALVAGE_WORKSHOP_RUNTIME.get_width() / 4.0
	var prop_cell_height := SALVAGE_WORKSHOP_RUNTIME.get_height() / 2.0
	var craft_table_source := Rect2(0, prop_cell_height, prop_cell_width, prop_cell_height)
	draw_texture_rect_region(SALVAGE_WORKSHOP_RUNTIME, Rect2(base.x + 106, GROUND_Y - 101, 74, 62), craft_table_source)
	var flame_scale := 0.72 + flame / 360.0 + sin(pulse * 6.0) * 0.035
	var flame_size := Vector2(112, 132) * flame_scale
	var flame_index := clampi(int(floor(flame / 34.0)), 0, 2)
	var flame_source_width := CARAVAN_FLAME_RUNTIME.get_width() / 3.0
	var flame_source := Rect2(flame_source_width * flame_index, 0, flame_source_width, CARAVAN_FLAME_RUNTIME.get_height())
	draw_texture_rect_region(CARAVAN_FLAME_RUNTIME, Rect2(Vector2(base.x + 54, GROUND_Y - flame_size.y), flame_size), flame_source)
	draw_string(ThemeDB.fallback_font, Vector2(base.x - 94, base.y - 195), "THE CAVE CAMP" if zone == 0 else "THE LAST CAMP", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color("f9df96"))
	if zone != 0:
		draw_string(ThemeDB.fallback_font, Vector2(base.x - 94, base.y - 178), "WAGON REPAIR %d/3" % wagon_repair, HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("d8c9aa"))
	if zone == 0:
		draw_string(ThemeDB.fallback_font, Vector2(base.x - 94, base.y - 212), "WAGON: %s · %s" % [wagon_condition().replace("_", " ").to_upper(), "TRAVEL LOCKED" if wagon_travel_locked() else "TRAVEL READY"], HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color("e9b878"))
	if zone == 1:
		draw_string(ThemeDB.fallback_font, Vector2(base.x - 94, base.y - 160), "AXLE & BRAKES: %s" % ("INSTALLED" if axle_brakes_installed else "NEEDED"), HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color("9fd5d4") if axle_brakes_installed else Color("e9b878"))

func draw_ally_posts() -> void:
	if zone != 0:
		return
	for ally in posted_allies:
		var post: Vector2 = ALLY_POSTS[ally]
		var active := player.distance_to(post) <= 125.0
		draw_circle(post, 30.0, Color("8b62bc", 0.33) if active else Color("47355d", 0.24))
		draw_circle(post, 18.0, Color("e5d0ff", 0.78) if active else Color("b69ccf", 0.5))
		draw_string(ThemeDB.fallback_font, post + Vector2(-58, -39), ally, HORIZONTAL_ALIGNMENT_CENTER, 116, 12, Color("fff2df"))
		if active:
			draw_string(ThemeDB.fallback_font, post + Vector2(-58, 44), "ALLY POST", HORIZONTAL_ALIGNMENT_CENTER, 116, 11, Color("f4d67e"))

func draw_survivors(base: Vector2) -> void:
	var caravan_safe := provisions > 2.0
	var survivor_color := Color("c7b49a") if caravan_safe else Color("cb7777")
	for i in 8:
		var ally: String = THALESTRIEL[i]
		var portrait_sheet: Texture2D = THALESTRIEL_CURED_RUNTIME if cured_allies.has(ally) else THALESTRIEL_PLAGUED_RUNTIME
		var portrait_cell_width := portrait_sheet.get_width() / 4.0
		var portrait_cell_height := portrait_sheet.get_height() / 2.0
		var p := Vector2(base.x - 68 + float(i % 4) * 38.0, base.y - 153 + float(i / 4) * 28.0)
		var source := Rect2(portrait_cell_width * float(i % 4), portrait_cell_height * float(int(i / 4)), portrait_cell_width, portrait_cell_height)
		var portrait_rect := Rect2(p - Vector2(13, 20), Vector2(26, 32))
		draw_texture_rect_region(portrait_sheet, portrait_rect, source, survivor_color)
		draw_rect(portrait_rect, Color("d4b2ff") if cured_allies.has(ally) else Color("d8c9aa") if caravan_safe else Color("c87883"), false, 1.0)
	var emblem_width := CAMP_STATUS_EMBLEMS.get_width() / 2.0
	var emblem_source := Rect2(emblem_width * float(0 if caravan_safe else 1), 0, emblem_width, CAMP_STATUS_EMBLEMS.get_height())
	draw_texture_rect_region(CAMP_STATUS_EMBLEMS, Rect2(base.x - 140, base.y - 255, 40, 40), emblem_source)
	var status := "THE NINE HOLD TOGETHER" if caravan_safe else "A THALESTRIEL IS AT RISK"
	draw_string(ThemeDB.fallback_font, Vector2(base.x - 90, base.y - 230), status, HORIZONTAL_ALIGNMENT_LEFT, -1, 13, survivor_color)

func draw_salvage() -> void:
	for item in salvage:
		if item.taken:
			continue
		var p: Vector2 = item.pos
		var visual_p := p
		if visual_p.y >= GROUND_Y - 40.0:
			visual_p.y = GROUND_Y - 48.0
		var glow := 6.0 + sin(pulse * 3.0 + visual_p.x) * 2.0
		draw_circle(visual_p, 24 + glow, Color(0.95, 0.77, 0.32, 0.12))
		var pickup_index := 0
		match String(item.type):
			"kindling":
				pickup_index = 1
			"salvage":
				pickup_index = 2
			"shadow_echo":
				pickup_index = 3
		var source_width := SALVAGE_PICKUPS_RUNTIME.get_width() / 2.0
		var source_height := SALVAGE_PICKUPS_RUNTIME.get_height() / 2.0
		var source := Rect2(source_width * (pickup_index % 2), source_height * int(pickup_index / 2), source_width, source_height)
		draw_texture_rect_region(SALVAGE_PICKUPS_RUNTIME, Rect2(visual_p - Vector2(36, 36), Vector2(72, 72)), source)
		draw_string(ThemeDB.fallback_font, visual_p + Vector2(-50, -37), item.name, HORIZONTAL_ALIGNMENT_CENTER, 100, 14, Color("f7e7b6"))

func draw_portal() -> void:
	if zone != 2 or mark_level != 9:
		return
	var p := Vector2(PORTAL_X, GROUND_Y - 100)
	draw_texture_rect(DREAM_GATE_RUNTIME, Rect2(p - Vector2(100, 160), Vector2(200, 240)), false)
	draw_string(ThemeDB.fallback_font, p + Vector2(-66, 88), "DREAM GATE", HORIZONTAL_ALIGNMENT_CENTER, 132, 16, Color("f2d4ff"))

# The current pose cell and optional crop, shared by the normal and readability passes.
func player_sprite_frame() -> Dictionary:
	if LOLTH_TRANSFORMATIONS.stage_for_mark(mark_level) > 0:
		var pose := player_pose()
		var clip := pose
		var elapsed := player_animation_time if pose == player_animation_pose else 0.0
		var progress := -1.0
		if player_action_time > 0.0 and player_action_duration > 0.0:
			progress = clampf(1.0-player_action_time/player_action_duration, 0.0, 1.0)
		elif lolth_transform_time > 0.0 and on_floor:
			clip = "transform"
			elapsed = LOLTH_TRANSFORMATIONS.TRANSFORM_DURATION-lolth_transform_time
		if clip == "walk":
			clip = "run"
		elif clip == "air":
			clip = "rise" if velocity.y <= 80.0 else "fall"
		return LOLTH_TRANSFORMATIONS.sprite_frame(mark_level, clip, elapsed, progress)
	var pose_sheet: Texture2D = LOLTH_ELF_RUNTIME if lolth_form() == "elf" else LOLTH_DROW_RUNTIME
	var pose_index := 0
	match player_pose():
		"strike":
			pose_index = 3
		"dodge":
			pose_index = 4
		"collect":
			pose_index = 5
		"hurt":
			pose_index = 8
		"air":
			pose_index = 6 if velocity.y <= 80.0 else 7
		"walk":
			pose_index = 1 if int(floor(pulse * 8.0)) % 2 == 0 else 2
	var pose_width := pose_sheet.get_width() / 3.0
	var pose_height := pose_sheet.get_height() / 3.0
	var pose_source := Rect2(pose_width * float(pose_index % 3), pose_height * float(int(pose_index / 3)), pose_width, pose_height)
	var crop := Rect2()
	if pose_index == 4:
		# The adjacent attack cell spills a weapon into the dash cell's blank margin.
		# Sample only the clean body region, preserving its original scale and pivot.
		var top_cut := 0.32 if lolth_form() == "elf" else 0.23
		var left_cut := 0.0 if lolth_form() == "elf" else 0.15
		crop = Rect2(pose_width * left_cut, pose_height * top_cut, pose_width * (1.0 - left_cut), pose_height * (1.0 - top_cut))
	return {"sheet": pose_sheet, "source": pose_source, "crop": crop}

func draw_player() -> void:
	var frame := player_sprite_frame()
	draw_player_sprite(frame.sheet, frame.source, float(frame.get("height", PLAYER_SPRITE_HEIGHT)), float(frame.get("feet_ratio", 1.0)), frame.crop)
	draw_string(ThemeDB.fallback_font, player + Vector2(-58, -174), "NOLF", HORIZONTAL_ALIGNMENT_CENTER, 116, 13, Color("fff0b0"))
	if player_hurt_visible():
		draw_circle(player + Vector2(0, -62), 58, Color(0.85, 0.25, 0.45, 0.18))

func draw_player_sprite(sheet: Texture2D, source: Rect2, height: float = PLAYER_SPRITE_HEIGHT, feet_ratio: float = 1.0, crop: Rect2 = Rect2(), tint: Color = Color.WHITE) -> void:
	var width := height * source.size.x / source.size.y
	var destination := Rect2(player.x - width / 2.0, player.y + PLAYER_FEET_OFFSET - height * feet_ratio, width, height)
	if crop.has_area():
		var source_scale := destination.size / source.size
		destination.position += crop.position * source_scale
		destination.size = crop.size * source_scale
		source = Rect2(source.position + crop.position, crop.size)
	if player_facing_left:
		var origin := world_draw_origin()
		draw_set_transform(Vector2(player.x * 2.0, 0.0) + origin, 0.0, Vector2(-1.0, 1.0))
		draw_texture_rect_region(sheet, destination, source, tint)
		draw_set_transform(origin, 0.0, Vector2.ONE)
		return
	draw_texture_rect_region(sheet, destination, source, tint)

# B-06 readability: the frame-like foreground overlays hide Lolth at the Thornwake border
# and at the far foothill limit. Inside those named spans only, and only while the route is
# open, her existing sprite is redrawn semi-transparently in front of the overlay. Elsewhere,
# including the whole original cave and tutorial view, nothing extra is drawn.
func foreground_readability_alpha() -> float:
	if zone != 0 or camera_limit_x() <= 0.0:
		return 0.0
	var strength := 0.0
	for span in FOREGROUND_READABILITY_SPANS:
		var rise := clampf((player.x - span.x) / FOREGROUND_READABILITY_RAMP, 0.0, 1.0)
		# A span that ends at the route limit stays at full strength up to the limit.
		var fall := clampf((span.y - player.x) / FOREGROUND_READABILITY_RAMP, 0.0, 1.0) if span.y < ROUTE_END_X else 1.0
		if player.x >= span.x and player.x <= span.y:
			strength = maxf(strength, minf(rise, fall))
	return FOREGROUND_READABILITY_ALPHA * strength

func draw_foreground_readability() -> void:
	var alpha := foreground_readability_alpha()
	if alpha <= 0.0:
		return
	var frame := player_sprite_frame()
	draw_player_sprite(frame.sheet, frame.source, float(frame.get("height", PLAYER_SPRITE_HEIGHT)), float(frame.get("feet_ratio", 1.0)), frame.crop, Color(1, 1, 1, alpha))
	draw_string(ThemeDB.fallback_font, player + Vector2(-58, -174), "NOLF", HORIZONTAL_ALIGNMENT_CENTER, 116, 13, Color(1.0, 0.94, 0.69, alpha))

func draw_foreground_overlay() -> void:
	var panel_width := RUINS_FOREGROUND_OVERLAYS.get_width() / 2.0
	if zone == 0:
		draw_texture_rect(ASHEN_WAY_FOREGROUND_OVERLAY, Rect2(Vector2.ZERO, VIEW), false)
		var stone_overlay := Rect2(0, 0, panel_width, RUINS_FOREGROUND_OVERLAYS.get_height())
		draw_route_blend(ASHEN_WAY_FOREGROUND_OVERLAY, stone_overlay, RUINS_FOREGROUND_OVERLAYS, 0.0, VIEW.y, ROUTE_OVERLAY_FADE_WIDTH, false)
		draw_texture_rect_region(RUINS_FOREGROUND_OVERLAYS, Rect2(ROUTE_FOOTHILLS_START_X, 0, ROUTE_FOOTHILLS_WIDTH, VIEW.y), stone_overlay)
		return
	var source := Rect2(panel_width * float(zone - 1), 0, panel_width, RUINS_FOREGROUND_OVERLAYS.get_height())
	draw_texture_rect_region(RUINS_FOREGROUND_OVERLAYS, Rect2(Vector2.ZERO, VIEW), source)

func draw_mark_vfx() -> void:
	# The dash uses Lolth's existing pose only; the atlas streak contains stray marks.
	if mark_vfx_time <= 0.0 or mark_vfx_kind == "dash":
		return
	var alpha := clampf(mark_vfx_time / 0.42, 0.0, 1.0)
	var cell_width := SHADOW_ACTIONS_VFX.get_width() / 2.0
	var cell_height := SHADOW_ACTIONS_VFX.get_height() / 2.0
	var cell_index := 0
	var size := Vector2(132, 106)
	if mark_vfx_kind == "sense" or mark_vfx_kind == "gate":
		cell_index = 3
		size = Vector2(170, 124)
	elif mark_vfx_kind == "collect":
		cell_index = 1
		size = Vector2(96, 74)
	elif mark_vfx_kind == "swing":
		size = Vector2(104, 84)
		alpha *= 0.45
	var source := Rect2(cell_width * float(cell_index % 2), cell_height * float(int(cell_index / 2)), cell_width, cell_height)
	draw_set_transform(world_draw_origin(), 0.0, Vector2.ONE)
	draw_texture_rect_region(SHADOW_ACTIONS_VFX, Rect2(mark_vfx_pos - size / 2.0, size), source, Color(1, 1, 1, alpha))

func draw_hud() -> void:
	draw_rect(Rect2(24, 22, 1232, 102), Color(0.035, 0.04, 0.1, 0.84))
	draw_string(ThemeDB.fallback_font, Vector2(48, 54), "THE FIRST NINE", HORIZONTAL_ALIGNMENT_LEFT, -1, 25, Color("f8dc8c"))
	draw_string(ThemeDB.fallback_font, Vector2(48, 82), "%s  ·  %s  ·  Objective: %s" % [displayed_region_name(), clock_label(), current_objective()], HORIZONTAL_ALIGNMENT_LEFT, -1, 17, Color("ddd6e8"))
	draw_string(ThemeDB.fallback_font, Vector2(48, 108), "MARK: %s  ·  CURED: %d/8  ·  CHECKPOINT: %s" % [MARK_NAMES[mark_level] if mark_level > 0 else "UNMARKED", awakened, checkpoint_label()], HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color("cbb5eb"))
	if zone == 0 and is_night() and night_wave_total > 0:
		var wave_state := "CLEARED" if night_waves_complete else "PAUSE" if night_wave_pause > 0.0 else "ACTIVE"
		draw_string(ThemeDB.fallback_font, Vector2(880, 108), "WAVE %d/%d: %s" % [night_wave, night_wave_total, wave_state], HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color("f2c879"))
	draw_mark_seal(Vector2(1212, 84))
	draw_meter(Vector2(620, 42), "VIGOR", health / max_health() * 100.0, Color("d7778c"), 0)
	draw_meter(Vector2(780, 42), "FLAME", flame, Color("efad4d"), 1)
	draw_meter(Vector2(940, 42), "GROUP", provisions / 8.0 * 100.0, Color("8ecb93"), 2)
	draw_meter(Vector2(1100, 42), "WAGON", wagon_integrity, Color("83b9d9"), 3)
	draw_rect(Rect2(24, 616, 1232, 78), Color(0.035, 0.04, 0.1, 0.86))
	draw_action_prompt(Vector2(46, 620), 0)
	draw_action_prompt(Vector2(246, 620), 1)
	draw_action_prompt(Vector2(460, 620), 2)
	draw_action_prompt(Vector2(765, 620), 3)
	var load_text: String = "EMPTY" if recovered_load.is_empty() else recovered_load[selected_load].name
	draw_string(ThemeDB.fallback_font, Vector2(46, 648), "A/D: Move · Space: Jump · E: Interact · LMB/J: Attack · Shift: Dash · I: Inventory · M: Wagon" + (" · C: First Thread" if mark_level >= 1 else ""), HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("d9d1e1"))
	var stats := current_stats()
	var next_threshold: int = int(ECHO_THRESHOLDS[mark_level]) if mark_level > 0 and mark_level < 9 else 0
	draw_string(ThemeDB.fallback_font, Vector2(46, 670), "LOAD %d/%d: %s  ·  STOCK %d/%d  ·  POSTS %d/%d  ·  ECHOES %d/%d  ·  M:%d V:%d G:%d S:%d W:%d" % [load_used(), load_capacity(), load_text, wagon_stock.size(), WAGON_STOCK_CAPACITY, posted_allies.size(), MAX_ACTIVE_POSTS, shadow_echoes, next_threshold, stats.might, stats.vigor, stats.grace, stats.shadow, stats.web], HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("a9d9d0"))
	if message_time > 0.0 or state != "journey":
		draw_string(ThemeDB.fallback_font, Vector2(46, 691), message, HORIZONTAL_ALIGNMENT_LEFT, -1, 17, Color("f7d679"))

func draw_cure_menu() -> void:
	draw_rect(Rect2(0, 0, VIEW.x, VIEW.y), Color(0.025, 0.01, 0.06, 0.88))
	draw_string(ThemeDB.fallback_font, Vector2(0, 118), "%s" % MARK_NAMES[mark_level], HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 38, Color("efd0ff"))
	draw_string(ThemeDB.fallback_font, Vector2(0, 160), "CHOOSE ONE THALESTRIEL TO CURE", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 20, Color("fff2df"))
	var available := available_allies()
	for index in available.size():
		var column := index % 4
		var row := int(index / 4)
		var rect := Rect2(154 + column * 250, 228 + row * 142, 220, 102)
		var selected := index == selected_cure
		draw_rect(rect, Color("4e3468") if selected else Color("20182c"))
		draw_rect(rect, Color("f6d47f") if selected else Color("725683"), false, 2.0)
		draw_string(ThemeDB.fallback_font, rect.position + Vector2(0, 43), available[index], HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 22, Color("fff2df"))
		draw_string(ThemeDB.fallback_font, rect.position + Vector2(0, 70), "Press E to awaken", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 14, Color("d9c6e8"))
	if lolth_transform_time > 0.0 and LOLTH_TRANSFORMATIONS.stage_for_mark(mark_level) > 0:
		# Acquisition happens beneath this modal. Present the same six-frame clip in its
		# free lower area so the cure choices remain immediately available and unobscured.
		var frame := LOLTH_TRANSFORMATIONS.sprite_frame(mark_level, "transform", LOLTH_TRANSFORMATIONS.TRANSFORM_DURATION-lolth_transform_time)
		var preview_scale := 2.0
		var size: Vector2 = frame.source.size*preview_scale
		var position := Vector2(640,584)-Vector2(56,100)*preview_scale
		draw_texture_rect_region(frame.sheet,Rect2(position,size),frame.source)
	draw_string(ThemeDB.fallback_font, Vector2(0, 600), "A/D or stick: choose   ·   E / top face: cure", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 18, Color("fff2df"))

func draw_meter(position: Vector2, label: String, value: float, color: Color, icon_index: int) -> void:
	var icon_width := HUD_STATUS_ICONS.get_width() / 3.0
	var icon_height := HUD_STATUS_ICONS.get_height() / 3.0
	var icon_source := Rect2(icon_width * (icon_index % 3), icon_height * int(icon_index / 3), icon_width, icon_height)
	draw_texture_rect_region(HUD_STATUS_ICONS, Rect2(position + Vector2(-25, -4), Vector2(21, 21)), icon_source)
	draw_string(ThemeDB.fallback_font, position, label, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("f2e9d5"))
	var bar := Rect2(position + Vector2(0, 8), Vector2(150, 18))
	draw_rect(bar, Color("252039"))
	draw_rect(Rect2(bar.position, Vector2(bar.size.x * clampf(value, 0.0, 100.0) / 100.0, bar.size.y)), color)
	draw_rect(bar, Color("f7dd96"), false, 1.5)

func draw_action_prompt(position: Vector2, icon_index: int) -> void:
	var icon_width := ACTION_PROMPT_ICONS.get_width() / 2.0
	var icon_height := ACTION_PROMPT_ICONS.get_height() / 2.0
	var source := Rect2(icon_width * float(icon_index % 2), icon_height * float(int(icon_index / 2)), icon_width, icon_height)
	draw_texture_rect_region(ACTION_PROMPT_ICONS, Rect2(position, Vector2(22, 22)), source)

func draw_mark_seal(position: Vector2) -> void:
	if mark_level <= 0:
		return
	var seal_width := MARK_PROGRESSION_SEALS.get_width() / 3.0
	var seal_height := MARK_PROGRESSION_SEALS.get_height() / 3.0
	var seal_index := 5 if mark_level < 5 else 6 if mark_level < 9 else 7
	var source := Rect2(seal_width * float(seal_index % 3), seal_height * float(int(seal_index / 3)), seal_width, seal_height)
	draw_texture_rect_region(MARK_PROGRESSION_SEALS, Rect2(position, Vector2(30, 30)), source)

func draw_passive_mission_emblem(position: Vector2, mission_type: String) -> void:
	var emblem_index := -1
	match mission_type:
		"provisions":
			emblem_index = 0
		"flame":
			emblem_index = 1
		"route":
			emblem_index = 2
	if emblem_index < 0:
		return
	var emblem_width := PASSIVE_MISSION_EMBLEMS.get_width() / 3.0
	var source := Rect2(emblem_width * float(emblem_index), 0, emblem_width, PASSIVE_MISSION_EMBLEMS.get_height())
	draw_texture_rect_region(PASSIVE_MISSION_EMBLEMS, Rect2(position, Vector2(22, 22)), source)

# Placeholder shell: no H-02 art, dialogue, or story text until H-02 is approved for runtime.
func draw_shar_shell() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color("07050f"))
	draw_string(ThemeDB.fallback_font, Vector2(0, 660), "E / top face: continue   ·   Esc / Start: skip", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 17, Color("e3c5ff"))

func draw_boss_camp_action() -> void:
	var panel := Rect2(24, 132, 420, 58)
	draw_rect(panel, Color(0.035, 0.04, 0.1, 0.84))
	draw_rect(panel, Color("b79857"), false, 1.5)
	draw_string(ThemeDB.fallback_font, panel.position + Vector2(14, 22), "CAMP ACTION: FACE THE ANTLERED HUNGER", HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color("f8dc8c"))
	draw_string(ThemeDB.fallback_font, panel.position + Vector2(14, 44), "At the Wagon, press F / left shoulder to begin.", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("d8c9aa"))

# Placeholder shell: no comic art or story text until H-01 is approved for runtime.
func draw_opening() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color("0b0814"))
	draw_string(ThemeDB.fallback_font, Vector2(0, 300), "THE FIRST NINE", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 42, Color("f8dc8c"))
	draw_string(ThemeDB.fallback_font, Vector2(0, 660), "E / click: continue   ·   Esc / Start: skip", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 17, Color("e3c5ff"))

func draw_wheel_kit_recipe() -> void:
	var panel := Rect2(24, 132, 420, 58)
	draw_rect(panel, Color(0.035, 0.04, 0.1, 0.84))
	draw_rect(panel, Color("b79857"), false, 1.5)
	draw_string(ThemeDB.fallback_font, panel.position + Vector2(14, 22), "WHEEL KIT RECIPE", HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color("f8dc8c"))
	draw_string(ThemeDB.fallback_font, panel.position + Vector2(14, 44), "IN WAGON STOCK:  WOOD %d/1  ·  ROPE %d/1  ·  SALVAGE %d/1" % [mini(stock_count("wood"), 1), mini(stock_count("rope"), 1), mini(stock_count("salvage"), 1)], HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("d8c9aa"))

func draw_nightfall_banner() -> void:
	draw_rect(Rect2(0, 250, VIEW.x, 120), Color(0.02, 0.02, 0.08, 0.82))
	draw_string(ThemeDB.fallback_font, Vector2(0, 302), "NIGHT FALLS ON THE CAVE CAMP", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 34, Color("f2c879"))
	draw_string(ThemeDB.fallback_font, Vector2(0, 344), "Briar Hounds and Stags of Mire are coming. Defend the Wagon.", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 19, Color("ece5d5"))

func draw_end_card(won: bool) -> void:
	var backdrop: Texture2D = SHADOW_CROWN_KEY_ART if won else LAST_CAMP_KEY_ART
	draw_texture_rect(backdrop, Rect2(Vector2.ZERO, VIEW), false)
	draw_rect(Rect2(0, 0, VIEW.x, VIEW.y), Color(0.03, 0.02, 0.09, 0.64))
	var title := "THE GOLDEN CITY OF DREAMS" if won else "THE CAMP FALLS"
	var subtitle := "The First Nine cross together, their old memories gone. A home may yet be dreamed." if won else "No one is lost forever. Press E to return to your checkpoint."
	draw_string(ThemeDB.fallback_font, Vector2(0, 288), title, HORIZONTAL_ALIGNMENT_CENTER, 1280, 42, Color("f8d67d") if won else Color("a7b0cc"))
	draw_string(ThemeDB.fallback_font, Vector2(100, 336), subtitle, HORIZONTAL_ALIGNMENT_CENTER, 1080, 21, Color("ece5d5"))
	draw_string(ThemeDB.fallback_font, Vector2(0, 418), "Press E to continue", HORIZONTAL_ALIGNMENT_CENTER, 1280, 20, Color("f6efdc"))

func draw_thornwake_complete() -> void:
	draw_rect(Rect2(0, 0, VIEW.x, VIEW.y), Color(0.02, 0.03, 0.08, 0.76))
	draw_string(ThemeDB.fallback_font, Vector2(0, 276), "THORNWAKE COMPLETE", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 42, Color("f8d67d"))
	draw_string(ThemeDB.fallback_font, Vector2(125, 328), "The first drow wakes. The Wagon can now climb toward Stonehook Mountains.", HORIZONTAL_ALIGNMENT_CENTER, 1030, 21, Color("f2e9dc"))
	draw_string(ThemeDB.fallback_font, Vector2(125, 366), "Press E to travel to Stonehook Mountains.", HORIZONTAL_ALIGNMENT_CENTER, 1030, 18, Color("d9c5ee"))

func draw_stonehook_complete() -> void:
	draw_rect(Rect2(0, 0, VIEW.x, VIEW.y), Color(0.025, 0.035, 0.07, 0.78))
	draw_string(ThemeDB.fallback_font, Vector2(0, 276), "STONEHOOK COMPLETE", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 42, Color("f8d67d"))
	draw_string(ThemeDB.fallback_font, Vector2(125, 328), "The second drow wakes. The Wagon descends toward Hollowroot Caverns.", HORIZONTAL_ALIGNMENT_CENTER, 1030, 21, Color("f2e9dc"))
	draw_string(ThemeDB.fallback_font, Vector2(125, 366), "Hollowroot is the next chapter of The First Nine.", HORIZONTAL_ALIGNMENT_CENTER, 1030, 18, Color("d9c5ee"))

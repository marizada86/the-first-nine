extends Node2D

const VIEW := Vector2(1280, 720)
const CARAVAN_X := 190.0
const GROUND_Y := 555.0
const PLAYER_RADIUS := 19.0
const INTERACT_RADIUS := 56.0
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
const ANTLERED_HUNGER_HEALTH := 8
const BOSS_LUNGE_RANGE := 190.0
const BOSS_WINDUP := 0.8
const BOSS_LUNGE_SPEED := 360.0
const BOSS_LUNGE_TIME := 0.45
const BOSS_RECOVER := 1.0
const BOSS_WAGON_WINDUP := 1.2
const BOSS_WAGON_CHARGE_SPEED := 260.0
const BOSS_WAGON_CHARGE_TIME := 3.5
const BOSS_WAGON_DAMAGE := 15.0
const FIRST_THREAD_RANGE := 150.0
const FIRST_THREAD_DAMAGE := 2
const FIRST_THREAD_COOLDOWN := 1.2
# In Thornwake, progression stops at Mark I. Mark II and later belong to later batches.
const THORNWAKE_MARK_CAP := 1
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
var checkpoint := {"mark": 0, "zone": 0, "flame": 100.0, "provisions": 4.0, "awakened": 0, "final_echo_phase": false, "wagon_repair": 0, "load": [], "stock": [], "wagon_integrity": 100.0, "clock": DAY_DURATION, "echoes": 0, "cured": [], "posts": [], "downed": [], "first_night": false, "axle_brakes": false, "stonehook_boss": false, "stonehook_shar": false, "brazier": false, "crafted": {}}

func _ready() -> void:
	setup_input_actions()
	start_new_run()
	queue_redraw()
	if "--self-test" in OS.get_cmdline_user_args():
		call_deferred("run_self_test")

func setup_input_actions() -> void:
	add_joy_motion_action("move_left", JOY_AXIS_LEFT_X, -1.0)
	add_joy_button_action("move_left", JOY_BUTTON_DPAD_LEFT)
	add_joy_motion_action("move_right", JOY_AXIS_LEFT_X, 1.0)
	add_joy_button_action("move_right", JOY_BUTTON_DPAD_RIGHT)
	add_key_action("primary", KEY_E)
	add_mouse_action("primary", MOUSE_BUTTON_LEFT)
	add_joy_button_action("primary", JOY_BUTTON_X)
	add_key_action("jump", KEY_SPACE)
	add_joy_button_action("jump", JOY_BUTTON_A)
	add_key_action("shadow_action", KEY_SHIFT)
	add_mouse_action("shadow_action", MOUSE_BUTTON_RIGHT)
	add_joy_motion_action("shadow_action", JOY_AXIS_TRIGGER_RIGHT, 1.0)
	add_key_action("camp_menu", KEY_M)
	add_joy_button_action("camp_menu", JOY_BUTTON_BACK)
	add_key_action("post_cycle", KEY_Q)
	add_joy_button_action("post_cycle", JOY_BUTTON_Y)
	add_key_action("post_toggle", KEY_R)
	add_joy_button_action("post_toggle", JOY_BUTTON_RIGHT_SHOULDER)
	add_key_action("skip", KEY_ESCAPE)
	add_joy_button_action("skip", JOY_BUTTON_START)
	add_key_action("camp_action", KEY_F)
	add_joy_button_action("camp_action", JOY_BUTTON_LEFT_SHOULDER)
	add_key_action("shadow_strike", KEY_C)
	add_joy_button_action("shadow_strike", JOY_BUTTON_B)

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
	var controls_bound := InputMap.action_get_events("move_left").size() >= 4 and InputMap.action_get_events("move_right").size() >= 4 and InputMap.action_get_events("primary").size() >= 3 and InputMap.action_get_events("jump").size() >= 2 and InputMap.action_get_events("shadow_action").size() >= 3 and InputMap.action_get_events("post_cycle").size() >= 2 and InputMap.action_get_events("skip").size() >= 2 and InputMap.action_get_events("camp_action").size() >= 2 and InputMap.action_get_events("shadow_strike").size() >= 2
	var opening_cave_ready := run_opening_cave_self_test()
	var thornwake_tutorial_ready := run_thornwake_tutorial_self_test()
	var first_boss_ready := run_first_boss_self_test()
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
	handle_primary()
	handle_primary()
	handle_primary()
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
	if controls_bound and opening_cave_ready and thornwake_tutorial_ready and first_boss_ready and wagon_failure and first_wave_ready and second_wave_ready and combo_works and stock_capacity and cataplasm_works and wheel_kit_works and brazier_works and dodge_works and cure_prompted and chosen_ally_helps and drow_returns and checkpoint_restored and tutorial_never_starts_shar and first_cure_stays_at_cave and first_cure_travel_blocked and first_mark_not_repeated and direct_entry_blocked and mountain_enemies_ready and scree_works and axle_brakes_work and stone_maw_ready and rope_route_works and second_cure_prompted and hollowroot_ready and hollowroot_enemies_ready and third_cure_prompted and web_anchor_works and hollowroot_checkpoint:
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
	var only_lolth_controllable: bool = camp.controllable == ["LOLTH"]
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
	handle_primary()
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
	handle_primary()
	handle_primary()
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
		handle_primary()
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
	handle_primary()
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
	handle_primary()
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
		print("SELF_TEST_B03_PASS: camp action starts a telegraphed Antlered Hunger; victory reaches the Shar shell, Mark I, and exactly one cure with capped Echoes and a locked wagon (%d melee hits)" % hits)
	else:
		push_error("SELF_TEST_B03_FAIL: start=%s/%s/%s/%s boss=%s lunge=%s/%s charge=%s/%s reset=%s victory=%s shell=%s/%s mark=%s/%s choices=%s echoes=%s/%s cure=%s/%s wagon=%s travel=%s echo=%s/%s thread=%s/%s melee=%s dodge=%s restore=%s premark=%s replay=%s/%s" % [no_boss_before_safe_camp, safe_camp_reached, boss_not_automatic, needs_wagon, only_boss, lunge_telegraphed, lunge_hits_after_windup, wagon_charge_telegraphed, charge_hits_after_windup, boss_failure_reset, boss_defeated_by_melee, shell_advances, shell_skipped, mark_once, lolth_drow, eight_choices, echoes_zero_before_cure, no_echo_before_cure, one_cure, no_second_cure, wagon_held, travel_blocked, echoes_after_cure, echoes_capped, thread_hits, thread_cooldown, melee_still_works, dodge_still_works, marked_restore, no_thread_before_mark, new_run_reaches_shell, full_shell_applies_mark])
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
		"controllable": ["LOLTH"],
		"wagon": {"open": true, "horse": false, "beds": false, "enclosed_rooms": false, "condition": wagon_condition(), "travel": "travel_locked" if wagon_travel_locked() else "travel_ready", "repair": wagon_repair, "integrity": wagon_integrity},
		"relics": {"present": true, "protected": true},
		"fire": flame,
		"stock": wagon_stock.size(),
		"allies": ally_records(),
	}

func spawn_zone() -> void:
	player = Vector2(330, GROUND_Y - 38)
	velocity = Vector2.ZERO
	on_floor = true
	ally_assists_used.clear()
	salvage.clear()
	shades.clear()
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
		salvage.append({"pos": Vector2(470, 432), "name": "HERBS", "type": "herb", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(610, 362), "name": "WATER", "type": "water", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(760, 362), "name": "WOOD", "type": "wood", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(835, 420), "name": "DRY BRANCHES", "type": "wood", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(920, 417), "name": "ROPE", "type": "rope", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(1060, 417), "name": "WHEEL SALVAGE", "type": "salvage", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(1105, 417), "name": "BRAZIER SALVAGE", "type": "salvage", "slots": 1, "taken": false, "renewable": true})
		salvage.append({"pos": Vector2(1110, GROUND_Y - 34), "name": "KINDLING", "type": "kindling", "slots": 1, "taken": false, "renewable": true})
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

func _process(delta: float) -> void:
	pulse += delta
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
	if Input.is_action_just_pressed("primary"):
		handle_primary()
	if Input.is_action_just_pressed("shadow_action"):
		use_shadow_action(direction)
	if Input.is_action_just_pressed("shadow_strike"):
		use_first_thread()
	if Input.is_action_just_pressed("camp_action"):
		use_camp_action()
	if Input.is_action_just_pressed("camp_menu"):
		open_camp_menu()
	if Input.is_action_just_pressed("post_cycle"):
		cycle_post_ally()
	if Input.is_action_just_pressed("post_toggle"):
		toggle_selected_post()
	update_wagon_threat(delta)
	update_enemies(delta)
	update_night_waves(delta)
	update_zone_hazards()
	check_enemy_contact()
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
	player.x = clampf(player.x + velocity.x * delta, 42.0, VIEW.x - 42.0)
	player.y += velocity.y * delta
	on_floor = false
	var floor_y := GROUND_Y - 38.0
	if player.y >= floor_y:
		player.y = floor_y
		velocity.y = 0.0
		on_floor = true
	if player.y > VIEW.y + 80.0:
		fail_run("Lolth fell into the ruins.")

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
	message = "Lolth is wounded."
	message_time = 1.5
	if health <= 0.0:
		fail_run("Lolth could not return to the Caravan.")

func use_shadow_action(direction: float) -> void:
	if mark_level < 5:
		perform_dodge(direction)
		return
	if ally_is_near("LURAEN") and not bool(ally_assists_used.get("luraen", false)):
		ally_assists_used.luraen = true
		echo_sense_time = 6.0
		trigger_mark_vfx("sense", player + Vector2(0, -96))
		message = "LURAEN reveals the path between waking and dream."
		message_time = 2.0
		return
	if mark_level >= 7:
		for gate in mark_gates:
			if not gate.opened and int(gate.mark) == 7 and player.distance_to(gate.pos) < 110.0:
				gate.opened = true
				trigger_mark_vfx("gate", gate.pos)
				message = "SPIDER'S PROMISE anchors a path through the ruins."
				message_time = 2.0
				return
	if mark_level >= 5:
		echo_sense_time = 3.0
		trigger_mark_vfx("sense", player + Vector2(0, -96))
		message = "NIGHT CHOIR reveals echoes and hidden routes."
		message_time = 2.0
		return
	perform_dodge(direction)

func perform_dodge(direction: float) -> void:
	if dodge_cooldown > 0.0:
		message = "Lolth needs a moment before dodging again."
		message_time = 0.7
		return
	var dodge_direction := direction if absf(direction) > 0.1 else -1.0 if player_facing_left else 1.0
	player_facing_left = dodge_direction < 0.0
	velocity.x = dodge_direction * DASH_SPEED * 0.78
	dodge_time = DODGE_DURATION
	dodge_cooldown = DODGE_COOLDOWN
	hurt_cooldown = DODGE_DURATION
	trigger_mark_vfx("dodge", player + Vector2(0, -72))
	message = "LOLTH DODGES"
	message_time = 0.7

func handle_primary() -> void:
	if zone == 2 and mark_level == 9 and absf(player.x - PORTAL_X) < 90.0:
		state = "victory"
		message = "Their old memories are gone. Lolth leaves the Kiss of Shar with the First Nine."
		return
	for shade in shades:
		if not shade.defeated and player.distance_to(shade.pos) < INTERACT_RADIUS:
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
				message = "Lolth binds a solid web floor across the Web Anchor."
			else:
				message = "%s yields to Lolth's Mark." % gate.name
			message_time = 2.5
			return
	if player.x < 305.0:
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
				message = "%s secured in RECOVERED LOAD." % item.name
				message_time = 2.5
			return
	message = "Stand near a resource, enemy, or the Wagon and press the primary action."
	message_time = 2.0

func defeat_enemy(shade: Dictionary) -> void:
	shade.defeated = true
	shade.defeated_at = pulse
	if mark_level > 0:
		collect_echo(int(shade.echoes))
	message = "%s falls. Lolth absorbs its shadow." % shade.name
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
		message = "Lolth has no shadow strike yet."
		message_time = 1.5
		return
	if first_thread_cooldown > 0.0:
		return
	var target: Dictionary = {}
	var best_distance := FIRST_THREAD_RANGE
	for shade in shades:
		var distance := player.distance_to(shade.pos)
		if not shade.defeated and distance <= best_distance:
			target = shade
			best_distance = distance
	if target.is_empty():
		message = "FIRST THREAD finds no target in range."
		message_time = 1.2
		return
	first_thread_cooldown = FIRST_THREAD_COOLDOWN
	player_facing_left = float(target.pos.x) < player.x
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
		message = "AELIRA finds enough for the group while Lolth gathers supplies."
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
	if player.x >= 305.0:
		message = "Return to the Wagon to manage supplies and crafting."
		message_time = 2.0
		return
	if not recovered_load.is_empty():
		selected_load = (selected_load + 1) % recovered_load.size()
		message = "Selected load: %s. Press primary action to store it." % recovered_load[selected_load].name
		message_time = 2.5
	elif zone == 0 and mark_level == 0 and tutorial_phase == "day_salvage":
		selected_recipe = WHEEL_KIT_RECIPE
		message = "Recipe: WHEEL KIT — %s from Wagon stock. Press primary action to craft." % recipe_label(RECIPES[WHEEL_KIT_RECIPE])
		message_time = 3.5
	else:
		selected_recipe = (selected_recipe + 1) % RECIPES.size()
		var recipe: Dictionary = RECIPES[selected_recipe]
		message = "Recipe: %s — %s. Press primary action to craft." % [recipe.name, recipe.description]
		message_time = 3.5

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
	mark_level += 1
	health = max_health()
	if mark_level <= 8:
		state = "cure"
		selected_cure = 0
		message = "%s — Choose a Thalestriel to cure." % MARK_NAMES[mark_level]
	else:
		message = "SHADOW CROWN — Shar takes the First Drows' memories as Lolth becomes a vast shadow spider."
	create_checkpoint()
	message_time = 4.5

func create_checkpoint() -> void:
	checkpoint = {"mark": mark_level, "zone": zone, "flame": flame, "provisions": provisions, "awakened": awakened, "final_echo_phase": final_echo_phase, "wagon_repair": wagon_repair, "load": recovered_load.duplicate(true), "stock": wagon_stock.duplicate(true), "wagon_integrity": wagon_integrity, "clock": clock_seconds, "echoes": shadow_echoes, "cured": cured_allies.duplicate(), "posts": posted_allies.duplicate(), "downed": downed_drows.duplicate(), "first_night": first_night_complete, "axle_brakes": axle_brakes_installed, "stonehook_boss": stonehook_boss_defeated, "stonehook_shar": stonehook_shar_ready, "hollowroot_boss": hollowroot_boss_defeated, "hollowroot_mark": hollowroot_mark_ready, "hollowroot_web": hollowroot_web_anchor_open, "brazier": brazier_built, "crafted": crafted_recipes.duplicate(true)}

func fail_run(reason: String) -> void:
	if state != "journey":
		return
	state = "defeat"
	message = "%s Checkpoint: %s." % [reason, checkpoint_label()]

func checkpoint_label() -> String:
	return "PROLOGUE" if int(checkpoint.mark) == 0 else MARK_NAMES[int(checkpoint.mark)]

func restart_from_checkpoint() -> void:
	if int(checkpoint.mark) == 0:
		reset_to_prologue()
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
	message = "Restored at %s. The Wagon holds." % checkpoint_label()
	message_time = 4.0

func reset_to_prologue() -> void:
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
	shades.append({"pos": position, "name": enemy_name, "health": enemy_health, "max_health": enemy_health, "echoes": echoes, "behavior": behavior, "wagon_hit_cooldown": 0.0, "attack_state": "approach", "attack_time": 0.0, "attack_dir": 0.0, "attack_count": 0, "attack_target": "lolth", "defeated": false, "defeated_at": -1.0})

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
		enemy.pos.x = clampf(float(enemy.pos.x) + direction * speed * delta, 70.0, VIEW.x - 70.0)
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
	enemy.pos.x = clampf(float(enemy.pos.x) + direction * speed * delta, 70.0, VIEW.x - 70.0)

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
			message = "Lolth climbs the rope route above the scree."
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
	if player.x >= 305.0:
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
		message = "%s wakes as a drow. The Wagon stays at the cave camp." % ally
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
	if player.x >= 305.0:
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
	if player.x >= 305.0 or cured_allies.is_empty():
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
	if player.x >= 305.0:
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
	draw_mark_vfx()
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
		var night_alpha := 0.56 if is_night() else 0.08
		if tutorial_phase == "dusk" and mark_level == 0:
			night_alpha = lerpf(0.08, 0.56, 1.0 - dusk_time / DUSK_DURATION)
		draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0.035, 0.07, 0.16, night_alpha))
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
	draw_rect(Rect2(0, GROUND_Y, VIEW.x, VIEW.y - GROUND_Y), Color("0c1123"))
	if zone == 0:
		draw_texture_rect(THORNWAKE_CONTINUOUS_GROUND, Rect2(0, GROUND_Y - 4, VIEW.x, VIEW.y - GROUND_Y + 4), false)
	else:
		var ground_panel_width := ZONE_GROUND_BANDS_RUNTIME.get_width() / 3.0
		var ground_source := Rect2(ground_panel_width * float(zone), 350, ground_panel_width, 443)
		draw_texture_rect_region(ZONE_GROUND_BANDS_RUNTIME, Rect2(0, GROUND_Y, VIEW.x, VIEW.y - GROUND_Y), ground_source)
	draw_line(Vector2(0, GROUND_Y), Vector2(VIEW.x, GROUND_Y), Color("b79857"), 2.0)
	for i in 30:
		var x := float(i * 48)
		draw_line(Vector2(x, GROUND_Y + 28), Vector2(x + 22, GROUND_Y + 35), Color("272846"), 2.0)

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

func draw_shades() -> void:
	for shade in shades:
		var p: Vector2 = shade.pos
		var sheet: Texture2D = BRIAR_HOUND_RUNTIME
		if zone == 1:
			sheet = STONEHOOK_THREATS_RUNTIME
		elif zone == 2:
			sheet = LATER_REGION_THREATS_RUNTIME
		elif String(shade.name) == "STAG OF MIRE":
			sheet = STAG_OF_MIRE_RUNTIME
		elif String(shade.name) == "ANTLERED HUNGER":
			sheet = ANTLERED_HUNGER_RUNTIME
		var source_columns := 3.0 if zone == 2 else 2.0
		var source_width := sheet.get_width() / source_columns
		var source_height := sheet.get_height() / 2.0
		var source := Rect2(0, 0, 0, 0)
		if shade.defeated:
			if pulse - shade.defeated_at > 0.42:
				continue
			source = Rect2(source_width, source_height, source_width, source_height)
		elif zone == 1:
			var stone_index := 0 if String(shade.name) == "Scree Crawler" else 1 if String(shade.name) == "Cliff Harrier" else 3
			source = Rect2(source_width * float(stone_index % 2), source_height * float(int(stone_index / 2)), source_width, source_height)
		elif zone == 2:
			var later_index := 3 if String(shade.name) == "ROOT CROWN" else 0
			source = Rect2(source_width * float(later_index % 3), source_height * float(int(later_index / 3)), source_width, source_height)
		elif player.distance_to(p) < 150.0:
			source = Rect2(0, source_height, source_width, source_height)
		else:
			var hover_frame := int(floor(pulse * 4.0)) % 2
			source = Rect2(source_width * float(hover_frame), 0, source_width, source_height)
		if String(shade.name) == "ANTLERED HUNGER":
			draw_texture_rect_region(sheet, Rect2(p.x - 80, p.y - 150, 160, 160), source)
		else:
			draw_texture_rect_region(sheet, Rect2(p.x - 48, p.y - 92, 96, 96), source)
		if not shade.defeated:
			var label_width := 180.0 if String(shade.name) == "ANTLERED HUNGER" else 100.0
			draw_string(ThemeDB.fallback_font, p + Vector2(-label_width / 2.0, -43), String(shade.name), HORIZONTAL_ALIGNMENT_CENTER, label_width, 12, Color("dfb8f4"))
			if String(shade.get("behavior", "")) == "charge" and is_night() and zone == 0:
				draw_string(ThemeDB.fallback_font, p + Vector2(-50, -58), "WAGON RUNNER", HORIZONTAL_ALIGNMENT_CENTER, 100, 10, Color("f3bc75"))
			var enemy_health := float(int(shade.health)) / float(int(shade.get("max_health", shade.health))) * 100.0
			draw_rect(Rect2(p.x - 34, p.y - 33, 68, 5), Color("27182e"))
			draw_rect(Rect2(p.x - 34, p.y - 33, 68 * enemy_health / 100.0, 5), Color("db7587"))

# Drawn above the camp so a charge toward the Wagon stays readable.
func draw_attack_telegraphs() -> void:
	if zone != 0:
		return
	for shade in shades:
		if not shade.defeated and String(shade.get("attack_state", "")) == "windup":
			draw_attack_telegraph(shade)

func draw_attack_telegraph(shade: Dictionary) -> void:
	var p: Vector2 = shade.pos
	var warning := Color(1.0, 0.42, 0.25, 0.7 + 0.3 * sin(pulse * 18.0))
	if String(shade.get("attack_target", "lolth")) == "wagon":
		draw_line(p + Vector2(0, -20), Vector2(CARAVAN_X, GROUND_Y - 40), warning, 4.0)
		draw_string(ThemeDB.fallback_font, p + Vector2(-50, -112), "CHARGE!", HORIZONTAL_ALIGNMENT_CENTER, 100, 16, warning)
	else:
		draw_string(ThemeDB.fallback_font, p + Vector2(-50, -112), "!", HORIZONTAL_ALIGNMENT_CENTER, 100, 24, warning)
	draw_arc(p + Vector2(0, -40), 46.0, 0.0, TAU, 32, warning, 3.0)

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

func draw_player() -> void:
	var pose_sheet: Texture2D = LOLTH_ELF_RUNTIME if lolth_form() == "elf" else LOLTH_DROW_RUNTIME
	var pose_index := 0
	if mark_vfx_time > 0.0 and mark_vfx_kind == "strike":
		pose_index = 3
	elif mark_vfx_time > 0.0 and mark_vfx_kind == "dash":
		pose_index = 4
	elif mark_vfx_time > 0.0 and mark_vfx_kind == "collect":
		pose_index = 5
	elif not on_floor:
		pose_index = 6 if velocity.y <= 80.0 else 7
	elif hurt_cooldown > 0.0:
		pose_index = 8
	elif absf(velocity.x) > 40.0:
		pose_index = 1 if int(floor(pulse * 8.0)) % 2 == 0 else 2
	var pose_width := pose_sheet.get_width() / 3.0
	var pose_height := pose_sheet.get_height() / 3.0
	var pose_source := Rect2(pose_width * float(pose_index % 3), pose_height * float(int(pose_index / 3)), pose_width, pose_height)
	draw_player_sprite(pose_sheet, pose_source)
	draw_string(ThemeDB.fallback_font, player + Vector2(-58, -174), "LOLTH", HORIZONTAL_ALIGNMENT_CENTER, 116, 13, Color("fff0b0"))
	if hurt_cooldown > 0.0:
		draw_circle(player + Vector2(0, -62), 58, Color(0.85, 0.25, 0.45, 0.18))

func draw_player_sprite(sheet: Texture2D, source: Rect2, height: float = PLAYER_SPRITE_HEIGHT, feet_ratio: float = 1.0) -> void:
	var width := height * source.size.x / source.size.y
	var destination := Rect2(player.x - width / 2.0, player.y + PLAYER_FEET_OFFSET - height * feet_ratio, width, height)
	if player_facing_left:
		draw_set_transform(Vector2(player.x * 2.0, 0.0), 0.0, Vector2(-1.0, 1.0))
		draw_texture_rect_region(sheet, destination, source)
		draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
		return
	draw_texture_rect_region(sheet, destination, source)

func draw_foreground_overlay() -> void:
	if zone == 0:
		draw_texture_rect(ASHEN_WAY_FOREGROUND_OVERLAY, Rect2(Vector2.ZERO, VIEW), false)
		return
	var panel_width := RUINS_FOREGROUND_OVERLAYS.get_width() / 2.0
	var source := Rect2(panel_width * float(zone - 1), 0, panel_width, RUINS_FOREGROUND_OVERLAYS.get_height())
	draw_texture_rect_region(RUINS_FOREGROUND_OVERLAYS, Rect2(Vector2.ZERO, VIEW), source)

func draw_mark_vfx() -> void:
	if mark_vfx_time <= 0.0:
		return
	var alpha := clampf(mark_vfx_time / 0.42, 0.0, 1.0)
	var cell_width := SHADOW_ACTIONS_VFX.get_width() / 2.0
	var cell_height := SHADOW_ACTIONS_VFX.get_height() / 2.0
	var cell_index := 0
	var size := Vector2(132, 106)
	if mark_vfx_kind == "dash":
		cell_index = 2
		size = Vector2(154, 84)
	elif mark_vfx_kind == "sense" or mark_vfx_kind == "gate":
		cell_index = 3
		size = Vector2(170, 124)
	elif mark_vfx_kind == "collect":
		cell_index = 1
		size = Vector2(96, 74)
	var source := Rect2(cell_width * float(cell_index % 2), cell_height * float(int(cell_index / 2)), cell_width, cell_height)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	draw_texture_rect_region(SHADOW_ACTIONS_VFX, Rect2(mark_vfx_pos - size / 2.0, size), source, Color(1, 1, 1, alpha))

func draw_hud() -> void:
	draw_rect(Rect2(24, 22, 1232, 102), Color(0.035, 0.04, 0.1, 0.84))
	draw_string(ThemeDB.fallback_font, Vector2(48, 54), "THE FIRST NINE", HORIZONTAL_ALIGNMENT_LEFT, -1, 25, Color("f8dc8c"))
	draw_string(ThemeDB.fallback_font, Vector2(48, 82), "%s  ·  %s  ·  Objective: %s" % [ZONE_NAMES[zone], clock_label(), current_objective()], HORIZONTAL_ALIGNMENT_LEFT, -1, 17, Color("ddd6e8"))
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
	draw_string(ThemeDB.fallback_font, Vector2(46, 648), "MOVE: A/D or stick  ·  JUMP: Space / bottom button  ·  PRIMARY: E / click / left face  ·  DODGE: Shift / right click / trigger" + ("  ·  FIRST THREAD: C / right face" if mark_level >= 1 else ""), HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("d9d1e1"))
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
	draw_string(ThemeDB.fallback_font, Vector2(0, 600), "A/D or stick: choose   ·   E / click: cure", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 18, Color("fff2df"))

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
	draw_string(ThemeDB.fallback_font, Vector2(0, 660), "E / click: continue   ·   Esc / Start: skip", HORIZONTAL_ALIGNMENT_CENTER, VIEW.x, 17, Color("e3c5ff"))

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

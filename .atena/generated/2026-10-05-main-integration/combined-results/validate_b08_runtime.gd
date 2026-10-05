extends SceneTree
# B-08 rendered checks at 1280x720 without fixed FPS, with real input. A D walk crosses into the
# foothills and past x=2600, where exactly one Cliff Harrier appears beside the Scree Crawler.
# Left-click, C, Shift, A/D and the F4 panel buttons then exercise grounded hit/miss, locked-aim
# windups, dashes, single-hit dives, a retreat, simultaneous combat, independent ore handling,
# F4 exact restoration and the credited defeats; a controller section follows. Frozen captures
# cover day/night in both facings, windup, dive, recovery, hit, miss, retreat and both actors.
#
# Keyboard-only isolation: right after the game's _ready defines the production bindings and
# before its first processed frame, this test process removes its joypad bindings from the
# InputMap (device settings and production thresholds are untouched). Synthetic 0.21 trigger
# and stick-drift noise is then sent separately. Bindings are restored for the controller section.

const RES_DIR := "res://.atena/generated/2026-10-05-b08-validation"
const SETTLE_TIMEOUT_MS := 3000
# Lolth's combat position: the Harrier hovers one reach to her right, the Scree Crawler is
# parked at its right bound (2770), far from every measured exchange.
const LOLTH_X := 2400.0
const CRAWLER_PARK_X := 2770.0
var game
var checks := 0
var failures := 0
var out_dir := RES_DIR
var metrics := {}
var suspended_joypad_events := {}
var first_spawn_x := -1.0
var spawned_early := false

func _initialize() -> void:
	if OS.get_environment("OUT") != "":
		out_dir = OS.get_environment("OUT")
	call_deferred("run")

func check(label: String, passed: bool) -> void:
	checks += 1
	print("B08RT %s %s" % ["PASS" if passed else "FAIL", label])
	if not passed:
		failures += 1

func key(code: Key, pressed: bool) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = code
	event.pressed = pressed
	Input.parse_input_event(event)

func tap(code: Key) -> void:
	key(code, true)
	await process_frame
	await process_frame
	key(code, false)
	await process_frame

func click(point: Vector2) -> void:
	for pressed in [true, false]:
		var event := InputEventMouseButton.new()
		event.position = point
		event.button_index = MOUSE_BUTTON_LEFT
		event.pressed = pressed
		Input.parse_input_event(event)
		await process_frame
		await process_frame

func joy_button(button: JoyButton) -> void:
	for pressed in [true, false]:
		var event := InputEventJoypadButton.new()
		event.button_index = button
		event.pressed = pressed
		Input.parse_input_event(event)
		await process_frame
		await process_frame

func trigger(value: float) -> void:
	var event := InputEventJoypadMotion.new()
	event.axis = JOY_AXIS_TRIGGER_RIGHT
	event.axis_value = value
	Input.parse_input_event(event)

func stick(value: float) -> void:
	var event := InputEventJoypadMotion.new()
	event.axis = JOY_AXIS_LEFT_X
	event.axis_value = value
	Input.parse_input_event(event)

func frames(count: int) -> void:
	for _frame in count:
		await process_frame

func capture() -> Image:
	game.queue_redraw()
	await process_frame
	await RenderingServer.frame_post_draw
	return root.get_texture().get_image()

func shot(name: String) -> Image:
	var image: Image = await capture()
	image.save_png(out_dir + "/" + name + ".png")
	return image

func floor_y() -> float:
	return game.GROUND_Y - game.PLAYER_FEET_OFFSET

func crawler() -> Dictionary:
	return game.scree_crawler

# --- Controller isolation -------------------------------------------------------------------

func suspend_joypad_bindings() -> void:
	for action in InputMap.get_actions():
		var removed: Array = suspended_joypad_events.get(action, [])
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadButton or event is InputEventJoypadMotion:
				removed.append(event)
				InputMap.action_erase_event(action, event)
		if not removed.is_empty():
			suspended_joypad_events[action] = removed
			Input.action_release(action)

func restore_joypad_bindings() -> void:
	for action in suspended_joypad_events:
		for event in suspended_joypad_events[action]:
			InputMap.action_add_event(action, event)
	suspended_joypad_events.clear()

func joypad_binding_counts() -> Dictionary:
	var counts := {}
	for action in InputMap.get_actions():
		var count := 0
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadButton or event is InputEventJoypadMotion:
				count += 1
		if count > 0:
			counts[action] = count
	return counts

func start_game() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	# _ready has run inside add_child; no frame has been processed yet.
	var added_frame := Engine.get_process_frames()
	metrics.joypad_bindings_before_suspension = joypad_binding_counts()
	var probe := InputEventJoypadMotion.new()
	probe.axis = JOY_AXIS_TRIGGER_RIGHT
	probe.axis_value = 0.21
	var matched_before := InputMap.event_is_action(probe, "shadow_action")
	var pulse_at_isolation: float = game.pulse
	var state_at_isolation := String(game.state)
	suspend_joypad_bindings()
	var isolated_frame := Engine.get_process_frames()
	var matched_after := InputMap.event_is_action(probe, "shadow_action")
	metrics.isolation = {"pulse": pulse_at_isolation, "state": state_at_isolation, "added_frame": added_frame, "isolated_frame": isolated_frame, "trigger_021_matched_before": matched_before, "trigger_021_matched_after": matched_after}
	check("controller isolation precedes the first gameplay frame (pulse %.3f, state %s, engine frame %d = %d)" % [pulse_at_isolation, state_at_isolation, isolated_frame, added_frame], pulse_at_isolation == 0.0 and state_at_isolation == "opening" and isolated_frame == added_frame and matched_before and not matched_after and not suspended_joypad_events.is_empty())
	var first_frame := -1
	for _frame in 10:
		await process_frame
		if float(game.pulse) > 0.0:
			first_frame = Engine.get_process_frames()
			break
	metrics.isolation.first_gameplay_frame = first_frame
	check("the game's first gameplay frame (engine frame %d) follows isolation (engine frame %d)" % [first_frame, isolated_frame], first_frame > isolated_frame)
	await tap(KEY_ESCAPE)
	await frames(2)

# Separate noise check: a resting 0.21 trigger and a drifting stick cannot act once isolated.
func noise_check() -> void:
	game.dodge_cooldown = 0.0
	game.dodge_time = 0.0
	var start_x: float = game.player.x
	var dashed := false
	var queued := false
	for _frame in 8:
		trigger(0.21)
		stick(0.35)
		await process_frame
		dashed = dashed or game.dodge_time > 0.0
		queued = queued or game.ui_gameplay_requests.has("shadow_action")
	trigger(0.0)
	stick(0.0)
	await frames(3)
	metrics.noise = {"dashed": dashed, "queued": queued, "moved": game.player.x - start_x}
	check("synthetic 0.21 trigger and 0.35 stick noise neither dash, queue nor move Lolth", game.state == "journey" and not dashed and not queued and is_equal_approx(game.player.x, start_x))

# --- Settled real movement ------------------------------------------------------------------

# Holds a movement key until the condition holds, releases it, then waits for zero velocity.
func hold_until(code: Key, done: Callable, timeout_seconds: float, on_frame := Callable()) -> Dictionary:
	var direction := 1.0 if code == KEY_D else -1.0
	var result := {"frames": 0, "settle_frames": 0, "monotonic": true, "regions": []}
	var last_x: float = game.player.x
	var started := Time.get_ticks_msec()
	key(code, true)
	while not done.call() and Time.get_ticks_msec() - started < int(timeout_seconds * 1000.0):
		await process_frame
		if on_frame.is_valid():
			on_frame.call()
		result.monotonic = bool(result.monotonic) and (game.player.x - last_x) * direction >= -0.001
		last_x = game.player.x
		result.frames = int(result.frames) + 1
		var region: String = game.lolth_region()
		if result.regions.is_empty() or String(result.regions.back()) != region:
			result.regions.append(region)
	key(code, false)
	var settle_started := Time.get_ticks_msec()
	while not is_zero_approx(game.velocity.x) and Time.get_ticks_msec() - settle_started < SETTLE_TIMEOUT_MS:
		await process_frame
		result.settle_frames = int(result.settle_frames) + 1
	result.settled = is_zero_approx(game.velocity.x)
	result.done = done.call() and bool(result.settled)
	print("B08RT_TRACE %s frames=%d settle_frames=%d settled=%s monotonic=%s x=%.1f" % [OS.get_keycode_string(code), int(result.frames), int(result.settle_frames), result.settled, result.monotonic, game.player.x])
	return result

# --- Fixture helpers (state placement only; every action below is real input) -------------

func hold_actor(actor_key: String, x: float, health_value: int, altitude := 0.0) -> void:
	var actor: Dictionary = game.get(actor_key)
	actor.pos = Vector2(x, game.GROUND_Y - 34.0 - altitude)
	actor.health = health_value
	actor.attack_state = "recover"
	actor.attack_time = 99.0
	actor.hit_flash = 0.0

func hold_crawler(x: float, health_value: int) -> void:
	hold_actor("scree_crawler", x, health_value)

func hold_harrier(x: float, health_value: int) -> void:
	hold_actor("cliff_harrier", x, health_value, game.CLIFF_HARRIER_HOVER)
	game.cliff_harrier.bob_time = 0.0

func arm_harrier(x: float, health_value: int) -> void:
	var harrier := harrier()
	harrier.pos = Vector2(x, game.GROUND_Y - 34.0 - game.CLIFF_HARRIER_HOVER)
	harrier.health = health_value
	harrier.attack_state = "approach"
	harrier.attack_time = 0.0
	harrier.strike_spent = false

func harrier() -> Dictionary:
	return game.cliff_harrier

func place_lolth(x: float) -> void:
	game.player = Vector2(x, floor_y())
	game.velocity = Vector2.ZERO
	game.snap_camera()

# --- Image measurements ---------------------------------------------------------------------

func pixel_delta(a: Image, b: Image, x: int, y: int) -> float:
	var c := a.get_pixel(x, y)
	var d := b.get_pixel(x, y)
	return (absf(c.r - d.r) + absf(c.g - d.g) + absf(c.b - d.b)) / 3.0

# Any visible change: 2/255 of mean channel difference. Dark sprite parts over a dark night
# floor stay detectable, so masks do not depend on the background behind each facing.
const CHANGE_THRESHOLD := 0.008

func changed_count(a: Image, b: Image, region: Rect2i, threshold := CHANGE_THRESHOLD) -> int:
	var count := 0
	region = region.intersection(Rect2i(0, 0, a.get_width(), a.get_height()))
	for y in range(region.position.y, region.end.y):
		for x in range(region.position.x, region.end.x):
			if pixel_delta(a, b, x, y) > threshold:
				count += 1
	return count

func changed_mask(a: Image, b: Image, region: Rect2i) -> Dictionary:
	var mask := {}
	region = region.intersection(Rect2i(0, 0, a.get_width(), a.get_height()))
	for y in range(region.position.y, region.end.y):
		for x in range(region.position.x, region.end.x):
			if pixel_delta(a, b, x, y) > CHANGE_THRESHOLD:
				mask[Vector2i(x, y)] = true
	return mask

func screen_rect(world: Rect2) -> Rect2i:
	return Rect2i(int(floor(world.position.x - game.camera_x)), int(floor(world.position.y)), int(ceil(world.size.x)), int(ceil(world.size.y)))

# Measures one frozen crawler view against the identical frame without the crawler.
func mirrored_overlap(left: Dictionary, right: Dictionary, center: float) -> float:
	var intersection := 0
	for point in right.mask:
		var mirrored := Vector2i(int(round(2.0 * center - point.x - 1.0)), point.y)
		if left.mask.has(mirrored) or left.mask.has(mirrored + Vector2i(1, 0)) or left.mask.has(mirrored - Vector2i(1, 0)):
			intersection += 1
	return float(intersection) / float(maxi(1, maxi(left.mask.size(), right.mask.size())))


# Measures one frozen Harrier view against the identical frame without it.
func measure_view(label: String) -> Dictionary:
	var with_harrier: Image = await shot("harrier-" + label)
	var saved := harrier()
	game.cliff_harrier = {}
	var without: Image = await capture()
	game.cliff_harrier = saved
	var geometry: Dictionary = game.enemy_draw_geometry(saved)
	var body: Rect2 = geometry.body
	var destination: Rect2 = geometry.destination
	var pos_x := float(saved.pos.x)
	if bool(saved.facing_left):
		destination = Rect2(2.0 * pos_x - destination.end.x, destination.position.y, destination.size.x, destination.size.y)
	var body_screen := screen_rect(body)
	var mask := changed_mask(with_harrier, without, body_screen.grow(2))
	var min_x := 99999
	var max_x := -1
	var max_y := -1
	for point in mask:
		min_x = mini(min_x, point.x)
		max_x = maxi(max_x, point.x)
		max_y = maxi(max_y, point.y)
	# Transparent cell padding on both sides of the body, kept 3 px clear of its alpha edge.
	var left_pad := screen_rect(Rect2(destination.position.x, body.position.y, body.position.x - destination.position.x - 3.0, body.size.y))
	var right_pad := screen_rect(Rect2(body.end.x + 3.0, body.position.y, destination.end.x - body.end.x - 3.0, body.size.y))
	var padding_changes := changed_count(with_harrier, without, left_pad) + changed_count(with_harrier, without, right_pad)
	var expected_center: float = pos_x - game.camera_x
	var expected_bottom: int = int(round(game.GROUND_Y - game.CLIFF_HARRIER_HOVER))
	var result := {
		"mask": mask,
		"body_fraction": float(mask.size()) / float(maxi(1, body_screen.size.x * body_screen.size.y)),
		"padding_pixels": left_pad.size.x * left_pad.size.y + right_pad.size.x * right_pad.size.y,
		"padding_changes": padding_changes,
		"center_offset": (min_x + max_x + 1) / 2.0 - expected_center,
		"lowest_row": max_y,
		"center_x": expected_center,
	}
	metrics["view_" + label] = {"body_fraction": result.body_fraction, "padding_pixels": result.padding_pixels, "padding_changes": padding_changes, "center_offset": result.center_offset, "lowest_row": max_y, "expected_bottom": expected_bottom, "camera_x": game.camera_x}
	check("%s: Harrier body visible (%.2f of body box), claws hover at row %d (expected %d), centered on its world x under a %.0f px view (%.1f px), clean padding (%d of %d pixels changed)" % [label, result.body_fraction, max_y, expected_bottom, game.camera_x, result.center_offset, padding_changes, result.padding_pixels], result.body_fraction > 0.15 and absi(max_y - expected_bottom) <= 3 and absf(result.center_offset) <= 5.0 and result.padding_pixels > 200 and padding_changes == 0)
	return result

# --- Sections -------------------------------------------------------------------------------

func note_spawn() -> void:
	if not harrier().is_empty() and first_spawn_x < 0.0:
		first_spawn_x = game.player.x
		spawned_early = game.player.x < game.CLIFF_HARRIER_ACTIVATION_X - 4.0

func enter_foothills() -> void:
	game.reach_expedition_ready_for_test(true, true)
	game.clock_seconds = 10.0
	await frames(2)
	check("fixture: legitimate first cure and safe return; no actor yet", game.expedition_departure_allowed() and crawler().is_empty() and harrier().is_empty())
	var walk := await hold_until(KEY_D, func(): return game.player.x >= 1900.0, 20.0)
	var found_crawler: bool = not crawler().is_empty() and String(crawler().encounter_id) == game.SCREE_CRAWLER_ID
	hold_crawler(CRAWLER_PARK_X, 3)
	check("real D walk into the foothills creates the crawler but no Harrier before x=2600", bool(walk.done) and found_crawler and harrier().is_empty() and not game.harrier_activated)
	var onward := await hold_until(KEY_D, func(): return game.player.x >= 2630.0, 20.0, note_spawn)
	var h := harrier()
	var one_harrier: bool = game.live_cliff_harrier_count() == 1 and game.shades.is_empty() and game.live_scree_crawler_count() == 1
	metrics.activation = {"first_spawn_player_x": first_spawn_x, "spawned_early": spawned_early}
	check("real D walk activates exactly one Cliff Harrier on first reaching x>=2600 (spawn at Lolth x=%.1f)" % first_spawn_x, bool(onward.done) and bool(onward.monotonic) and not h.is_empty() and String(h.encounter_id) == game.CLIFF_HARRIER_ID and not spawned_early and first_spawn_x >= game.CLIFF_HARRIER_ACTIVATION_X - 4.0 and one_harrier and game.harrier_activated)
	hold_harrier(game.CLIFF_HARRIER_HOME_X, 3)
	hold_crawler(CRAWLER_PARK_X, 3)

func frozen_views() -> void:
	game.set_process(false)
	var stashed_crawler: Dictionary = game.scree_crawler
	game.scree_crawler = {}
	var saved_clock: float = game.clock_seconds
	var views := {}
	for night in [false, true]:
		game.clock_seconds = game.DAY_DURATION + 10.0 if night else 10.0
		for facing_left in [false, true]:
			place_lolth(LOLTH_X - 60.0)
			game.player_facing_left = not facing_left
			hold_harrier(LOLTH_X + 120.0, 3)
			harrier().facing_left = facing_left
			game.message_time = 0.0
			game.player_action_time = 0.0
			game.mark_vfx_time = 0.0
			var label := "%s-%s" % ["night" if night else "day", "left" if facing_left else "right"]
			views[label] = await measure_view(label)
		var phase := "night" if night else "day"
		var overlap := mirrored_overlap(views[phase + "-left"], views[phase + "-right"], float(views[phase + "-right"].center_x))
		metrics[phase + "_mirror_overlap"] = overlap
		check("%s: left facing is the exact reflection of right facing around the body center (%.2f overlap)" % [phase, overlap], overlap >= 0.9)
	# Both actors together, mid-fight, at night and by day.
	for night in [false, true]:
		game.clock_seconds = game.DAY_DURATION + 10.0 if night else 10.0
		game.scree_crawler = stashed_crawler
		# Lolth between the two: the Harrier hovers on her left, the crawler stands on her right.
		place_lolth(2625.0)
		game.player_facing_left = false
		hold_crawler(CRAWLER_PARK_X - 5.0, 2)
		crawler().facing_left = true
		hold_harrier(2490.0, 3)
		harrier().facing_left = false
		game.message_time = 0.0
		await shot("both-actors-" + ("night" if night else "day"))
	game.scree_crawler = stashed_crawler
	hold_crawler(CRAWLER_PARK_X, 3)
	game.clock_seconds = saved_clock
	game.set_process(true)

func melee_and_thread() -> void:
	place_lolth(LOLTH_X)
	var reach: float = game.melee_reach(harrier())
	game.hurt_cooldown = 99.0
	hold_harrier(LOLTH_X + reach - 6.0, 3)
	harrier().facing_left = true
	game.combo_time = 0.0
	game.message_time = 0.0
	await frames(2)
	await click(Vector2(1200, 580))
	var hit: bool = int(harrier().health) == 2 and game.player_pose() == "strike" and not game.player_hurt_visible() and int(crawler().health) == 3
	await shot("harrier-hit")
	check("real left-click from the ground hits the hovering Harrier inside its visible reach (%.1f px) without a hurt pose" % reach, hit)
	await frames(30)
	hold_harrier(LOLTH_X + reach + 14.0, 2)
	game.combo_time = 0.0
	await click(Vector2(1200, 580))
	var miss: bool = int(harrier().health) == 2 and String(game.message).begins_with("Out of reach") and not game.player_hurt_visible()
	await shot("harrier-miss")
	check("real left-click just outside the reach misses without damage or a hurt pose", miss)
	var thread_reach := maxf(game.FIRST_THREAD_RANGE, reach)
	hold_harrier(LOLTH_X + thread_reach - 6.0, 3)
	game.first_thread_cooldown = 0.0
	await tap(KEY_C)
	check("real C First Thread reaches the Harrier inside its range for its existing damage", int(harrier().health) == 3 - game.FIRST_THREAD_DAMAGE and game.first_thread_cooldown > 0.0)
	hold_harrier(LOLTH_X + thread_reach + 14.0, 3)
	game.first_thread_cooldown = 0.0
	await tap(KEY_C)
	check("real C First Thread finds no target just outside its range", int(harrier().health) == 3 and String(game.message).begins_with("FIRST THREAD finds no target"))

func wait_for_state(wanted: String, timeout_ms: int) -> bool:
	var started := Time.get_ticks_msec()
	while String(harrier().attack_state) != wanted and Time.get_ticks_msec() - started < timeout_ms:
		await process_frame
	return String(harrier().attack_state) == wanted

func windup_locked_aim_and_dash() -> void:
	place_lolth(LOLTH_X)
	game.player_facing_left = false
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	game.dodge_cooldown = 0.0
	arm_harrier(LOLTH_X + 150.0, 3)
	game.message_time = 0.0
	var reached := await wait_for_state("windup", 2000)
	var locked_target := float(harrier().target_x)
	var locked_dir := float(harrier().attack_dir)
	# Freeze one windup frame for the capture and the warning measurement.
	game.set_process(false)
	var with_warning: Image = await shot("harrier-windup")
	harrier().attack_state = "approach"
	var without_warning: Image = await capture()
	harrier().attack_state = "windup"
	game.set_process(true)
	var body: Rect2 = game.enemy_draw_geometry(harrier()).body
	var from_x := float(harrier().pos.x)
	var strip := screen_rect(Rect2(minf(from_x, locked_target), game.GROUND_Y - 14.0, absf(from_x - locked_target), 26.0))
	var label := screen_rect(Rect2(from_x - 60.0, body.position.y - 62.0, 120.0, 24.0))
	var strip_changes := changed_count(with_warning, without_warning, strip)
	var label_changes := changed_count(with_warning, without_warning, label)
	metrics.windup_warning = {"strip_changes": strip_changes, "label_changes": label_changes, "locked_target": locked_target}
	check("windup shows a ground warning toward the locked target and a DIVE! label (%d / %d changed pixels)" % [strip_changes, label_changes], reached and strip_changes > 300 and label_changes > 30 and locked_dir < 0.0)
	# Real D held through the rest of the windup: the dive target and direction stay locked.
	key(KEY_D, true)
	var held_lock := true
	var started := Time.get_ticks_msec()
	while String(harrier().attack_state) == "windup" and Time.get_ticks_msec() - started < 2000:
		await process_frame
		held_lock = held_lock and (String(harrier().attack_state) != "windup" or (float(harrier().target_x) == locked_target and float(harrier().attack_dir) == locked_dir))
	var dive_seen := String(harrier().attack_state) == "dive"
	var dive_target_held := float(harrier().target_x) == locked_target
	key(KEY_D, false)
	await frames(30)
	check("moving with real D during the windup does not retarget: the dive keeps its locked point and direction", held_lock and dive_seen and dive_target_held and game.player.x > locked_target)
	# Real Shift just before a second dive: dash invulnerability spends it without damage.
	await frames(60)
	place_lolth(LOLTH_X)
	game.player_facing_left = false
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	game.dodge_cooldown = 0.0
	arm_harrier(LOLTH_X + 150.0, 3)
	reached = await wait_for_state("windup", 2000)
	while String(harrier().attack_state) == "windup" and float(harrier().attack_time) > 0.06:
		await process_frame
	key(KEY_SHIFT, true)
	var dodged := false
	var dive_started := false
	var deadline := Time.get_ticks_msec() + 2500
	while String(harrier().attack_state) != "recover" and Time.get_ticks_msec() < deadline:
		await process_frame
		dodged = dodged or game.dodge_time > 0.0
		dive_started = dive_started or String(harrier().attack_state) == "dive"
		if game.dodge_time > 0.0:
			game.set_process(true)
		key(KEY_SHIFT, false)
	await shot("harrier-recovery")
	check("real Shift dash avoids the dive, which is spent without damage", reached and dodged and dive_started and bool(harrier().strike_spent) and game.health == game.max_health())

func dive_lands_once() -> void:
	await frames(30)
	place_lolth(LOLTH_X)
	game.player_facing_left = false
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	game.dodge_time = 0.0
	arm_harrier(LOLTH_X + 150.0, 3)
	var reached := await wait_for_state("windup", 2000)
	# Hold Lolth's position by clamping her to the locked target once the dive starts.
	while String(harrier().attack_state) == "windup":
		await process_frame
	var hurt_frames := 0
	var last_health: float = game.health
	var deadline := Time.get_ticks_msec() + 3000
	var captured_dive := false
	while String(harrier().attack_state) != "recover" and Time.get_ticks_msec() < deadline:
		game.hurt_cooldown = 0.0
		game.player.x = float(harrier().target_x)
		await process_frame
		if game.health < last_health:
			hurt_frames += 1
		last_health = game.health
	check("an unavoided dive wounds Lolth exactly once by the existing hurt (%d hurt frames)" % hurt_frames, reached and hurt_frames == 1 and game.health == game.max_health() - 1.0 and bool(harrier().strike_spent) and game.state == "journey")
	hold_harrier(game.CLIFF_HARRIER_HOME_X, 3)

func simultaneous_fight() -> void:
	await frames(20)
	game.health = game.max_health()
	place_lolth(LOLTH_X + 20.0)
	game.player_facing_left = false
	game.hurt_cooldown = 0.0
	game.dodge_time = 0.0
	var c := crawler()
	c.pos = Vector2(LOLTH_X + 20.0 - (game.scree_crawler_strike_range() - 8.0), game.GROUND_Y - 34.0)
	c.health = 3
	c.attack_state = "approach"
	c.attack_time = 0.0
	c.strike_spent = false
	arm_harrier(LOLTH_X + 20.0 + 160.0, 3)
	var started := Time.get_ticks_msec()
	var both_strikes := false
	var hurts := 0
	var last_health: float = game.health
	while Time.get_ticks_msec() - started < 6000:
		game.hurt_cooldown = 0.0
		game.dodge_time = 0.0
		await process_frame
		if game.health < last_health:
			hurts += 1
		last_health = game.health
		if bool(c.strike_spent) and bool(harrier().strike_spent) and String(c.attack_state) == "recover" and String(harrier().attack_state) == "recover":
			both_strikes = true
			break
	await shot("both-actors-fight")
	check("both actors strike in the same exchange; each lands at most once (%d wounds)" % hurts, both_strikes and hurts == 2 and game.health == game.max_health() - 2.0 and game.state == "journey")
	hold_crawler(CRAWLER_PARK_X, 3)
	hold_harrier(game.CLIFF_HARRIER_HOME_X, 3)

func ore_run_and_cave() -> void:
	# Both actors alive: the ore is collected and deposited without any kill.
	await frames(10)
	game.health = game.max_health()
	var back := await hold_until(KEY_D, func(): return game.player.x >= game.ROUTE_ORE_X - 10.0, 15.0)
	await tap(KEY_E)
	var carried: bool = game.load_has_pickup(game.ROUTE_ORE_ID, game.recovered_load) == 1
	var home := await hold_until(KEY_A, func(): return game.at_wagon(), 40.0)
	await frames(3)
	var saved_h: Dictionary = game.safe_wagon_state.get("harrier", {})
	var saved_c: Dictionary = game.safe_wagon_state.get("crawler", {})
	check("a live foothill pair does not block the safe capture at the cave Wagon; both flags are saved", bool(home.done) and game.camera_x == 0.0 and bool(saved_h.get("activated", false)) and not bool(saved_h.get("defeated", true)) and bool(saved_c.get("activated", false)) and game.shades.is_empty())
	var stock_before: int = game.wagon_stock.size()
	await tap(KEY_E)
	check("real D/E/A run collects and deposits the ore once with both actors alive", bool(back.done) and carried and game.wagon_stock.size() == stock_before + 1 and game.load_has_pickup(game.ROUTE_ORE_ID, game.wagon_stock) == 1 and game.pickup_copies(game.ROUTE_ORE_ID) == 1 and not game.crawler_defeated and not game.harrier_defeated and game.live_cliff_harrier_count() == 1 and game.live_scree_crawler_count() == 1)
	var again := await hold_until(KEY_D, func(): return game.player.x >= 2630.0, 30.0)
	check("a revisit meets the same two actors with their health; no copies", bool(again.done) and game.live_cliff_harrier_count() == 1 and game.live_scree_crawler_count() == 1)
	hold_crawler(CRAWLER_PARK_X, 3)
	hold_harrier(game.CLIFF_HARRIER_HOME_X, 3)

func retreat_from_windup() -> void:
	await frames(10)
	var limits: Vector2 = game.cliff_harrier_limits()
	var start_x: float = limits.x - 150.0
	place_lolth(start_x)
	game.player_facing_left = false
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	hold_crawler(CRAWLER_PARK_X, 3)
	arm_harrier(limits.x, 2)
	var actor := harrier()
	var reached := await wait_for_state("windup", 2000)
	var retreat := {"captured": ""}
	var started := Time.get_ticks_msec()
	key(KEY_A, true)
	while game.player.x >= game.ROUTE_FOOTHILLS_START_X - 40.0 and Time.get_ticks_msec() - started < 8000:
		await process_frame
		if String(retreat.captured) == "" and start_x - game.player.x >= 40.0:
			retreat.captured = String(actor.attack_state)
			game.set_process(false)
			await shot("harrier-retreat")
			game.set_process(true)
	key(KEY_A, false)
	var settle_started := Time.get_ticks_msec()
	while not is_zero_approx(game.velocity.x) and Time.get_ticks_msec() - settle_started < SETTLE_TIMEOUT_MS:
		await process_frame
	var settled: bool = is_zero_approx(game.velocity.x) and game.player.x < game.ROUTE_FOOTHILLS_START_X
	var held_x := float(actor.pos.x)
	await frames(90)
	metrics.retreat = {"state_at_capture": retreat.captured, "harrier_x": held_x, "lolth_x": game.player.x}
	check("real A retreat out of the foothills takes no damage; the Harrier stays at its patrol bound and never follows", reached and settled and String(retreat.captured) == "windup" and game.health == game.max_health() and float(actor.pos.x) >= limits.x - 0.01 and is_equal_approx(float(actor.pos.x), held_x) and String(actor.attack_state) in ["approach", "recover"] and int(actor.health) == 2)
	var back := await hold_until(KEY_D, func(): return game.player.x >= 1900.0, 20.0)
	check("returning meets the same live Harrier with its health; no second copy", bool(back.done) and is_same(harrier(), actor) and int(actor.health) == 2 and game.live_cliff_harrier_count() == 1)
	var onward := await hold_until(KEY_D, func(): return game.player.x >= 2630.0, 20.0)
	check("walking back past x=2600 does not create another Harrier", bool(onward.done) and game.live_cliff_harrier_count() == 1 and is_same(harrier(), actor))
	hold_crawler(CRAWLER_PARK_X, 3)
	hold_harrier(game.CLIFF_HARRIER_HOME_X, 2)

func click_button(button: Button) -> void:
	var point := button.get_global_rect().get_center()
	for pressed in [true, false]:
		var event := InputEventMouseButton.new()
		event.position = point
		event.button_index = MOUSE_BUTTON_LEFT
		event.pressed = pressed
		Input.parse_input_event(event)
		await process_frame
		await process_frame

# F4 exact restoration through the real panel: F4 opens it, the Mark up button starts the
# override (snapshotting both live actors), and the restore button returns every field.
func f4_exact_restore() -> void:
	await frames(5)
	place_lolth(LOLTH_X)
	var h := harrier()
	var c := crawler()
	h.pos = Vector2(2700.0, game.cliff_harrier_anchor_y(33.0))
	h.health = 2
	h.attack_state = "windup"
	h.attack_time = 0.41
	h.target_x = 2620.0
	h.attack_dir = -1.0
	h.bob_time = 1.7
	h.facing_left = true
	c.pos = Vector2(2600.0, game.GROUND_Y - 34.0)
	c.health = 1
	c.attack_state = "recover"
	c.attack_time = 0.6
	game.crawler_defeated = false
	game.harrier_defeated = false
	await tap(KEY_F4)
	var panel_open: bool = game.playtester_panel.visible
	var harrier_before: Dictionary = game.cliff_harrier.duplicate(true)
	var crawler_before: Dictionary = game.scree_crawler.duplicate(true)
	var flags_before: Array = [game.scree_crawler_state(), game.cliff_harrier_state()]
	var mark_before: int = game.mark_level
	await click_button(game.playtester_mark_up)
	var overridden: bool = game.playtester_active and game.mark_level == mark_before + 1
	game.cliff_harrier.health = 1
	game.cliff_harrier.pos = Vector2(2500.0, game.cliff_harrier_anchor_y(30.0))
	game.cliff_harrier.attack_state = "dive"
	game.scree_crawler.health = 3
	game.scree_crawler.pos = Vector2(2490.0, game.GROUND_Y - 34.0)
	game.harrier_defeated = true
	game.harrier_reward_paid = true
	game.crawler_defeated = true
	await click_button(game.playtester_restore_button)
	var restored: bool = game.cliff_harrier == harrier_before and game.scree_crawler == crawler_before and [game.scree_crawler_state(), game.cliff_harrier_state()] == flags_before and game.mark_level == mark_before and not game.playtester_active
	check("real F4 panel input (open, Mark up, restore) deep-restores both live actors, timers, positions, facings and flags", panel_open and overridden and restored)
	if game.playtester_panel.visible:
		await tap(KEY_F4)
	await frames(10)
	hold_crawler(CRAWLER_PARK_X, 3)
	hold_harrier(game.CLIFF_HARRIER_HOME_X, 3)

func controller_section() -> void:
	restore_joypad_bindings()
	check("restored controller bindings match the bindings before isolation", joypad_binding_counts() == metrics.joypad_bindings_before_suspension)
	place_lolth(LOLTH_X)
	game.hurt_cooldown = 99.0
	var reach: float = game.melee_reach(harrier())
	hold_harrier(LOLTH_X + reach - 6.0, 3)
	game.combo_time = 0.0
	await frames(2)
	await joy_button(JOY_BUTTON_X)
	check("real controller X attack hits the hovering Harrier inside its reach", int(harrier().health) == 2 and not game.player_hurt_visible())
	hold_harrier(2780.0, 3)
	await frames(30)
	game.dodge_cooldown = 0.0
	game.dodge_time = 0.0
	trigger(1.0)
	var dashed := false
	for _frame in 4:
		await process_frame
		dashed = dashed or game.dodge_time > 0.0
	trigger(0.0)
	await frames(4)
	check("real controller right trigger dashes with restored bindings", dashed)

func defeat_both() -> void:
	await frames(40)
	place_lolth(LOLTH_X)
	game.hurt_cooldown = 99.0
	var echoes_before: int = game.shadow_echoes
	var mark_before: int = game.mark_level
	var cured_before: Array = game.cured_allies.duplicate()
	var reach: float = game.melee_reach(harrier())
	hold_harrier(LOLTH_X + reach - 6.0, 1)
	game.combo_time = 0.0
	await frames(2)
	await click(Vector2(1200, 580))
	var harrier_paid: bool = bool(game.harrier_defeated) and bool(game.harrier_reward_paid) and not game.crawler_defeated and game.shadow_echoes == echoes_before + 1 and int(crawler().health) == 3 and not bool(crawler().defeated)
	await frames(30)
	game.combo_time = 0.0
	await click(Vector2(1200, 580))
	hold_crawler(LOLTH_X + game.melee_reach(crawler()) - 6.0, 1)
	game.combo_time = 0.0
	await click(Vector2(1200, 580))
	var both_paid: bool = bool(game.crawler_defeated) and bool(game.crawler_reward_paid) and game.shadow_echoes == echoes_before + 2
	metrics.defeat = {"echoes_before": echoes_before, "echoes_after": game.shadow_echoes}
	var leave := await hold_until(KEY_A, func(): return game.player.x < game.ROUTE_FOOTHILLS_START_X - 40.0, 10.0)
	var back := await hold_until(KEY_D, func(): return game.player.x >= 2630.0, 20.0)
	check("two real credited defeats pay one Echo each, once; revisits neither respawn nor repay; no progression unlock", harrier_paid and both_paid and bool(leave.done) and bool(back.done) and game.shadow_echoes == echoes_before + 2 and game.live_cliff_harrier_count() == 0 and game.live_scree_crawler_count() == 0 and game.mark_level == mark_before and game.cured_allies == cured_before and game.wagon_travel_locked())

func run() -> void:
	root.size = Vector2i(1280, 720)
	await start_game()
	await noise_check()
	await enter_foothills()
	if harrier().is_empty() or crawler().is_empty():
		print("B08_RUNTIME_FAIL: %d/%d checks (actors missing)" % [checks - failures, checks])
		quit(1)
		return
	await frozen_views()
	await melee_and_thread()
	await windup_locked_aim_and_dash()
	await dive_lands_once()
	await simultaneous_fight()
	await ore_run_and_cave()
	await retreat_from_windup()
	await f4_exact_restore()
	await controller_section()
	await defeat_both()
	check("crop bounds stayed cached through rendered play (crawler scans %d, Harrier scans %d, atlas scans %d)" % [game.ui_encounter_bounds_scans, game.ui_harrier_bounds_scans, game.ui_enemy_bounds_scans], game.ui_encounter_bounds_scans == 1 and game.ui_harrier_bounds_scans == 1 and game.ui_enemy_bounds_scans == 22 and game.ui_enemy_bounds.size() == 22)
	var file := FileAccess.open(out_dir + "/b08-runtime-metrics.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(metrics, "\t") + "\n")
	print("B08_RUNTIME_%s: %d/%d checks" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks])
	quit(0 if failures == 0 else 1)

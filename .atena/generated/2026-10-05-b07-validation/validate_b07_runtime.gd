extends SceneTree
# B-07 rendered checks at 1280x720 without fixed FPS. A real-input run reaches the foothills
# with D, meets the single Scree Crawler, hits and misses it with left-click and C, dashes a
# lunge with Shift, takes one lunge, retreats with A (cancelling a windup), returns to the cave
# Wagon and back, then exercises restored controller bindings and the credited defeat.
# Frozen captures cover day/night in both facings plus windup, hit, miss and retreat.
#
# Keyboard-only isolation: right after the game's _ready defines the production bindings and
# before its first processed frame, this test process removes its joypad bindings from the
# InputMap (device settings and production thresholds are untouched). Synthetic 0.21 trigger
# and stick-drift noise is then sent separately. Bindings are restored for the controller section.

const RES_DIR := "res://.atena/generated/2026-10-05-b07-validation"
const SETTLE_TIMEOUT_MS := 3000
# Lolth's combat position, left of the crawler's clear patrol span (2400-2860).
const LOLTH_X := 2380.0
var game
var checks := 0
var failures := 0
var out_dir := RES_DIR
var metrics := {}
var suspended_joypad_events := {}

func _initialize() -> void:
	if OS.get_environment("OUT") != "":
		out_dir = OS.get_environment("OUT")
	call_deferred("run")

func check(label: String, passed: bool) -> void:
	checks += 1
	print("B07RT %s %s" % ["PASS" if passed else "FAIL", label])
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
func hold_until(code: Key, done: Callable, timeout_seconds: float) -> Dictionary:
	var direction := 1.0 if code == KEY_D else -1.0
	var result := {"frames": 0, "settle_frames": 0, "monotonic": true, "regions": []}
	var last_x: float = game.player.x
	var started := Time.get_ticks_msec()
	key(code, true)
	while not done.call() and Time.get_ticks_msec() - started < int(timeout_seconds * 1000.0):
		await process_frame
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
	print("B07RT_TRACE %s frames=%d settle_frames=%d settled=%s monotonic=%s x=%.1f" % [OS.get_keycode_string(code), int(result.frames), int(result.settle_frames), result.settled, result.monotonic, game.player.x])
	return result

# --- Fixture helpers (state placement only; every action below is real input) -------------

func hold_crawler(x: float, health_value: int) -> void:
	var c := crawler()
	c.pos = Vector2(x, game.GROUND_Y - 34.0)
	c.health = health_value
	c.attack_state = "recover"
	c.attack_time = 99.0
	c.hit_flash = 0.0

func arm_crawler(x: float, health_value: int) -> void:
	var c := crawler()
	c.pos = Vector2(x, game.GROUND_Y - 34.0)
	c.health = health_value
	c.attack_state = "approach"
	c.attack_time = 0.0
	c.strike_spent = false

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
func measure_view(label: String) -> Dictionary:
	var with_crawler: Image = await shot("crawler-" + label)
	var saved := crawler()
	game.scree_crawler = {}
	var without: Image = await capture()
	game.scree_crawler = saved
	var geometry: Dictionary = game.enemy_draw_geometry(saved)
	var body: Rect2 = geometry.body
	var destination: Rect2 = geometry.destination
	var pos_x := float(saved.pos.x)
	if bool(saved.facing_left):
		destination = Rect2(2.0 * pos_x - destination.end.x, destination.position.y, destination.size.x, destination.size.y)
	var body_screen := screen_rect(body)
	var mask := changed_mask(with_crawler, without, body_screen.grow(2))
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
	var padding_changes := changed_count(with_crawler, without, left_pad) + changed_count(with_crawler, without, right_pad)
	var expected_center: float = pos_x - game.camera_x
	var result := {
		"mask": mask,
		"body_fraction": float(mask.size()) / float(maxi(1, body_screen.size.x * body_screen.size.y)),
		"padding_pixels": left_pad.size.x * left_pad.size.y + right_pad.size.x * right_pad.size.y,
		"padding_changes": padding_changes,
		"center_offset": (min_x + max_x + 1) / 2.0 - expected_center,
		"lowest_row": max_y,
		"center_x": expected_center,
	}
	metrics["view_" + label] = {"body_fraction": result.body_fraction, "padding_pixels": result.padding_pixels, "padding_changes": padding_changes, "center_offset": result.center_offset, "lowest_row": max_y, "camera_x": game.camera_x}
	check("%s: crawler body visible (%.2f of body box), grounded (lowest row %d), centered on its world x under a %.0f px view (%.1f px), clean padding (%d of %d pixels changed)" % [label, result.body_fraction, max_y, game.camera_x, result.center_offset, padding_changes, result.padding_pixels], result.body_fraction > 0.15 and max_y >= int(game.GROUND_Y) - 3 and max_y <= int(game.GROUND_Y) and absf(result.center_offset) <= 3.0 and result.padding_pixels > 500 and padding_changes == 0)
	return result

func mirrored_overlap(left: Dictionary, right: Dictionary, center: float) -> float:
	var intersection := 0
	for point in right.mask:
		var mirrored := Vector2i(int(round(2.0 * center - point.x - 1.0)), point.y)
		if left.mask.has(mirrored) or left.mask.has(mirrored + Vector2i(1, 0)) or left.mask.has(mirrored - Vector2i(1, 0)):
			intersection += 1
	return float(intersection) / float(maxi(1, maxi(left.mask.size(), right.mask.size())))

# --- Sections -------------------------------------------------------------------------------

func enter_foothills() -> void:
	game.reach_expedition_ready_for_test(true)
	game.clock_seconds = 10.0
	await frames(2)
	check("fixture: legitimate first cure and safe return, no crawler yet", game.expedition_departure_allowed() and crawler().is_empty() and not game.crawler_activated and game.scree_crawler_spawn_allowed() == false)
	var walk := await hold_until(KEY_D, func(): return game.player.x >= 1900.0, 20.0)
	var c := crawler()
	check("real D walk enters the foothills and creates exactly one identified crawler", bool(walk.done) and bool(walk.monotonic) and walk.regions.has("stonehook_foothills") and not c.is_empty() and String(c.encounter_id) == game.SCREE_CRAWLER_ID and game.live_scree_crawler_count() == 1 and game.shades.is_empty() and game.crawler_activated)
	metrics.walk_in = {"frames": walk.frames, "settle_frames": walk.settle_frames, "x": game.player.x}

func frozen_views() -> void:
	game.set_process(false)
	var c := crawler()
	var saved_clock: float = game.clock_seconds
	var views := {}
	for night in [false, true]:
		game.clock_seconds = game.DAY_DURATION + 10.0 if night else 10.0
		for facing_left in [false, true]:
			place_lolth(2330.0)
			game.player_facing_left = not facing_left
			hold_crawler(2520.0, 3)
			c.facing_left = facing_left
			game.message_time = 0.0
			game.player_action_time = 0.0
			game.mark_vfx_time = 0.0
			var label := "%s-%s" % ["night" if night else "day", "left" if facing_left else "right"]
			views[label] = await measure_view(label)
		var phase := "night" if night else "day"
		var overlap := mirrored_overlap(views[phase + "-left"], views[phase + "-right"], float(views[phase + "-right"].center_x))
		metrics[phase + "_mirror_overlap"] = overlap
		check("%s: left facing is the exact reflection of right facing around the body center (%.2f overlap)" % [phase, overlap], overlap >= 0.9)
	game.clock_seconds = saved_clock
	game.set_process(true)

func melee_and_thread() -> void:
	# Health stays within the crawler's own maximum (3) so the drawn health bar is truthful.
	place_lolth(LOLTH_X)
	var reach: float = game.melee_reach(crawler())
	game.hurt_cooldown = 99.0
	hold_crawler(LOLTH_X + reach - 6.0, 3)
	game.combo_time = 0.0
	game.message_time = 0.0
	await frames(2)
	await click(Vector2(1200, 580))
	var hit: bool = int(crawler().health) == 2 and game.player_pose() == "strike" and not game.player_hurt_visible()
	await shot("crawler-hit")
	check("real left-click hits the crawler inside its visible reach (%.1f px) without a hurt pose" % reach, hit)
	await frames(30)
	hold_crawler(LOLTH_X + reach + 14.0, 2)
	game.combo_time = 0.0
	await click(Vector2(1200, 580))
	var miss: bool = int(crawler().health) == 2 and String(game.message).begins_with("Out of reach") and not game.player_hurt_visible()
	await shot("crawler-miss")
	check("real left-click just outside the reach misses without damage or a hurt pose", miss)
	var thread_reach := maxf(game.FIRST_THREAD_RANGE, reach)
	hold_crawler(LOLTH_X + thread_reach - 6.0, 3)
	game.first_thread_cooldown = 0.0
	await tap(KEY_C)
	check("real C First Thread hits inside its range for its existing damage", int(crawler().health) == 3 - game.FIRST_THREAD_DAMAGE and game.first_thread_cooldown > 0.0)
	hold_crawler(LOLTH_X + thread_reach + 14.0, 3)
	game.first_thread_cooldown = 0.0
	await tap(KEY_C)
	check("real C First Thread finds no target just outside its range", int(crawler().health) == 3 and String(game.message).begins_with("FIRST THREAD finds no target"))

func wait_for_state(wanted: String, timeout_ms: int) -> bool:
	var started := Time.get_ticks_msec()
	while String(crawler().attack_state) != wanted and Time.get_ticks_msec() - started < timeout_ms:
		await process_frame
	return String(crawler().attack_state) == wanted

func windup_and_dash() -> void:
	place_lolth(LOLTH_X)
	game.player_facing_left = false
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	game.dodge_cooldown = 0.0
	arm_crawler(LOLTH_X + game.scree_crawler_strike_range() - 4.0, 3)
	var started := Time.get_ticks_msec()
	game.message_time = 0.0
	var reached := await wait_for_state("windup", 2000)
	var windup_started := Time.get_ticks_msec()
	# Freeze one windup frame for the capture and the warning measurement.
	game.set_process(false)
	var with_warning: Image = await shot("crawler-windup")
	crawler().attack_state = "approach"
	var without_warning: Image = await capture()
	crawler().attack_state = "windup"
	game.set_process(true)
	var body: Rect2 = game.enemy_draw_geometry(crawler()).body
	var strip := screen_rect(Rect2(body.position.x - 140.0, game.GROUND_Y - 14.0, 140.0, 26.0))
	var label := screen_rect(Rect2(float(crawler().pos.x) - 60.0, body.position.y - 62.0, 120.0, 24.0))
	var strip_changes := changed_count(with_warning, without_warning, strip)
	var label_changes := changed_count(with_warning, without_warning, label)
	metrics.windup_warning = {"strip_changes": strip_changes, "label_changes": label_changes}
	check("windup shows a ground warning toward Lolth and a LUNGE! label (%d / %d changed pixels)" % [strip_changes, label_changes], reached and strip_changes > 300 and label_changes > 30 and float(crawler().attack_dir) < 0.0)
	# Real Shift press just before the lunge: dash invulnerability spends the strike harmlessly.
	while String(crawler().attack_state) == "windup" and float(crawler().attack_time) > 0.06:
		await process_frame
	var windup_seconds := (Time.get_ticks_msec() - windup_started) / 1000.0
	key(KEY_SHIFT, true)
	var dodged := false
	var strike_seen := false
	var deadline := Time.get_ticks_msec() + 2000
	while String(crawler().attack_state) != "recover" and Time.get_ticks_msec() < deadline:
		await process_frame
		dodged = dodged or game.dodge_time > 0.0
		strike_seen = strike_seen or String(crawler().attack_state) == "strike"
		key(KEY_SHIFT, false)
	metrics.dash = {"windup_seconds_observed": windup_seconds, "approach_ms": windup_started - started}
	check("real Shift dash avoids the lunge, which is spent without damage", dodged and strike_seen and bool(crawler().strike_spent) and game.health == game.max_health())

func strike_lands_once() -> void:
	await frames(20)
	place_lolth(LOLTH_X)
	game.player_facing_left = false
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	game.dodge_time = 0.0
	arm_crawler(LOLTH_X + game.scree_crawler_strike_range() - 4.0, 3)
	var reached := await wait_for_state("windup", 2000)
	var hurt_frames := 0
	var last_health: float = game.health
	var trace: Array = []
	var deadline := Time.get_ticks_msec() + 3000
	while String(crawler().attack_state) != "recover" and Time.get_ticks_msec() < deadline:
		# Remove the hurt cooldown every frame so only the spent strike can prevent a second hit.
		game.hurt_cooldown = 0.0
		await process_frame
		if game.health < last_health:
			hurt_frames += 1
		last_health = game.health
		if String(crawler().attack_state) != "windup":
			trace.append({"state": String(crawler().attack_state), "gap": float(crawler().pos.x) - game.player.x, "delta": game.get_process_delta_time(), "dodge": game.dodge_time, "spent": bool(crawler().strike_spent), "health": game.health})
	metrics.strike_trace = {"reach": game.melee_reach(crawler()), "frames": trace}
	check("an unavoided lunge wounds Lolth exactly once by the existing hurt (%d hurt frames)" % hurt_frames, reached and hurt_frames == 1 and game.health == game.max_health() - 1.0 and bool(crawler().strike_spent) and game.state == "journey")
	hold_crawler(2600.0, 3)

func retreat_and_return() -> void:
	await frames(10)
	var limits: Vector2 = game.scree_crawler_limits()
	var start_x: float = limits.x - (game.scree_crawler_strike_range() - 4.0)
	place_lolth(start_x)
	game.player_facing_left = false
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	arm_crawler(limits.x, 2)
	var actor := crawler()
	game.message_time = 0.0
	var reached := await wait_for_state("windup", 2000)
	# Real A held from inside the windup. Once Lolth has moved 40 px, one frame is frozen for
	# the retreat capture while both actors are on screen and the warning is still shown.
	var retreat := {"frames": 0, "outcome": "", "max_x": actor.pos.x, "min_x": actor.pos.x}
	var started := Time.get_ticks_msec()
	key(KEY_A, true)
	while game.player.x >= game.ROUTE_FOOTHILLS_START_X - 40.0 and Time.get_ticks_msec() - started < 6000:
		await process_frame
		retreat.frames = int(retreat.frames) + 1
		retreat.min_x = minf(float(retreat.min_x), float(actor.pos.x))
		retreat.max_x = maxf(float(retreat.max_x), float(actor.pos.x))
		if not retreat.has("captured") and start_x - game.player.x >= 40.0:
			retreat.captured = String(actor.attack_state)
			game.set_process(false)
			await shot("crawler-retreat")
			game.set_process(true)
		if String(retreat.outcome) == "" and String(actor.attack_state) != "windup":
			retreat.outcome = String(actor.attack_state)
	key(KEY_A, false)
	var settle_started := Time.get_ticks_msec()
	while not is_zero_approx(game.velocity.x) and Time.get_ticks_msec() - settle_started < SETTLE_TIMEOUT_MS:
		await process_frame
	var settled: bool = is_zero_approx(game.velocity.x) and game.player.x < game.ROUTE_FOOTHILLS_START_X
	var held_x := float(actor.pos.x)
	await frames(90)
	metrics.retreat = {"outcome_after_windup": retreat.outcome, "state_at_capture": retreat.get("captured", ""), "frames": retreat.frames, "crawler_min_x": retreat.min_x, "crawler_max_x": retreat.max_x, "lolth_x": game.player.x}
	check("real A retreat from inside a windup takes no damage; the crawler never leaves its patrol (outcome: %s)" % retreat.outcome, reached and settled and String(retreat.get("captured", "")) == "windup" and String(retreat.outcome) != "" and game.health == game.max_health() and float(retreat.min_x) >= limits.x - 0.01 and is_equal_approx(float(actor.pos.x), held_x) and String(actor.attack_state) != "windup" and String(actor.attack_state) != "strike" and int(actor.health) == 2)
	var home := await hold_until(KEY_A, func(): return game.at_wagon(), 30.0)
	await frames(3)
	var saved: Dictionary = game.safe_wagon_state.get("crawler", {})
	check("real A return reaches the cave Wagon; a live foothill crawler does not block the safe capture", bool(home.done) and game.camera_x == 0.0 and bool(saved.get("activated", false)) and not bool(saved.get("defeated", true)) and is_same(crawler(), actor) and game.shades.is_empty())
	var back := await hold_until(KEY_D, func(): return game.player.x >= 1900.0, 20.0)
	check("real D revisit finds the same live crawler with its health; no second copy", bool(back.done) and is_same(crawler(), actor) and int(actor.health) == 2 and game.live_scree_crawler_count() == 1)

func controller_section() -> void:
	restore_joypad_bindings()
	check("restored controller bindings match the bindings before isolation", joypad_binding_counts() == metrics.joypad_bindings_before_suspension)
	place_lolth(LOLTH_X)
	game.hurt_cooldown = 99.0
	var reach: float = game.melee_reach(crawler())
	hold_crawler(LOLTH_X + reach - 6.0, 3)
	game.combo_time = 0.0
	await frames(2)
	await joy_button(JOY_BUTTON_X)
	check("real controller X attack hits the crawler inside its reach", int(crawler().health) == 2 and not game.player_hurt_visible())
	hold_crawler(2750.0, 3)
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

# The ore stays reachable past the live crawler with ordinary movement; no kill is required.
func ore_past_live_crawler() -> void:
	place_lolth(1900.0)
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	arm_crawler(game.SCREE_CRAWLER_HOME_X, 3)
	await frames(2)
	var reached := await hold_until(KEY_D, func(): return game.player.x >= game.ROUTE_ORE_X - 10.0, 10.0)
	await tap(KEY_E)
	var carried: bool = game.load_has_pickup(game.ROUTE_ORE_ID, game.recovered_load) == 1
	var away := await hold_until(KEY_A, func(): return game.player.x < game.ROUTE_FOOTHILLS_START_X - 40.0, 10.0)
	metrics.ore_run = {"health_after": game.health, "crawler_health": crawler().health}
	check("real D/E/A run collects the ore past the live crawler and leaves alive (health %.0f/%.0f)" % [game.health, game.max_health()], bool(reached.done) and carried and bool(away.done) and game.state == "journey" and game.health > 0.0 and game.live_scree_crawler_count() == 1 and int(crawler().health) == 3 and not game.crawler_defeated)
	var back := await hold_until(KEY_D, func(): return game.player.x >= 1900.0, 10.0)
	check("returning after the ore run meets the same crawler; no second copy", bool(back.done) and game.live_scree_crawler_count() == 1)

func defeat_once() -> void:
	await frames(40)
	place_lolth(LOLTH_X)
	game.hurt_cooldown = 99.0
	var reach: float = game.melee_reach(crawler())
	hold_crawler(LOLTH_X + reach - 6.0, 1)
	var echoes_before: int = game.shadow_echoes
	var mark_before: int = game.mark_level
	var cured_before: Array = game.cured_allies.duplicate()
	game.combo_time = 0.0
	await frames(2)
	await click(Vector2(1200, 580))
	var paid: bool = bool(game.crawler_defeated) and bool(game.crawler_reward_paid) and game.shadow_echoes == echoes_before + 1
	metrics.defeat = {"echoes_before": echoes_before, "echoes_after_kill": game.shadow_echoes, "defeated": game.crawler_defeated, "reward_paid": game.crawler_reward_paid}
	await frames(60)
	game.combo_time = 0.0
	await click(Vector2(1200, 580))
	var walk := await hold_until(KEY_A, func(): return game.player.x < game.ROUTE_FOOTHILLS_START_X - 40.0, 5.0)
	var back := await hold_until(KEY_D, func(): return game.player.x >= 1900.0, 10.0)
	check("a real credited defeat pays one Echo once; revisits do not respawn or pay again", paid and bool(walk.done) and bool(back.done) and game.shadow_echoes == echoes_before + 1 and bool(crawler().get("defeated", true)) and game.live_scree_crawler_count() == 0 and not game.scree_crawler_spawn_allowed() and game.mark_level == mark_before and game.cured_allies == cured_before and game.wagon_travel_locked())

func run() -> void:
	root.size = Vector2i(1280, 720)
	await start_game()
	await noise_check()
	await enter_foothills()
	if crawler().is_empty():
		print("B07_RUNTIME_FAIL: %d/%d checks (no crawler)" % [checks - failures, checks])
		quit(1)
		return
	await frozen_views()
	await melee_and_thread()
	await windup_and_dash()
	await strike_lands_once()
	await retreat_and_return()
	await controller_section()
	await ore_past_live_crawler()
	await defeat_once()
	check("crop bounds stayed cached through rendered play (encounter scans %d, atlas scans %d)" % [game.ui_encounter_bounds_scans, game.ui_enemy_bounds_scans], game.ui_encounter_bounds_scans == 1 and game.ui_enemy_bounds_scans == 22 and game.ui_enemy_bounds.size() == 22)
	var file := FileAccess.open(out_dir + "/b07-runtime-metrics.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(metrics, "\t") + "\n")
	print("B07_RUNTIME_%s: %d/%d checks" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks])
	quit(0 if failures == 0 else 1)

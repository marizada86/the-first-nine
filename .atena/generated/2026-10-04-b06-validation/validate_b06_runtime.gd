extends SceneTree
# B-06 rendered checks at 1280x720 without fixed FPS: baseline parity of the cave view, the
# camera translation fixture, a real-input outward/return run, offscreen Stag damage, camera-offset
# combat and UI, and frozen day/night captures at five transition positions.
# B06_RENDER_FAULT runs only the translation fixture with a deliberately faulty subclass.
# B06_ISOLATION_FAULT=late_isolation runs only the route-start isolation boundary with the
# published ccc4fcf/7c781ab ordering (isolation after the first journey frame).

const RES_DIR := "res://.atena/generated/2026-10-04-b06-validation"
var game
var checks := 0
var failures := 0
var out_dir := RES_DIR
var render_fault := ""
var isolation_fault := ""
var metrics := {}
var suspended_joypad_events := {}
const SETTLE_TIMEOUT_MS := 3000
const READABILITY_MIN_RATIO := 0.5

func _initialize() -> void:
	if OS.get_environment("OUT") != "":
		out_dir = OS.get_environment("OUT")
	render_fault = OS.get_environment("B06_RENDER_FAULT")
	isolation_fault = OS.get_environment("B06_ISOLATION_FAULT")
	call_deferred("run")

func check(label: String, passed: bool) -> void:
	checks += 1
	print("B06RT %s %s" % ["PASS" if passed else "FAIL", label])
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

func capture(node: CanvasItem) -> Image:
	node.queue_redraw()
	await process_frame
	await RenderingServer.frame_post_draw
	return root.get_texture().get_image()

func shot(name: String) -> Image:
	var image: Image = await capture(game)
	image.save_png(out_dir + "/" + name + ".png")
	return image

func differing_pixels(a: Image, b: Image, exclude: Rect2i = Rect2i()) -> int:
	var count := 0
	for y in a.get_height():
		for x in a.get_width():
			if exclude.has_area() and exclude.has_point(Vector2i(x, y)):
				continue
			if a.get_pixel(x, y) != b.get_pixel(x, y):
				count += 1
	return count

func column_difference(image: Image, x: int, top: int, bottom: int) -> float:
	var total := 0.0
	for y in range(top, bottom):
		var a := image.get_pixel(x - 1, y)
		var b := image.get_pixel(x, y)
		total += (absf(a.r - b.r) + absf(a.g - b.g) + absf(a.b - b.b)) / 3.0
	return total / float(bottom - top)

func title_glyph_pixels(image: Image) -> int:
	var count := 0
	var title := Color("f8dc8c")
	for y in range(30, 62):
		for x in range(44, 260):
			var c := image.get_pixel(x, y)
			if absf(c.r - title.r) + absf(c.g - title.g) + absf(c.b - title.b) < 0.03:
				count += 1
	return count

func free_node(node: Node) -> void:
	root.remove_child(node)
	node.queue_free()
	await process_frame

func floor_y() -> float:
	return game.GROUND_Y - game.PLAYER_FEET_OFFSET

# Same deterministic setup for the B-06 build and the pre-B-06 baseline build.
func prepare_scenario(instance, scenario: String) -> void:
	instance.set_process(false)
	instance.reset_to_prologue()
	match scenario:
		"night":
			instance.tutorial_phase = "night_defense"
			instance.clock_seconds = instance.DAY_DURATION
			instance.start_thornwake_night()
		"secured":
			instance.reach_safe_camp_for_test()
			instance.player = Vector2(instance.CARAVAN_X + 20.0, instance.GROUND_Y - instance.PLAYER_FEET_OFFSET)
			instance.use_camp_action()
			instance.defeat_boss_for_test()
			instance.skip_shar_shell()
			instance.cure_selected_ally()
			instance.player = Vector2(instance.CARAVAN_X + 20.0, instance.GROUND_Y - instance.PLAYER_FEET_OFFSET)
			instance.was_at_safe_wagon = false
			instance.update_safe_wagon()
			instance.player = Vector2(900.0, instance.GROUND_Y - instance.PLAYER_FEET_OFFSET)
	instance.pulse = 1.25
	instance.message_time = 0.0
	instance.player_action_time = 0.0
	instance.mark_vfx_time = 0.0
	instance.velocity = Vector2.ZERO

func baseline_parity() -> void:
	var baseline_path := RES_DIR + "/baseline/main_7e477ba.gd"
	if not FileAccess.file_exists(baseline_path):
		check("pre-B-06 baseline script is available for cave-view parity", false)
		return
	# The route signpost is the only intended addition at a zero view offset.
	var signpost := Rect2i(1000, 270, 262, 290)
	for scenario in ["day", "night", "secured"]:
		var images: Array[Image] = []
		for script_path in [baseline_path, "res://main.gd"]:
			var instance = load(script_path).new()
			root.add_child(instance)
			await process_frame
			prepare_scenario(instance, scenario)
			var image: Image = await capture(instance)
			images.append(image)
			await free_node(instance)
		images[1].save_png(out_dir + "/parity-" + scenario + ".png")
		var different := differing_pixels(images[0], images[1], signpost if scenario == "secured" else Rect2i())
		var signpost_drawn := differing_pixels(images[0], images[1]) > different
		metrics["parity_" + scenario + "_differing_pixels"] = different
		check("cave view at zero offset matches the pre-B-06 build (%s, %d differing pixels)" % [scenario, different], different == 0 and (scenario != "secured" or signpost_drawn))

func translation_fixture() -> void:
	var script_path := RES_DIR + ("/camera_fixture.gd" if render_fault == "" else "/faults/" + render_fault + ".gd")
	var fixture = load(script_path).new()
	root.add_child(fixture)
	await process_frame
	fixture.set_process(false)
	fixture.reset_to_prologue()
	fixture.salvage.clear()
	fixture.pulse = 0.0
	fixture.message_time = 0.0
	var ground: float = fixture.GROUND_Y
	for facing_left in [false, true]:
		var images: Array[Image] = []
		for offset in [0.0, 1000.0]:
			fixture.camera_x = offset
			fixture.player = Vector2(600.0 + offset, ground - fixture.PLAYER_FEET_OFFSET)
			fixture.player_facing_left = facing_left
			fixture.shades.clear()
			fixture.spawn_enemy("BRIAR HOUND", Vector2(820.0 + offset, ground - 34.0), 3, 0)
			fixture.spawn_enemy("STAG OF MIRE", Vector2(1040.0 + offset, ground - 34.0), 3, 0)
			for shade in fixture.shades:
				shade.facing_left = facing_left
			var image: Image = await capture(fixture)
			images.append(image)
		var label := "left" if facing_left else "right"
		# Faulty runs never write evidence captures, so they cannot replace the real images.
		if render_fault == "":
			images[1].save_png(out_dir + "/translation-%s-offset-1000.png" % label)
		var different := differing_pixels(images[0], images[1])
		metrics["translation_%s_differing_pixels" % label] = different
		check("world translation keeps %s-facing Lolth, enemies, labels and bars identical on screen (%d differing pixels)" % [label, different], different == 0)
		check("world marker after reflected sprites and screen marker stay in place (%s)" % label, images[1].get_pixel(110, 110) == Color.CYAN and images[1].get_pixel(50, 50) == Color.MAGENTA)
	await free_node(fixture)

# Measures one observed frame of the walk: continuity bounds, context and regions.
func sample_walk(result: Dictionary, direction: float) -> void:
	await process_frame
	# process_frame resumes before this frame's _process, so the observed step belongs to
	# either the previous or the current frame time; bound it by the larger of the two.
	var delta: float = game.get_process_delta_time()
	var frame_time := maxf(delta, float(result.last_delta))
	result.last_delta = delta
	var step: float = game.player.x - float(result.last_x)
	result.monotonic = bool(result.monotonic) and step * direction >= -0.001
	result.step_ok = bool(result.step_ok) and absf(step) <= 290.0 * frame_time + 0.5
	result.camera_ok = bool(result.camera_ok) and absf(game.camera_x - float(result.last_camera)) <= game.CAMERA_GLIDE_SPEED * frame_time + 0.5
	result.context_ok = bool(result.context_ok) and game.zone == 0 and game.state == "journey" and is_equal_approx(game.player.y, floor_y())
	result.max_step = maxf(float(result.max_step), absf(step))
	if frame_time > 0.0:
		result.max_step_ratio = maxf(float(result.max_step_ratio), absf(step) / (290.0 * frame_time))
	if game.player.x <= game.CAMERA_WINDOW_RIGHT:
		result.camera_at_cave = maxf(float(result.camera_at_cave), game.camera_x)
	var region: String = game.lolth_region()
	if result.regions.is_empty() or String(result.regions.back()) != region:
		result.regions.append(region)
	result.last_x = game.player.x
	result.last_camera = game.camera_x
	result.frames = int(result.frames) + 1

# Holds a movement key until the condition holds, then releases it and waits for Lolth to
# actually stop (zero velocity) under a wall-clock timeout, measuring every frame throughout.
# A walk counts as done only when the condition holds after a real stop.
func hold_until(code: Key, done: Callable, timeout_seconds: float) -> Dictionary:
	var direction := 1.0 if code == KEY_D else -1.0
	var result := {"frames": 0, "settle_frames": 0, "monotonic": true, "step_ok": true, "camera_ok": true, "context_ok": true, "max_step": 0.0, "max_step_ratio": 0.0, "camera_at_cave": 0.0, "regions": [], "last_x": game.player.x, "last_camera": game.camera_x, "last_delta": game.get_process_delta_time()}
	var started := Time.get_ticks_msec()
	key(code, true)
	while not done.call() and Time.get_ticks_msec() - started < int(timeout_seconds * 1000.0):
		await sample_walk(result, direction)
	key(code, false)
	var settle_started := Time.get_ticks_msec()
	while not is_zero_approx(game.velocity.x) and Time.get_ticks_msec() - settle_started < SETTLE_TIMEOUT_MS:
		await sample_walk(result, direction)
		result.settle_frames = int(result.settle_frames) + 1
	result.settled = is_zero_approx(game.velocity.x)
	result.done = done.call() and bool(result.settled)
	print("B06RT_TRACE %s frames=%d settle_frames=%d settled=%s monotonic=%s step_ok=%s camera_ok=%s context_ok=%s max_step=%.2f max_step_ratio=%.3f" % [OS.get_keycode_string(code), int(result.frames), int(result.settle_frames), result.settled, result.monotonic, result.step_ok, result.camera_ok, result.context_ok, float(result.max_step), float(result.max_step_ratio)])
	return result

# Keyboard-only route section: physical controllers attached to the test machine must not inject
# actions (a resting right trigger near 0.20 exceeds the 0.2 action deadzone and dashes). Only
# this test process's InputMap is changed; device settings and production thresholds are not.
# Idempotent: a repeated call keeps every binding saved by an earlier call for restoration.
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

# Holds gameplay processing for one input dispatch so a controller action that reaches the
# request queue stays queued, then reports whether it was queued and whether Lolth dashed
# once processing resumed. late_suspension reproduces isolation applied after the queueing.
func boundary_trigger(instance, late_suspension: bool) -> Dictionary:
	instance.dodge_cooldown = 0.0
	instance.dodge_time = 0.0
	instance.set_process(false)
	trigger(0.21)
	await process_frame
	await process_frame
	var queued: bool = instance.ui_gameplay_requests.has("shadow_action")
	if late_suspension:
		suspend_joypad_bindings()
	trigger(0.0)
	instance.set_process(true)
	var dashed := false
	for _frame in 4:
		await process_frame
		dashed = dashed or instance.dodge_time > 0.0
	return {"queued": queued, "dashed": dashed}

# Control: with live bindings, a 0.21 trigger queues a dash that survives a later suspension.
# This proves the boundary check below can detect the stale-queue failure it guards against.
func isolation_boundary_control() -> void:
	var instance = load("res://main.tscn").instantiate()
	root.add_child(instance)
	await process_frame
	instance.skip_opening()
	await process_frame
	var before := joypad_binding_counts()
	var stale: Dictionary = await boundary_trigger(instance, true)
	restore_joypad_bindings()
	metrics.isolation_control = stale
	check("control: a 0.21 trigger queued before isolation still dashes after a late suspension", bool(stale.queued) and bool(stale.dashed) and joypad_binding_counts() == before)
	await free_node(instance)

# Route start. Isolation begins right after the game's _ready (which defines the production
# bindings) and before any frame, so no controller action can reach the request queue.
func start_route_game() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	metrics.joypad_bindings_before_suspension = joypad_binding_counts()
	var late := isolation_fault == "late_isolation"
	if not late:
		suspend_joypad_bindings()
	trigger(0.21)
	await process_frame
	await tap(KEY_ESCAPE)
	var boundary: Dictionary = await boundary_trigger(game, late)
	# A repeated suspension must not discard the bindings saved by the first one.
	suspend_joypad_bindings()
	metrics.isolation_boundary = boundary
	check("controller isolation starts before the first journey frame: a 0.21 trigger at the boundary neither queues nor performs a dash", not suspended_joypad_events.is_empty() and not bool(boundary.queued) and not bool(boundary.dashed) and game.state == "journey")

func trigger(value: float) -> void:
	var event := InputEventJoypadMotion.new()
	event.axis = JOY_AXIS_TRIGGER_RIGHT
	event.axis_value = value
	Input.parse_input_event(event)

# Sends a right-trigger value for a few frames and reports whether Lolth dashed.
func trigger_dashes(value: float) -> bool:
	game.dodge_cooldown = 0.0
	game.dodge_time = 0.0
	trigger(value)
	var dashed := false
	for _frame in 4:
		await process_frame
		dashed = dashed or game.dodge_time > 0.0
	trigger(0.0)
	for _frame in 3:
		await process_frame
	return dashed

func route_run() -> void:
	await start_route_game()
	# Fixture: the legitimate B-03/B-04 path through the boss, Mark I, one cure and a safe return.
	game.reach_expedition_ready_for_test()
	await process_frame
	await process_frame
	var hub_before: Dictionary = game.cave_camp_state()
	hub_before.erase("lolth_region")
	hub_before.erase("fire")
	check("legitimate first cure and safe return open the on-foot route", game.expedition_departure_allowed() and game.camp_secured and game.camera_x == 0.0 and game.wagon_travel_locked())
	await shot("route-cave-secured")
	var far_x: float = game.ROUTE_END_X - game.PLAYER_EDGE_MARGIN
	var outward := await hold_until(KEY_D, func(): return game.player.x >= far_x - 0.5, 30.0)
	metrics.outward_frames = outward.frames
	metrics.outward_max_step = outward.max_step
	check("real D input reaches the far foothill limit", bool(outward.done) and is_equal_approx(game.camera_x, game.ROUTE_END_X - game.VIEW.x))
	check("outward motion has no reset, jump, region screen or floor change", bool(outward.monotonic) and bool(outward.step_ok) and bool(outward.camera_ok) and bool(outward.context_ok))
	check("view offset stays zero while Lolth is inside the cave window", float(outward.camera_at_cave) == 0.0)
	check("displayed region crosses Thornwake, the approach and the foothills", outward.regions == ["thornwake", "stonehook_approach", "stonehook_foothills"])
	var hub_away: Dictionary = game.cave_camp_state()
	hub_away.erase("lolth_region")
	hub_away.erase("fire")
	check("Wagon and family keep one cave anchor while Lolth is away", hub_away == hub_before and float(hub_away.anchor_x) == game.CARAVAN_X)
	await shot("route-far-end")
	var ore_reached := await hold_until(KEY_A, func(): return game.player.x <= game.ROUTE_ORE_X + 20.0, 10.0)
	await tap(KEY_E)
	check("real E collects the single foothill ore", bool(ore_reached.done) and bool(game.route_ore_state().taken) and game.pickup_copies(game.ROUTE_ORE_ID) == 1 and game.load_has_pickup(game.ROUTE_ORE_ID, game.recovered_load) == 1)
	await tap(KEY_E)
	check("a second E press finds nothing more", game.recovered_load.size() == 1 and game.pickup_copies(game.ROUTE_ORE_ID) == 1)
	await tap(KEY_M)
	check("M cannot open the Wagon from the foothills", not game.ui_management.is_open() and String(game.message).begins_with("Return to the Wagon"))
	await tap(KEY_I)
	var clock_before: float = game.clock_seconds
	await create_timer(0.15).timeout
	check("I opens Lolth's inventory away from the Wagon and pauses the world", game.ui_management.is_open() and game.ui_management.mode == "inventory" and game.clock_seconds == clock_before)
	await shot("foothills-inventory")
	await tap(KEY_ESCAPE)
	check("Esc closes the inventory", not game.ui_management.is_open())
	await process_frame
	await click(Vector2(1200, 580))
	check("left-click in the foothills swings without a target or a world interaction", game.player_pose() == "strike" and game.recovered_load.size() == 1)
	var stock_before: int = game.wagon_stock.size()
	var inward := await hold_until(KEY_A, func(): return game.at_wagon(), 30.0)
	await process_frame
	var saved_taken: Dictionary = game.safe_wagon_state.get("pickup_taken", {})
	check("real A input returns along the same route to the cave Wagon", bool(inward.done) and bool(inward.monotonic) and bool(inward.step_ok) and bool(inward.camera_ok) and bool(inward.context_ok) and game.camera_x == 0.0)
	check("arrival secures a consistent snapshot with the carried ore", bool(saved_taken.get(game.ROUTE_ORE_ID, false)) and game.load_has_pickup(game.ROUTE_ORE_ID, game.safe_wagon_state.load) == 1)
	await tap(KEY_E)
	check("real E deposits the ore once at the cave Wagon", game.wagon_stock.size() == stock_before + 1 and game.load_has_pickup(game.ROUTE_ORE_ID, game.wagon_stock) == 1 and game.pickup_copies(game.ROUTE_ORE_ID) == 1)
	await shot("route-returned-deposit")

func offscreen_camp() -> void:
	var away := await hold_until(KEY_D, func(): return game.player.x >= 2300.0, 20.0)
	var away_x: float = game.player.x
	var away_camera: float = game.camera_x
	# Fixture: night with one concrete Stag where it begins its Wagon charge.
	game.clock_seconds = game.DAY_DURATION + 1.0
	game.night_wave_total = 0
	game.shades.clear()
	game.spawn_enemy("STAG OF MIRE", Vector2(game.CARAVAN_X + 300.0, game.GROUND_Y - 34.0), 2, 1)
	var integrity_before: float = game.wagon_integrity
	var clock_before: float = game.clock_seconds
	var saw_windup := false
	var started := Time.get_ticks_msec()
	while game.wagon_integrity >= integrity_before and Time.get_ticks_msec() - started < 15000:
		await process_frame
		saw_windup = saw_windup or (not game.shades.is_empty() and String(game.shades[0].attack_state) == "windup")
	check("the cave Stag telegraphs and damages the Wagon while Lolth stays in the foothills", bool(away.done) and saw_windup and game.wagon_integrity < integrity_before and game.player.x == away_x and game.camera_x == away_camera and game.clock_seconds > clock_before)
	await shot("offscreen-stag-damage-night")
	game.wagon_integrity = 1.0
	started = Time.get_ticks_msec()
	while game.state == "journey" and Time.get_ticks_msec() - started < 15000:
		await process_frame
	check("Wagon destruction away from the cave reaches the defeat card", game.state == "defeat")
	await shot("offscreen-defeat")
	var cured: Array = game.cured_allies.duplicate()
	await tap(KEY_E)
	await process_frame
	check("E restores the cave snapshot with Mark I, the cure and one ore", game.state == "journey" and game.player.x == 330.0 and game.camera_x == 0.0 and game.mark_level == 1 and game.cured_allies == cured and game.wagon_integrity > 0.0 and game.pickup_copies(game.ROUTE_ORE_ID) == 1 and bool(game.route_ore_state().taken))

func camera_offset_combat() -> void:
	var walked := await hold_until(KEY_D, func(): return game.player.x >= 1150.0, 10.0)
	game.shades.clear()
	game.spawn_enemy("BRIAR HOUND", Vector2(game.player.x + 60.0, game.GROUND_Y - 34.0), 3, 1)
	game.hurt_cooldown = 99.0
	await process_frame
	var offset: float = game.camera_x
	await click(Vector2(1200, 580))
	var melee_hit: bool = int(game.shades[0].health) == 2
	await shot("camera-offset-melee")
	await tap(KEY_C)
	check("left-click melee and C First Thread hit by world position under a %.0f px view offset" % offset, bool(walked.done) and offset > 0.0 and melee_hit and bool(game.shades[0].defeated))
	game.shades.clear()
	await tap(KEY_M)
	check("M near the Thornwake border still cannot open the Wagon", not game.ui_management.is_open())

func sprite_visibility(with_lolth: Image, without_lolth: Image, region: Rect2i) -> float:
	return region_difference_plain(with_lolth, without_lolth, region)

func region_difference_plain(a: Image, b: Image, region: Rect2i) -> float:
	var total := 0.0
	for y in range(region.position.y, region.end.y):
		for x in range(region.position.x, region.end.x):
			var c := a.get_pixel(x, y)
			var d := b.get_pixel(x, y)
			total += (absf(c.r - d.r) + absf(c.g - d.g) + absf(c.b - d.b)) / 3.0
	return total / float(maxi(1, region.size.x * region.size.y))

# Measures Lolth's visibility at the two reviewed problem locations, in day and night and both
# facings: the difference she makes on screen with the foreground drawn, relative to the same
# frame with the foreground omitted. Also checks the pass stays out of every other view.
func foreground_readability() -> void:
	var script_path := RES_DIR + ("/readability_fixture.gd" if render_fault == "" else "/faults/" + render_fault + ".gd")
	# The route-run instance is hidden and paused so only the measured view draws.
	if game != null:
		game.visible = false
		game.set_process(false)
	var view = load(script_path).new()
	root.add_child(view)
	await process_frame
	view.set_process(false)
	view.reset_to_prologue()
	view.player = Vector2(1200.0, view.GROUND_Y - view.PLAYER_FEET_OFFSET)
	var closed_route_clear: bool = view.foreground_readability_alpha() == 0.0
	view.reach_expedition_ready_for_test()
	view.shades.clear()
	view.night_wave_total = 0
	view.message_time = 0.0
	view.player_action_time = 0.0
	view.mark_vfx_time = 0.0
	view.pulse = 0.5
	var scoped := closed_route_clear
	for x in [900.0, 2400.0]:
		view.player.x = x
		scoped = scoped and view.foreground_readability_alpha() == 0.0
	check("readability pass stays out of the closed route, the cave view and unoccluded foothills", scoped)
	var ratios := {}
	for night in [false, true]:
		view.clock_seconds = view.DAY_DURATION + 10.0 if night else 10.0
		for x in [1280.0, view.ROUTE_END_X - view.PLAYER_EDGE_MARGIN]:
			for facing_left in [false, true]:
				view.player = Vector2(x, view.GROUND_Y - view.PLAYER_FEET_OFFSET)
				view.player_facing_left = facing_left
				view.velocity = Vector2.ZERO
				view.snap_camera()
				var screen_x := int(round(x - view.camera_x))
				var region := Rect2i(screen_x - 75, int(view.player.y + view.PLAYER_FEET_OFFSET) - 205, 150, 205).intersection(Rect2i(0, 130, 1280, 486))
				var frames := {}
				for hide_foreground in [false, true]:
					view.fixture_hide_foreground = hide_foreground
					for present in [true, false]:
						view.player.y = view.GROUND_Y - view.PLAYER_FEET_OFFSET + (0.0 if present else 3000.0)
						frames[str(hide_foreground) + str(present)] = await capture(view)
				view.player.y = view.GROUND_Y - view.PLAYER_FEET_OFFSET
				view.fixture_hide_foreground = false
				var label := "%s-%04d-%s" % ["night" if night else "day", int(x), "left" if facing_left else "right"]
				if render_fault == "":
					frames["falsetrue"].save_png(out_dir + "/readability-" + label + ".png")
				var occluded := sprite_visibility(frames["falsetrue"], frames["falsefalse"], region)
				var unoccluded := sprite_visibility(frames["truetrue"], frames["truefalse"], region)
				var ratio := occluded / maxf(unoccluded, 0.0001)
				ratios[label] = {"visibility_ratio": ratio, "alpha": view.foreground_readability_alpha()}
				check("Lolth stays readable through the foreground at %s (visibility %.2f of unoccluded)" % [label, ratio], ratio >= READABILITY_MIN_RATIO)
	metrics.foreground_readability = ratios
	await free_node(view)
	if game != null:
		game.visible = true
		game.set_process(true)

func transition_captures() -> void:
	game.set_process(false)
	game.shades.clear()
	game.night_wave_total = 0
	game.message_time = 0.0
	game.player_action_time = 0.0
	game.mark_vfx_time = 0.0
	var title_counts: Array[int] = []
	for night in [false, true]:
		game.clock_seconds = game.DAY_DURATION + 10.0 if night else 10.0
		for x in [1000.0, 1280.0, 1520.0, 1760.0, 2400.0]:
			game.player = Vector2(x, floor_y())
			game.player_facing_left = false
			game.velocity = Vector2.ZERO
			game.snap_camera()
			var image: Image = await shot("transition-%s-%04d" % ["night" if night else "day", int(x)])
			title_counts.append(title_glyph_pixels(image))
			check("frozen %s capture at x=%d uses view offset %.0f" % ["night" if night else "day", int(x), game.camera_x], is_equal_approx(game.camera_x, maxf(0.0, x - game.CAMERA_WINDOW_RIGHT)) and game.is_night() == night)
	metrics.hud_title_glyph_pixels = title_counts
	check("HUD title stays fixed in screen space at every position", title_counts.min() > 50 and title_counts.max() - title_counts.min() <= maxi(2, int(title_counts.min() * 0.02)))
	# Seam continuity: each band edge is mirrored at its own seam, so no visible cut appears.
	game.clock_seconds = 10.0
	for seam in [game.ROUTE_THORNWAKE_END_X, game.ROUTE_FOOTHILLS_START_X]:
		game.camera_x = seam - 640.0
		game.player = Vector2(seam + 300.0, floor_y())
		var image: Image = await shot("seam-%04d" % int(seam))
		var seam_difference := column_difference(image, 640, 140, 610)
		var typical := 0.0
		for column in [400, 500, 760, 880]:
			typical += column_difference(image, column, 140, 610) / 4.0
		metrics["seam_%d" % int(seam)] = {"seam_column_difference": seam_difference, "typical_column_difference": typical}
		check("no visible cut at the x=%d seam (%.4f vs typical %.4f)" % [int(seam), seam_difference, typical], seam_difference <= maxf(typical * 3.0, 0.02))
	game.set_process(true)

func run() -> void:
	root.size = Vector2i(1280, 720)
	if render_fault == "no_foreground_readability":
		await foreground_readability()
		print("B06_RUNTIME_%s: %d/%d checks (render fault: %s)" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks, render_fault])
		quit(0 if failures == 0 else 1)
		return
	if isolation_fault != "":
		await start_route_game()
		print("B06_RUNTIME_%s: %d/%d checks (isolation fault: %s)" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks, isolation_fault])
		quit(0 if failures == 0 else 1)
		return
	if render_fault != "":
		await translation_fixture()
		print("B06_RUNTIME_%s: %d/%d checks (render fault: %s)" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks, render_fault])
		quit(0 if failures == 0 else 1)
		return
	await baseline_parity()
	await translation_fixture()
	await isolation_boundary_control()
	await route_run()
	await offscreen_camp()
	await camera_offset_combat()
	restore_joypad_bindings()
	check("repeated suspension keeps every saved controller binding through restoration", joypad_binding_counts() == metrics.joypad_bindings_before_suspension)
	var restored_bindings := InputMap.action_get_events("shadow_action").size() == 2 and InputMap.action_get_events("move_right").size() >= 4
	game.shades.clear()
	# Root-cause record only: with bindings restored, a 0.21 trigger value passes the 0.2 deadzone.
	metrics.restored_trigger_021_dashes = await trigger_dashes(0.21)
	var controller_dash: bool = await trigger_dashes(1.0)
	check("restored controller bindings dash again on a synthetic right trigger", restored_bindings and controller_dash)
	await foreground_readability()
	await transition_captures()
	var file := FileAccess.open(out_dir + "/runtime-metrics.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(metrics, "\t") + "\n")
	print("B06_RUNTIME_%s: %d/%d checks" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks])
	quit(0 if failures == 0 else 1)

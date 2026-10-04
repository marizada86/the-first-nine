extends SceneTree
# Independent source-pixel assertions plus optional normal-rendering captures.
# Fault fixtures are validation-only subclasses, never used by main.tscn.

var game
var failures := 0
var checks := 0
var expected_bounds: Dictionary = {}
var telemetry: Dictionary = {}
var out_dir := "res://.atena/generated/2026-10-04-b05-geometry-validation"

func _initialize() -> void:
	call_deferred("run")

func check(label: String, passed: bool) -> void:
	checks += 1
	print("GEOMETRY %s %s" % ["PASS" if passed else "FAIL", label])
	if not passed:
		failures += 1

func native_source(sheet: Texture2D, column: int, row: int) -> Rect2:
	var left := int(sheet.get_width() * column / 2.0)
	var right := int(sheet.get_width() * (column + 1) / 2.0)
	var top := int(sheet.get_height() * row / 2.0)
	var bottom := int(sheet.get_height() * (row + 1) / 2.0)
	return Rect2(left, top, right - left, bottom - top)

func native_bounds(sheet: Texture2D, source: Rect2) -> Rect2i:
	# This is test-only, independently reads source alpha rather than trusting cache.
	var pixels := sheet.get_image().get_region(Rect2i(source))
	var left := pixels.get_width()
	var right := -1
	var top := pixels.get_height()
	var bottom := -1
	for y in pixels.get_height():
		for x in pixels.get_width():
			if pixels.get_pixel(x, y).a >= 0.25:
				left = mini(left, x)
				right = maxi(right, x)
				top = mini(top, y)
				bottom = maxi(bottom, y)
	return Rect2i(left, top, right - left + 1, bottom - top + 1)

func expected_reach(sheet: Texture2D, enemy: Dictionary) -> float:
	var row := 1 if game.player.distance_to(enemy.pos) < 150.0 else 0
	var column := 0 if row == 1 else int(floor(game.pulse * 4.0)) % 2
	var source := native_source(sheet, column, row)
	var bounds: Rect2i = expected_bounds[sheet.resource_path + str(source)]
	return 44.0 + float(bounds.size.x) * float(game.THORNWAKE_ENEMY_SIZES[enemy.name]) / source.size.y / 2.0

func shot(name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return
	game.queue_redraw()
	await RenderingServer.frame_post_draw
	root.get_texture().get_image().save_png(out_dir + "/" + name + ".png")

func run() -> void:
	root.size = Vector2i(1280, 720)
	var fault := ""
	var args := OS.get_cmdline_user_args()
	var fault_index := args.find("--geometry-fault")
	if fault_index >= 0 and fault_index + 1 < args.size():
		fault = args[fault_index + 1]
	if fault != "":
		game = load(out_dir + "/faults/" + fault + ".gd").new()
	else:
		game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.set_process(false)
	game.reset_to_prologue()
	game.shades.clear()
	game.salvage.clear()
	var prepared_scans: int = game.ui_enemy_bounds_scans
	check("startup prepares all 22 runtime cells", prepared_scans == 22 and game.ui_enemy_bounds.size() == 22)
	print("GEOMETRY_PREPARE: cells=%d time_ms=%.3f" % [prepared_scans, game.ui_enemy_bounds_startup_usec / 1000.0])
	telemetry.startup_cells = prepared_scans
	telemetry.startup_ms = game.ui_enemy_bounds_startup_usec / 1000.0
	if prepared_scans != 22:
		print("GEOMETRY_FAIL: startup preparation missing")
		quit(1)
		return
	var sheets := {"BRIAR HOUND": game.BRIAR_HOUND_RUNTIME, "STAG OF MIRE": game.STAG_OF_MIRE_RUNTIME, "ANTLERED HUNGER": game.ANTLERED_HUNGER_RUNTIME}
	var frame_reaches: Dictionary = {}
	for enemy_name in sheets:
		var sheet: Texture2D = sheets[enemy_name]
		game.spawn_enemy(enemy_name, Vector2(780, game.GROUND_Y - 34), 6, 0)
		var enemy: Dictionary = game.shades.back()
		var reported: Array = []
		for frame in 4:
			var column := frame % 2
			var row := int(frame / 2)
			game.pulse = 0.0 if column == 0 else 0.26
			game.player = Vector2(730 if row == 1 else 440, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
			enemy.defeated = frame == 3
			enemy.defeated_at = game.pulse
			var source := native_source(sheet, column, row)
			var bounds := native_bounds(sheet, source)
			expected_bounds[sheet.resource_path + str(source)] = bounds
			var geometry: Dictionary = game.enemy_draw_geometry(enemy)
			var destination: Rect2 = geometry.destination
			var body: Rect2 = geometry.body
			var scale_factor := float(game.THORNWAKE_ENEMY_SIZES[enemy_name]) / source.size.y
			check("%s frame %d source/aspect" % [enemy_name, frame], geometry.source == source and is_equal_approx(destination.size.x / source.size.x, destination.size.y / source.size.y))
			check("%s frame %d native outline/centering/floor" % [enemy_name, frame], body.size.is_equal_approx(Vector2(bounds.size) * scale_factor) and is_equal_approx(body.get_center().x, enemy.pos.x) and is_equal_approx(body.end.y, game.GROUND_Y))
			check("%s frame %d native shared reach" % [enemy_name, frame], is_equal_approx(game.melee_reach(enemy), 44.0 + float(bounds.size.x) * scale_factor / 2.0))
			reported.append({"frame": frame, "body_width": body.size.x, "reach": game.melee_reach(enemy)})
		frame_reaches[enemy_name] = reported
		game.shades.clear()
	# Independent alpha-derived boundary, not the production melee_reach result.
	for enemy_name in sheets:
		var sheet: Texture2D = sheets[enemy_name]
		game.spawn_enemy(enemy_name, Vector2(780, game.GROUND_Y - 34), 6, 0)
		var enemy: Dictionary = game.shades.back()
		game.pulse = 0.0
		var last_hit := 0
		for gap in range(30, 400):
			game.player = Vector2(780 - gap, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
			if gap <= expected_reach(sheet, enemy):
				last_hit = gap
		game.player.x = 780 - last_hit + 1
		game.combo_time = 0.0
		game.handle_attack()
		check(enemy_name + " native boundary hits", enemy.health == 5)
		enemy.health = 6
		game.player.x = 780 - last_hit - 2
		game.handle_attack()
		check(enemy_name + " outside native boundary misses", enemy.health == 6)
		print("GEOMETRY_BOUNDARY: %s last_hit=%d" % [enemy_name, last_hit])
		game.shades.clear()
	# Enemy damage remains the existing 35 px rule, not the enlarged visual outline.
	game.spawn_enemy("BRIAR HOUND", Vector2(780, game.GROUND_Y - 34), 6, 0)
	var hound: Dictionary = game.shades.back()
	game.health = game.max_health()
	game.hurt_cooldown = 0.0
	game.player = Vector2(700, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	game.check_enemy_contact()
	check("enlarged visual overlap does not rebalance contact damage", game.health == game.max_health())
	game.player = hound.pos
	game.check_enemy_contact()
	check("existing close contact still causes genuine damage", game.health == game.max_health() - 1.0)
	game.shades.clear()
	game.health = game.max_health()
	game.clear_combat_visuals()
	game.message = "THORNWAKE GEOMETRY — Controlled proportions capture."
	game.message_time = 5.0
	game.pulse = 0.0
	game.player = Vector2(440, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	for enemy_name in sheets:
		game.spawn_enemy(enemy_name, Vector2(780, game.GROUND_Y - 34), 6, 0)
		await shot(String(enemy_name).to_lower().replace(" ", "-") + "-aspect")
		game.shades.clear()
	# Normal wave and boss setup must also reuse prepared data.
	game.reset_to_prologue()
	game.set_process(false)
	game.clock_seconds = game.DAY_DURATION - 0.01
	game.update_clock(0.02)
	game.enemy_draw_geometry(game.shades[0])
	game.player = game.shades[0].pos
	game.handle_attack()
	game.update_night_waves(0.0)
	game.update_night_waves(game.NIGHT_WAVE_INTERVAL)
	game.enemy_draw_geometry(game.shades[0])
	game.shades.clear()
	game.spawn_enemy("ANTLERED HUNGER", Vector2(780, game.GROUND_Y - 34), 12, 0)
	game.enemy_draw_geometry(game.shades[0])
	check("frames/waves/boss/attacks perform zero gameplay pixel scans", game.ui_enemy_bounds_scans == prepared_scans and game.ui_enemy_bounds.size() == 22)
	telemetry.gameplay_added_scans = game.ui_enemy_bounds_scans - prepared_scans
	telemetry.frames = frame_reaches
	telemetry.checks = checks
	telemetry.failures = failures
	if fault == "":
		var file := FileAccess.open(out_dir + "/geometry-metrics.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(telemetry, "\t") + "\n")
	print("GEOMETRY_%s: %d/%d checks fault=%s" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks, fault])
	quit(0 if failures == 0 else 1)

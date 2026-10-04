extends SceneTree
# Independent movement/state assertions and paired rendered-pixel checks.
var game
var checks := 0
var failures := 0
var out_dir := "res://.atena/generated/2026-10-04-enemy-facing-validation"
var fault := ""
var raster_metrics: Array = []
var native_widths: Dictionary = {}

func prepare_native_oracle() -> void:
	for sheet in [game.BRIAR_HOUND_RUNTIME, game.STAG_OF_MIRE_RUNTIME, game.ANTLERED_HUNGER_RUNTIME]:
		var atlas: Image = sheet.get_image()
		for row in 2:
			for column in 2:
				var left := int(sheet.get_width() * column / 2.0)
				var right := int(sheet.get_width() * (column + 1) / 2.0)
				var top := int(sheet.get_height() * row / 2.0)
				var bottom := int(sheet.get_height() * (row + 1) / 2.0)
				var minimum := right
				var maximum := -1
				for y in range(top, bottom):
					for x in range(left, right):
						if atlas.get_pixel(x, y).a >= 0.25:
							minimum = mini(minimum, x)
							maximum = maxi(maximum, x)
				native_widths[sheet.resource_path + str(row) + str(column)] = float(maximum - minimum + 1) / float(bottom - top)

func native_reach(enemy: Dictionary) -> float:
	var sheet: Texture2D = game.BRIAR_HOUND_RUNTIME
	if enemy.name == "STAG OF MIRE":
		sheet = game.STAG_OF_MIRE_RUNTIME
	elif enemy.name == "ANTLERED HUNGER":
		sheet = game.ANTLERED_HUNGER_RUNTIME
	var row := 1 if game.player.distance_to(enemy.pos) < 150.0 else 0
	var column := 0 if row == 1 else int(floor(game.pulse * 4.0)) % 2
	return 44.0 + native_widths[sheet.resource_path + str(row) + str(column)] * float(game.THORNWAKE_ENEMY_SIZES[enemy.name]) / 2.0

func _initialize() -> void:
	fault = OS.get_environment("FACING_FAULT")
	call_deferred("run")

func check(label: String, passed: bool) -> void:
	checks += 1
	print("FACING %s %s" % ["PASS" if passed else "FAIL", label])
	if not passed:
		failures += 1

func new_enemy(name: String, x: float = 780.0) -> Dictionary:
	game.shades.clear()
	game.spawn_enemy(name, Vector2(x, game.GROUND_Y - 34), 6, 0)
	return game.shades[0]

func color_distance(a: Color, b: Color) -> float:
	return (absf(a.r - b.r) + absf(a.g - b.g) + absf(a.b - b.b)) / 3.0

func region_difference(a: Image, b: Image, region: Rect2i, reflect: bool = false, center: int = 780) -> float:
	var total := 0.0
	for y in range(region.position.y, region.end.y):
		for x in range(region.position.x, region.end.x):
			total += color_distance(a.get_pixel(x, y), b.get_pixel(2 * center - 1 - x if reflect else x, y))
	return total / float(region.size.x * region.size.y)

func capture() -> Image:
	game.queue_redraw()
	await process_frame
	await RenderingServer.frame_post_draw
	return root.get_texture().get_image()

func run() -> void:
	root.size = Vector2i(1280, 720)
	game = load(out_dir + "/render_fixture.gd" if fault == "" else out_dir + "/faults/" + fault + ".gd").new()
	root.add_child(game)
	game.set_process(false)
	game.reset_to_prologue()
	game.state = "journey"
	game.salvage.clear()
	game.shades.clear()
	var scans: int = game.ui_enemy_bounds_scans
	check("all 22 atlas cells are prepared", scans == 22)
	prepare_native_oracle()
	# Initial facing points towards the initial target, even before the first tick.
	game.player.x = 440.0
	for name in ["BRIAR HOUND", "STAG OF MIRE", "ANTLERED HUNGER"]:
		var enemy := new_enemy(name)
		check(name + " spawn faces its left target", game.enemy_facing_left(enemy))
		var target_x: float = game.CARAVAN_X if name == "STAG OF MIRE" else 760.0
		game.player.x = 760.0
		enemy = new_enemy(name, target_x - 150.0)
		check(name + " spawn faces its right target", not game.enemy_facing_left(enemy))
		# Force a stale facing before each movement to expose a missing update.
		for direction in [-1.0, 1.0]:
			enemy.pos.x = target_x - direction * 150.0
			enemy.attack_state = "approach"
			enemy.attack_time = 0.0
			enemy.attack_count = 0
			enemy.facing_left = direction > 0.0
			var previous_x: float = enemy.pos.x
			game.update_enemies(0.01)
			check("%s moves/faces %s" % [name, direction], (enemy.pos.x - previous_x) * direction > 0.0 and game.enemy_facing_left(enemy) == (direction < 0.0))
		# Telegraph/strike cannot turn to follow a target crossing behind.
		for direction in [-1.0, 1.0]:
			enemy.pos.x = 780.0
			enemy.attack_state = "windup"
			enemy.attack_time = 1.0
			enemy.attack_target = "lolth"
			enemy.attack_dir = direction
			enemy.facing_left = direction < 0.0
			game.player.x = 780.0 - direction * 300.0
			game.update_enemies(0.01)
			check("%s windup locks %s despite target crossing" % [name, direction], enemy.attack_dir == direction and game.enemy_facing_left(enemy) == (direction < 0.0))
			enemy.attack_state = "strike"
			enemy.attack_time = 1.0
			var previous_x: float = enemy.pos.x
			game.update_enemies(0.01)
			check("%s strike moves/faces locked %s" % [name, direction], (enemy.pos.x - previous_x) * direction > 0.0 and game.enemy_facing_left(enemy) == (direction < 0.0))
		enemy.attack_state = "recover"
		enemy.attack_time = 1.0
		var held: bool = game.enemy_facing_left(enemy)
		game.player.x = 440.0
		game.update_enemies(0.01)
		check(name + " stationary recovery retains facing", game.enemy_facing_left(enemy) == held)
		enemy.defeated = true
		var position: Vector2 = enemy.pos
		game.update_enemies(0.1)
		check(name + " defeated retains position and facing", enemy.pos == position and game.enemy_facing_left(enemy) == held)
	# Zero-motion clamping/zero target distance do not cause turns.
	var enemy := new_enemy("BRIAR HOUND", 780.0)
	enemy.facing_left = true
	game.player.x = 780.0
	enemy.attack_state = "recover"
	enemy.attack_time = 1.0
	game.update_enemies(0.01)
	check("zero horizontal distance does not flicker", game.enemy_facing_left(enemy))
	var legacy: Dictionary = enemy.duplicate(true)
	legacy.erase("facing_left")
	legacy.attack_state = "strike"
	legacy.attack_dir = -1.0
	check("legacy dictionary fallback uses locked attack direction", game.enemy_facing_left(legacy))
	legacy.attack_state = "approach"
	game.player.x = 1120.0
	check("legacy dictionary fallback faces target", not game.enemy_facing_left(legacy))
	# Generic path includes retreat away from a close target.
	game.zone = 1
	game.player.x = 850.0
	enemy = new_enemy("CLIFF HARRIER", 780.0)
	check("generic spawn faces right target", not game.enemy_facing_left(enemy))
	game.update_enemies(0.01)
	check("generic negative-speed retreat faces actual left movement", enemy.pos.x < 780.0 and game.enemy_facing_left(enemy))
	game.player.x = 440.0
	game.update_enemies(0.01)
	check("generic forward pursuit also faces left", game.enemy_facing_left(enemy))
	enemy.pos.x = 70.0
	game.player.x = 0.0
	enemy.behavior = "stalk"
	enemy.facing_left = false
	game.update_enemies(0.01)
	check("clamped zero-motion retains facing", enemy.pos.x == 70.0 and not game.enemy_facing_left(enemy))
	game.zone = 0
	game.player.x = 440.0
	enemy = new_enemy("BRIAR HOUND")
	enemy.facing_left = true
	game.begin_playtester_session()
	enemy.facing_left = false
	game.shades.clear()
	game.restore_playtester_session()
	check("F4 deep snapshot restores enemy facing", game.shades.size() == 1 and game.enemy_facing_left(game.shades[0]) and not game.playtester_active)
	# Safe-wagon restore intentionally clears threats, rather than resurrecting facing.
	game.mark_level = 1
	game.cured_allies.clear()
	game.cured_allies.append("AELIRA")
	game.player.x = 220.0
	game.shades.clear()
	game.capture_safe_wagon_state()
	enemy = new_enemy("BRIAR HOUND")
	game.restore_safe_wagon_state()
	check("safe-wagon restore clears threats and preserves Mark/cure", game.shades.is_empty() and game.mark_level == 1 and game.cured_allies == ["AELIRA"])
	game.reset_to_prologue()
	game.state = "journey"
	game.set_process(false)
	game.player = Vector2(440, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	game.salvage.clear()
	game.shades.clear()
	# All four native frames, including the defeated pose, preserve shared geometry.
	for name in ["BRIAR HOUND", "STAG OF MIRE", "ANTLERED HUNGER"]:
		enemy = new_enemy(name)
		for frame in 4:
			game.pulse = 0.26 if frame % 2 == 1 else 0.0
			game.player.x = 730.0 if frame == 2 else 440.0
			enemy.defeated = frame == 3
			enemy.defeated_at = game.pulse
			enemy.facing_left = false
			var right: Dictionary = game.enemy_draw_geometry(enemy)
			var reach: float = game.melee_reach(enemy)
			enemy.facing_left = true
			var left: Dictionary = game.enemy_draw_geometry(enemy)
			check("%s frame %d mirrored geometry/feet/reach unchanged" % [name, frame], right == left and is_equal_approx(reach, game.melee_reach(enemy)) and is_equal_approx(left.body.get_center().x, enemy.pos.x) and is_equal_approx(left.body.end.y, game.GROUND_Y))
			if DisplayServer.get_name() != "headless":
				enemy.facing_left = false
				var right_image: Image = await capture()
				enemy.facing_left = true
				var left_image: Image = await capture()
				var width := int(ceil(right.body.size.x / 2.0)) + 2
				var top := int(floor(right.body.position.y))
				var body_rect := Rect2i(780 - width, top, width * 2, int(game.GROUND_Y) - top + 2)
				var mirrored_error := region_difference(left_image, right_image, body_rect, true)
				var unmirrored_error := region_difference(left_image, right_image, body_rect)
				check("%s frame %d raster is horizontal reflection" % [name, frame], mirrored_error < 0.012 and unmirrored_error > 0.01)
				var label_rect := Rect2i(500, maxi(0, top - 55), 560, mini(54, top))
				check("%s frame %d labels/bars stay unmirrored" % [name, frame], region_difference(left_image, right_image, label_rect) < 0.0001)
				check("%s frame %d subsequent world marker stays fixed" % [name, frame], left_image.get_pixel(96, 96).is_equal_approx(Color.MAGENTA))
				raster_metrics.append({"enemy": name, "frame": frame, "mirror_error": mirrored_error, "unmirrored_error": unmirrored_error})
				if frame == 0 and fault == "":
					var prefix := String(name).to_lower().replace(" ", "-")
					right_image.save_png(out_dir + "/" + prefix + "-right-isolated.png")
					left_image.save_png(out_dir + "/" + prefix + "-left-isolated.png")
	# Symmetric hit/miss boundaries and no new native-alpha scans.
	game.pulse = 0.0
	for name in ["BRIAR HOUND", "STAG OF MIRE", "ANTLERED HUNGER"]:
		for side in [-1.0, 1.0]:
			enemy = new_enemy(name)
			enemy.facing_left = side > 0.0
			var last_hit := 0
			for gap in range(30, 400):
				game.player.x = 780.0 + side * float(gap)
				if gap <= native_reach(enemy):
					last_hit = gap
			game.player.x = 780.0 + side * float(last_hit - 1)
			game.combo_time = 0.0
			game.handle_attack()
			check("%s %s-side hit boundary" % [name, side], enemy.health == 5)
			enemy.health = 6
			game.player.x = 780.0 + side * float(last_hit + 2)
			game.handle_attack()
			check("%s %s-side miss boundary" % [name, side], enemy.health == 6)
	check("facing changes add zero alpha scans", game.ui_enemy_bounds_scans == scans and game.ui_enemy_bounds.size() == 22)
	# Full production rendering overview: fixture is removed, not a game art edit.
	if DisplayServer.get_name() != "headless" and fault == "":
		root.remove_child(game)
		game.queue_free()
		game = load("res://main.tscn").instantiate()
		root.add_child(game)
		game.set_process(false)
		game.reset_to_prologue()
		game.state = "journey"
		game.salvage.clear()
		game.shades.clear()
		game.pulse = 0.0
		game.player.x = 260.0
		for entry in [["BRIAR HOUND", 490.0], ["STAG OF MIRE", 780.0], ["ANTLERED HUNGER", 1080.0]]:
			game.spawn_enemy(entry[0], Vector2(entry[1], game.GROUND_Y - 34), 6, 0)
		var overview_right: Image
		var allowed_regions: Array[Rect2] = []
		for shade in game.shades:
			var destination: Rect2 = game.enemy_draw_geometry(shade).destination
			allowed_regions.append(destination)
			allowed_regions.append(Rect2(float(shade.pos.x) * 2.0 - destination.end.x, destination.position.y, destination.size.x, destination.size.y))
		for facing in [false, true]:
			for shade in game.shades:
				shade.facing_left = facing
			var overview: Image = await capture()
			overview.save_png(out_dir + ("/overview-left.png" if facing else "/overview-right.png"))
			if not facing:
				overview_right = overview
			else:
				var outside_changes := 0
				var sprite_changes := 0
				var outside_min := Vector2i(1280, 720)
				var outside_max := Vector2i.ZERO
				for y in 720:
					for x in 1280:
						if color_distance(overview.get_pixel(x, y), overview_right.get_pixel(x, y)) <= 0.001:
							continue
						var allowed := false
						for region in allowed_regions:
							# A raster sample is at the pixel center, not its top-left edge.
							if region.has_point(Vector2(x + 0.5, y + 0.5)):
								allowed = true
								break
						if allowed:
							sprite_changes += 1
						else:
							outside_changes += 1
							outside_min = Vector2i(mini(outside_min.x, x), mini(outside_min.y, y))
							outside_max = Vector2i(maxi(outside_max.x, x), maxi(outside_max.y, y))
							if outside_changes <= 8:
								print("FACING_OUTSIDE_PIXEL: %s difference=%.6f" % [Vector2i(x, y), color_distance(overview.get_pixel(x, y), overview_right.get_pixel(x, y))])
				print("FACING_OVERVIEW: sprite_changes=%d outside=%d bounds=%s..%s allowed=%s" % [sprite_changes, outside_changes, outside_min, outside_max, allowed_regions])
				check("production scene changes only enemy sprites, not Lolth/HUD/wagon/background", outside_changes == 0 and sprite_changes > 100)
	var report := {"checks": checks, "failures": failures, "fault": fault, "rendered": DisplayServer.get_name() != "headless", "raster_metrics": raster_metrics}
	if fault == "":
		var suffix := "normal" if report.rendered else "headless"
		var file := FileAccess.open(out_dir + "/facing-" + suffix + "-metrics.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(report, "\t") + "\n")
	print("FACING_%s: %d/%d checks fault=%s" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks, fault])
	quit(0 if failures == 0 else 1)

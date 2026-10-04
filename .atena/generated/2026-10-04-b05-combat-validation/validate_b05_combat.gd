extends SceneTree
# B-05 real-input combat validation at 1280x720. Keyboard and mouse events go through
# Input.parse_input_event, so the game's own input handling runs every frame.
# Run: godot --rendering-driver opengl3 --path . -s .atena/generated/2026-10-04-b05-combat-validation/validate_b05_combat.gd

var game: Node
var out_dir := "res://.atena/generated/2026-10-04-b05-combat-validation"
var failures := 0

func key(code: Key, pressed: bool) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = code
	event.pressed = pressed
	Input.parse_input_event(event)

func tap(code: Key) -> void:
	key(code, true)
	await process_frame
	key(code, false)
	await process_frame

func click_button(button: Button) -> void:
	var point := button.get_global_rect().get_center()
	for pressed in [true, false]:
		var event := InputEventMouseButton.new()
		event.position = point
		event.button_index = MOUSE_BUTTON_LEFT
		event.pressed = pressed
		Input.parse_input_event(event)
		await process_frame

func live(name: String) -> Dictionary:
	for shade in game.shades:
		if String(shade.name) == name and not shade.defeated:
			return shade
	return {}

func gap(enemy: Dictionary) -> float:
	return absf(float(enemy.pos.x) - game.player.x) if not enemy.is_empty() else -1.0

func report(tag: String, enemy: Dictionary) -> void:
	print("%s gap=%.0f enemy_hp=%s lolth_hp=%.1f pose=%s hurt_overlay=%s vfx=%s msg=%s" % [tag, gap(enemy), str(enemy.get("health", "-")), game.health, game.player_pose(), game.player_hurt_visible(), game.mark_vfx_kind, game.message])

func check(label: String, ok: bool) -> void:
	print("RUNTIME %s %s" % ["PASS" if ok else "FAIL", label])
	if not ok:
		failures += 1

func shot(name: String) -> void:
	await RenderingServer.frame_post_draw
	root.get_texture().get_image().save_png(out_dir + "/" + name + ".png")

func next_night() -> void:
	await tap(KEY_F4)
	var night_button: Button = game.playtester_panel.get_child(0).get_child(0).get_child(3).get_child(1)
	await click_button(night_button)
	await tap(KEY_F4)
	await process_frame

func walk_until(direction_key: Key, enemy_name: String, target_gap: float) -> void:
	key(direction_key, true)
	var guard := 0
	while guard < 600:
		var enemy := live(enemy_name)
		if enemy.is_empty() or gap(enemy) <= target_gap:
			break
		await process_frame
		guard += 1
	key(direction_key, false)
	await process_frame

func _initialize() -> void:
	if OS.get_environment("OUT") != "":
		out_dir = OS.get_environment("OUT")
	call_deferred("run")

func run() -> void:
	root.size = Vector2i(1280, 720)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await process_frame
	await tap(KEY_ESCAPE)
	await next_night()
	var hound := live("BRIAR HOUND")
	check("F4 Next night spawns a Briar Hound", not hound.is_empty() and game.is_night())
	# Dodge with no enemy contact: dodge pose and effect, no hurt pose, no damage.
	var lolth_before: float = game.health
	key(KEY_SHIFT, true)
	await process_frame
	await process_frame
	report("DODGE", hound)
	check("dodge shows the dodge pose and dash effect without hurt (Lolth %.1f -> %.1f)" % [lolth_before, game.health], game.player_pose() == "dodge" and game.mark_vfx_kind == "dash" and not game.player_hurt_visible() and game.health == lolth_before)
	await shot("b05-dodge")
	key(KEY_SHIFT, false)
	for i in 30:
		await process_frame
	# Hit at visible contact: walk until the bodies touch, then press the attack key.
	await walk_until(KEY_D, "BRIAR HOUND", 82.0)
	hound = live("BRIAR HOUND")
	var hound_before := int(hound.health)
	var hit_gap := gap(hound)
	lolth_before = game.health
	report("HIT_BEFORE", hound)
	key(KEY_E, true)
	await process_frame
	await process_frame
	report("HIT_AFTER", hound)
	check("attack pressed at %.0f px visible contact damages the hound (%d -> %d), Lolth %.1f -> %.1f" % [hit_gap, hound_before, int(hound.health), lolth_before, game.health], int(hound.health) < hound_before and game.player_pose() == "strike" and game.mark_vfx_kind == "strike")
	await shot("b05-hit")
	key(KEY_E, false)
	check("the defeated hound grants no Echo before Mark I", bool(hound.defeated) and game.shadow_echoes == 0)
	# The wave progresses to the Stag of Mire.
	var guard := 0
	while live("STAG OF MIRE").is_empty() and guard < 400:
		await process_frame
		guard += 1
	var stag := live("STAG OF MIRE")
	check("night wave advances to the Stag of Mire (wave %d)" % game.night_wave, not stag.is_empty() and game.night_wave == 2)
	# Miss beyond reach: a visible swing, no damage.
	game.hurt_cooldown = 99.0
	await walk_until(KEY_D, "STAG OF MIRE", 140.0)
	stag = live("STAG OF MIRE")
	var stag_before := int(stag.health)
	var miss_gap := gap(stag)
	key(KEY_E, true)
	await process_frame
	await process_frame
	report("MISS", stag)
	check("attack at %.0f px misses the stag (%d -> %d) with a distinct swing" % [miss_gap, stag_before, int(stag.health)], int(stag.health) == stag_before and game.mark_vfx_kind == "swing" and game.player_pose() == "strike" and String(game.message).begins_with("Out of reach"))
	await shot("b05-miss")
	key(KEY_E, false)
	await process_frame
	# Close in and defeat the stag with real presses.
	var presses := 0
	while not live("STAG OF MIRE").is_empty() and presses < 12:
		stag = live("STAG OF MIRE")
		var direction_key := KEY_D if float(stag.pos.x) > game.player.x else KEY_A
		if gap(stag) > 90.0:
			await walk_until(direction_key, "STAG OF MIRE", 90.0)
		await tap(KEY_E)
		presses += 1
	# Clearing the last tutorial wave before Mark I ends the night at the B-02 safe camp.
	check("real presses defeat the stag (%d presses) and clear the night (phase %s)" % [presses, game.tutorial_phase], live("STAG OF MIRE").is_empty() and (game.night_waves_complete or game.tutorial_phase == "safe_camp"))
	game.hurt_cooldown = 0.0
	# A genuine hound strike on Lolth: hurt pose and overlay appear only with real damage.
	await next_night()
	hound = live("BRIAR HOUND")
	lolth_before = game.health
	guard = 0
	while game.health == lolth_before and guard < 600:
		await process_frame
		guard += 1
	report("HURT", hound)
	check("a real hound strike lowers Lolth (%.1f -> %.1f) and shows the hurt pose and overlay" % [lolth_before, game.health], game.health < lolth_before and game.player_pose() == "hurt" and game.player_hurt_visible())
	await shot("b05-hurt")
	# Restore the run through the playtester panel.
	await tap(KEY_F4)
	await click_button(game.playtester_restore_button)
	check("playtester restore returns to the original run", not game.playtester_active and game.mark_level == 0 and not game.is_night())
	print("B05_RUNTIME_%s: %d failures" % ["PASS" if failures == 0 else "FAIL", failures])
	quit(0 if failures == 0 else 1)

extends SceneTree
# Real keyboard/mouse/controller dispatch plus normal-rendering assertions.
# Run without fixed FPS: godot --path . --resolution 1280x720 -s res://.atena/generated/2026-10-04-b05-local-controls-validation/validate_controls_and_menus.gd

var game
var failures := 0
var checks := 0
var out_dir := "res://.atena/generated/2026-10-04-b05-local-controls-validation"

func _initialize() -> void:
	call_deferred("run")

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

func mouse(button_index: MouseButton, pressed: bool, point: Vector2 = Vector2(1200, 580)) -> void:
	var event := InputEventMouseButton.new()
	event.position = point
	event.button_index = button_index
	event.pressed = pressed
	Input.parse_input_event(event)

func click(point: Vector2) -> void:
	mouse(MOUSE_BUTTON_LEFT, true, point)
	await process_frame
	await process_frame
	mouse(MOUSE_BUTTON_LEFT, false, point)
	await process_frame

func click_button(item: Button) -> void:
	var ancestor := item.get_parent()
	while is_instance_valid(ancestor):
		if ancestor is ScrollContainer:
			ancestor.ensure_control_visible(item)
			break
		ancestor = ancestor.get_parent()
	await process_frame
	await process_frame
	await click(item.get_global_rect().get_center())

func find_button(identity: String) -> Button:
	for item in game.ui_management.overlay.find_children("*", "Button", true, false):
		if String(item.get_meta("identity", "")) == identity:
			return item
	return null

func check(label: String, passed: bool) -> void:
	checks += 1
	print("LOCAL %s %s" % ["PASS" if passed else "FAIL", label])
	if not passed:
		failures += 1

func shot(name: String) -> Image:
	game.queue_redraw()
	await RenderingServer.frame_post_draw
	var picture := root.get_texture().get_image()
	picture.save_png(out_dir + "/" + name + ".png")
	return picture

func controller_menu() -> void:
	await controller_button(JOY_BUTTON_BACK)

func controller_button(button_index: JoyButton) -> void:
	for pressed in [true, false]:
		var event := InputEventJoypadButton.new()
		event.button_index = button_index
		event.pressed = pressed
		Input.parse_input_event(event)
		await process_frame

func run() -> void:
	root.size = Vector2i(1280, 720)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await process_frame
	await click(Vector2(1200, 580))
	check("gameplay left-click does not advance the opening", game.state == "opening" and game.opening_beat == 0)
	await tap(KEY_E)
	check("E advances narrative confirmation", game.opening_beat == 1)
	await tap(KEY_ESCAPE)
	game.player = Vector2(500, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	game.velocity = Vector2.ZERO
	game.hurt_cooldown = 99.0
	game.shades.clear()
	game.spawn_enemy("BRIAR HOUND", Vector2(580, game.GROUND_Y - 34), 10, 0)
	var enemy: Dictionary = game.shades[0]
	game.salvage.assign([{"pos": game.player, "name": "TEST HERB", "type": "herb", "slots": 1, "taken": false}])
	await tap(KEY_E)
	check("E collects without attacking the overlapping enemy", game.recovered_load.size() == 1 and int(enemy.health) == 10)
	game.salvage.append({"pos": game.player, "name": "TEST WATER", "type": "water", "slots": 1, "taken": false})
	await click(Vector2(1200, 580))
	check("left-click attacks without collecting", int(enemy.health) == 9 and game.recovered_load.size() == 1 and not game.salvage[1].taken)
	await tap(KEY_I)
	check("I opens carried inventory away from the Wagon", game.ui_management.is_open() and game.ui_management.mode == "inventory" and is_instance_valid(find_button("load_0")))
	var clock_before: float = game.clock_seconds
	var flame_before: float = game.flame
	var provisions_before: float = game.provisions
	await create_timer(0.15).timeout
	check("inventory pauses world time and survival", game.clock_seconds == clock_before and game.flame == flame_before and game.provisions == provisions_before)
	await shot("inventory-carried")
	var hp_before := int(enemy.health)
	await click_button(find_button("load_0"))
	check("inventory selection click cannot attack or duplicate items", int(enemy.health) == hp_before and game.recovered_load.size() == 1)
	await click_button(game.ui_management.close_button)
	await process_frame
	check("closing inventory consumes the click", not game.ui_management.is_open() and int(enemy.health) == hp_before and game.recovered_load.size() == 1)
	await tap(KEY_M)
	check("M cannot open the Wagon away from camp", not game.ui_management.is_open())
	game.player = Vector2(game.CARAVAN_X + 20, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	game.velocity = Vector2.ZERO
	await tap(KEY_M)
	check("M opens the Wagon near camp", game.ui_management.mode == "wagon" and game.ui_management.is_open())
	await click_button(find_button("store"))
	check("Wagon storage moves one existing item without duplication", game.recovered_load.is_empty() and game.wagon_stock.size() == 1)
	game.wagon_stock.assign([{"name": "WOOD", "type": "wood", "slots": 1}, {"name": "ROPE", "type": "rope", "slots": 1}, {"name": "SALVAGE", "type": "salvage", "slots": 1}])
	game.ui_management.refresh()
	await shot("wagon-supplies")
	find_button("craft").grab_focus()
	await tap(KEY_E)
	check("menu crafting preserves the Wheel Kit tutorial", game.wagon_stock.is_empty() and game.wagon_repair == 1 and game.tutorial_phase == "dusk")
	await click_button(find_button("allies"))
	var ally_rows := 0
	var locked := true
	for ally in game.THALESTRIEL:
		var item := find_button("ally_" + String(ally))
		ally_rows += 1 if is_instance_valid(item) else 0
		locked = locked and is_instance_valid(item) and item.disabled
	check("Allies lists all eight with locked Thornwake assignments", ally_rows == 8 and locked and find_button("assign_mission").disabled)
	game.ui_management.manage_ally("AELIRA")
	game.ui_management.assign_mission()
	check("callbacks cannot bypass cave role locks", game.posted_allies.is_empty() and game.passive_mission.is_empty() and game.cured_allies.is_empty())
	await shot("wagon-allies")
	await tap(KEY_M)
	await tap(KEY_Q)
	await tap(KEY_R)
	check("direct ally-management shortcuts are retired", not InputMap.has_action("post_cycle") and not InputMap.has_action("post_toggle") and game.posted_allies.is_empty())
	game.player.x = 500
	await controller_menu()
	check("controller opens inventory away from camp", game.ui_management.is_open() and game.ui_management.mode == "inventory")
	await tap(KEY_ESCAPE)
	game.player.x = game.CARAVAN_X + 20
	await controller_menu()
	check("controller opens Wagon near camp", game.ui_management.is_open() and game.ui_management.mode == "wagon")
	await tap(KEY_F4)
	check("F4 closes management so panels cannot overlap", game.playtester_panel.visible and not game.ui_management.is_open())
	await click_button(game.playtester_mark_up)
	await click_button(game.playtester_mark_up)
	await click_button(game.playtester_mark_up)
	await click_button(game.playtester_mark_up)
	await click_button(game.playtester_mark_up)
	check("F4 snapshot excludes UI nodes and input queues", game.mark_level == 5 and not game.playtester_snapshot.has("ui_management") and not game.playtester_snapshot.has("ui_gameplay_requests"))
	await tap(KEY_F4)
	await tap(KEY_SHIFT)
	check("Shift remains dash at higher inspected Marks", game.player_pose() == "dodge" and game.mark_vfx_kind == "dash" and not game.player_hurt_visible())
	await tap(KEY_F4)
	await click_button(game.playtester_restore_button)
	check("F4 restores prior state without duplicating inventory", game.mark_level == 0 and not game.playtester_active and game.recovered_load.is_empty() and game.wagon_stock.is_empty())
	game.reset_to_prologue()
	game.player = Vector2(480, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	game.hurt_cooldown = 99.0
	game.salvage.clear()
	game.shades.clear()
	game.spawn_enemy("BRIAR HOUND", Vector2(750, game.GROUND_Y - 34), 3, 0)
	await click(Vector2(1200, 580))
	check("empty melee swing remains visible and deals no damage", game.player_pose() == "strike" and game.mark_vfx_kind == "swing" and int(game.shades[0].health) == 3)
	var pose_before: String = game.player_pose()
	mouse(MOUSE_BUTTON_RIGHT, true)
	await process_frame
	mouse(MOUSE_BUTTON_RIGHT, false)
	await process_frame
	check("right-click parry remains reserved and inactive", game.player_pose() == pose_before and game.dodge_time == 0.0)
	game.set_process(false)
	game.player_action = "dodge"
	game.player_action_time = 1.0
	game.hurt_flash_time = 0.0
	game.mark_vfx_time = 0.0
	var dash_baseline: Image = await shot("dash-baseline")
	game.trigger_mark_vfx("dash", game.player + Vector2(0, -72))
	var clean_dash: Image = await shot("dash-clean")
	check("dash raster has no extra atlas overlay", dash_baseline.get_data() == clean_dash.get_data())
	game.mark_level = 1
	await shot("dash-drow")
	game.mark_level = 0
	game.player_action = ""
	game.player_action_time = 0.0
	game.mark_vfx_time = 0.0
	await shot("enemy-proportions")
	var hound: Dictionary = game.shades[0]
	check("Briar Hound uses larger 160 px cell and adjusted melee reach", game.enemy_visual_size(hound) == 160.0 and is_equal_approx(game.melee_reach(hound), 114.0))
	game.shades.clear()
	game.spawn_enemy("STAG OF MIRE", Vector2(780, game.GROUND_Y - 34), 2, 0)
	await shot("stag-proportions")
	check("Stag uses 200 px cell", game.enemy_visual_size(game.shades[0]) == 200.0)
	game.shades.clear()
	game.spawn_enemy("ANTLERED HUNGER", Vector2(780, game.GROUND_Y - 34), 12, 0)
	await shot("boss-proportions")
	check("boss uses 260 px cell", game.enemy_visual_size(game.shades[0]) == 260.0)
	game.set_process(true)
	game.reset_to_prologue()
	await process_frame
	await process_frame
	await tap(KEY_SPACE)
	check("Space jumps with real keyboard input", game.velocity.y < 0.0 and game.player.y < game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	game.player = Vector2(480, game.GROUND_Y - game.PLAYER_FEET_OFFSET)
	game.velocity = Vector2.ZERO
	game.hurt_cooldown = 99.0
	game.salvage.clear()
	game.shades.clear()
	game.spawn_enemy("BRIAR HOUND", Vector2(550, game.GROUND_Y - 34), 10, 0)
	var input_target: Dictionary = game.shades[0]
	await tap(KEY_J)
	check("J provides independent keyboard melee", int(input_target.health) == 9)
	await controller_button(JOY_BUTTON_X)
	check("controller left face attacks", int(input_target.health) == 8)
	game.salvage.assign([{"pos": game.player, "name": "CONTROLLER HERB", "type": "herb", "slots": 1, "taken": false}])
	await controller_button(JOY_BUTTON_Y)
	check("controller top face collects without attacking", game.recovered_load.size() == 1 and int(input_target.health) == 8)
	# Exercise prototype existing role guards without opening its gameplay route.
	game.reset_to_prologue()
	game.zone = 1
	game.mark_level = 1
	game.cured_allies.assign(["AELIRA", "VAELUN", "NIMARA"])
	game.player.x = game.CARAVAN_X + 20
	game.ui_management.open_window("wagon")
	game.ui_management.show_section("allies")
	game.ui_management.manage_ally("AELIRA")
	game.ui_management.manage_ally("VAELUN")
	game.ui_management.manage_ally("NIMARA")
	check("menu callbacks retain the two-post cap", game.posted_allies.size() == 2 and not game.posted_allies.has("NIMARA"))
	game.ui_management.manage_ally("AELIRA")
	check("menu recall returns an existing post", game.posted_allies == ["VAELUN"])
	game.reset_to_prologue()
	print("LOCAL_CONTROLS_%s: %d/%d checks" % ["PASS" if failures == 0 else "FAIL", checks - failures, checks])
	quit(0 if failures == 0 else 1)

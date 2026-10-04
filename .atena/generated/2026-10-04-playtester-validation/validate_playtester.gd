extends SceneTree

func _initialize() -> void:
	call_deferred("run_validation")

func press_f4() -> void:
	var event := InputEventKey.new()
	event.physical_keycode = KEY_F4
	event.pressed = true
	Input.parse_input_event(event)
	await process_frame
	event = InputEventKey.new()
	event.physical_keycode = KEY_F4
	event.pressed = false
	Input.parse_input_event(event)
	await process_frame

func click_button(button: Button) -> void:
	var point := button.get_global_rect().get_center()
	var event := InputEventMouseButton.new()
	event.position = point
	event.button_index = MOUSE_BUTTON_LEFT
	event.pressed = true
	Input.parse_input_event(event)
	await process_frame
	event = InputEventMouseButton.new()
	event.position = point
	event.button_index = MOUSE_BUTTON_LEFT
	event.pressed = false
	Input.parse_input_event(event)
	await process_frame

func run_validation() -> void:
	root.size = Vector2i(1280, 720)
	var game = load("res://main.tscn").instantiate()
	root.add_child(game)
	var toggle_events := InputMap.action_get_events("playtester_toggle")
	assert(toggle_events.size() == 1 and toggle_events[0] is InputEventKey)
	assert(toggle_events[0].physical_keycode == KEY_F4)
	game.skip_opening()
	await process_frame
	await press_f4()
	assert(game.playtester_panel.visible)
	var before_clock: float = game.clock_seconds
	await process_frame
	assert(game.clock_seconds == before_clock)
	await RenderingServer.frame_post_draw
	root.get_texture().get_image().save_png("res://.atena/generated/2026-10-04-playtester-validation/panel.png")
	await click_button(game.playtester_mark_up)
	assert(game.mark_level == 1)
	await click_button(game.playtester_mark_down)
	assert(game.mark_level == 0)
	var next_night: Button = game.playtester_panel.get_child(0).get_child(0).get_child(3).get_child(1)
	await click_button(next_night)
	assert(game.is_night() and game.shades.size() == 1)
	await press_f4()
	assert(not game.playtester_panel.visible)
	await process_frame
	await RenderingServer.frame_post_draw
	root.get_texture().get_image().save_png("res://.atena/generated/2026-10-04-playtester-validation/forced-night.png")
	await press_f4()
	var next_day: Button = game.playtester_panel.get_child(0).get_child(0).get_child(3).get_child(0)
	await click_button(next_day)
	assert(not game.is_night() and game.shades.is_empty() and game.night_wave == 0)
	await click_button(game.playtester_restore_button)
	assert(not game.playtester_active and not game.playtester_panel.visible)
	assert(game.mark_level == 0 and not game.is_night() and game.shades.is_empty())
	print("PLAYTESTER_RUNTIME_PASS: F4 binding/toggle, pause, mouse Mark +/-, Next night/day, enemy spawn, dawn cleanup, resume, restore")
	quit(0)

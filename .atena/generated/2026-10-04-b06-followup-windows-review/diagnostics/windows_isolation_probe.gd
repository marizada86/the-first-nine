extends "res://.atena/generated/2026-10-04-b06-validation/validate_b06_runtime.gd"
# Review-only diagnostic. Production files and the original suite are not edited.
# Contrasts the committed post-skip isolation boundary with isolation before the first frame.

func run() -> void:
	root.size = Vector2i(1280, 720)
	for trial in ["late-natural", "early-natural", "late-queued-trigger"]:
		var isolate_before_skip: bool = trial == "early-natural"
		game = load("res://main.tscn").instantiate()
		root.add_child(game)
		if isolate_before_skip:
			suspend_joypad_bindings()
		await process_frame
		await tap(KEY_ESCAPE)
		if trial == "late-queued-trigger":
			trigger(0.21)
			Input.flush_buffered_events()
		print("WINDOWS_ISOLATION trial=%s" % trial)
		print("WINDOWS_ISOLATION before_suspend early=%s requests=%s dodge=%s" % [isolate_before_skip, game.ui_gameplay_requests, game.dodge_time])
		if not isolate_before_skip:
			suspend_joypad_bindings()
		print("WINDOWS_ISOLATION after_suspend early=%s requests=%s trigger_matches=%s" % [isolate_before_skip, game.ui_gameplay_requests, Input.is_action_pressed("shadow_action")])
		var dashed: bool = await trigger_dashes(0.21)
		print("WINDOWS_ISOLATION result early=%s dashed=%s requests=%s" % [isolate_before_skip, dashed, game.ui_gameplay_requests])
		check("same isolation assertion, early=%s" % isolate_before_skip, not suspended_joypad_events.is_empty() and not dashed)
		restore_joypad_bindings()
		await free_node(game)
	game = null
	print("WINDOWS_ISOLATION_END: %d/%d (diagnostic, not acceptance)" % [checks - failures, checks])
	quit(0)

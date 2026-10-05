extends SceneTree
# B-06 named headless checks. B06_FAULT selects a deliberately faulty test-only subclass.
# Run: godot --headless --path . --script res://.atena/generated/2026-10-04-b06-validation/validate_b06_headless.gd

const RES_DIR := "res://.atena/generated/2026-10-04-b06-validation"
var fault := ""

func _initialize() -> void:
	fault = OS.get_environment("B06_FAULT")
	call_deferred("run")

func run() -> void:
	root.size = Vector2i(1280, 720)
	var script_path := "res://main.gd" if fault == "" else RES_DIR + "/faults/" + fault + ".gd"
	var game = load(script_path).new()
	root.add_child(game)
	await process_frame
	await process_frame
	# The checks drive every frame explicitly.
	game.set_process(false)
	var checks: Dictionary = game.stonehook_expedition_checks()
	var failures := 0
	for check_name in checks:
		var passed := bool(checks[check_name])
		print("B06 %s %s" % ["PASS" if passed else "FAIL", check_name])
		if not passed:
			failures += 1
	print("B06_%s: %d/%d checks%s" % ["PASS" if failures == 0 else "FAIL", checks.size() - failures, checks.size(), "" if fault == "" else " (fault: " + fault + ")"])
	quit(0 if failures == 0 else 1)

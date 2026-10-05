extends SceneTree
# B-07 named headless checks. B07_FAULT selects a deliberately faulty test-only subclass.
# Run: godot --headless --path . --script res://.atena/generated/2026-10-05-b07-validation/validate_b07_headless.gd

const RES_DIR := "res://.atena/generated/2026-10-05-b07-validation"
var fault := ""
# Every named assertion must be reported; a missing name (an aborted or crashed section) fails.
const EXPECTED := [
	"section_fixtures_ready", "locked_contexts_no_crawler", "legit_entry_spawns_one",
	"oscillation_and_days_keep_actor", "geometry_crawler_crop", "reach_matches_body",
	"melee_hit_and_miss", "first_thread_hit_and_miss", "windup_precedes_strike",
	"single_hit_per_strike", "dash_avoids_strike", "retreat_cancels_pending_strike",
	"crawler_stays_in_foothills", "crawler_does_not_stall_waves", "offscreen_stag_with_crawler",
	"safe_capture_with_live_crawler", "ore_independent_of_crawler", "reward_once_within_cap",
	"failure_rolls_back_together", "undefeated_recreated_once", "saved_defeat_stays_defeated",
	"f4_exact_restore", "new_run_resets_encounter", "bounds_prepared_once",
]

func _initialize() -> void:
	fault = OS.get_environment("B07_FAULT")
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
	var result = game.stonehook_encounter_checks()
	var checks: Dictionary = result if result is Dictionary else {}
	var failures := 0
	for check_name in EXPECTED:
		var reported := checks.has(check_name)
		var passed := reported and bool(checks[check_name])
		print("B07 %s %s%s" % ["PASS" if passed else "FAIL", check_name, "" if reported else " (not reached)"])
		if not passed:
			failures += 1
	for check_name in checks:
		if not EXPECTED.has(check_name):
			print("B07 FAIL unexpected_check %s" % check_name)
			failures += 1
	print("B07_%s: %d/%d checks%s" % ["PASS" if failures == 0 else "FAIL", EXPECTED.size() - mini(failures, EXPECTED.size()), EXPECTED.size(), "" if fault == "" else " (fault: " + fault + ")"])
	quit(0 if failures == 0 else 1)

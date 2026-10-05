extends SceneTree
# B-08 named headless checks. B08_FAULT selects a deliberately faulty test-only subclass.
# Run: godot --headless --path . --script res://.atena/generated/2026-10-05-b08-validation/validate_b08_headless.gd

const RES_DIR := "res://.atena/generated/2026-10-05-b08-validation"
var fault := ""
# Every named assertion must be reported; a missing name (an aborted or crashed section) fails.
const EXPECTED := [
	"section_fixtures_ready", "harrier_locked_contexts", "harrier_activation_at_2600",
	"both_actors_persist_oscillation_days", "harrier_geometry_crop", "harrier_hover_and_bob", "harrier_reachable_in_live_flight",
	"harrier_reach_matches_body", "harrier_grounded_melee_hit_miss", "harrier_first_thread_hit_miss",
	"harrier_vertical_reach_follows_display", "nearest_eligible_target", "harrier_facings",
	"harrier_approach_and_retreat", "harrier_windup_locks_target", "harrier_single_hit_per_dive",
	"harrier_dash_avoids_dive", "harrier_no_idle_contact", "harrier_cancels_outside_foothills",
	"harrier_stays_in_bounds", "simultaneous_combat_single_hits", "independent_defeat_and_reward",
	"two_rewards_within_cap", "cave_waves_keep_both", "safe_capture_with_both_live",
	"ore_independent_of_both", "save_combo_neither", "save_combo_crawler_only",
	"save_combo_harrier_only", "save_combo_both", "f4_restores_both_exactly",
	"new_run_resets_both", "harrier_bounds_prepared_once",
	"harrier_bounds_ready_before_first_frame",
]

func _initialize() -> void:
	fault = OS.get_environment("B08_FAULT")
	call_deferred("run")

func run() -> void:
	root.size = Vector2i(1280, 720)
	var script_path := "res://main.gd" if fault == "" else RES_DIR + "/faults/" + fault + ".gd"
	var script = load(script_path)
	if script == null or not script.can_instantiate():
		# A parse or import failure is a failure of the run, never a rejection by an assertion.
		print("B08_LOAD_FAIL: %s could not be instantiated" % script_path)
		quit(2)
		return
	var game = script.new()
	root.add_child(game)
	# _ready has run inside add_child and no frame has been processed: the Harrier crop must
	# already be cached, scanned exactly once.
	var harrier_key: String = game.STONEHOOK_THREATS_RUNTIME.resource_path + str(game.cliff_harrier_source())
	var ready_before_frame: bool = game.ui_encounter_bounds.has(harrier_key) and game.ui_harrier_bounds_scans == 1 and float(game.pulse) == 0.0
	await process_frame
	await process_frame
	# The checks drive every frame explicitly.
	game.set_process(false)
	var result = game.cliff_harrier_checks()
	var checks: Dictionary = result if result is Dictionary else {}
	checks["harrier_bounds_ready_before_first_frame"] = ready_before_frame
	var failures := 0
	for check_name in EXPECTED:
		var reported := checks.has(check_name)
		var passed := reported and bool(checks[check_name])
		print("B08 %s %s%s" % ["PASS" if passed else "FAIL", check_name, "" if reported else " (not reached)"])
		if not passed:
			failures += 1
	for check_name in checks:
		if not EXPECTED.has(check_name):
			print("B08 FAIL unexpected_check %s" % check_name)
			failures += 1
	print("B08_%s: %d/%d checks%s" % ["PASS" if failures == 0 else "FAIL", EXPECTED.size() - mini(failures, EXPECTED.size()), EXPECTED.size(), "" if fault == "" else " (fault: " + fault + ")"])
	quit(0 if failures == 0 else 1)

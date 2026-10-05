extends "res://.atena/generated/2026-10-04-b05-combat-validation/validate_b05_combat.gd"
# Runs the historical 9-check B-05 combat suite unchanged, isolated from physical controllers.
# The suite drives only keyboard and mouse input. Right after the game's _ready defines the
# production bindings, and before its first frame, this wrapper removes only the joypad motion
# bindings (sticks and triggers) from this test process's InputMap and releases their actions.
# A resting physical trigger above the unchanged 0.2 deadzone can then no longer dash.
# Button bindings, device settings, production thresholds and every original scenario,
# assertion, input sequence and timeout are untouched; the historical file is not modified.
#
# B06_COMBAT_NOISE=1 sends a synthetic 0.21 right-trigger event every frame, emulating a
# resting physical trigger, so the isolation is exercised against the interference source.
# B06_COMBAT_ISOLATION_FAULT selects a deliberately faulty variant (always with that noise):
#   missing - no isolation;  late - isolation only after the game's first processed frame.
var removed_motion_bindings := 0
var added_frame := -1
var isolated_frame := -1
var isolation_fault := ""
var noise := false

func _initialize() -> void:
	isolation_fault = OS.get_environment("B06_COMBAT_ISOLATION_FAULT")
	noise = OS.get_environment("B06_COMBAT_NOISE") == "1" or isolation_fault != ""
	node_added.connect(_on_node_added)
	if noise:
		process_frame.connect(_send_trigger_noise)
	super._initialize()

func _on_node_added(node: Node) -> void:
	if node.get_script() != preload("res://main.gd") or added_frame >= 0:
		return
	added_frame = Engine.get_process_frames()
	match isolation_fault:
		"missing":
			pass
		"late":
			process_frame.connect(_isolate_when_late.bind(node))
		_:
			node.ready.connect(_isolate_physical_motion.bind(node), CONNECT_ONE_SHOT)

func _isolate_when_late(node: Node) -> void:
	# The isolated_frame guard keeps this to a single late isolation.
	if float(node.pulse) > 0.0 and isolated_frame < 0:
		_isolate_physical_motion(node)

func _send_trigger_noise() -> void:
	var event := InputEventJoypadMotion.new()
	event.axis = JOY_AXIS_TRIGGER_RIGHT
	event.axis_value = 0.21
	Input.parse_input_event(event)

func _isolate_physical_motion(node: Node) -> void:
	# A non-dispatching probe: does a resting 0.21 trigger map to the dash action?
	var probe := InputEventJoypadMotion.new()
	probe.axis = JOY_AXIS_TRIGGER_RIGHT
	probe.axis_value = 0.21
	var matched_before := InputMap.event_is_action(probe, "shadow_action")
	for action in InputMap.get_actions():
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadMotion:
				InputMap.action_erase_event(action, event)
				Input.action_release(action)
				removed_motion_bindings += 1
	isolated_frame = Engine.get_process_frames()
	var matched_after := InputMap.event_is_action(probe, "shadow_action")
	var buttons_kept := has_button("shadow_strike", JOY_BUTTON_B) and has_button("attack", JOY_BUTTON_X) and has_button("primary", JOY_BUTTON_Y)
	# main.gd advances pulse on every processed gameplay frame, so zero proves that the game
	# has not processed a single frame when its controller bindings are isolated.
	var game_pulse := float(node.pulse)
	var before_gameplay := game_pulse == 0.0 and String(node.state) == "opening"
	var applied := removed_motion_bindings > 0 and matched_before and not matched_after and buttons_kept and before_gameplay
	print("COMBAT_ISOLATION %s: removed %d joypad motion bindings before gameplay=%s (game pulse %.3f, state %s, engine frame %d, added at %d); 0.21 trigger matched dash before=%s after=%s; button bindings kept=%s" % ["PASS" if applied else "FAIL", removed_motion_bindings, before_gameplay, game_pulse, String(node.state), isolated_frame, added_frame, matched_before, matched_after, buttons_kept])
	if not applied:
		failures += 1

func has_button(action: String, button: JoyButton) -> bool:
	for event in InputMap.action_get_events(action):
		if event is InputEventJoypadButton and event.button_index == button:
			return true
	return false

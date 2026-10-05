extends "res://.atena/generated/2026-10-04-b05-local-controls-validation/validate_controls_and_menus.gd"
# Runs the historical 33-check menu suite unchanged, isolated from physical controllers.
# The suite sends only synthetic controller buttons (Back, X, Y). Right after the game's
# _ready defines the production bindings, and before its first frame, this wrapper removes
# only the joypad motion bindings (sticks and triggers) from this test process's InputMap.
# A resting physical trigger or drifting stick can then no longer dash or move Lolth. Every
# button binding used by the synthetic checks stays in place. Device settings and production
# thresholds are untouched, and the historical file and its evidence are not modified.
var removed_motion_bindings := 0
var isolation_applied := false

func _initialize() -> void:
	node_added.connect(_on_node_added)
	super._initialize()

func _on_node_added(node: Node) -> void:
	if node.get_script() == preload("res://main.gd") and not node.ready.is_connected(_isolate_physical_motion):
		node.ready.connect(_isolate_physical_motion, CONNECT_ONE_SHOT)

func _isolate_physical_motion() -> void:
	for action in InputMap.get_actions():
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadMotion:
				InputMap.action_erase_event(action, event)
				Input.action_release(action)
				removed_motion_bindings += 1
	var buttons_kept := has_button("camp_menu", JOY_BUTTON_BACK) and has_button("attack", JOY_BUTTON_X) and has_button("primary", JOY_BUTTON_Y)
	isolation_applied = removed_motion_bindings > 0 and buttons_kept
	print("MENU_ISOLATION %s: removed %d joypad motion bindings before the first frame; synthetic button bindings kept=%s" % ["PASS" if isolation_applied else "FAIL", removed_motion_bindings, buttons_kept])
	if not isolation_applied:
		print("LOCAL FAIL physical-controller isolation was not applied")

func has_button(action: String, button: JoyButton) -> bool:
	for event in InputMap.action_get_events(action):
		if event is InputEventJoypadButton and event.button_index == button:
			return true
	return false

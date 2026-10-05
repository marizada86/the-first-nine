extends "res://.atena/generated/2026-10-04-b05-combat-validation/validate_b05_combat.gd"
# Review-only diagnostic. All nine original checks and scenarios are inherited unchanged.
# Remove motion bindings after production setup and before the first frame, as in the menu wrapper.
func _initialize() -> void:
	node_added.connect(_on_node_added)
	super._initialize()

func _on_node_added(node: Node) -> void:
	if node.get_script() == preload("res://main.gd"):
		node.ready.connect(_isolate_motion, CONNECT_ONE_SHOT)

func _isolate_motion() -> void:
	var removed := 0
	for action in InputMap.get_actions():
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadMotion:
				InputMap.action_erase_event(action, event)
				Input.action_release(action)
				removed += 1
	print("COMBAT_MOTION_ISOLATION_DIAGNOSTIC removed=%d" % removed)

func report(tag: String, enemy: Dictionary) -> void:
	super.report(tag, enemy)
	if tag == "MISS":
		var connected := Input.get_connected_joypads()
		print("COMBAT_PHYSICAL_INPUT_OBSERVATION connected=%s" % connected)
		for device in connected:
			print("COMBAT_PHYSICAL_INPUT_OBSERVATION device=%d right_trigger=%s" % [device, Input.get_joy_axis(device, JOY_AXIS_TRIGGER_RIGHT)])

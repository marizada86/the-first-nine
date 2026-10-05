extends "res://main.gd"
# Faulty test-only subclass: a new run keeps the expedition's view and the collected ore.
func reset_to_prologue() -> void:
	var ore_taken := bool(route_ore_state().get("taken", false))
	var kept_camera := camera_x
	super.reset_to_prologue()
	camera_x = kept_camera
	for item in salvage:
		if String(item.get("id", "")) == ROUTE_ORE_ID:
			item.taken = ore_taken

extends "res://main.gd"
# Faulty test-only subclass: every entry past the activation line adds another Harrier copy.
var fault_was_past := false

func update_foothill_encounter(delta: float) -> void:
	super.update_foothill_encounter(delta)
	var past := player.x >= CLIFF_HARRIER_ACTIVATION_X
	if past and not fault_was_past and not cliff_harrier.is_empty():
		shades.append(cliff_harrier.duplicate(true))
	fault_was_past = past

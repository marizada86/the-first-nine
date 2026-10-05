extends "res://main.gd"
# Faulty test-only subclass: a safe-wagon restore keeps the unsaved Harrier flags.
func restore_safe_wagon_state() -> void:
	var kept := cliff_harrier_state()
	super.restore_safe_wagon_state()
	apply_cliff_harrier_state(kept)

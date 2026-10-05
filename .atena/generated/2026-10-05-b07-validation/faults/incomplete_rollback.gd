extends "res://main.gd"
# Faulty test-only subclass: a safe-wagon restore keeps the unsaved encounter flags.
func restore_safe_wagon_state() -> void:
	var kept := scree_crawler_state()
	super.restore_safe_wagon_state()
	apply_scree_crawler_state(kept)

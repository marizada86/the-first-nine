extends "res://main.gd"
# Faulty test-only subclass: every entry into the foothills adds another crawler copy.
var fault_was_inside := false

func update_foothill_encounter(delta: float) -> void:
	super.update_foothill_encounter(delta)
	var inside := player.x >= ROUTE_FOOTHILLS_START_X
	if inside and not fault_was_inside and not scree_crawler.is_empty():
		shades.append(scree_crawler.duplicate(true))
	fault_was_inside = inside

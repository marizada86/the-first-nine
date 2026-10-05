extends "res://main.gd"
# Faulty test-only subclass: Wagon proximity is measured from the displayed region's start,
# which creates a second camp at the foothills.
func at_wagon() -> bool:
	var region_start := ROUTE_FOOTHILLS_START_X if lolth_region() == "stonehook_foothills" else 0.0
	return player.x - region_start < WAGON_INTERACT_MAX_X

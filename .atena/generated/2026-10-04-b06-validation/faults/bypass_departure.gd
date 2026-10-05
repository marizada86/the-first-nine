extends "res://main.gd"
# Faulty test-only subclass: Mark I alone opens the route, without the cure, safe camp or legitimacy.
func expedition_departure_allowed() -> bool:
	return state == "journey" and zone == 0 and mark_level >= 1

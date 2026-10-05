extends "res://main.gd"
# Faulty test-only subclass: the Harrier's bounds ignore the patrol span and the foothills.
func cliff_harrier_limits() -> Vector2:
	return Vector2(ENEMY_EDGE_MARGIN, ROUTE_END_X + 600.0)

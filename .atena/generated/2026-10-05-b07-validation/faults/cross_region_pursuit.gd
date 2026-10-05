extends "res://main.gd"
# Faulty test-only subclass: the crawler follows Lolth out of the foothills toward the cave.
func lolth_in_crawler_region() -> bool:
	return true

func scree_crawler_limits() -> Vector2:
	return Vector2(ENEMY_EDGE_MARGIN, ROUTE_END_X - scree_crawler_body_half_width())

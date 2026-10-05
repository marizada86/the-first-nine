extends "res://main.gd"
# Faulty test-only subclass: draws the neighboring Cliff Harrier cell instead of the crawler.
func scree_crawler_source() -> Rect2:
	return Rect2(768, 0, 768, 512)

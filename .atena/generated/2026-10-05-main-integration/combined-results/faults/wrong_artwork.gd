extends "res://main.gd"
# Faulty test-only subclass: the Harrier is drawn from another creature's atlas cell.
func cliff_harrier_source() -> Rect2:
	return Rect2(0, 512, 768, 512)

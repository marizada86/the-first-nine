extends "res://main.gd"
# Validation-only regression: squash a wide destination back into a square.
func enemy_draw_geometry(shade: Dictionary) -> Dictionary:
	var geometry := super.enemy_draw_geometry(shade)
	geometry.destination.size.x = geometry.destination.size.y
	return geometry

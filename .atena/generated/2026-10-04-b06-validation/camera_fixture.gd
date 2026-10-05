extends "res://main.gd"
# Test-only isolated drawing: production enemy and Lolth sprites under the world translation,
# a world-space marker after them, and a screen-space marker after the reset.
func _draw() -> void:
	draw_set_transform(world_draw_origin(), 0.0, Vector2.ONE)
	draw_shades()
	draw_player()
	draw_rect(Rect2(Vector2(roundf(camera_x) + 100.0, 100.0), Vector2(20, 20)), Color.CYAN)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	draw_rect(Rect2(40, 40, 20, 20), Color.MAGENTA)

extends "res://main.gd"
# Test-only isolated drawing: exercise production sprite, labels and bars.
func _draw() -> void:
	draw_shades()
	draw_rect(Rect2(80, 80, 32, 32), Color.MAGENTA)

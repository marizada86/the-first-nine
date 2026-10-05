extends "res://main.gd"
# Test-only oracle: identical production drawing, with an optional switch that omits the
# foreground overlays so Lolth's unoccluded visibility can be measured at the same position.
var fixture_hide_foreground := false

func draw_foreground_overlay() -> void:
	if not fixture_hide_foreground:
		super.draw_foreground_overlay()

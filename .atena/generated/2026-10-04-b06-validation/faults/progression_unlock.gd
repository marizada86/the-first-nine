extends "res://main.gd"
# Faulty test-only subclass: capped Echoes in the foothills awaken the next Mark.
func collect_echo(amount := 1) -> void:
	super.collect_echo(amount)
	if lolth_region() == "stonehook_foothills" and mark_level < 9 and shadow_echoes >= int(ECHO_THRESHOLDS[mark_level]):
		advance_mark()

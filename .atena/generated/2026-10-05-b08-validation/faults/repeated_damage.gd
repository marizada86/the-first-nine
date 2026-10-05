extends "res://main.gd"
# Faulty test-only subclass: a dive is never spent, so it can wound on every contact frame.
func cliff_harrier_strike_lands(harrier: Dictionary) -> void:
	if dodge_time > 0.0:
		return
	hurt_lolth()
	harrier.strike_spent = false

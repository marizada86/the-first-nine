extends "res://main.gd"
# Faulty test-only subclass: every Harrier defeat pays an Echo, ignoring the reward flag.
func defeat_cliff_harrier() -> void:
	harrier_defeated = true
	harrier_reward_paid = true
	if mark_level > 0:
		collect_echo(1)

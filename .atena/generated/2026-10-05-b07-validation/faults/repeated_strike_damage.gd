extends "res://main.gd"
# Faulty test-only subclass: a strike is never spent, so one lunge can wound repeatedly.
func scree_crawler_strike_lands(_crawler: Dictionary) -> void:
	if dodge_time > 0.0 or hurt_cooldown > 0.0:
		return
	hurt_lolth()

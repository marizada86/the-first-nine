extends "res://main.gd"
# Faulty test-only subclass: every defeat pays an Echo, ignoring the reward flag.
func defeat_scree_crawler() -> void:
	crawler_defeated = true
	crawler_reward_paid = true
	collect_echo(1)

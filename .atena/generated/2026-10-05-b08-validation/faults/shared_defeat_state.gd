extends "res://main.gd"
# Faulty test-only subclass: defeating the Harrier also marks the crawler defeated and paid.
func defeat_cliff_harrier() -> void:
	super.defeat_cliff_harrier()
	crawler_defeated = true
	crawler_reward_paid = true

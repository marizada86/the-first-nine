extends "res://main.gd"
# Faulty test-only subclass: the playtester snapshot omits the live Harrier and its flags.
func begin_playtester_session() -> void:
	super.begin_playtester_session()
	for field in ["cliff_harrier", "harrier_activated", "harrier_defeated", "harrier_reward_paid"]:
		playtester_snapshot.erase(field)

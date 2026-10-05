extends "res://main.gd"
# Faulty test-only subclass: the playtester snapshot omits the live crawler and its flags.
func begin_playtester_session() -> void:
	super.begin_playtester_session()
	for field in ["scree_crawler", "crawler_activated", "crawler_defeated", "crawler_reward_paid"]:
		playtester_snapshot.erase(field)

extends "res://main.gd"
# Faulty test-only subclass: the playtester snapshot omits Lolth's route position, the view and pickups.
func begin_playtester_session() -> void:
	super.begin_playtester_session()
	for field in ["player", "camera_x", "salvage"]:
		playtester_snapshot.erase(field)

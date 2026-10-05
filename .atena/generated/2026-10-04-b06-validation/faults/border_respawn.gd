extends "res://main.gd"
# Faulty test-only subclass: crossing the Thornwake border re-creates the foothill ore.
func move_player(delta: float) -> void:
	var was_away := is_away_from_cave()
	super.move_player(delta)
	if was_away != is_away_from_cave():
		for item in salvage:
			if String(item.get("id", "")) == ROUTE_ORE_ID:
				item.taken = false

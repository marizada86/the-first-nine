extends "res://main.gd"
# Faulty test-only subclass: the camp clock and its attackers freeze while Lolth is away.
func advance_world_clock(delta: float) -> void:
	if is_away_from_cave():
		return
	super.advance_world_clock(delta)

func update_enemies(delta: float) -> void:
	if is_away_from_cave():
		return
	super.update_enemies(delta)

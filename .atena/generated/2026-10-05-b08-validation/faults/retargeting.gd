extends "res://main.gd"
# Faulty test-only subclass: during windup the Harrier keeps re-aiming at Lolth's live position.
func update_cliff_harrier(harrier: Dictionary, delta: float) -> void:
	if String(harrier.attack_state) == "windup":
		harrier.target_x = player.x
		harrier.attack_dir = signf(player.x - float(harrier.pos.x))
	super.update_cliff_harrier(harrier, delta)

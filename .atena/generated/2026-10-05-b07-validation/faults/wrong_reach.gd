extends "res://main.gd"
# Faulty test-only subclass: the crawler uses the legacy generic reach instead of its body.
func melee_reach(shade: Dictionary) -> float:
	if is_scree_crawler(shade):
		return MELEE_LOLTH_HALF_WIDTH + MELEE_DEFAULT_ENEMY_HALF_WIDTH
	return super.melee_reach(shade)

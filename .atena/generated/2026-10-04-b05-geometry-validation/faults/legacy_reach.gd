extends "res://main.gd"
# Validation-only regression: restore independent hand-measured widths.
func melee_reach(shade: Dictionary) -> float:
	var old_size := 160.0 if String(shade.name) == "ANTLERED HUNGER" else 96.0
	return MELEE_LOLTH_HALF_WIDTH + float(MELEE_ENEMY_HALF_WIDTHS.get(String(shade.name), MELEE_DEFAULT_ENEMY_HALF_WIDTH)) * enemy_visual_size(shade) / old_size

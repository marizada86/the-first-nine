extends "res://main.gd"
# Faulty test-only subclass: a living foothill crawler is treated as a cave threat.
func is_at_safe_wagon() -> bool:
	if live_scree_crawler_count() > 0:
		return false
	return super.is_at_safe_wagon()

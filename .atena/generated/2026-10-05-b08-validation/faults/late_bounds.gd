extends "res://main.gd"
# Faulty test-only subclass: the Harrier crop is scanned lazily on its first use in gameplay
# instead of before the first frame.
func prepare_harrier_bounds(_atlas: Image) -> void:
	ui_harrier_bounds_scans = 0

func enemy_frame_bounds(sheet: Texture2D, source: Rect2) -> Rect2i:
	var key := sheet.resource_path + str(source)
	if source == cliff_harrier_source() and not ui_encounter_bounds.has(key):
		ui_encounter_bounds[key] = scan_alpha_bounds(source, sheet.get_image())
		ui_harrier_bounds_scans += 1
	return super.enemy_frame_bounds(sheet, source)

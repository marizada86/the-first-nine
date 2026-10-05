extends "res://main.gd"
# Faulty test-only subclass: a restore keeps the failed expedition's position, view and pickups.
func restore_safe_wagon_state() -> void:
	var kept_player := player
	var kept_camera := camera_x
	var kept_salvage := salvage.duplicate(true)
	super.restore_safe_wagon_state()
	player = kept_player
	camera_x = kept_camera
	salvage = kept_salvage

extends "res://.atena/generated/2026-10-04-b05-geometry-validation/validate_enemy_geometry.gd"
# B-08 regression: the independent B-05 alpha oracle runs unchanged against the B-08 build.
# Only its output directory moves, so earlier evidence is never overwritten.
func _initialize() -> void:
	out_dir = "res://.atena/generated/2026-10-05-b08-validation/regressions/geometry"
	super._initialize()

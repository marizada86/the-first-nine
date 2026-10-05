extends "res://.atena/generated/2026-10-04-b05-geometry-validation/validate_enemy_geometry.gd"
# B-07 regression: the independent B-05 alpha oracle runs unchanged against the B-07 build.
# Only its output directory moves, so B-05 and B-06 evidence is never overwritten.
func _initialize() -> void:
	out_dir = "res://.atena/generated/2026-10-05-b07-validation/regressions/geometry"
	super._initialize()

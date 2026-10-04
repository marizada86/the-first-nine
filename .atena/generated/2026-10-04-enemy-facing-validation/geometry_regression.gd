extends "res://.atena/generated/2026-10-04-b05-geometry-validation/validate_enemy_geometry.gd"
# Reuse the independent alpha oracle, but never overwrite B-05 evidence.
func _initialize() -> void:
	out_dir = "res://.atena/generated/2026-10-04-enemy-facing-validation/regressions"
	super._initialize()

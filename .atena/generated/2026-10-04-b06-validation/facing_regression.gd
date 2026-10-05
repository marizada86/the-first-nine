extends "res://.atena/generated/2026-10-04-enemy-facing-validation/validate_facing.gd"
# Reuse the facing checks unchanged, but never overwrite the committed facing evidence.
# validate_facing.gd loads its render fixture from out_dir, so an identical copy lives there.
func _initialize() -> void:
	out_dir = "res://.atena/generated/2026-10-04-b06-validation/regressions/facing"
	super._initialize()

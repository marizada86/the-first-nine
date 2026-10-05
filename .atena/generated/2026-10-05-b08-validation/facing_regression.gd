extends "res://.atena/generated/2026-10-04-enemy-facing-validation/validate_facing.gd"
# B-08 regression: the facing checks run unchanged against the B-08 build. Only the output
# directory moves; validate_facing.gd loads its render fixture from out_dir, so an identical
# copy of the original render_fixture.gd lives there.
func _initialize() -> void:
	out_dir = "res://.atena/generated/2026-10-05-b08-validation/regressions/facing"
	super._initialize()

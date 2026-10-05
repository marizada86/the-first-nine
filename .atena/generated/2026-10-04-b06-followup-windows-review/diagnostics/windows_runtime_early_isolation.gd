extends "res://.atena/generated/2026-10-04-b06-validation/validate_b06_runtime.gd"
# Review-only diagnostic: start keyboard isolation before the opening is skipped.
# All original 51 checks, movement bounds and test scenarios are inherited unchanged.
func tap(code: Key) -> void:
	if code == KEY_ESCAPE and game != null and game.state == "opening":
		suspend_joypad_bindings()
	await super.tap(code)

func suspend_joypad_bindings() -> void:
	# Do not discard the saved bindings when the original route runner reaches its later call.
	if suspended_joypad_events.is_empty():
		super.suspend_joypad_bindings()

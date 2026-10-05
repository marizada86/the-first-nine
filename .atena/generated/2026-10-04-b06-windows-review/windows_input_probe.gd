extends "res://.atena/generated/2026-10-04-b06-validation/validate_b06_runtime.gd"
# Review-only instrumentation. Existing checks and game code are unchanged.
class InputProbe:
	extends Node
	var ignored := 0
	func _input(event: InputEvent) -> void:
		if OS.get_environment("B06_DIAGNOSTIC_IGNORE_JOYPADS") == "1" and (event is InputEventJoypadMotion or event is InputEventJoypadButton):
			ignored += 1
			get_viewport().set_input_as_handled()
			if ignored == 1:
				print("B06_PROBE FILTER hardware joypad events in this diagnostic only")
			return
		if event.is_action_pressed("shadow_action"):
			print("B06_PROBE SHADOW_INPUT ", event.as_text(), " class=", event.get_class(), " device=", event.device)

func _initialize() -> void:
	call_deferred("add_probe")
	super._initialize()

func add_probe() -> void:
	root.add_child(InputProbe.new())

func check(label: String, passed: bool) -> void:
	if label == "legitimate first cure and safe return open the on-foot route" and OS.get_environment("B06_DIAGNOSTIC_IGNORE_JOYPADS") == "1":
		# Registered after the game: receives physical events first in reverse scene order.
		root.add_child(InputProbe.new())
	if game != null and (not passed or label.begins_with("the cave Stag")):
		print("B06_PROBE CHECK ", label, " x=", game.player.x, " velocity=", game.velocity.x, " camera=", game.camera_x, " integrity=", game.wagon_integrity, " menu=", game.ui_management.is_open(), " state=", game.state, " message=", game.message)
	super.check(label, passed)

func hold_until(code: Key, done: Callable, timeout_seconds: float) -> Dictionary:
	var result: Dictionary = await super.hold_until(code, done, timeout_seconds)
	print("B06_PROBE STOP key=", OS.get_keycode_string(code), " velocity=", game.velocity.x, " axis=", Input.get_axis("move_left", "move_right"), " shadow=", Input.get_action_strength("shadow_action"))
	if OS.get_environment("B06_DIAGNOSTIC_WAIT_STILL") == "1":
		var started := Time.get_ticks_msec()
		while not is_zero_approx(game.velocity.x) and Time.get_ticks_msec() - started < 2000:
			await process_frame
		print("B06_PROBE SETTLED velocity=", game.velocity.x, " elapsed_ms=", Time.get_ticks_msec() - started)
	return result

extends "res://.atena/generated/2026-10-04-b05-local-controls-validation/validate_controls_and_menus.gd"
# Review-only diagnostic: preserve all 33 original assertions and synthetic controller checks.
# Consume physical joypad event dispatch, without changing InputMap or game controls.
class PhysicalFilter extends Node:
	var synthetic_dispatch := false
	func _input(event: InputEvent) -> void:
		if event is InputEventJoypadMotion or (event is InputEventJoypadButton and not synthetic_dispatch):
			get_viewport().set_input_as_handled()

var physical_filter: PhysicalFilter

func controller_button(button_index: JoyButton) -> void:
	for pressed in [true, false]:
		var event := InputEventJoypadButton.new()
		event.button_index = button_index
		event.pressed = pressed
		physical_filter.synthetic_dispatch = true
		Input.parse_input_event(event)
		Input.flush_buffered_events()
		physical_filter.synthetic_dispatch = false
		await process_frame

func run() -> void:
	# This filter must be the last root child to receive events before the game's handlers.
	# Install it as soon as the game is present, before its first process frame.
	process_frame.connect(_install_filter, CONNECT_ONE_SHOT)
	await super.run()

func _install_filter() -> void:
	physical_filter = PhysicalFilter.new()
	root.add_child(physical_filter)

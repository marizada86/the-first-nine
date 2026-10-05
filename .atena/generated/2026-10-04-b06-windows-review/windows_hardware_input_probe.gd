extends SceneTree
# Read-only sample of real controller events using the unchanged game's bindings.
class EventSampler:
	extends Node
	var samples := 0
	var minimum := INF
	var maximum := -INF
	var dash_events := 0
	func _input(event: InputEvent) -> void:
		if event is InputEventJoypadMotion and event.axis == JOY_AXIS_TRIGGER_RIGHT:
			samples += 1
			minimum = minf(minimum, event.axis_value)
			maximum = maxf(maximum, event.axis_value)
			if event.is_action_pressed("shadow_action"):
				dash_events += 1

func _initialize() -> void:
	call_deferred("run")

func run() -> void:
	var game = load("res://main.gd").new()
	root.add_child(game)
	game.set_process(false)
	var sampler := EventSampler.new()
	root.add_child(sampler)
	await create_timer(0.75).timeout
	print("WINDOWS_HARDWARE_INPUT samples=", sampler.samples, " right_trigger_min=", sampler.minimum, " right_trigger_max=", sampler.maximum, " dash_pressed_events=", sampler.dash_events)
	print("No synthetic controller input or production changes were used.")
	quit(0)

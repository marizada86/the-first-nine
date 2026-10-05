extends SceneTree

const ROOT := "res://.atena/generated/2026-10-05-lolth-three-transformations/"
var game

func _initialize() -> void:
	call_deferred("run")

func run() -> void:
	game = load("res://main.gd").new()
	root.add_child(game)
	game.set_process(false)
	game.skip_opening()
	game.clock_seconds = 12.0
	game.player = Vector2(650,555)
	game.on_floor = true
	var images: Array = []
	for mark in [3,5,7]:
		game.mark_level = mark
		for left in [false,true]:
			game.player_facing_left = left
			for clip in ["idle","run","strike","dodge","collect","rise","fall","hurt","transform","signature"]:
				game.clear_combat_visuals()
				game.velocity = Vector2.ZERO
				game.on_floor = true
				game.player_animation_pose = "idle"
				game.player_animation_time = 0.0
				if clip == "run":
					game.velocity.x = -150.0 if left else 150.0
					game.player_animation_pose = "walk"
					game.player_animation_time = 0.2
				elif clip in ["strike","dodge","collect","hurt"]:
					game.set_player_action(clip,0.45)
					game.player_action_time = 0.18
				elif clip in ["rise","fall"]:
					game.on_floor = false
					game.velocity.y = -150.0 if clip=="rise" else 150.0
					game.player_animation_pose = "air"
					game.player_animation_time = 0.15
				elif clip == "transform":
					game.lolth_transform_time = 0.3
				elif clip == "signature":
					# Preview-only clip: no new runtime power or input is added.
					game.set_player_action("signature",0.6)
					game.player_action_time = 0.2
				game.queue_redraw()
				await process_frame
				await RenderingServer.frame_post_draw
				var path := ROOT+"runtime-mark-%d-%s-%s.png" % [mark,"left" if left else "right",clip]
				root.get_texture().get_image().save_png(path)
				images.append(path)
	for threshold in [3,5,7]:
		game.clear_combat_visuals()
		game.on_floor = true
		game.mark_level = threshold-1
		game.advance_mark()
		game.update_lolth_presentation(0.4)
		game.queue_redraw()
		await process_frame
		await RenderingServer.frame_post_draw
		var path := ROOT+"acquisition-mark-%d-cure.png" % threshold
		root.get_texture().get_image().save_png(path)
		images.append(path)
	var file := FileAccess.open(ROOT+"render-captures.json",FileAccess.WRITE)
	file.store_string(JSON.stringify({"captures":images,"viewport":[root.size.x,root.size.y],"renderer":RenderingServer.get_video_adapter_name(),"engine":Engine.get_version_info()},"\t"))
	print("LOLTH_RENDER_PASS: 63 fresh captures, 3 stages x 10 clips x 2 facings plus 3 cure acquisition previews")
	game.queue_free()
	quit()

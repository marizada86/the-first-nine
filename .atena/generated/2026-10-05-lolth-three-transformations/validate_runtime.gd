extends SceneTree

const ROOT := "res://.atena/generated/2026-10-05-lolth-three-transformations/"
const FORMS := preload("res://lolth_transformations.gd")
var checks: Dictionary = {}

func _initialize() -> void:
	call_deferred("run")

func check(name: String, condition: bool) -> void:
	checks[name] = condition
	if not condition:
		push_error("LOLTH_FORM_FAIL: " + name)

func run() -> void:
	var game = load("res://main.gd").new()
	root.add_child(game)
	game.set_process(false)
	game.skip_opening()
	var expected := [0,0,0,3,3,5,5,7,7,7]
	for mark in range(10):
		game.mark_level = mark
		game.clear_combat_visuals()
		game.on_floor = true
		game.velocity = Vector2.ZERO
		var frame: Dictionary = game.player_sprite_frame()
		check("threshold_%d" % mark, FORMS.stage_for_mark(mark)==expected[mark] and int(frame.get("stage",0))==expected[mark])
		check("narrative_form_%d" % mark, game.lolth_form()==("elf" if mark==0 else "drow"))
	for mark in [3,5,7]:
		game.mark_level = mark
		game.clear_combat_visuals()
		var frame: Dictionary = game.player_sprite_frame()
		check("body_scale_%d" % mark, is_equal_approx(float(frame.height)*40.0/112.0, FORMS.DISPLAY_BODY_HEIGHT) and is_equal_approx(float(frame.feet_ratio)*112.0,100.0))
		for clip in FORMS.CLIPS:
			var data: Array = FORMS.CLIPS[clip]
			var indices: Dictionary = {}
			for i in int(data[1]):
				var sample := FORMS.sprite_frame(mark,clip,(float(i)+0.1)/float(data[2]))
				indices[sample.index] = true
				check("rect_%d_%s_%d" % [mark,clip,i], sample.source.position.x>=0 and sample.source.position.y>=0 and sample.source.end.x<=672 and sample.source.end.y<=672)
			check("clip_%d_%s" % [mark,clip], indices.size()==int(data[1]))
		game.set_player_action("strike",0.28)
		game.lolth_transform_time = 0.8
		check("action_priority_%d" % mark, game.player_sprite_frame().clip=="strike" and game.player_sprite_frame().index==10)
		game.player_action_time = 0.01
		check("strike_finishes_%d" % mark, game.player_sprite_frame().index==13)
		game.clear_combat_visuals()
		game.on_floor = false
		game.velocity.y = -100.0
		check("rising_%d" % mark, game.player_sprite_frame().clip=="rise")
		game.velocity.y = 100.0
		check("falling_%d" % mark, game.player_sprite_frame().clip=="fall")
		game.on_floor = true
	for threshold in [3,5,7]:
		game.reset_to_prologue()
		game.zone = 2
		game.mark_level = threshold-1
		var cures: Array = game.cured_allies.duplicate()
		game.advance_mark()
		check("acquisition_%d" % threshold, game.lolth_transform_time==0.8 and game.player_sprite_frame().clip=="transform" and game.cured_allies==cures)
		game.update_lolth_presentation(0.4)
		check("transition_middle_%d" % threshold, game.player_sprite_frame().index==29)
		game.update_lolth_presentation(0.41)
		check("transition_once_%d" % threshold, game.lolth_transform_time==0.0 and game.player_sprite_frame().clip=="idle")
		game.advance_mark()
		check("intermediate_no_transition_%d" % threshold, game.lolth_transform_time==0.0)
	for mark in [3,5,7]:
		game.reset_to_prologue()
		game.mark_level = mark-1
		game.create_checkpoint()
		var before: Dictionary = game.checkpoint.duplicate(true)
		game.playtester_change_mark(1)
		check("f4_stage_%d" % mark, game.player_sprite_frame().stage==mark and game.lolth_transform_time==0.8)
		game.restore_playtester_session()
		check("f4_restore_%d" % mark, game.mark_level==mark-1 and game.checkpoint==before and game.lolth_transform_time==0.0)
		game.mark_level = mark
		game.zone = 2
		game.create_checkpoint()
		game.lolth_transform_time = 0.8
		game.restart_from_checkpoint()
		check("checkpoint_restore_%d" % mark, game.mark_level==mark and game.player_sprite_frame().stage==mark and game.lolth_transform_time==0.0)
	game.reset_to_prologue()
	game.mark_level = 5
	game.cured_allies.append("AELIRA")
	game.capture_safe_wagon_state()
	game.lolth_transform_time = 0.8
	game.restore_safe_wagon_state()
	check("safe_restore_stage", game.mark_level==5 and game.player_sprite_frame().stage==5 and game.lolth_transform_time==0.0)
	check("gameplay_geometry", game.PLAYER_RADIUS==19.0 and game.MELEE_LOLTH_HALF_WIDTH==44.0 and game.ATTACK_POSE_TIME==0.28)
	var failed: Array = []
	for name in checks:
		if not checks[name]: failed.append(name)
	var file := FileAccess.open(ROOT+"runtime-validation.json",FileAccess.WRITE)
	file.store_string(JSON.stringify({"checks":checks,"passed":checks.size()-failed.size(),"failed":failed,"engine":Engine.get_version_info()},"\t"))
	print("LOLTH_FORMS_%s: %d/%d checks" % ["PASS" if failed.is_empty() else "FAIL",checks.size()-failed.size(),checks.size()])
	game.queue_free()
	quit(0 if failed.is_empty() else 1)

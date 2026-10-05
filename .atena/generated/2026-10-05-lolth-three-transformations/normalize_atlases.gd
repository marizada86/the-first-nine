extends SceneTree

const ROOT := "res://.atena/generated/2026-10-05-lolth-three-transformations/"
const CELL := 112
const PIVOT := Vector2i(56, 100)
const PALETTE := [Color("100e1c"), Color("242033"), Color("393048"), Color("544660"), Color("76657f"), Color("aa9daf"), Color("ddd5e3"), Color("f6efff"), Color("301144"), Color("531778"), Color("9232c7"), Color("d578ff")]
const CLIPS := {"idle": [0,4,5.0,true], "run": [4,6,10.0,true], "strike": [10,4,14.285714,false], "dodge": [14,3,10.0,false], "collect": [17,3,10.0,false], "rise": [20,2,8.0,true], "fall": [22,2,8.0,true], "hurt": [24,2,4.444444,false], "transform": [26,6,7.5,false], "signature": [32,4,6.0,false]}

func _initialize() -> void:
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(ROOT + "components.json"))
	var report: Dictionary = {"cell": CELL, "pivot": [PIVOT.x,PIVOT.y], "palette_colors": PALETTE.size(), "stages": {}}
	for mark in ["3","5","7"]:
		var info: Dictionary = data[mark]
		var source := Image.load_from_file(ROOT + String(info.source))
		var first: Dictionary = info.frames[0]
		var head_y := 10000
		for run in first.runs:
			for x in range(int(run[1]), int(run[2])):
				var c := source.get_pixel(x,int(run[0]))
				if c.r > 0.45 and c.g > 0.4 and c.b > 0.45 and absf(c.r-c.g) < 0.22:
					head_y = mini(head_y,int(run[0]))
		var body_height := int(first.bbox[3])-head_y
		var scale_factor := 40.0/float(body_height)
		var atlas := Image.create(CELL*6,CELL*6,false,Image.FORMAT_RGBA8)
		atlas.fill(Color.TRANSPARENT)
		var frame_records: Array = []
		for i in range(36):
			var frame: Dictionary = info.frames[i]
			var bounds: Array = frame.bbox.duplicate()
			for run in frame.runs:
				bounds[0] = mini(int(bounds[0]),int(run[1]))
				bounds[1] = mini(int(bounds[1]),int(run[0]))
				bounds[2] = maxi(int(bounds[2]),int(run[2]))
				bounds[3] = maxi(int(bounds[3]),int(run[0])+1)
			var box := Rect2i(int(bounds[0]),int(bounds[1]),int(bounds[2])-int(bounds[0]),int(bounds[3])-int(bounds[1]))
			var isolated := Image.create(box.size.x,box.size.y,false,Image.FORMAT_RGBA8)
			isolated.fill(Color.TRANSPARENT)
			var foot_min := 10000
			var foot_max := 0
			for run in frame.runs:
				for x in range(int(run[1]),int(run[2])):
					var y := int(run[0])
					var c := source.get_pixel(x,y)
					isolated.set_pixel(x-box.position.x,y-box.position.y,c)
					if y >= int(frame.bbox[3])-5 and c.r < 0.35 and c.g < 0.3 and c.b < 0.4:
						foot_min = mini(foot_min,x)
						foot_max = maxi(foot_max,x)
			var anchor_x := (foot_min+foot_max)/2.0 if foot_min < 10000 else (int(frame.bbox[0])+int(frame.bbox[2]))/2.0
			var anchor_y := float(frame.bbox[3])
			isolated.resize(maxi(1,roundi(box.size.x*scale_factor)),maxi(1,roundi(box.size.y*scale_factor)),Image.INTERPOLATE_NEAREST)
			# Technical atlas conversion: binary alpha and a shared indexed palette.
			for y in isolated.get_height():
				for x in isolated.get_width():
					var c := isolated.get_pixel(x,y)
					if c.a < 0.5:
						isolated.set_pixel(x,y,Color.TRANSPARENT)
						continue
					var best: Color = PALETTE[0]
					var distance := INF
					for candidate in PALETTE:
						var diff := Vector3(c.r-candidate.r,c.g-candidate.g,c.b-candidate.b).length_squared()
						if diff < distance:
							distance = diff
							best = candidate
					isolated.set_pixel(x,y,best)
			var offset := PIVOT-Vector2i(roundi((anchor_x-box.position.x)*scale_factor),roundi((anchor_y-box.position.y)*scale_factor))
			var dest := Rect2i(offset,isolated.get_size())
			if dest.position.x < 2 or dest.position.y < 2 or dest.end.x > CELL-2 or dest.end.y > CELL-2:
				push_error("Unsafe frame %s/%d: %s" % [mark,i,dest])
				quit(1)
				return
			atlas.blit_rect(isolated,Rect2i(Vector2i.ZERO,isolated.get_size()),Vector2i((i%6)*CELL,(i/6)*CELL)+offset)
			frame_records.append({"frame":i,"raw_bounds":bounds,"normalized_bounds":[dest.position.x,dest.position.y,dest.size.x,dest.size.y],"anchor_raw":[anchor_x,anchor_y]})
		var path := ROOT + "lolth-mark-%s-atlas-v1.png" % mark
		atlas.save_png(path)
		var master := atlas.get_region(Rect2i(0,0,CELL,CELL))
		master.resize(CELL*4,CELL*4,Image.INTERPOLATE_NEAREST)
		master.save_png(ROOT+"lolth-mark-%s-master-v1.png" % mark)
		var manifest := {"mark":int(mark),"atlas":"lolth-mark-%s-atlas-v1.png" % mark,"cell_size":[CELL,CELL],"columns":6,"pivot":[PIVOT.x,PIVOT.y],"body_height":40,"display_body_height":200.0*410.0/428.0,"clips":CLIPS,"source":info.source,"ai_generated":true}
		var file := FileAccess.open(ROOT+"lolth-mark-%s-animation-v1.json" % mark,FileAccess.WRITE)
		file.store_string(JSON.stringify(manifest,"\t"))
		report.stages[mark] = {"raw_body_height":body_height,"scale_factor":scale_factor,"frames":frame_records}
	var file := FileAccess.open(ROOT+"normalization-report.json",FileAccess.WRITE)
	file.store_string(JSON.stringify(report,"\t"))
	print("ATLAS_NORMALIZATION_PASS: 108 isolated frames, 112px cells, 40px anatomical height, shared 12-color palette")
	quit()

extends RefCounted

# Presentation only. Narrative elf/drow form and all combat geometry stay in main.gd.
const SHEETS := {
	3: preload("res://assets/runtime_v2/characters/lolth/lolth-mark-3-atlas-v1.png"),
	5: preload("res://assets/runtime_v2/characters/lolth/lolth-mark-5-atlas-v1.png"),
	7: preload("res://assets/runtime_v2/characters/lolth/lolth-mark-7-atlas-v1.png")
}
const CELL := 112.0
const PIVOT_Y := 100.0
const BODY_HEIGHT := 40.0
# Base drow's standing body occupies y=16..426 in a 428px cell drawn at 200px.
const DISPLAY_BODY_HEIGHT := 200.0 * 410.0 / 428.0
const TRANSFORM_DURATION := 0.8
const CLIPS := {"idle": [0,4,5.0,true], "run": [4,6,10.0,true], "strike": [10,4,14.285714,false], "dodge": [14,3,10.0,false], "collect": [17,3,10.0,false], "rise": [20,2,8.0,true], "fall": [22,2,8.0,true], "hurt": [24,2,4.444444,false], "transform": [26,6,7.5,false], "signature": [32,4,6.0,false]}
static var pixel_textures: Dictionary = {}

static func pixel_texture(stage: int) -> CanvasTexture:
	if not pixel_textures.has(stage):
		var texture := CanvasTexture.new()
		texture.diffuse_texture = SHEETS[stage]
		texture.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		pixel_textures[stage] = texture
	return pixel_textures[stage]

static func stage_for_mark(mark: int) -> int:
	if mark >= 7:
		return 7
	if mark >= 5:
		return 5
	if mark >= 3:
		return 3
	return 0

static func sprite_frame(mark: int, clip: String, elapsed: float, action_progress: float = -1.0) -> Dictionary:
	var stage := stage_for_mark(mark)
	if stage == 0:
		return {}
	var sequence: Array = CLIPS.get(clip, CLIPS.idle)
	var count := int(sequence[1])
	var offset := maxi(0, int(floor(elapsed * float(sequence[2]))))
	if action_progress >= 0.0:
		offset = clampi(int(floor(action_progress * count)), 0, count-1)
	elif bool(sequence[3]):
		offset %= count
	else:
		offset = mini(offset, count-1)
	var index := int(sequence[0]) + offset
	return {"sheet": pixel_texture(stage), "source": Rect2(float(index%6)*CELL, float(index/6)*CELL, CELL, CELL), "crop": Rect2(), "height": CELL*DISPLAY_BODY_HEIGHT/BODY_HEIGHT, "feet_ratio": PIVOT_Y/CELL, "stage": stage, "clip": clip, "index": index}

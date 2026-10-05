extends "res://.atena/generated/2026-10-04-b06-validation/camera_fixture.gd"
# Faulty test-only subclass: Lolth's reflection ignores the world-to-view translation.
func draw_player_sprite(sheet: Texture2D, source: Rect2, height: float = PLAYER_SPRITE_HEIGHT, feet_ratio: float = 1.0, crop: Rect2 = Rect2(), tint: Color = Color.WHITE) -> void:
	if not player_facing_left:
		super.draw_player_sprite(sheet, source, height, feet_ratio, crop, tint)
		return
	var width := height * source.size.x / source.size.y
	var destination := Rect2(player.x - width / 2.0, player.y + PLAYER_FEET_OFFSET - height * feet_ratio, width, height)
	if crop.has_area():
		var source_scale := destination.size / source.size
		destination.position += crop.position * source_scale
		destination.size = crop.size * source_scale
		source = Rect2(source.position + crop.position, crop.size)
	draw_set_transform(Vector2(player.x * 2.0, 0.0), 0.0, Vector2(-1.0, 1.0))
	draw_texture_rect_region(sheet, destination, source, tint)
	draw_set_transform(world_draw_origin(), 0.0, Vector2.ONE)

extends "res://.atena/generated/2026-10-04-b06-validation/camera_fixture.gd"
# Faulty test-only subclass: the enemy reflection resets to identity instead of the world view.
func draw_enemy_sprite(shade: Dictionary, geometry: Dictionary, tint: Color) -> void:
	var origin := world_draw_origin()
	if enemy_facing_left(shade):
		draw_set_transform(Vector2(float(shade.pos.x) * 2.0, 0.0) + origin, 0.0, Vector2(-1.0, 1.0))
	draw_texture_rect_region(geometry.sheet, geometry.destination, geometry.source, tint)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

extends "res://.atena/generated/2026-10-04-enemy-facing-validation/render_fixture.gd"
func draw_enemy_sprite(shade: Dictionary, geometry: Dictionary, tint: Color) -> void:
	if enemy_facing_left(shade):
		draw_set_transform(Vector2(float(shade.pos.x) * 2.0, 0.0), 0.0, Vector2(-1.0, 1.0))
	draw_texture_rect_region(geometry.sheet, geometry.destination, geometry.source, tint)

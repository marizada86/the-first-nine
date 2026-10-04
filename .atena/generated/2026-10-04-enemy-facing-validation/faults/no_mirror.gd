extends "res://.atena/generated/2026-10-04-enemy-facing-validation/render_fixture.gd"
func draw_enemy_sprite(_shade: Dictionary, geometry: Dictionary, tint: Color) -> void:
	draw_texture_rect_region(geometry.sheet, geometry.destination, geometry.source, tint)

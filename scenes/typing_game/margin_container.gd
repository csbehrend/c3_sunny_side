extends MarginContainer

@export var upper_left_bound: Vector2 = Vector2()
@export var lower_right_bound: Vector2 = Vector2()

signal margins_set

func _on_sprite_2d_sprite_scaled(texture_size):
	var margin_lu: Vector2i = (upper_left_bound).snapped(Vector2i(1, 1))
	var margin_rd: Vector2i = ((texture_size - lower_right_bound)).snapped(Vector2i(1, 1))
	add_theme_constant_override("margin_top", margin_lu.y)
	add_theme_constant_override("margin_left", margin_lu.x)
	add_theme_constant_override("margin_bottom", margin_rd.y)
	add_theme_constant_override("margin_right", margin_rd.x)
	
	margins_set.emit(lower_right_bound.x - upper_left_bound.x)

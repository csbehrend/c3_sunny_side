extends Sprite2D

signal sprite_scaled

func _ready():
	# Scale sprite to screen
	var vp = get_viewport()
	if vp != null:
		scale = Vector2(vp.size) / texture.get_size()
	sprite_scaled.emit(texture.get_size())

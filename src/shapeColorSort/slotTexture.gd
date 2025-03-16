extends TextureRect

var hasPaper = false
var isCenterStack = false
var shapeAndColor

var paperChairTexture = load("res://assets/shapeColorSort/chairs/chair with paper.png")
var paperStackTexture = load("res://assets/shapeColorSort/papers/stack of paper.png")

signal paperDropped(correctStatus)
signal paperPickedUp(slotNode, paperTexture)
#plan was to initially allow wrong drops too, but switched to just correct drops later

func _get_drag_data(_at_position: Vector2) -> Variant:
	if (isCenterStack):
		set_drag_preview(make_drag_preview())
		#print("picked up")
		paperPickedUp.emit(self, texture)
		texture = paperStackTexture
		return self
	else:
		return

#GitHub: drag/drop inventory system 
#adds a preview of the texture to mouse cursor while dragging
func make_drag_preview() -> TextureRect:
	var t := TextureRect.new()
	t.texture = texture
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	return t

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if (isCenterStack):
		return false
	if (hasPaper):
		return false
	return true
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	print("dropped:" + data.shapeAndColor)
	print("wanted:" + shapeAndColor)
	if (data.shapeAndColor != shapeAndColor):
		paperDropped.emit(false)
	else:
		paperDropped.emit(true)
		hasPaper = true
		texture = paperChairTexture

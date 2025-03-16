extends RichTextLabel

#@export var content: String = ""

func _ready():
	selection_enabled = true

func is_unicode(unicode: int) -> bool:
	return unicode == text.unicode_at(0)

func pop_letter():
	visible = false

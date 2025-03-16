extends HBoxContainer

@export var char_scene: PackedScene

func write_word(content: String):
	for x in content:
		var inst = char_scene.instantiate()
		inst.text = x
		add_child(inst)

func check_letter(unicode: int, idx: int) -> bool:
	assert(idx < get_length())
	var letter = get_child(idx)
	return letter.is_unicode(unicode)
	
func pop_letter_idx(idx: int):
	assert(idx < get_length())
	get_child(idx).pop_letter()
	
func select_idx(idx: int):
	assert(idx < get_length())
	get_child(idx).select_all()

func get_length() -> int:
	return get_child_count()

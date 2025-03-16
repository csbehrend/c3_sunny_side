extends Control

@export_file("*.txt") var text_path: String = ""
@export var word_scene: PackedScene

signal test_completed

var word_objs: Array = []
var eval: bool = false

# Update theme in here and typingchar if changed
#const font_width: int = 8

func _on_margin_container_margins_set(line_width: int):
	var char_width: int  = get_theme_font("font").get_string_size("a", HORIZONTAL_ALIGNMENT_LEFT, -1, get_theme_font_size("font_size")).x
	var max_char: int =  line_width / char_width
	
	#var content: String = ""
	#if text_path != "":
	#	var file = FileAccess.open(text_path, FileAccess.READ)
	#	content = file.get_as_text()
	#	file.close()
	
	
	var words: Array[String]
	#words.assign(content.split(" "))
	words.assign(SceneManager.typing_content.split(" "))
	
	for idx in range(words.size() - 1):
		words[idx] += " "
	#words[words.size() - 1] = words[words.size() - 1].get_slice("\n", 0)
	
	for word in words:
		assert(word.length() <= max_char)
		word_objs.append(add_word(word))
	
	word_objs[0].select_idx(0)
	eval = true

var word_idx: int = 0
var letter_idx: int = 0

func add_word(content: String):
	var inst = word_scene.instantiate()
	inst.write_word(content)
	add_child(inst)
	return inst

func _input(event):
	if eval and word_idx < word_objs.size() and (event is InputEventKey) and event.pressed:
		if (word_objs[word_idx].check_letter(event.unicode, letter_idx)):
			word_objs[word_idx].pop_letter_idx(letter_idx)
			letter_idx += 1
			if (letter_idx >= word_objs[word_idx].get_length()):
				letter_idx = 0
				word_idx += 1
			if (word_idx < word_objs.size()):
				word_objs[word_idx].select_idx(letter_idx)
			else:
				test_completed.emit(1)
